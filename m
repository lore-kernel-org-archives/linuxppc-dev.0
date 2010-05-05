Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Wed, 5 May 2010 11:11:20 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [PATCH 06/13] powerpc/4xx: Simple platform for the ISS 4xx
	simulator
Message-ID: <20100505151120.GJ29593@zod.rchland.ibm.com>
References: <20100305204255.18424.85295.sendpatchset@norville.austin.ibm.com>
	<20100305204329.18424.26544.sendpatchset@norville.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100305204329.18424.26544.sendpatchset@norville.austin.ibm.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>, Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 05, 2010 at 01:45:54PM -0700, Dave Kleikamp wrote:
>+config ISS4xx
>+	bool "ISS 4xx Simulator"
>+	depends on (44x || 40x)
>+	default n
>+	select 405GP if 40x
>+	select 440GP if 44x && !PPC_47x
>+	select PPC_FPU
>+	select OF_RTC
>+	help
>+	  This option enables support for the IBM ISS simulation environment

This looks like how we want to do this, however...

>+/* We can have either UICs or MPICs */
>+static void __init iss4xx_init_irq(void)
>+{
>+	struct device_node *np;
>+
>+	/* Find top level interrupt controller */
>+	for_each_node_with_property(np, "interrupt-controller") {
>+		if (of_get_property(np, "interrupts", NULL) == NULL)
>+			break;
>+	}
>+	if (np == NULL)
>+		panic("Can't find top level interrupt controller");
>+
>+	/* Check type and do appropriate initialization */
>+	if (of_device_is_compatible(np, "ibm,uic")) {
>+		uic_init_tree();
>+		ppc_md.get_irq = uic_get_irq;
>+	} else if (of_device_is_compatible(np, "chrp,open-pic")) {
>+		/* The MPIC driver will get everything it needs from the
>+		 * device-tree, just pass 0 to all arguments
>+		 */
>+		struct mpic *mpic = mpic_alloc(np, 0, MPIC_PRIMARY, 0, 0,
>+					       " MPIC     ");
>+		BUG_ON(mpic == NULL);
>+		mpic_init(mpic);
>+		ppc_md.get_irq = mpic_get_irq;
>+	} else
>+		panic("Unrecognized top level interrupt controller");
>+}

.. on non-476 builds we get link errors:

arch/powerpc/platforms/built-in.o: In function `as1_writeb':
(.init.text+0x5d4): undefined reference to `mpic_alloc'
arch/powerpc/platforms/built-in.o: In function `as1_writeb':
(.init.text+0x5e4): undefined reference to `mpic_init'
arch/powerpc/platforms/built-in.o: In function `as1_writeb':
(.init.text+0x5ea): undefined reference to `mpic_get_irq'
arch/powerpc/platforms/built-in.o: In function `as1_writeb':
(.init.text+0x5ee): undefined reference to `mpic_get_irq'
make: *** [.tmp_vmlinux1] Error 1

because we don't have CONFIG_MPIC turned on for these.  I'd suggest we guard
the mpic else chunk in this file behind CONFIG_MPIC.  Agreed?

I'm less worried about the mpic references that are already guarded behind the
CONFIG_SMP sections.  Nobody has been crazy enough to make an SMP 440 or 460 SoC
yet, so CONFIG_SMP should only get selected for 476, and that already selects
MPIC in the Kconfig.

josh
