Date: Tue, 26 Jun 2001 16:29:13 -0500
From: Takashi Oe <toe@unlserve.unl.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Crash on BenH's latest rsync (2.4.6-pre3)
Message-Id: <20010626162913.3dc483d8.toe@unlserve.unl.edu>
In-Reply-To: <20010626205147.26310@smtp.wanadoo.fr>
References: <20010626121003.D31231@opus.bloom.county>
	<20010626205147.26310@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

BootX support on your rsync tree and linuxppc_2_4_devel tree is
broken.  I guess no one with BootX bothered to try
linuxppc_2_4_devel..


Takashi Oe

--- linux-2.4-benh/arch/ppc/kernel/setup.c.ORIG	Wed Jun 20 17:49:30 2001
+++ linux-2.4-benh/arch/ppc/kernel/setup.c	Tue Jun 26 16:24:06 2001
@@ -480,6 +480,11 @@
 	if ( ppc_md.progress ) ppc_md.progress("id mach(): start", 0x100);

 #ifdef CONFIG_ALL_PPC
+	/* prom_init has already been called from __start */
+	/* relocate_nodes() must be called before intuit_machine_type() */
+	if (boot_infos)
+		relocate_nodes();
+
 	/* if we didn't get any bootinfo telling us what we are... */
 	if ( _machine == 0 )
 	{
@@ -494,10 +499,6 @@

 	if ( have_of )
 	{
-		/* prom_init has already been called from __start */
-		if (boot_infos)
-			relocate_nodes();
-
 		/* _machine must be defined by now, so this is safe. */
 		finish_device_tree();
 		/*

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
