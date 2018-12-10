Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1231CC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 06:52:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63C8F2081C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 06:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63C8F2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Ctzd2xpmzDqnK
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 17:52:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43CtxL690kzDqkp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 17:50:14 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43CtxF65dqz9v6LW;
 Mon, 10 Dec 2018 07:50:09 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 7c8gn_KO7hqw; Mon, 10 Dec 2018 07:50:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43CtxF5W2Vz9v6LV;
 Mon, 10 Dec 2018 07:50:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2DDF38B79A;
 Mon, 10 Dec 2018 07:50:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id IcsyDM7uwaby; Mon, 10 Dec 2018 07:50:10 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 0A5828B74C;
 Mon, 10 Dec 2018 07:50:10 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id C8242716D9; Mon, 10 Dec 2018 06:50:09 +0000 (UTC)
Message-Id: <a9c14a1ca37b82dbe015d259cd60d8aea9e7847a.1544336305.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3] powerpc/uaccess: fix warning/error with access_ok()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 10 Dec 2018 06:50:09 +0000 (UTC)
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

With the following piece of code, the following compilation warning
is encountered:

	if (_IOC_DIR(ioc) != _IOC_NONE) {
		int verify = _IOC_DIR(ioc) & _IOC_READ ? VERIFY_WRITE : VERIFY_READ;

		if (!access_ok(verify, ioarg, _IOC_SIZE(ioc))) {

drivers/platform/test/dev.c: In function 'my_ioctl':
drivers/platform/test/dev.c:219:7: warning: unused variable 'verify' [-Wunused-variable]
   int verify = _IOC_DIR(ioc) & _IOC_READ ? VERIFY_WRITE : VERIFY_READ;

This patch fixes it by referencing 'type' in the macro allthough
doing nothing with it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v3: not changing __access_ok() anymyre, only referencing type in access_ok()

 v2: fixed the three direct users of __access_ok()

 arch/powerpc/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 15bea9a0f260..ebc0b916dcf9 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -63,7 +63,7 @@ static inline int __access_ok(unsigned long addr, unsigned long size,
 #endif
 
 #define access_ok(type, addr, size)		\
-	(__chk_user_ptr(addr),			\
+	(__chk_user_ptr(addr), (void)(type),		\
 	 __access_ok((__force unsigned long)(addr), (size), get_fs()))
 
 /*
-- 
2.13.3

