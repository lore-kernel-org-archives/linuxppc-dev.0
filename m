Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMX0Y3MVkzDvg1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 13:02:05 +1100 (AEDT)
Date: Mon, 21 Nov 2016 13:02:01 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Balbir Singh <bsingharora@gmail.com>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 05/13] KVM: PPC: Book3S HV: Adapt to new HPTE format on
 POWER9
Message-ID: <20161121020201.GB26748@fergus.ozlabs.ibm.com>
References: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
 <1479454122-26994-6-git-send-email-paulus@ozlabs.org>
 <8919b2ab-0702-d1d8-a391-b6c36571a8cf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8919b2ab-0702-d1d8-a391-b6c36571a8cf@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 19, 2016 at 11:38:40AM +1100, Balbir Singh wrote:
> 
> 
> On 18/11/16 18:28, Paul Mackerras wrote:
> > This adapts the KVM-HV hashed page table (HPT) code to read and write
> > HPT entries in the new format defined in Power ISA v3.00 on POWER9
> > machines.  The new format moves the B (segment size) field from the
> > first doubleword to the second, and trims some bits from the AVA
> > (abbreviated virtual address) and ARPN (abbreviated real page number)
> > fields.  As far as possible, the conversion is done when reading or
> > writing the HPT entries, and the rest of the code continues to use
> > the old format.
[snip]
> > @@ -440,6 +442,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
> >  {
> >  	struct kvm *kvm = vcpu->kvm;
> >  	unsigned long hpte[3], r;
> > +	unsigned long hnow_v, hnow_r;
> >  	__be64 *hptep;
> >  	unsigned long mmu_seq, psize, pte_size;
> >  	unsigned long gpa_base, gfn_base;
> > @@ -488,6 +491,10 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
> >  	unlock_hpte(hptep, hpte[0]);
> >  	preempt_enable();
> >  
> > +	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> > +		hpte[0] = hpte_new_to_old_v(hpte[0], hpte[1]);
> > +		hpte[1] = hpte_new_to_old_r(hpte[1]);
> > +	}
> 
> I think we can avoid this, if we avoid the conversion in kvmppc_hpte_hv_fault().
> If we decide not to do this, then gpa will need to use a new mask to extract
> the correct gpa.

Yes, we could store vcpu->arch.pgfault[] in native format, i.e. new
format on P9.  That might make the code a bit simpler indeed.

Paul.
