Return-Path: <anton@samba.org>
Date: Fri, 25 Nov 2011 16:35:57 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: Decode correct MSR bits in oops output
Message-ID: <20111125163557.5a464006@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On a 64bit book3s machine I have an oops from a system reset that
claims the book3e CE bit was set:

MSR: 8000000000021032 <ME,CE,IR,DR>  CR: 24004082  XER: 00000010

On a book3s machine system reset sets IBM bit 46 and 47 depending on
the power saving mode. Separate the definitions by type and for
completeness add the rest of the bits in.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/kernel/process.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/process.c	2011-11-25 13:22:24.294919094 +1100
+++ linux-build/arch/powerpc/kernel/process.c	2011-11-25 13:36:23.213834524 +1100
@@ -584,16 +584,32 @@ static struct regbit {
 	unsigned long bit;
 	const char *name;
 } msr_bits[] = {
+#if defined(CONFIG_PPC64) && !defined(CONFIG_BOOKE)
+	{MSR_SF,	"SF"},
+	{MSR_HV,	"HV"},
+#endif
+	{MSR_VEC,	"VEC"},
+	{MSR_VSX,	"VSX"},
+#ifdef CONFIG_BOOKE
+	{MSR_CE,	"CE"},
+#endif
 	{MSR_EE,	"EE"},
 	{MSR_PR,	"PR"},
 	{MSR_FP,	"FP"},
-	{MSR_VEC,	"VEC"},
-	{MSR_VSX,	"VSX"},
 	{MSR_ME,	"ME"},
-	{MSR_CE,	"CE"},
+#ifdef CONFIG_BOOKE
 	{MSR_DE,	"DE"},
+#else
+	{MSR_SE,	"SE"},
+	{MSR_BE,	"BE"},
+#endif
 	{MSR_IR,	"IR"},
 	{MSR_DR,	"DR"},
+	{MSR_PMM,	"PMM"},
+#ifndef CONFIG_BOOKE
+	{MSR_RI,	"RI"},
+	{MSR_LE,	"LE"},
+#endif
 	{0,		NULL}
 };
 
