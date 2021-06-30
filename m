Return-Path: <SRS0=aNTg=LY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1709C11F65
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jun 2021 10:36:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97AAE61A2B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jun 2021 10:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97AAE61A2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GFHnr71H4z3098
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jun 2021 20:36:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=chronox.de header.i=@chronox.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=Pvsq6rKP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.helo=mo4-p00-ob.smtp.rzone.de (client-ip=85.215.255.22;
 helo=mo4-p00-ob.smtp.rzone.de; envelope-from=smueller@chronox.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=chronox.de header.i=@chronox.de header.a=rsa-sha256
 header.s=strato-dkim-0002 header.b=Pvsq6rKP; 
 dkim-atps=neutral
X-Greylist: delayed 179 seconds by postgrey-1.36 at boromir;
 Wed, 30 Jun 2021 20:36:02 AEST
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [85.215.255.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GFHnG2wppz2ym7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jun 2021 20:36:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1625049173;
 s=strato-dkim-0002; d=chronox.de;
 h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=zrELvurilohi17VMVTv19kjVdyfbFWDqfvMOj6MTPRU=;
 b=Pvsq6rKPcZhmpytH6ZY8J1FlsnG5uaIc1QHQUPMS/4IBGqVxL2P8fSr38kZAU7rhay
 /3vN8YimMXlmSaklR9qUtBhHC3C7QUT5vwTlsarM6qiHRYiI1RIrsKnsgC1xZptoU0qL
 zXIW9s2h6yBf31r09oWHMnGdIThojUeWT2v6ADnv8NIWoSufC2wKAMH0C4o5Ui4tw2kU
 HeB4Us0ZlQtGxOT7N+sXvPCQ4dayOkYs6ysOm/acRPYcHdYmshrM0CkteYv1IGoAT4Ho
 fbbijfjZwcxQWMl+Os19wwC+hs7R9Cu4ONz9td6vYPM8QX4HxTaFtM+/Ra1ZMo3IngWK
 NQ/w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNzyCzy1Sfr67uExK884PCF2aGHC1nvBRG6qaFpQl"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de by smtp.strato.de (RZmta 47.27.7 AUTH)
 with ESMTPSA id d01c2ax5UAWq0yP
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Wed, 30 Jun 2021 12:32:52 +0200 (CEST)
Message-ID: <304ee0376383d9ceecddbfd216c035215bbff861.camel@chronox.de>
Subject: [PATCH] crypto: DRBG - select SHA512
From: Stephan Mueller <smueller@chronox.de>
To: Sachin Sant <sachinp@linux.vnet.ibm.com>, linux-crypto@vger.kernel.org
Date: Wed, 30 Jun 2021 12:32:52 +0200
In-Reply-To: <73D2DF91-CC7A-46CD-8D48-63FFB1857D24@linux.vnet.ibm.com>
References: <73D2DF91-CC7A-46CD-8D48-63FFB1857D24@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

With the swtich to use HMAC(SHA-512) as the default DRBG type, the
configuration must now also select SHA-512.

Fixes: 9b7b94683a9b "crypto: DRBG - switch to HMAC SHA512 DRBG as default
DRBG"
Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Signed-off-by: Stephan Mueller <smueller@chronox.com>
---
 crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index ca3b02dcbbfa..64b772c5d1c9 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1768,7 +1768,7 @@ config CRYPTO_DRBG_HMAC
 	bool
 	default y
 	select CRYPTO_HMAC
-	select CRYPTO_SHA256
+	select CRYPTO_SHA512
 
 config CRYPTO_DRBG_HASH
 	bool "Enable Hash DRBG"
-- 
2.31.1



