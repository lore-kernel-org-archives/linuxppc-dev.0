Return-Path: <murzin.v@gmail.com>
Received: from mail-lb0-x230.google.com (mail-lb0-x230.google.com
 [IPv6:2a00:1450:4010:c04::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7535F2C00F8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Sep 2013 22:42:10 +1000 (EST)
Received: by mail-lb0-f176.google.com with SMTP id y6so3620977lbh.35
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Sep 2013 05:42:04 -0700 (PDT)
From: Vladimir Murzin <murzin.v@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: fix section mismatch warning in free_lppacas
Date: Sun, 29 Sep 2013 14:41:18 +0200
Message-Id: <1380458478-2324-1-git-send-email-murzin.v@gmail.com>
Cc: geoff@infradead.org, Vladimir Murzin <murzin.v@gmail.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While cross-building for PPC64 I've got bunch of

WARNING: arch/powerpc/kernel/built-in.o(.text.unlikely+0x2d2): Section
mismatch in reference from the function .free_lppacas() to the variable
.init.data:lppaca_size The function .free_lppacas() references the variable
__initdata lppaca_size. This is often because .free_lppacas lacks a __initdata
annotation or the annotation of lppaca_size is wrong.

Fix it by using proper annotation for free_lppacas. Additionally, annotate
{allocate,new}_llpcas properly.

Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
---
 arch/powerpc/kernel/paca.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 3fc16e3..0620eaa 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -46,7 +46,7 @@ struct lppaca lppaca[] = {
 static struct lppaca *extra_lppacas;
 static long __initdata lppaca_size;
 
-static void allocate_lppacas(int nr_cpus, unsigned long limit)
+static void __init allocate_lppacas(int nr_cpus, unsigned long limit)
 {
 	if (nr_cpus <= NR_LPPACAS)
 		return;
@@ -57,7 +57,7 @@ static void allocate_lppacas(int nr_cpus, unsigned long limit)
 						 PAGE_SIZE, limit));
 }
 
-static struct lppaca *new_lppaca(int cpu)
+static struct lppaca * __init new_lppaca(int cpu)
 {
 	struct lppaca *lp;
 
@@ -70,7 +70,7 @@ static struct lppaca *new_lppaca(int cpu)
 	return lp;
 }
 
-static void free_lppacas(void)
+static void __init free_lppacas(void)
 {
 	long new_size = 0, nr;
 
-- 
1.8.1.5
