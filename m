Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 08C11B7CF8
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Mar 2010 21:20:12 +1100 (EST)
Date: Mon, 22 Mar 2010 11:19:29 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 01/10] irq: move some interrupt arch_* functions into
	struct irq_chip.
In-Reply-To: <1269221770-9667-2-git-send-email-yinghai@kernel.org>
Message-ID: <alpine.LFD.2.00.1003220950570.3147@localhost.localdomain>
References: <1269221770-9667-1-git-send-email-yinghai@kernel.org>
	<1269221770-9667-2-git-send-email-yinghai@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: lguest@ozlabs.org, Jeremy Fitzhardinge <jeremy@goop.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Ian Campbell <ian.campbell@citrix.com>,
	Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 21 Mar 2010, Yinghai Lu wrote:

> From: Ian Campbell <ian.campbell@citrix.com>
> 
> Move arch_init_copy_chip_data and arch_free_chip_data into function
> pointers in struct irq_chip since they operate on irq_desc->chip_data.

Not sure about that. These functions are solely used by x86 and there
is really no need to generalize them. The problem you try to solve is
x86/xen specific and can be solved by x86_platform_ops as well w/o
adding extra function pointers to irq_chip.

> arch_init_chip_data cannot be moved into struct irq_chip because
> irq_desc->chip is not known at the time the irq_desc is setup. Instead
> rename arch_init_chip_data to arch_init_irq_desc for PowerPC, the
> only other user, whose usage better matches the new name.
> 
> To replace the x86 arch_init_chip_data functionality
> irq_to_desc_alloc_node now takes a pointer to a function to allocate
> the chip data. This is necessary to ensure the allocation happens
> under the correct locking at the core level. On PowerPC and SH

Err, that argument is totally bogus. The calling convention of
irq_to_desc_alloc_node and arch_init_chip_data/arch_init_irq_desc is
still the same. It does not explain why the heck we need that function
pointer at all.

AFAICT the function pointer to irq_to_desc_alloc_node is completely
pointless. It just solves a Xen/x86 specific problem which can be
solved by using x86_platform_ops and keeps the churn x86 internal.

> architectures (the other users of irq_to_desc_alloc_node) pass in NULL
> which retains existing chip_data behaviour.
 
> I've retained the chip_data behaviour for uv_irq although it isn't
> clear to me if these interrupt types support migration or how closely
> related to the APIC modes they really are. If it weren't for this the
> x86_{init,copy,free}_chip_data functions could be static to
> io_apic.c.
> 
> I've tested by booting on an 64 bit x86 system with sparse IRQ enabled
> and 32 bit without, but it's not clear to me what actions I need to
> take to actually exercise some of these code paths.
> 
> -v4: yinghai add irq_to_desc_alloc_node_x...

Aside of the general objection against this, please use descriptive
function names and do not distinguish functions by adding random
characters which tell us absolutely nothing about the purpose.

Thanks,

	tglx
