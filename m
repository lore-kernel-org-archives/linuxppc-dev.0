Return-Path: <linuxppc-dev+bounces-25964-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004B3C5DF81
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 18:44:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPdsL66HZz2y1Y;
	Wed, 19 Aug 2026 04:44:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1048"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787078662;
	cv=none; b=f+8+hUUef1iOUgGClRsDV5ralEmkNXVXfQRQ7W10EM3YCZhPGatdViee/W7Gz1huZwshiL5EZ/2K25/bp7mqsGZ0lFzq65BUVPxwngoNlAI0HWPZn1Zgp0BnwY1LNg/yce3KkRFRtzBxZP6z0scD2dzi7O/nU0zUAOyMFJjdNc00j2aLZ0z5rIa4mW/AWEPBSb7uD/4zfiWo+bVl3STY/p47nueop4Komp/isBgeJY4fd1zTCp27pYqwRAjgTM6cZiTocRAitmx5miStIp4mgCdhEDqguA0quj9lgXugfMlC/EpS8fc3rvX87IuMZdwr+s8kut4Dkz7EALwQDScYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787078662; c=relaxed/relaxed;
	bh=/6VLnCrFj77nEpm0xrqvTnbS1Ab1ZKiuI0ElgGAu+90=;
	h=MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:From:
	 To:Cc:Content-Type; b=bwSIPH33jkbannsxV/PxrTuzaHfI3eQSzuKNTlSJtK9UB6EdUq8FKLFQ5T3shJmCMZbal8lcQKwzaVkwnTIzoS0TAGW3WFzilLJhr9Yzl8LtmZUX/7g/Zx940U8hjSRKu7olS52XipG06xlkow/2r9umOutBpyWuDBrnIe4IvW/BGcY9egqRmZk/zFVNCDO9fNrPfC49Bc2+OacluXPoNWl8Vx8NeB8qEp8CTafVQ3VTRRCcJUzRVt+wHoqcOk2iucLOseGQaa72ElnKnpaMDjJT2B3Fet8geUg2hWbhX6V82bboLB9VlxrGQ0PaiE2MVUlQTfBXaICK62BdjyY3ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=AJjGuVUC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1048; helo=mail-pj1-x1048.google.com; envelope-from=3akieag0kdl0udwkrgsul1dqnjrrjoh.frpolqx0ssf-ghyolvwv.r2odev.ruj@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=AJjGuVUC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--rathodpriyank.bounces.google.com (client-ip=2607:f8b0:4864:20::1048; helo=mail-pj1-x1048.google.com; envelope-from=3akieag0kdl0udwkrgsul1dqnjrrjoh.frpolqx0ssf-ghyolvwv.r2odev.ruj@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1048.google.com (mail-pj1-x1048.google.com [IPv6:2607:f8b0:4864:20::1048])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPdsJ57LSz2xyB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2026 04:44:20 +1000 (AEST)
Received: by mail-pj1-x1048.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so344286a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 11:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787078657; x=1787683457; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject:date
         :message-id:references:in-reply-to:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/6VLnCrFj77nEpm0xrqvTnbS1Ab1ZKiuI0ElgGAu+90=;
        b=AJjGuVUCfLvavLyEJiTI4bJ3/j7V6VfMpJltRsw51FOiIfovdY8UJ/bKaMEuN2iiiB
         kBiI/G04Q6KZscWZ5hhk1dwUomXKN9Hg0UbkVTj9VnFKRakxXGAiOgamHAviz67jujR0
         vgixZMbAVkV8qBte6ceOzrTbqq1wN/YUjbvlJyYdAVSOe7M/HSizwZGKBTwjudC/E8mC
         MiGaVEVMVOMx0CV+vGal4zJ5pLXiXe7YUv7RhqaOl9nEt2ENF81RM9pNom85+cgH1THm
         t0/AGs4s+yC1k5EKDJHrYG2qLFCzWFI8e0PqYWiEAqw/rSWZ2ThvBSZTuUYalEGabWm7
         OUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787078657; x=1787683457;
        h=content-transfer-encoding:content-type:cc:to:from:subject:date
         :message-id:references:in-reply-to:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/6VLnCrFj77nEpm0xrqvTnbS1Ab1ZKiuI0ElgGAu+90=;
        b=D5+bbI3/MuFxvxiOYhLB1TvjCGoAaW6d225YLwLoJlVj6MCmqh8ahR2Xh5M5Hu3/aY
         CVM/1c+5fJgHLOW0EDL7igIpg4inb+uR2v7g4fvKZmr2OmkMJWkwfOxEBi5EORdi0MFB
         zD0Va/yVIz2AwoAmeb1/KUqdujaNT0HLvQTDHq3BKiG/g9tqxZM0JpI7JP5s2B1CX3hy
         MOeekYe0oTbbfUNznv+XAfOhG3AaB5IkejdjdkoirgnJAEOJVDxWdai/NulT/ye9lROU
         u/5+WcF25/eVX2yM4YEQTAbAeS6zWNip5vNcR4lzAbOW7uPAYQ4Py2yYJ70MuOC5oJDP
         HqJQ==
X-Gm-Message-State: AOJu0YwKWTxeX+M7KVHPnyuWhWQ83PEfq7tuIWKuCyDE5b6u9kKMD9qZ
	qHqrXM1JNRlYJHj85mUWlUrwNntrdWd3fzLRX2ZTDsWugqTHqY12j8mCv7Sd6eePTnHFKIbW9oO
	+UEORtvBmwa6eP9aAtrtR96TU4W1s5Q3qQA==
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
X-Received: from pgju12.prod.google.com ([2002:a63:f64c:0:b0:c9a:eb48:4a8])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:430a:b0:3cc:ea12:dde0 with SMTP id adf61e73a8af0-3ccea12e914mr8687967637.19.1787078656291;
 Tue, 18 Aug 2026 11:44:16 -0700 (PDT)
In-Reply-To: <20260803-b4-fix-aer-memleaks-v3-0-e87159611933@google.com>
References: <20260803-b4-fix-aer-memleaks-v3-0-e87159611933@google.com>
Message-ID: <18ccfa91cd9816e2.3137322e31392e39302e313337.1bc3e0.0000sendgmr@google.com>
Date: Tue, 18 Aug 2026 18:44:16 +0000
Subject: Re: [PATCH v3 0/2] PCI/AER: Fix ghes_estatus_pool memory leaks in
 error handling
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpUaGFuayB5b3UgZm9yIHRoZSByZXZpZXcgYW5kIHJlY29tbWVuZGF0aW9ucy4N
Cg0KV2hpbGUgdGhvc2UgcmVjb21tZW5kYXRpb25zIG1heSBiZSB2YWxpZCBhbmQgcmVsZXZhbnQs
IHRoZXkgYXJlIGNvbXBsZXRlbHkgIA0Kc2VwYXJhdGUgZnJvbSBhbmQgbm90IHJlbGF0ZWQgdG8g
dGhlIGN1cnJlbnQgY2hhbmdl4oCUd2hpY2ggaXMgc3RyaWN0bHkgIA0Kc2NvcGVkIHRvIGZpeGlu
ZyB0aGUgZ2hlc19lc3RhdHVzX3Bvb2wgbWVtb3J5IGxlYWtzIGluIGFlcl9yZWNvdmVyX3F1ZXVl
KCkgIA0KYW5kIGFlcl9yZWNvdmVyX3dvcmtfZnVuYygpLg0KDQpUaGVyZWZvcmUsIHRob3NlIHJl
Y29tbWVuZGF0aW9ucyB3aWxsIG5vdCBiZSBhZGRyZXNzZWQgYXMgcGFydCBvZiB0aGVzZSAgDQpj
b21taXRzIHNvIHRoYXQgd2UgY2FuIGtlZXAgdGhlIHNjb3BlIGZvY3VzZWQgYW5kIG1vdmUgdGhl
c2UgbWVtb3J5IGxlYWsgIA0KZml4ZXMgZm9yd2FyZC4NCg0KVGhhbmtzLA0KUHJpeWFuaw0K

