Date: Mon, 17 Sep 2001 12:28:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Board names for 4xx
Message-ID: <20010917122828.J3851@zax>
References: <20010914144403.G3851@zax> <20010914072847.R21906@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010914072847.R21906@cpe-24-221-152-185.az.sprintbbd.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Sep 14, 2001 at 07:28:47AM -0700, Tom Rini wrote:
> On Fri, Sep 14, 2001 at 02:44:03PM +1000, David Gibson wrote:
>
> > The patch below allows publishing the type of board the kernel is
> > running on in /proc/cpuinfo (under "machine") for 4xx machines.  It
> > displays Walnut boards as "IBM Walnut" and (currently) all others
> > simply as "4xx".  Adding other boards is trivial - just a #define in
> > the relevant header file.  It also eliminates a warning in
> > ppc4xx_setup.c
>
> Sounds neat.  But since a number of utils (some distro-specific) parse
> the machine: line, do you think something like:

Yes, the fact that things parse it is the main reason I thought to add
it.

> machine:\t\t<Core>: <Board>
> ie:
> 405GP: IBM Walnut
> 405GP: EmbeddedPlanet
> or
> 403CX: TiVo

I don't see why - this information already appears in the "cpu:"
field and on machines that do have the "machine:" field it doesn't
generally include processor type information.

Below is an updated patch.  It improves the formatting (two '\t's
instead of one), adds information for the Oak and ep405 boards, and
fixes conflicts with some more recent updates.

diff -urN ../linuxppc_2_4_devel/arch/ppc/kernel/ppc4xx_setup.c linux-bungo/arch/ppc/kernel/ppc4xx_setup.c
--- ../linuxppc_2_4_devel/arch/ppc/kernel/ppc4xx_setup.c	Mon Sep 17 10:32:05 2001
+++ linux-bungo/arch/ppc/kernel/ppc4xx_setup.c	Mon Sep 17 12:21:21 2001
@@ -86,7 +86,7 @@
 #endif

 #define BOOT_WDT_DEFAULT_PERIOD		120	/* 2 minutes */
-extern board_setup_arch(void);
+extern void board_setup_arch(void);

 void __init
 ppc4xx_setup_arch(void)
@@ -165,6 +165,8 @@
 	int len = 0;
 	bd_t *bip = (bd_t *)__res;

+	len += sprintf(len + buffer,
+		       "machine\t\t: %s\n", PPC4xx_MACHINE_NAME);
 #ifdef CONFIG_STB03xxx
 	len += sprintf(len + buffer,
 			"plb bus clock\t: %dMHz\n",
diff -urN ../linuxppc_2_4_devel/include/asm-ppc/oak.h linux-bungo/include/asm-ppc/oak.h
--- ../linuxppc_2_4_devel/include/asm-ppc/oak.h	Mon Sep 17 10:32:05 2001
+++ linux-bungo/include/asm-ppc/oak.h	Mon Sep 17 12:22:50 2001
@@ -60,6 +60,8 @@
 	unsigned int	 bi_busfreq;		/* Bus speed, in Hz */
 } bd_t;

+#define PPC4xx_MACHINE_NAME	"IBM Oak"
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __OAK_H__ */
 #endif /* __KERNEL__ */
diff -urN ../linuxppc_2_4_devel/include/asm-ppc/ppc4xx.h linux-bungo/include/asm-ppc/ppc4xx.h
--- ../linuxppc_2_4_devel/include/asm-ppc/ppc4xx.h	Mon Sep 17 10:32:05 2001
+++ linux-bungo/include/asm-ppc/ppc4xx.h	Mon Sep 17 12:23:29 2001
@@ -30,6 +30,10 @@
 #include <asm/ep405.h>
 #endif

+#ifndef PPC4xx_MACHINE_NAME
+#define PPC4xx_MACHINE_NAME	"4xx"
+#endif
+
 /* IO_BASE is for PCI I/O.
  * ISA not supported, just here to resolve copilation.
  */
diff -urN ../linuxppc_2_4_devel/include/asm-ppc/walnut.h linux-bungo/include/asm-ppc/walnut.h
--- ../linuxppc_2_4_devel/include/asm-ppc/walnut.h	Mon Sep 17 10:32:05 2001
+++ linux-bungo/include/asm-ppc/walnut.h	Mon Sep 17 12:19:31 2001
@@ -69,5 +69,7 @@
 #define kbd_write_output(val)  writeb(val, kb_data)
 #define kbd_write_command(val) writeb(val, kb_cs)

+#define PPC4xx_MACHINE_NAME	"IBM Walnut"
+
 #endif /* __WALNUT_H__ */
 #endif /* __KERNEL__ */


--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
