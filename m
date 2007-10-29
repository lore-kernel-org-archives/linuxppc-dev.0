Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 02945DE04D
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 06:24:24 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9TJOLiU006690
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 15:24:21 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9TJOLpb119772
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 13:24:21 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9TJOLaY021780
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 13:24:21 -0600
From: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: [PATCH] [Powerpc] include udbg.h when using udbg_printf
To: linuxppc-dev@ozlabs.org
Date: Mon, 29 Oct 2007 14:24:19 -0500
Message-ID: <20071029192417.7254.88915.stgit@farscape.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


[Powerpc] include udbg.h when using udbg_printf

this fixes the error
	error: implicit declaration of function ‘udbg_printf’

We have a few spots where we reference udbg_printf() without #including
udbg.h.  These are within #ifdef DEBUG blocks, so unnoticed until we do
a #define DEBUG or #define DEBUG_LOW nearby.

Signed-Off-By: Will Schmidt <will_schmidt@vnet.ibm.com>
---

 arch/powerpc/mm/hash_utils_64.c           |    1 +
 arch/powerpc/mm/slb.c                     |    1 +
 arch/powerpc/platforms/cell/smp.c         |    1 +
 arch/powerpc/platforms/pseries/firmware.c |    1 +
 4 files changed, 4 insertions(+), 0 deletions(-)


diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index c78dc91..94b8ca0 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -51,6 +51,7 @@
 #include <asm/cputable.h>
 #include <asm/sections.h>
 #include <asm/spu.h>
+#include <asm/udbg.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index bbd2c51..637afb2 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -25,6 +25,7 @@
 #include <asm/smp.h>
 #include <asm/firmware.h>
 #include <linux/compiler.h>
+#include <asm/udbg.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
diff --git a/arch/powerpc/platforms/cell/smp.c b/arch/powerpc/platforms/cell/smp.c
index 1c0acba..e443845 100644
--- a/arch/powerpc/platforms/cell/smp.c
+++ b/arch/powerpc/platforms/cell/smp.c
@@ -44,6 +44,7 @@
 #include <asm/rtas.h>
 
 #include "interrupt.h"
+#include <asm/udbg.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
diff --git a/arch/powerpc/platforms/pseries/firmware.c b/arch/powerpc/platforms/pseries/firmware.c
index 8b18a1c..b765b7c 100644
--- a/arch/powerpc/platforms/pseries/firmware.c
+++ b/arch/powerpc/platforms/pseries/firmware.c
@@ -25,6 +25,7 @@
 
 #include <asm/firmware.h>
 #include <asm/prom.h>
+#include <asm/udbg.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
