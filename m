Return-Path: <zhong@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3AB5EB6F13
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2012 13:44:59 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Fri, 8 Jun 2012 04:32:28 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q583ilkb8520124
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jun 2012 13:44:48 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q583ilD2002565
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jun 2012 13:44:47 +1000
Message-ID: <1339127063.32077.8.camel@ThinkPad-T420>
Subject: [PATCH powerpc] fix Section mismatch warnings in prom_init.c
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: LKML <linux-kernel@vger.kernel.org>
Date: Fri, 08 Jun 2012 11:44:23 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patches tries to fix a couple of Section mismatch warnings like
following one:

WARNING: arch/powerpc/kernel/built-in.o(.text+0x2923c): Section mismatch
in reference from the function .prom_query_opal() to the
function .init.text:.call_prom()
The function .prom_query_opal() references
the function __init .call_prom().
This is often because .prom_query_opal lacks a __init 
annotation or the annotation of .call_prom is wrong.

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/prom_init.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c
b/arch/powerpc/kernel/prom_init.c
index 1b488e5..0794a30 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1312,7 +1312,7 @@ static struct opal_secondary_data {
 
 extern char opal_secondary_entry;
 
-static void prom_query_opal(void)
+static void __init prom_query_opal(void)
 {
 	long rc;
 
@@ -1436,7 +1436,7 @@ static void __init prom_opal_hold_cpus(void)
 	prom_debug("prom_opal_hold_cpus: end...\n");
 }
 
-static void prom_opal_takeover(void)
+static void __init prom_opal_takeover(void)
 {
 	struct opal_secondary_data *data = &RELOC(opal_secondary_data);
 	struct opal_takeover_args *args = &data->args;
-- 
1.7.1
