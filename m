Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FC9C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 02:06:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF16220865
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 02:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihlXv5uD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF16220865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4339JW0XPFzDqLh
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 13:06:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ihlXv5uD";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ihlXv5uD"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4339BZ3HBhzDqP2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 13:01:26 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id h3so5775697pfg.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Nov 2018 18:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MwVyjHp/fiWyn0O0W9Rih+wjIXZmpTnAagHUb6jvH1Q=;
 b=ihlXv5uDuokNaGTSiWI2p1uhQjtoM/t4C6UGuy1B4BO8z5NIwI+/lQXOyyhMmvXTiU
 K5EiiOjb04N0u3u9wrA7QrpnechssIwnnQzv9rVykt5sgQYMSZlL0ywfZvzceWx9vdKL
 cf/NvUPy8sn+JJKwfu2Gubx1qDkVE1q0pg9ET3pvZ60colM3ltxS0+Z+snOKI1BqJVXc
 5FNziZ347ErSkK+bggBQhjCOzU6Tz5x3WWo5lK6ethNEGO7t8i/B5EolN344Uk0Kel1v
 EUxMOJ2q2CFu0Fz29WriOzqX4lUJ0spfUqwlE6zBFdAHhrxoUCwY2eATS/mdFQVePTib
 3fHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MwVyjHp/fiWyn0O0W9Rih+wjIXZmpTnAagHUb6jvH1Q=;
 b=N743dpDsCVrqOr+Q58z83ft99hMki4b87wJIrEI86TLGjxe3vtEvj/ewolhTx4xId8
 a5sux959FegQL70s2zfOegvIDA0Ktbsa5CryaikqbfqcGL8sM1S9HiA5BJn2193e0fyJ
 G+U8p1hSWfPSzwls0e10Ohh/XQa0BusjMZ1ifTqgUDzTPCwAX/hGrtSAmhc83v32oXBZ
 vE5YcN6w1DG0fSqDqXRvzif7wPAzGjpgQ6aroPbcYZU7zBhvY82aHzxpNgK2me49fL/J
 EnbkivoIG494d483mMV/2LJ4WCaBNr21t2YmnB56OV/G1Sj8mqxUsbfjYF+Xsd7Bicov
 uibw==
X-Gm-Message-State: AA+aEWYPgZaYHCqt3ltgeYHOT47L/oVuPnMqZsw0H2TnnBxbbfyeOHKB
 199Vhgf6e+di9DLy9u5DY+nNUXBpi78=
X-Google-Smtp-Source: AFSGD/XmpbPmXeLyv0bMDzUmH2dsyhNzTxQ8hyhIBohmlKxS0ihN+tbvFoOUAUX93yTEiwp2iV7QyQ==
X-Received: by 2002:a62:6f49:: with SMTP id k70mr3324485pfc.7.1543197684391;
 Sun, 25 Nov 2018 18:01:24 -0800 (PST)
Received: from bobo.local0.net (203-221-165-244.tpgi.com.au. [203.221.165.244])
 by smtp.gmail.com with ESMTPSA id b5sm76675525pfc.150.2018.11.25.18.01.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 25 Nov 2018 18:01:23 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] powerpc/smp: Fix NMI IPI timeout
Date: Mon, 26 Nov 2018 12:01:05 +1000
Message-Id: <20181126020107.17250-2-npiggin@gmail.com>
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

The NMI IPI timeout logic is broken, if __smp_send_nmi_ipi times out
on the first condition, delay_us will be zero which will send it into
the second spin loop with no timeout so it will spin forever.

Fixes: 5b73151fff63 ("powerpc: NMI IPI make NMI IPIs fully sychronous")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/smp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 3f15edf25a0d..137196a4248b 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -519,7 +519,7 @@ int __smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us, bool
 		if (delay_us) {
 			delay_us--;
 			if (!delay_us)
-				break;
+				goto timeout;
 		}
 	}
 
@@ -530,10 +530,11 @@ int __smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us, bool
 		if (delay_us) {
 			delay_us--;
 			if (!delay_us)
-				break;
+				goto timeout;
 		}
 	}
 
+timeout:
 	if (!cpumask_empty(&nmi_ipi_pending_mask)) {
 		/* Timeout waiting for CPUs to call smp_handle_nmi_ipi */
 		ret = 0;
-- 
2.19.2

