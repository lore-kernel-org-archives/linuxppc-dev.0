Return-Path: <linuxppc-dev+bounces-25876-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E81C5CFC1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 21:01:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hMF505ZnBz2ykT;
	Sat, 15 Aug 2026 07:01:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::645"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786741268;
	cv=none; b=M+MztiSACss5VJRhrDkWaI5ax4411CN0fkZcCjlfT/x4DH2kgRoAoJ+usyK5MKQTnj2sUAbeO6WxraSzvudhaiSamFyWMUHtSwSZh2vOT8oA9xc9aXsZG8IO3g6UZJKGPwbkpb2ze2trb1+TdtBidT1aMig+/yktj8ZlDQe39d62+v655jRsvRNkASzHMaUaq99A5bnEtAZVCsNfjJtWdfc9qXQvZAZFuz71upukEcjrA3uwRLNg9662UfV6LCZNrxLwGz/m9+3VRQXtumLh2Sw+TNj/TEAJVlkzqB9DXpV6nqL/tXncE7r3IKroTdRRHINM4p4jt4tMroQi3Ej4Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786741268; c=relaxed/relaxed;
	bh=7b9OMXuv3ZP+H19/AmnDH9qKEt9RkVpbpVuxQpQ0/a8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QqIhlFoDh51iOxbwXyY/OI9FdQNj53VlRB2Kd2f8zGz5WtDGwxb44L5W7tAgXipKL2fTUaLX2IDlSkhnDvPHLol16gPUBYbQWGeTaQAkkO7B4aZM8sdwJGQd+9dmfu7xNy+s90t2j4f6JMsdRkaEKquov49cUodi00j8NnS0+IHBqDCbr1IJjdKMly0pV9IqD9/vbd5Hd+s1fR65KXIXJik5cP6fCS99/gFAkHYzxPMmSozKvpwKgmHNOne9ds1QMW3hHKrCG5O+y9k0w3/ndcmMsXWi+s+EZH3+TlrAOWJvpKDfogrh99WupWAGQe+N94TtGrCtMUu3QkxKYKRj2A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=SqWYvUc/; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::645; helo=mail-ej1-x645.google.com; envelope-from=3dyj_agkkdgobizcvaipcowwotm.kwutqvcfxxk-lmdtqaba.whtija.wzo@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=SqWYvUc/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--tarunsahu.bounces.google.com (client-ip=2a00:1450:4864:20::645; helo=mail-ej1-x645.google.com; envelope-from=3dyj_agkkdgobizcvaipcowwotm.kwutqvcfxxk-lmdtqaba.whtija.wzo@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x645.google.com (mail-ej1-x645.google.com [IPv6:2a00:1450:4864:20::645])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hMF4y47VZz2xyk
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2026 07:01:06 +1000 (AEST)
Received: by mail-ej1-x645.google.com with SMTP id a640c23a62f3a-c1f548718d0so154724666b.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 14:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786741262; x=1787346062; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7b9OMXuv3ZP+H19/AmnDH9qKEt9RkVpbpVuxQpQ0/a8=;
        b=SqWYvUc/1sv54ysKndod6UBLDuuqASplN82kDVdTSucKtoEU/2Skm9jXCVYUg9RcrL
         eiZJkUBXK2DdIGcPYZzxWOqEpTGzoZnxcXXLeaoe+BUNke3nAB/VMsXtsBU4T1+1mxch
         RY4SQB2NLon7E87119zy8sGAD0NiYBny4cmzfdTN3cUQ1kvWdatpaOtZbIEtORMjSS4O
         cej7ZiyECNAdIcTglfisjfYFfeoi8HeaT+HPdM/ge7/Wc/DQ7nV1rHK2Hes+SoJkfyco
         T76sdbGy8+Q7Wv8u39zdY/ziJdG9Rt5H11EQyFPClr7xz6WmaEjvkvqAixubuTUxzPyX
         m9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786741262; x=1787346062;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7b9OMXuv3ZP+H19/AmnDH9qKEt9RkVpbpVuxQpQ0/a8=;
        b=kAYc09nm+ngBPs7FXJ4uwwu/UeoMJvmaCv895PU7hXv/wusrUxowh9jm3TCWklj4Zy
         Pnw0mA6XwHLciZm8UEMXJj3BCh4PfQQKxRv9oZvH05rys0l+Hqdn27aK5GAYjRVoj/M+
         eGBmSi5wmNuhTqYz/YZmOsSZ0qLRr80COSIorYAEbNfudfQN8YgJ0vlhEoDdgEyAZAGG
         N+wKPiVRw0EZrCPP7+lkdIDBtpx2caT3dK1LFls8u6r7LSShPSGry7LJJX54VGtw93x8
         H7YG4ixy0EqkWRQtrBSZoI2II36yMNjHKHsz+eci1KXFw4ikx+AjB6p3Q8TS7H3XMALt
         36ng==
X-Forwarded-Encrypted: i=1; AHgh+RqxfGsYAvEVLUUXSSKYM7gxA6jxwIINPqWOpkHCTSnppmyGEig9V5bp6jgno4phmo1+2xwVD23P/ohM1/U=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwAGEV0owpMJq7xmFWuK5bDT/c1kVrco23uVYyMXaPE7lR7fdjt
	EE8BG8yYiGfk/848IrBnYyNPl+bNaQLfJGwe2+LBVF9i9Ch9LJ8gAg76v2f/6F1qMuBMsKb0BLu
	M1MoR3g3Nw9ejm7gIXQ==
X-Received: from ejcfz27.prod.google.com ([2002:a17:907:959b:b0:c09:e2fc:4344])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:a606:b0:c1c:2007:298e with SMTP id a640c23a62f3a-c212a208e62mr387287766b.24.1786741261643;
 Fri, 14 Aug 2026 14:01:01 -0700 (PDT)
Date: Fri, 14 Aug 2026 21:00:56 +0000
In-Reply-To: <20260814210057.4102768-1-tarunsahu@google.com>
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
Mime-Version: 1.0
References: <20260814210057.4102768-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814210057.4102768-3-tarunsahu@google.com>
Subject: [PATCH v3 2/3] firmware/edd: use kobject_put() on edd_device_register()
 failure
From: Tarun Sahu <tarunsahu@google.com>
To: helgaas@kernel.org, dmatlack@google.com, 
	Nicholas Piggin <npiggin@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	sourabhjain@linux.ibm.com, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Russell King <linux@armlinux.org.uk>, radheys@amd.com, 
	skhawaja@google.com, djeffery@redhat.com, Geoff Levand <geoff@infradead.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-arm-kernel@lists.infradead.org, souravsgl@google.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

As per koject_init_and_add() function kernel document, even if this
function returns error kobject_put must be used instead of kfree.

When edd_device_register() fails after initializing the kobject with
kobject_init_and_add(), calling kfree(edev) directly bypasses the
kobject release callback (edd_release) and leaks the allocated kobject
resources.

Fix this by replacing direct kfree(edev) with kobject_put(&edev->kobj) on
registration failure.

Signed-off-by: Tarun Sahu <tarunsahu@google.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 drivers/firmware/edd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
index f980c5b56858..763e7b16d517 100644
--- a/drivers/firmware/edd.c
+++ b/drivers/firmware/edd.c
@@ -748,7 +748,7 @@ edd_init(void)
 
 		rc = edd_device_register(edev, i);
 		if (rc) {
-			kfree(edev);
+			kobject_put(&edev->kobj);
 			goto out;
 		}
 		edd_devices[i] = edev;
-- 
2.55.0.691.gc56d675ccc-goog


