Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A15C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 17:54:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D2492146E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 17:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="r2raxAxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D2492146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444QGj2SFSzDqML
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 04:54:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="r2raxAxb"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444Pjc5RqWzDqGY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 04:29:24 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 444PjX0MX2z9v0vy;
 Wed, 20 Feb 2019 18:29:20 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=r2raxAxb; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id ojwbZbXaCGQW; Wed, 20 Feb 2019 18:29:19 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 444PjW6PzRz9v0vr;
 Wed, 20 Feb 2019 18:29:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550683759; bh=rbzK6VyAdTHyLL0UVQmqZhhndDy082fNAq24IRLMG0k=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=r2raxAxbDoRNRjJfmAMELYJqHHYVXYQymO/MyBAE/2aRAhpys3HmxKxUPbIPCb1Y9
 1JJqTWrTs9xyU+2Z47dctb5owUqQCgItcaBFfioqmajlgliaFlnsYWCGdEKPBLTnMF
 xMqLCRjBxEfCs6S4k+m+oMLfXgUU8aMQnoGBROXI=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 89C138B84F;
 Wed, 20 Feb 2019 18:29:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id IX2vA2KKKvHT; Wed, 20 Feb 2019 18:29:21 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 668978B84A;
 Wed, 20 Feb 2019 18:29:21 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 555CA6E85E; Wed, 20 Feb 2019 17:29:21 +0000 (UTC)
Message-Id: <6d810ec0964ea9e84e8351b880ecd44dbc441631.1550648295.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550648295.git.christophe.leroy@c-s.fr>
References: <cover.1550648295.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 14/16] powerpc/kconfig: make _etext and data areas
 alignment configurable on Book3s 32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 j.neuschaefer@gmx.net
Date: Wed, 20 Feb 2019 17:29:21 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Depending on the number of available BATs for mapping the different
kernel areas, it might be needed to increase the alignment of _etext
and/or of data areas.

This patchs allows the user to do it via Kconfig.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 640a7cfba9d0..20c4e3a62b90 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -725,16 +725,44 @@ config THREAD_SHIFT
 	  Used to define the stack size. The default is almost always what you
 	  want. Only change this if you know what you are doing.
 
+config ETEXT_SHIFT_BOOL
+	bool "Set custom etext alignment" if STRICT_KERNEL_RWX && PPC_BOOK3S_32
+	depends on ADVANCED_OPTIONS
+	help
+	  This option allows you to set the kernel end of text alignment. When
+	  RAM is mapped by blocks, the alignment needs to fit the size and
+	  number of possible blocks. The default should be OK for most configs.
+
+	  Say N here unless you know what you are doing.
+
 config ETEXT_SHIFT
-	int
+	int "_etext shift" if ETEXT_SHIFT_BOOL
+	range 17 28 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
 	default 17 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
 	default PPC_PAGE_SHIFT
+	help
+	  On Book3S 32 (603+), IBATs are used to map kernel text.
+	  Smaller is the alignment, greater is the number of necessary IBATs.
+
+config DATA_SHIFT_BOOL
+	bool "Set custom data alignment" if STRICT_KERNEL_RWX && PPC_BOOK3S_32
+	depends on ADVANCED_OPTIONS
+	help
+	  This option allows you to set the kernel data alignment. When
+	  RAM is mapped by blocks, the alignment needs to fit the size and
+	  number of possible blocks. The default should be OK for most configs.
+
+	  Say N here unless you know what you are doing.
 
 config DATA_SHIFT
-	int
+	int "Data shift" if DATA_SHIFT_BOOL
 	default 24 if STRICT_KERNEL_RWX && PPC64
+	range 17 28 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
 	default 22 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
 	default PPC_PAGE_SHIFT
+	help
+	  On Book3S 32 (603+), DBATs are used to map kernel text and rodata RO.
+	  Smaller is the alignment, greater is the number of necessary DBATs.
 
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order"
-- 
2.13.3

