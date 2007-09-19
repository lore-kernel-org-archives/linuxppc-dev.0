Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 19 Sep 2007 14:21:56 +1000
Subject: [PATCH 1/2] powerpc: Don't expose clock vDSO functions when CPU has
	no timebase
Message-Id: <20070919042157.2CD09DDE1C@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We forgot to remove the clock_gettime, clock_getres and get_tbfreq vDSO
calls on CPUs that have no timebase such as 601 or 403 (old CPUs that have
different mechanisms and for which the vDSO code will not work properly).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/vdso.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: linux-work/arch/powerpc/kernel/vdso.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/vdso.c	2007-09-18 16:54:37.000000000 +1000
+++ linux-work/arch/powerpc/kernel/vdso.c	2007-09-18 16:55:11.000000000 +1000
@@ -98,6 +98,18 @@ static struct vdso_patch_def vdso_patche
 		CPU_FTR_USE_TB, 0,
 		"__kernel_gettimeofday", NULL
 	},
+	{
+		CPU_FTR_USE_TB, 0,
+		"__kernel_clock_gettime", NULL
+	},
+	{
+		CPU_FTR_USE_TB, 0,
+		"__kernel_clock_getres", NULL
+	},
+	{
+		CPU_FTR_USE_TB, 0,
+		"__kernel_get_tbfreq", NULL
+	},
 };
 
 /*
