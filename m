Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wy7yv39YmzDr1b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 13:47:19 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id u36so6567162pgn.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 20:47:19 -0700 (PDT)
Date: Wed, 28 Jun 2017 13:47:05 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Mahesh Salgaonkar
 <mahesh@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul
 Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Rework local TLB flush for boot and
 MCE on POWER9
Message-ID: <20170628134705.6bbd2b9a@roar.ozlabs.ibm.com>
In-Reply-To: <87k23wvn78.fsf@skywalker.in.ibm.com>
References: <20170606054247.24914-1-npiggin@gmail.com>
 <87k23wvn78.fsf@skywalker.in.ibm.com>
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

On Wed, 28 Jun 2017 08:21:55 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > There are two cases outside the normal address space management
> > where a CPU's local TLB is to be flushed:
> >
> >   1. Host boot; in case something has left stale entries in the
> >      TLB (e.g., kexec).
> >
> >   2. Machine check; to clean corrupted TLB entries.
> >
> > CPU state restore from deep idle states also flushes the TLB. However
> > this seems to be a side effect of reusing the boot code to set CPU
> > state, rather than a requirement itself.
> >
> > This type of TLB flush is coded inflexibly, several times for each CPU
> > type, and they have a number of problems with ISA v3.0B:
> >
> > - The current radix mode of the MMU is not taken into account. tlbiel
> >   is undefined if the R field does not match the current radix mode.
> >
> > - ISA v3.0B hash mode should be flushing the partition and process
> >   table caches.
> >
> > - ISA v3.0B radix mode should be flushing partition and process table
> >   caches, and also the page walk cache.
> >
> > To improve this situation, consolidate the flushing code and implement
> > it in C and inline asm under the mm/ directory, and add ISA v3.0B cases
> > for radix and hash.
> >
> > Take it out from early cputable detection hooks, and move it later in
> > the boot process after the MMU registers are set up and before
> > relocation is first turned on.
> >
> > Provide capability for LPID flush to specify radix mode.
> >
> > TLB flush is no longer called when restoring from deep idle states.  
> 
> 
> I am not sure the new location of flushing the tlb is correct/perfect. For ex:
> may be we should do it before htab_initialize() so that we start with
> all everything flushed ? But otherwise
> 
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>


Thanks for taking a look over it. The location of the flush is based on
the thinking that:

1. We don't have to flush while MSR IR/DR = 0 because real mode
   translation entries should be correct (if not we have much bigger
   problems). But we must flush before setting IR/DR.

2. We should flush after all setup is done (e.g., all SPRs set) in
   case there is some influence on internal translation structures
   or invalidation.

The conclusion is that we should flush just before turning on MSR IR/DR.

If there is something wrong with my assumptions, it would be be
important to adjust the patch.

Thanks,
Nick
