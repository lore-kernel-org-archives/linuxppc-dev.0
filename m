Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3400C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 02:11:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 481C920865
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 02:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdcWMEuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 481C920865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4339Qb1NRtzDqLh
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 13:11:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hdcWMEuI";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="hdcWMEuI"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4339Bg260MzDqP7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 13:01:31 +1100 (AEDT)
Received: by mail-pl1-x644.google.com with SMTP id f12-v6so13086359plo.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Nov 2018 18:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=N0GXqg42VQjauaBVb73gfJ52grYiBU0Li1Uh4mnxddk=;
 b=hdcWMEuIKZTOKQlSmaHeFbnpSjtYrateL3dwxMguZwTM227I9xwb1BePtBnoAuCNyM
 WqHafEeH6hE69jVJq5qbLVORoJ2yjCKUohjSmq3H3yFkxQ6Fu8pKNqttlZlnn8TO9j68
 vLKJoWy9j1KQgpO3WosroxQOyVvqsq3PmYNiPSpA3+2orsqV/jUlWmUMzi/5TeqU2FLW
 6sbp7NxsuXZrCtQdKHGnxVIEgieAQW27UiAXqMVGffuEFHN86QvR85LOCXgAAWF5HrMn
 1Mji43N5RUIVbAwIOg35TOWak5TONEcOtMtrLfF5PGTUamaAB/WCngQABzraPh3Hf7kM
 1OSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=N0GXqg42VQjauaBVb73gfJ52grYiBU0Li1Uh4mnxddk=;
 b=lCkHvLUcz1HbQue6A+tRm8Bbot30gdFXOAz9ZipHcyW+nsk0uppeg30eoYvZ6TL0fI
 jqXy1BtYafET6G+4tWcblCjiAkYlpdsEhptahRTXNelVvT4GbbQu49Yumk65+7t0yXWg
 KHOop+LE8EqjT9TSNFJRPQx8XWhRLSVXnWKL6VdvhS525BcglXDjq6FpkoDXLTZoZ9Ub
 PWt9aWO7NmpgxlzLwPfJbipLeK4a/9cV5OwXc2Zr4HNZKO8IlJFjYrPZjFRa1Zlf6J+t
 jtUMTn+uPOS8avMVYD9PfrSg/H1B7XeycmrsrB5utFnYEap8pUzraF9ehdbrJTxvJlIs
 8vCw==
X-Gm-Message-State: AA+aEWZtHcu/W0exfEK3+n9KyGtsunqK6ldZ43RuhmKgP4xNi1lhgVjK
 ucB3sF7cEvv/bBGwteXpqCcRTKCWSvI=
X-Google-Smtp-Source: AFSGD/WPAMRC45sUchauuaZXuptnhUR6hEEQS0Kvr7JA56q8FLZvjNgLhVDTU++2ybPdcAgHJXPYbw==
X-Received: by 2002:a17:902:bd46:: with SMTP id
 b6mr25340276plx.231.1543197689269; 
 Sun, 25 Nov 2018 18:01:29 -0800 (PST)
Received: from bobo.local0.net (203-221-165-244.tpgi.com.au. [203.221.165.244])
 by smtp.gmail.com with ESMTPSA id b5sm76675525pfc.150.2018.11.25.18.01.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Nov 2018 18:01:28 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc/smp: __smp_send_nmi_ipi static
Date: Mon, 26 Nov 2018 12:01:07 +1000
Message-Id: <20181126020107.17250-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126020107.17250-1-npiggin@gmail.com>
References: <20181126020107.17250-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 6e521a3f67ca..5366d9e7bed4 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -462,7 +462,8 @@ static void do_smp_send_nmi_ipi(int cpu, bool safe)
  * - delay_us > 0 is the delay before giving up waiting for targets to
  *   begin executing the handler, == 0 specifies indefinite delay.
  */
-int __smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us, bool safe)
+static int __smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *),
+				u64 delay_us, bool safe)
 {
 	unsigned long flags;
 	int me = raw_smp_processor_id();
-- 
2.19.2

