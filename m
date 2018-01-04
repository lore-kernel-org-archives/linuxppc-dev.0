Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zCG8r736FzF0QG
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jan 2018 05:11:56 +1100 (AEDT)
Received: by mail-pl0-x241.google.com with SMTP id n13so1464766plp.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Jan 2018 10:11:56 -0800 (PST)
Date: Fri, 5 Jan 2018 04:11:40 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] powerpc/64s: Improve local TLB flush for boot and
 MCE on POWER9
Message-ID: <20180105041140.1f86846e@roar.ozlabs.ibm.com>
In-Reply-To: <87d12r2zjx.fsf@linux.vnet.ibm.com>
References: <20171223151550.30612-1-npiggin@gmail.com>
 <87d12r2zjx.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 03 Jan 2018 12:34:34 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > There are several cases outside the normal address space management
> > where a CPU's entire local TLB is to be flushed:
> >
> >   1. Booting the kernel, in case something has left stale entries in
> >      the TLB (e.g., kexec).
> >
> >   2. Machine check, to clean corrupted TLB entries.
> >
> > One other place where the TLB is flushed, is waking from deep idle
> > states. The flush is a side-effect of calling ->cpu_restore with the
> > intention of re-setting various SPRs. The flush itself is unnecessary
> > because in the first case, the TLB should not acquire new corrupted
> > TLB entries as part of sleep/wake (though they may be lost).
> >
> > This type of TLB flush is coded inflexibly, several times for each CPU
> > type, and they have a number of problems with ISA v3.0B:
> >
> > - The current radix mode of the MMU is not taken into account, it is
> >   always done as a hash flushn For IS=2 (LPID-matching flush from host)
> >   and IS=3 with HV=0 (guest kernel flush), tlbie(l) is undefined if
> >   the R field does not match the current radix mode.
> >
> > - ISA v3.0B hash must flush the partition and process table caches as
> >   well.
> >
> > - ISA v3.0B radix must flush partition and process scoped translations,
> >   partition and process table caches, and also the page walk cache.
> >
> > So consolidate the flushing code and implement it in C and inline asm
> > under the mm/ directory with the rest of the flush code. Add ISA v3.0B
> > cases for radix and hash, and use the radix flush in radix environment.
> >
> > Provide a way for IS=2 (LPID flush) to specify the radix mode of the
> > partition. Have KVM pass in the radix mode of the guest.
> >
> > Take out the flushes from early cputable/dt_cpu_ftrs detection hooks,
> > and move it later in the boot process after, the MMU registers are set
> > up and before relocation is first turned on.
> >
> > The TLB flush is no longer called when restoring from deep idle states.
> > This was not be done as a separate step because booting secondaries
> > uses the same cpu_restore as idle restore, which needs the TLB flush.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>  
> 
> ......
> 
> > diff --git a/arch/powerpc/kvm/book3s_hv_ras.c b/arch/powerpc/kvm/book3s_hv_ras.c
> > index c356f9a40b24..e61066bb6725 100644
> > --- a/arch/powerpc/kvm/book3s_hv_ras.c
> > +++ b/arch/powerpc/kvm/book3s_hv_ras.c
> > @@ -87,8 +87,7 @@ static long kvmppc_realmode_mc_power7(struct kvm_vcpu *vcpu)
> >  				   DSISR_MC_SLB_PARITY | DSISR_MC_DERAT_MULTI);
> >  		}
> >  		if (dsisr & DSISR_MC_TLB_MULTI) {
> > -			if (cur_cpu_spec && cur_cpu_spec->flush_tlb)
> > -				cur_cpu_spec->flush_tlb(TLB_INVAL_SCOPE_LPID);
> > +			tlbiel_all_lpid(vcpu->kvm->arch.radix);  
> 
> Why use vcpu->kvm-arch.radix? why not TLB_INVAL_SCOPE_LPID?

tlbiel_all_lpid always does TLB_INVAL_SCOPE_LPID. The radix field needs to
be supplied to LPID flushes because by the ISA, the operation is undefined
if R field does not match the radix mode of the target partition. This is
the first dot point of problems in the changelog.

Thanks,
Nick
