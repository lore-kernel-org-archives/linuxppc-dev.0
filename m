Return-Path: <galak@freescale.com>
Date: Wed, 21 Sep 2005 15:44:11 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0509211543360.27905@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] powerpc: Fix compiling of ppc32
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The merging of auxvec.h into asm-powerpc introduced the AT_SYSINFO_EHDR
into the ppc32 build that is used for VDSO.  However, we dont have VDSO
support in the ppc32 tree at this time.  Introducing this define causes
a number of other things to get built with the assumption of VDSO, thus
causing the compile errors for ppc32.

Until we have VDSO on ppc32 we will leave AT_SYSINFO_EHDR a ppc64 only
define.

Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>

---
commit 8be656b5000421a25f147e712bb19417bf677c2f
tree a1ab3f3319f90b3ff8bfc4e0e12894c104a06531
parent fe759f4a2175afef92c603fe410aaf9785eb4c93
author Kumar K. Gala <kumar.gala@freescale.com> Wed, 21 Sep 2005 15:32:33 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Wed, 21 Sep 2005 15:32:33 -0500

 include/asm-powerpc/auxvec.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/asm-powerpc/auxvec.h b/include/asm-powerpc/auxvec.h
--- a/include/asm-powerpc/auxvec.h
+++ b/include/asm-powerpc/auxvec.h
@@ -14,6 +14,8 @@
 /* The vDSO location. We have to use the same value as x86 for glibc's
  * sake :-)
  */
+#ifdef __powerpc64__
 #define AT_SYSINFO_EHDR		33
+#endif
 
 #endif
