Return-Path: <srs0=sdsh=ef=gmail.com=sjitindarsingh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGVzN3cvNzF0cp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 12:00:00 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zGVzN1L3jz8sw8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 12:00:00 +1100 (AEDT)
Message-ID: <1515545991.1993.17.camel@gmail.com>
Subject: Re: [PATCH] KVM: PPC: Book3S: Add capabilities for Meltdown/Spectre
 workarounds
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras
 <paulus@ozlabs.org>,  kvm@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 10 Jan 2018 11:59:51 +1100
In-Reply-To: <2b9c6453-c56f-ac4d-daa9-16d9ffa6cebe@ozlabs.ru>
References: <20180109044815.GA19326@fergus.ozlabs.ibm.com>
 <1515487154.1993.3.camel@gmail.com>
 <2b9c6453-c56f-ac4d-daa9-16d9ffa6cebe@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-01-09 at 23:44 +1100, Alexey Kardashevskiy wrote:
> On 09/01/18 19:39, Suraj Jitindar Singh wrote:
> > On Tue, 2018-01-09 at 15:48 +1100, Paul Mackerras wrote:
> > > This adds three new capabilities that give userspace information
> > > about
> > > the underlying machine's level of vulnerability to the Meltdown
> > > and
> > > Spectre attacks, and what instructions the hardware implements to
> > > assist software to work around the vulnerabilities.
> > > 
> > > Each capability is a tri-state, where 0 indicates that the
> > > machine is
> > > vulnerable and no workarounds are implement, 1 indicates that the
> > > machine is vulnerable but workaround assist instructions are
> > > available, and 2 indicates that the machine is not vulnerable.
> > > 
> > > The capabilities are:
> > > 
> > > KVM_CAP_PPC_SAFE_CACHE reports the vulnerability of the machine
> > > to
> > > attacks based on using speculative loads to data in L1 cache
> > > which
> > > should not be addressable.  The workaround provided by hardware
> > > is an
> > > instruction to invalidate the entire L1 data cache.
> > > 
> > > KVM_CAP_PPC_SAFE_BOUNDS_CHECK reports the vulnerability of the
> > > machine
> > > to attacks based on using speculative loads behind mispredicted
> > > bounds
> > > checks.  The workaround provided by hardware is an instruction
> > > that
> > > acts as a speculation barrier.
> > > 
> > > KVM_CAP_PPC_SAFE_INDIRECT_BRANCH reports the vulnerability of the
> > > machine to attacks based on poisoning the indirect branch
> > > predictor.
> > > No workaround that requires software changes is provided; the
> > > current
> > > hardware fix is to prevent speculation past indirect branches.
> > > 
> > > Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> > > ---
> > > Note: This patch depends on the patch "powerpc/pseries: Add
> > > H_GET_CPU_CHARACTERISTICS flags & wrapper" by Michael Ellerman,
> > > available at http://patchwork.ozlabs.org/patch/856914/ .
> > > 
> > >  Documentation/virtual/kvm/api.txt |  36 +++++++
> > >  arch/powerpc/kvm/powerpc.c        | 202
> > > ++++++++++++++++++++++++++++++++++++++
> > >  include/uapi/linux/kvm.h          |   3 +
> > >  3 files changed, 241 insertions(+)
> > > 
> > > diff --git a/Documentation/virtual/kvm/api.txt
> > > b/Documentation/virtual/kvm/api.txt
> > > index 57d3ee9..8d76260 100644
> > > --- a/Documentation/virtual/kvm/api.txt
> > > +++ b/Documentation/virtual/kvm/api.txt
> > > @@ -4369,3 +4369,39 @@ Parameters: none
> > >  This capability indicates if the flic device will be able to
> > > get/set
> > > the
> > >  AIS states for migration via the KVM_DEV_FLIC_AISM_ALL attribute
> > > and
> > > allows
> > >  to discover this without having to create a flic device.
> > > +
> > > +8.14 KVM_CAP_PPC_SAFE_CACHE
> > > +
> > > +Architectures: ppc
> > > +
> > > +This capability gives information about the underlying machine's
> > > +vulnerability or otherwise to the Meltdown attack.  Its value is
> > > a
> > > +tristate, where 0 indicates the machine is vulnerable, 1
> > > indicates
> > > the
> > > +hardware is vulnerable but provides assistance to work around
> > > the
> > > +vulnerability (specifically by providing a fast L1 data cache
> > > flush
> > > +facility), and 2 indicates that the machine is not vulnerable.
> > > +
> > > +8.15 KVM_CAP_PPC_SAFE_BOUNDS_CHECK
> > > +
> > > +Architectures: ppc
> > > +
> > > +This capability gives information about the underlying machine's
> > > +vulnerability or otherwise to the bounds-check variant of the
> > > Spectre
> > > +attack.  Its value is a tristate, where 0 indicates the machine
> > > is
> > > +vulnerable, 1 indicates the hardware is vulnerable but provides
> > > +assistance to work around the vulnerability (specifically by
> > > providing
> > > +an instruction that acts as a speculation barrier), and 2
> > > indicates
> > > +that the machine is not vulnerable.
> > > +
> > > +8.16 KVM_CAP_PPC_SAFE_INDIRECT_BRANCH
> > > +
> > > +Architectures: ppc
> > > +
> > > +This capability gives information about the underlying machine's
> > > +vulnerability or otherwise to the indirect branch variant of the
> > > Spectre
> > > +attack.  Its value is a tristate, where 0 indicates the machine
> > > is
> > > +vulnerable and 2 indicates that the machine is not vulnerable.
> > > +(1 would indicate the availability of a workaround that software
> > > +needs to implement, but there is currently no workaround that
> > > needs
> > > +software changes.)
> > > +
> > > diff --git a/arch/powerpc/kvm/powerpc.c
> > > b/arch/powerpc/kvm/powerpc.c
> > > index 1915e86..58e863b 100644
> > > --- a/arch/powerpc/kvm/powerpc.c
> > > +++ b/arch/powerpc/kvm/powerpc.c
> > > @@ -39,6 +39,10 @@
> > >  #include <asm/iommu.h>
> > >  #include <asm/switch_to.h>
> > >  #include <asm/xive.h>
> > > +#ifdef CONFIG_PPC_PSERIES
> > > +#include <asm/hvcall.h>
> > > +#include <asm/plpar_wrappers.h>
> > > +#endif
> > >  
> > >  #include "timing.h"
> > >  #include "irq.h"
> > > @@ -488,6 +492,193 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
> > >  	module_put(kvm->arch.kvm_ops->owner);
> > >  }
> > >  
> > > +#ifdef CONFIG_PPC_BOOK3S_64
> > > +/*
> > > + * These functions check whether the underlying hardware is safe
> > > + * against the Meltdown/Spectre attacks and whether it supplies
> > > + * instructions for use in workarounds.  The information comes
> > > from
> > > + * firmware, either via the device tree on powernv platforms or
> > > + * from an hcall on pseries platforms.
> > > + *
> > > + * For check_safe_cache() and check_safe_bounds_check(), a
> > > return
> > > + * value of 0 means vulnerable, 1 means vulnerable but
> > > workaround
> > > + * instructions are provided, and 2 means not vulnerable (no
> > > workaround
> > > + * is needed).
> > > + * For check_safe_indirect_branch(), 0 means vulnerable and 2
> > > means
> > > + * not vulnerable.
> > > + */
> > > +static inline bool have_fw_feat(struct device_node *fw_features,
> > > +				const char *state, const char
> > > *name)
> > > +{
> > > +	struct device_node *np;
> > > +	bool r = false;
> > > +
> > > +	np = of_get_child_by_name(fw_features, name);
> > > +	if (np) {
> > > +		r = of_property_read_bool(np, state);
> > > +		of_node_put(np);
> > > +	}
> > > +	return r;
> > > +}
> > > +
> > > +#ifdef CONFIG_PPC_PSERIES
> > > +static bool check_pseries_safe_cache(int *rp)
> > > +{
> > > +	struct h_cpu_char_result c;
> > > +	unsigned long rc;
> > > +	int r = 0;
> > > +
> > > +	if (!machine_is(pseries))
> > > +		return false;
> > > +
> > > +	rc = plpar_get_cpu_characteristics(&c);
> > > +	if (rc == H_SUCCESS) {
> > > +		if (!(c.behavior & 
> > 
> > s/behavior/behaviour
> 

Mainly because that's what it's called in the struct and so needs to be
that if you want it to compile :)

Also, straya

> Why?
> https://dictionary.cambridge.org/dictionary/english/behavior
> 
> 
> 
