Date: Wed, 8 Mar 2000 16:41:38 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Booting 2.3.48 (devel) kernel problems?
In-Reply-To: <20000308151946.024345@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.10.10003081629120.14132-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >So the framebuffer got mapped from OF but not from BootX.
>
> I think it worked with OF because we inherit from OF SDR1 and, by luck,
> OF page tables are high enough in memory to not have been damaged by the
> kernel. When booting via BootX, that's not the case.
>
> We should not try to access the framebuffer from identify_machine() and
> MMU_Init() unless it was mapped with a BAT in head.S (for debugging
> purposes). In normal cases, it will get mapped via map_bootx_text called
> from setup_arch() and can be used beyond that point.

In his own words :-)

------------------------------------8<-----------------------------------
 - make sure setting the display BAT in arch/ppc/mm/init.c (MMU_Init) is
commented out, this is a hack and need some alignement tricks to work in
all cases. It should already be in #if 0/#endif

 - in arch/ppc/kernel/pmac_setup.c, comment out the content of the
function pmac_progress. (Or change pmac_init() so that it sets
ppc_md.progress to NULL, and set it to pmac_progress only
pmac_setup_arch()).

The problem is that pmac_progress will try to print to the framebuffer at
a time where it's not mapped (MMU_Init).
------------------------------------8<-----------------------------------

Or, in a diff:

--- arch/ppc/kernel/pmac_setup.c.org	Wed Mar  8 16:41:53 2000
+++ arch/ppc/kernel/pmac_setup.c	Wed Mar  8 16:41:12 2000
@@ -229,6 +229,10 @@
 	struct device_node *cpu;
 	int *fp;

+#ifdef CONFIG_BOOTX_TEXT
+	ppc_md.progress = pmac_progress;
+#endif
+
 	/* Set loops_per_sec to a half-way reasonable value,
 	   for use until calibrate_delay gets called. */
 	cpu = find_type_devices("cpu");
@@ -687,7 +691,7 @@
         ppc_ide_md.io_base = _IO_BASE;	/* actually too early for this :-(
*/
 #endif
 #ifdef CONFIG_BOOTX_TEXT
-	ppc_md.progress = pmac_progress;
+	ppc_md.progress = NULL;
 #endif
 	if (ppc_md.progress) ppc_md.progress("pmac_init(): exit", 0);

Just unconfiguring BOOTX_TEXT would have done the same trick I guess.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
