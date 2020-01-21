Return-Path: <SRS0=KLET=3K=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB348C32771
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jan 2020 02:02:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A9FF207FF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jan 2020 02:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A9FF207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 481sHP0qKlzDqkX
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jan 2020 13:02:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=perches.com
 (client-ip=216.40.44.31; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
X-Greylist: delayed 449 seconds by postgrey-1.36 at bilbo;
 Tue, 21 Jan 2020 13:00:52 AEDT
Received: from smtprelay.hostedemail.com (smtprelay0031.hostedemail.com
 [216.40.44.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 481sFc5k14zDqW4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2020 13:00:50 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 10B091800864F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2020 01:53:30 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay04.hostedemail.com (Postfix) with ESMTP id 68169180A68AC;
 Tue, 21 Jan 2020 01:53:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shake46_56b5e3c028834
X-Filterd-Recvd-Size: 1824
Received: from XPS-9350.home (unknown [47.151.135.224])
 (Authenticated sender: joe@perches.com)
 by omf19.hostedemail.com (Postfix) with ESMTPA;
 Tue, 21 Jan 2020 01:53:15 +0000 (UTC)
Message-ID: <618f58cd46f0e4fd619cb2ee3c76665a28e30f4e.camel@perches.com>
Subject: Re: [PATCH -next] powerpc/maple: fix comparing pointer to 0
From: Joe Perches <joe@perches.com>
To: Chen Zhou <chenzhou10@huawei.com>, benh@kernel.crashing.org, 
 paulus@samba.org, mpe@ellerman.id.au
Date: Mon, 20 Jan 2020 17:52:15 -0800
In-Reply-To: <20200121013153.9937-1-chenzhou10@huawei.com>
References: <20200121013153.9937-1-chenzhou10@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 nivedita@alum.mit.edu, tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
 allison@lohutok.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2020-01-21 at 09:31 +0800, Chen Zhou wrote:
> Fixes coccicheck warning:
> ./arch/powerpc/platforms/maple/setup.c:232:15-16:
> 	WARNING comparing pointer to 0

Does anyone have or use these powerpc maple boards anymore?

Maybe the whole codebase should just be deleted instead.

If not, setup.c has an unused DBG macro that could be removed too.
---
 arch/powerpc/platforms/maple/setup.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index 47f7310..d6a083c 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -57,12 +57,6 @@
 
 #include "maple.h"
 
-#ifdef DEBUG
-#define DBG(fmt...) udbg_printf(fmt)
-#else
-#define DBG(fmt...)
-#endif
-
 static unsigned long maple_find_nvram_base(void)
 {
 	struct device_node *rtcs;


