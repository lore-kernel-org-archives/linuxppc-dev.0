Return-Path: <SRS0=ULCe=QH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FEBC282D7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 02:56:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C8B520989
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 02:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="KS/klICh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8B520989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qlHY6Rf5zDqVv
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 13:56:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.78; helo=conuserg-11.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="KS/klICh"; 
 dkim-atps=neutral
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qlFh1M3tzDqT8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 13:54:47 +1100 (AEDT)
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id x0V2rd64008650;
 Thu, 31 Jan 2019 11:53:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x0V2rd64008650
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1548903220;
 bh=5uoBhSU0NECHQSXDysma0LK2UEd1UzpFB2egb+QJU5s=;
 h=From:To:Cc:Subject:Date:From;
 b=KS/klIChkS3UtvxOk79uttMt3fcMy/mNvVZ8b50mZzyRGsikVuE0pN2ToUb1b0Pnl
 zdIGr0hSikUsUjWPWNjiUK8BacOmmfA1Zd2ez4gKqpIgAiRF/TH0J+NekAV3qSAAE9
 PnXGVyCwm+mM8Qo0zRcwnIxljPIqHc54g9lSxBaE2ydIvcxjxwSEJNUsNnz1cCOdAS
 Fr9oERmof9ijbOsqR2zVs6dPPTP8koXPfkZJlB1IGaCMBFK0lV+j35jdOLNv8rbYud
 liI/K5sreO0MKOStd8bJv9H7We39Rtd0Y8WmSR77+GeJoYQhJCAocP/FTXG9AQ8S+P
 K6b8Fxs8s+FWQ==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc/prom_init: add __init markers to all functions
Date: Thu, 31 Jan 2019 11:53:19 +0900
Message-Id: <1548903199-32695-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mathieu Malaterre <malat@debian.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

It is fragile to rely on the compiler's optimization to avoid the
section mismatch. Some functions may not be necessarily inlined
when the compiler's inlining heuristic changes.

Add __init markers consistently.

As for prom_getprop() and prom_getproplen(), they are marked as
'inline', so inlining is guaranteed because PowerPC never enables
CONFIG_OPTIMIZE_INLINING. However, it would be better to leave the
inlining decision to the compiler. I replaced 'inline' with __init.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/powerpc/kernel/prom_init.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index f33ff41..85b0719 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -501,19 +501,19 @@ static int __init prom_next_node(phandle *nodep)
 	}
 }
 
-static inline int prom_getprop(phandle node, const char *pname,
+static int __init prom_getprop(phandle node, const char *pname,
 			       void *value, size_t valuelen)
 {
 	return call_prom("getprop", 4, 1, node, ADDR(pname),
 			 (u32)(unsigned long) value, (u32) valuelen);
 }
 
-static inline int prom_getproplen(phandle node, const char *pname)
+static int __init prom_getproplen(phandle node, const char *pname)
 {
 	return call_prom("getproplen", 2, 1, node, ADDR(pname));
 }
 
-static void add_string(char **str, const char *q)
+static void __init add_string(char **str, const char *q)
 {
 	char *p = *str;
 
@@ -523,7 +523,7 @@ static void add_string(char **str, const char *q)
 	*str = p;
 }
 
-static char *tohex(unsigned int x)
+static char __init *tohex(unsigned int x)
 {
 	static const char digits[] __initconst = "0123456789abcdef";
 	static char result[9] __prombss;
@@ -570,7 +570,7 @@ static int __init prom_setprop(phandle node, const char *nodename,
 #define islower(c)	('a' <= (c) && (c) <= 'z')
 #define toupper(c)	(islower(c) ? ((c) - 'a' + 'A') : (c))
 
-static unsigned long prom_strtoul(const char *cp, const char **endp)
+static unsigned long __init prom_strtoul(const char *cp, const char **endp)
 {
 	unsigned long result = 0, base = 10, value;
 
@@ -595,7 +595,7 @@ static unsigned long prom_strtoul(const char *cp, const char **endp)
 	return result;
 }
 
-static unsigned long prom_memparse(const char *ptr, const char **retptr)
+static unsigned long __init prom_memparse(const char *ptr, const char **retptr)
 {
 	unsigned long ret = prom_strtoul(ptr, retptr);
 	int shift = 0;
@@ -2924,7 +2924,7 @@ static void __init fixup_device_tree_pasemi(void)
 	prom_setprop(iob, name, "device_type", "isa", sizeof("isa"));
 }
 #else	/* !CONFIG_PPC_PASEMI_NEMO */
-static inline void fixup_device_tree_pasemi(void) { }
+static inline void __init fixup_device_tree_pasemi(void) { }
 #endif
 
 static void __init fixup_device_tree(void)
@@ -2986,15 +2986,15 @@ static void __init prom_check_initrd(unsigned long r3, unsigned long r4)
 
 #ifdef CONFIG_PPC64
 #ifdef CONFIG_RELOCATABLE
-static void reloc_toc(void)
+static void __init reloc_toc(void)
 {
 }
 
-static void unreloc_toc(void)
+static void __init unreloc_toc(void)
 {
 }
 #else
-static void __reloc_toc(unsigned long offset, unsigned long nr_entries)
+static void __init __reloc_toc(unsigned long offset, unsigned long nr_entries)
 {
 	unsigned long i;
 	unsigned long *toc_entry;
@@ -3008,7 +3008,7 @@ static void __reloc_toc(unsigned long offset, unsigned long nr_entries)
 	}
 }
 
-static void reloc_toc(void)
+static void __init reloc_toc(void)
 {
 	unsigned long offset = reloc_offset();
 	unsigned long nr_entries =
@@ -3019,7 +3019,7 @@ static void reloc_toc(void)
 	mb();
 }
 
-static void unreloc_toc(void)
+static void __init unreloc_toc(void)
 {
 	unsigned long offset = reloc_offset();
 	unsigned long nr_entries =
-- 
2.7.4

