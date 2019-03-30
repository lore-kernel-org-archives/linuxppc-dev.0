Return-Path: <SRS0=BcJT=SB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2AAC43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 13:02:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C08C620700
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 13:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C08C620700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sdf.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Wdzr17lszDqQl
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 00:02:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sdf.org
 (client-ip=205.166.94.20; helo=mx.sdf.org; envelope-from=lkml@sdf.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=sdf.org
Received: from mx.sdf.org (ol.sdf.org [205.166.94.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Wdxw4qgfzDqV6
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Mar 2019 00:00:34 +1100 (AEDT)
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
 by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id x2UD0H1N014264
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits) verified NO); 
 Sat, 30 Mar 2019 13:00:19 GMT
Received: (from lkml@localhost)
 by sdf.org (8.15.2/8.12.8/Submit) id x2UD0H0C020934;
 Sat, 30 Mar 2019 13:00:17 GMT
Date: Sat, 30 Mar 2019 13:00:17 GMT
From: George Spelvin <lkml@sdf.org>
Message-Id: <201903301300.x2UD0H0C020934@sdf.org>
To: heiko.carstens@de.ibm.com, lkml@sdf.org
Subject: Re: CONFIG_ARCH_SUPPORTS_INT128: Why not mips, s390, powerpc,
 and alpha?
In-Reply-To: <201903301030.x2UAUNOg026448@sdf.org>
References: <201903291307.x2TD772v013534@sdf.org>,
 <20190330084346.GA3801@osiris>,
 <201903301030.x2UAUNOg026448@sdf.org>
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
Cc: linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mips@vger.kernel.org, linux-alpha@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

I've been tracking down when "umulditi3" support was added to various
gcc platforms.  So far, I've found:

ia64: 2005-07-28, gcc 4.1.0
https://gcc.gnu.org/viewcvs/gcc?view=revision&revision=102463

mips: 2008-06-09, gcc 4.4.0
https://gcc.gnu.org/viewcvs/gcc?view=revision&revision=136600 

alpha: 2013-02-01, gcc 4.8.0
https://gcc.gnu.org/viewcvs/gcc?view=revision&revision=195668

s390: 2011-10-07, gcc 4.7.0
https://gcc.gnu.org/viewcvs/gcc?view=revision&revision=179647

ppc64: 2013-02-01, gcc 4.8.0
https://gcc.gnu.org/viewcvs/gcc?view=revision&revision=195667


Here's a revised s390 patch.

From e8ea8c0a5d618385049248649b8c13717b598a42 Mon Sep 17 00:00:00 2001
From: George Spelvin <lkml@sdf.org>
Date: Sat, 30 Mar 2019 10:27:14 +0000
Subject: [PATCH v2] s390: Enable CONFIG_ARCH_SUPPORTS_INT128 on 64-bit builds

If a platform supports a 64x64->128-bit widening multiply,
that allows more efficient scaling of 64-bit values in various
parts of the kernel.  GCC advertises __int128 support with the
__INT128__ #define, but we care about efficient inline
support, so this is a separate flag.

For s390, that was added on 2011-10-07 by
https://gcc.gnu.org/viewcvs/gcc?view=revision&revision=179647
which is part of GCC 4.7.

Signed-off-by: George Spelvin <lkml@sdf.org>
---
 arch/s390/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index ed554b09eb3f..6ddaee6573f4 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -372,6 +372,7 @@ endchoice
 
 config 64BIT
 	def_bool y
+	select ARCH_SUPPORTS_INT128 if GCC_VERSION >= 40700 || CC_IS_CLANG
 
 config COMPAT
 	def_bool y
-- 
2.20.1

