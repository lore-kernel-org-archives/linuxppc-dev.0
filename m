Date: Fri, 28 Jun 2002 07:53:39 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH/RFC] Fixing kd_mksound again...
Message-ID: <20020628145339.GI26734@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Currently in linuxppc_2_4 (and 2.5) we always use the PC-style
kd_mksound on __powerpc__ (=> PPC32, not PPC64 ?) and override that in
the pmac port to something more sensible.  I would like to propose the
following patch which expands the test to __powerpc__ && CONFIG_6xx.
While it is possible to override kd_mksound later on, in a
per-board/platform fashion, I think it makes the most sense to default
to the PC-style version when we can be reasonably sure that it will work
(i.e., it does work on my LoPEC and I think Sandpoint X3 as well) and
otherwise assume that it won't (i.e., 405, Redwood4, probably 8xx).
In the cases where it currently isn't working anyhow[1] if someone wants
to make this work, they will have to override the given _kd_mksound
anyhow, so using the empty one by default is best here.

The following patch applies cleanly against both 2.4.19-rc1 and 2.5.24.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

[1]: I bring this up since I just got a report that it doesn't work on
PPC405 systems, and based on the RW4 check in _devel in this code, I'm
not supprised.  This patch will supersede the current _devel part, of
course.

===== drivers/char/vt.c 1.10 vs edited =====
--- 1.10/drivers/char/vt.c	Mon May  6 09:18:24 2002
+++ edited/drivers/char/vt.c	Fri Jun 28 07:42:52 2002
@@ -90,7 +90,8 @@
  * comments - KDMKTONE doesn't put the process to sleep.
  */

-#if defined(__i386__) || defined(__alpha__) || defined(__powerpc__) \
+#if defined(__i386__) || defined(__alpha__) || \
+    || (defined(__powerpc__) && defined(CONFIG_6xx)) \
     || (defined(__mips__) && defined(CONFIG_ISA)) \
     || (defined(__arm__) && defined(CONFIG_HOST_FOOTBRIDGE)) \
     || defined(__x86_64__)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
