Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E09DFDDE17
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 12:14:17 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m382EExo023544
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 22:14:14 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m382EEVC251154
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 22:14:14 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m382EDHx008059
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Apr 2008 22:14:14 -0400
Date: Mon, 7 Apr 2008 21:12:40 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [PATCH 3 of 3] [KVM POWERPC] PowerPC 440 KVM implementation
Message-ID: <20080407211240.4fc5c6d9@zod.rchland.ibm.com>
In-Reply-To: <b07f3049f16483f80322.1207601614@localhost.localdomain>
References: <patchbomb.1207601611@localhost.localdomain>
	<b07f3049f16483f80322.1207601614@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kvm-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	kvm-ppc-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 07 Apr 2008 15:53:34 -0500
Hollis Blanchard <hollisb@us.ibm.com> wrote:

> Currently supports only PowerPC 440 Linux guests on 440 hosts. (Only tested
> with 440EP "Bamboo" guests so far, but with appropriate userspace support other
> SoC/board combinations should work.)

I haven't reviewed the whole patch yet, but lots of it looks pretty
clean.  A couple comments on some things that made me scratch my head
below.

> Interrupt handling: We use IVPR to hijack the host interrupt vectors while
> running the guest, but hand off decrementer and external interrupts for normal
> guest processing.
> 
> Address spaces: We take advantage of the fact that Linux doesn't use the AS=1
> address space (in host or guest), which gives us virtual address space to use
> for guest mappings. While the guest is running, the host kernel remains mapped
> in AS=0, but the guest can only use AS=1 mappings.
> 
> TLB entries: The TLB entries covering the host linear address space remain
> present while running the guest (which reduces the overhead of lightweight
> exits). We keep three copies of the TLB:
>  - guest TLB: contents of the TLB as the guest sees it
>  - shadow TLB: the TLB that is actually in hardware while guest is running
>  - host TLB: to restore TLB state when context switching guest -> host
> When a TLB miss occurs because a mapping was not present in the shadow TLB, but
> was present in the guest TLB, KVM handles the fault without invoking the guest.
> Large guest pages are backed by multiple 4KB shadow pages through this
> mechanism.
> 
> Instruction emulation: The guest kernel executes at user level, so executing
> privileged instructions trap into KVM, where we decode and emulate them. Future
> performance work will focus on reducing the overhead and frequency of these
> traps.
> 
> IO: MMIO and DCR accesses are emulated by userspace. We use virtio for network
> and block IO, so those drivers must be enabled in the guest. It's possible that
> some qemu device emulation (e.g. e1000 or rtl8139) may also work with little
> effort.
> 
> Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>

As Olof pointed out, having this in Documentation might be nice.

> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
> --- a/arch/powerpc/Kconfig.debug
> +++ b/arch/powerpc/Kconfig.debug
> @@ -151,6 +151,7 @@
> 
>  config PPC_EARLY_DEBUG
>  	bool "Early debugging (dangerous)"
> +	depends on !KVM
>  	help
>  	  Say Y to enable some early debugging facilities that may be available
>  	  for your processor/board combination. Those facilities are hacks

Might want to add a brief explanation as to why this doesn't work with
KVM due to the AS conflict.

> diff --git a/arch/powerpc/kvm/44x_tlb.c b/arch/powerpc/kvm/44x_tlb.c
> new file mode 100644
> --- /dev/null
> +++ b/arch/powerpc/kvm/44x_tlb.c
> @@ -0,0 +1,224 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
> + *
> + * Copyright IBM Corp. 2007
> + *
> + * Authors: Hollis Blanchard <hollisb@us.ibm.com>
> + */
> +
> +#include <linux/types.h>
> +#include <linux/string.h>
> +#include <linux/kvm_host.h>
> +#include <linux/highmem.h>
> +#include <asm/mmu-44x.h>
> +#include <asm/kvm_ppc.h>
> +
> +#include "44x_tlb.h"
> +
> +#define PPC44x_TLB_USER_PERM_MASK (PPC44x_TLB_UX|PPC44x_TLB_UR|PPC44x_TLB_UW)
> +#define PPC44x_TLB_SUPER_PERM_MASK (PPC44x_TLB_SX|PPC44x_TLB_SR|PPC44x_TLB_SW)
> +
> +static unsigned int kvmppc_tlb_44x_pos;
> +
> +static u32 kvmppc_44x_tlb_shadow_attrib(u32 attrib, int usermode)
> +{
> +	/* XXX remove mask when Linux is fixed */
> +	attrib &= 0xf03f;

What does that mean?  Is this the "44x TLB handler writes to reserved
fields" issue?  If so, could you comment that a little more verbosely?

Or you could just send a patch to fix Linux... ;).

