Date: Mon, 1 Jul 2002 08:27:27 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH/RFC] Change how we pick which _kd_mksound to use.
Message-ID: <20020701152727.GC20920@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The following changes how we pick a _kd_mksound.  The problem is that on
some machines, such as IBM405, the default _kd_mksound breaks horribly
due to the inb/outb's attempting to fiddle with timers which don't
exist.  This changes the test which selects either an empty _kd_mksound
or the one in question from __powerpc__ to CONFIG_PPC64 (since from what I
understand, __powerpc__ is defined on ppc64) || (CONFIG_PPC32 &&
CONFIG_6xx).  The CONFIG_6xx test is because these boards are the ones
which tend to have a SuperIO chip, or something else with the timers at
0x61, 0xB6, etc.

The other option would be to define an empty no_kd_mksound or so on
4xx/8xx and then conditionally set kd_mksound to that, but I would
prefer this since we're already doing some preprocessor checks anyhow.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== drivers/char/vt.c 1.9 vs edited =====
--- 1.9/drivers/char/vt.c	Tue Feb  5 00:55:25 2002
+++ edited/drivers/char/vt.c	Mon Jul  1 08:05:43 2002
@@ -90,7 +90,8 @@
  * comments - KDMKTONE doesn't put the process to sleep.
  */

-#if defined(__i386__) || defined(__alpha__) || defined(__powerpc__) \
+#if defined(__i386__) || defined(__alpha__) || defined(CONFIG_PPC64) \
+    || (defined(CONFIG_PPC32) && defined(CONFIG_6xx)) \
     || (defined(__mips__) && defined(CONFIG_ISA)) \
     || (defined(__arm__) && defined(CONFIG_HOST_FOOTBRIDGE)) \
     || defined(__x86_64__)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
