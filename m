Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tLMDY1CYXzDvyG
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Nov 2016 15:23:25 +1100 (AEDT)
Date: Sat, 19 Nov 2016 15:13:12 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 09/13] KVM: PPC: Book3S HV: Adapt TLB invalidations to
 work on POWER9
Message-ID: <20161119041312.GD29462@fergus.ozlabs.ibm.com>
References: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
 <1479454122-26994-10-git-send-email-paulus@ozlabs.org>
 <87y40gn941.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87y40gn941.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 18, 2016 at 08:11:34PM +0530, Aneesh Kumar K.V wrote:
> > @@ -3287,6 +3290,17 @@ static int kvmppc_core_init_vm_hv(struct kvm *kvm)
> >  	kvm->arch.lpcr = lpcr;
> >  
> >  	/*
> > +	 * Work out how many sets the TLB has, for the use of
> > +	 * the TLB invalidation loop in book3s_hv_rmhandlers.S.
> > +	 */
> > +	if (cpu_has_feature(CPU_FTR_ARCH_300))
> > +		kvm->arch.tlb_sets = 256;	/* POWER9 */
> > +	else if (cpu_has_feature(CPU_FTR_ARCH_207S))
> > +		kvm->arch.tlb_sets = 512;	/* POWER8 */
> > +	else
> > +		kvm->arch.tlb_sets = 128;	/* POWER7 */
> > +
> 
> We have 
> 
> #define POWER7_TLB_SETS		128	/* # sets in POWER7 TLB */
> #define POWER8_TLB_SETS		512	/* # sets in POWER8 TLB */
> #define POWER9_TLB_SETS_HASH	256	/* # sets in POWER9 TLB Hash mode */
> #define POWER9_TLB_SETS_RADIX	128	/* # sets in POWER9 TLB Radix mode */
> 
> May be use that instead of opencoding ?

Doing that would make it easier to check that we're using the same
values everywhere but harder to see what actual numbers we're
getting.  I guess I could use the symbols and put the values in the
comments.  In any case, in future these values are just going to be
default values if we can't find a suitable device-tree property.

Paul.