> +
> +	if (!usermode) {
> +		/* Guest is in supervisor mode, so we need to translate guest
> +		 * supervisor permissions into user permissions. */
> +		attrib &= ~PPC44x_TLB_USER_PERM_MASK;
> +		attrib |= (attrib & PPC44x_TLB_SUPER_PERM_MASK) << 3;
> +	}
> +
> +	/* Make sure host can always access this memory. */
> +	attrib |= PPC44x_TLB_SX|PPC44x_TLB_SR|PPC44x_TLB_SW;
> +
> +	return attrib;
> +}
> +

<snip>

> diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
> new file mode 100644
> --- /dev/null
> +++ b/arch/powerpc/kvm/emulate.c
> @@ -0,0 +1,753 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
> + *
> + * Copyright IBM Corp. 2007
> + *
> + * Authors: Hollis Blanchard <hollisb@us.ibm.com>
> + */
> +
> +#include <linux/jiffies.h>
> +#include <linux/timer.h>
> +#include <linux/types.h>
> +#include <linux/string.h>
> +#include <linux/kvm_host.h>
> +
> +#include <asm/dcr.h>
> +#include <asm/time.h>
> +#include <asm/byteorder.h>
> +#include <asm/kvm_ppc.h>

#include <asm/dcr-regs.h>

> +
> +#include "44x_tlb.h"
> +
> +#define DCRN_CPR0_CFGADDR	0xc
> +#define DCRN_CPR0_CFGDATA	0xd

Remove these.

<snip>

> +int kvmppc_emulate_instruction(struct kvm_run *run, struct kvm_vcpu *vcpu)
> +{
> +	u32 inst = vcpu->arch.last_inst;
> +	u32 ea;
> +	int ra;
> +	int rb;
> +	int rc;
> +	int rs;
> +	int rt;
> +	int sprn;
> +	int dcrn;
> +	enum emulation_result emulated = EMULATE_DONE;
> +	int advance = 1;
> +
> +	switch (get_op(inst)) {

<snip>

> +		case 323:                                       /* mfdcr */
> +			dcrn = get_dcrn(inst);
> +			rt = get_rt(inst);
> +
> +			/* emulate some access in kernel */
> +			switch (dcrn) {
> +			case DCRN_CPR0_CFGADDR:
> +				vcpu->arch.gpr[rt] = vcpu->arch.cpr0_cfgaddr;
> +				break;
> +			case DCRN_CPR0_CFGDATA:
> +				local_irq_disable();
> +				mtdcr(DCRN_CPR0_CFGADDR,
> +				      vcpu->arch.cpr0_cfgaddr);
> +				vcpu->arch.gpr[rt] = mfdcr(DCRN_CPR0_CFGDATA);
> +				local_irq_enable();
> +				break;
> +			default:
> +				run->dcr.dcrn = dcrn;
> +				run->dcr.data =  0;
> +				run->dcr.is_write = 0;
> +				vcpu->arch.io_gpr = rt;
> +				vcpu->arch.dcr_needed = 1;
> +				emulated = EMULATE_DO_DCR;
> +			}
> +
> +			break;

<snip>

> +		case 451:                                       /* mtdcr */
> +			dcrn = get_dcrn(inst);
> +			rs = get_rs(inst);
> +
> +			/* emulate some access in kernel */
> +			switch (dcrn) {
> +			case DCRN_CPR0_CFGADDR:
> +				vcpu->arch.cpr0_cfgaddr = vcpu->arch.gpr[rs];
> +				break;
> +			default:
> +				run->dcr.dcrn = dcrn;
> +				run->dcr.data = vcpu->arch.gpr[rs];
> +				run->dcr.is_write = 1;
> +				vcpu->arch.dcr_needed = 1;
> +				emulated = EMULATE_DO_DCR;
> +			}
> +
> +			break;

What exactly are those doing?  I'm confused as to why the CPR0 DCRs are
special cased.  Also, you don't seem to actually be doing much on
storing guest DCRs, so can I assume they aren't really needed at
runtime?

josh
