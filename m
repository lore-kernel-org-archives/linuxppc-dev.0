Return-Path: <linuxppc-dev+bounces-26567-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4024FC79F82
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 17:16:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hc35x0RDWz2yrf;
	Sat, 05 Sep 2026 03:16:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::545"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788542180;
	cv=none; b=gD0CmbzX8KVkTLJ5U1EztHop5u3i6FkxzOGFKqo35eG5DkmNMPV6EqZvv5nPUNZ9nzfKGH/LLVIzhOgAy3ZDCznRP2Ql6+Lq+xc33/gG1tezIKB3aXPgUU8h8Z46Vj7zRfzS0wmISAAEZuIEsuzN2B7r9eWLVCx0+fku3YGoKip1w0aMOWY+6viTcevRr3WHcPBrnM3yFifNUgJ39NqRgjBDERd2Eti9w21OMfH6sAoWn7Zm6yUqJl4ROtzNyq5DLfvgrmGHLcsYqC0PNF6s6i0KIH2YJ+gRln/6xKFsjwbbbUwHWjZL18OTKW8NoQf7e3TYJbDnNS3McTifwZ4SQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788542180; c=relaxed/relaxed;
	bh=9g3ixuSdmQCpOEGBBcnV25oj0cDJNzVy8Tk+QtmySWs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fhjK2DNHJjqrwTFCSmlbvFpcMxGvwYlIFV5cpT+N+Zel4tQpOs3IFJ1g1ewyZbk3sAAciof4Zrp9PQ5EbSBjREjIgBiawiD/cfTmtH6+sb7TRJxUpIqdwstkstRi+ER4o+vaI1a1zDFWBN/U3lH3360kY1Jaimkj2xDm+jTeQCdZJE1o63IqR7mXAcXiY5n7qSKB2ZAGpukoVFJot4ZZS6biaBfUdZ2raKSZmfXx3MKdVmunqD7rGc1DjVikVyiyPOvzeoJKK1UCPFwCXGZRrssBAfuOVNJ9luulfK/IVFkEKwOZdzatYGkQSH/BNB0s8XbpLB9d1VxOsrUAVCJD6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=CNDLC0Mr; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::545; helo=mail-ed1-x545.google.com; envelope-from=33_yaagkkdkatarunsahugoogle.comlinuxppc-devlists.ozlabs.org@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=CNDLC0Mr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--tarunsahu.bounces.google.com (client-ip=2a00:1450:4864:20::545; helo=mail-ed1-x545.google.com; envelope-from=33_yaagkkdkatarunsahugoogle.comlinuxppc-devlists.ozlabs.org@flex--tarunsahu.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x545.google.com (mail-ed1-x545.google.com [IPv6:2a00:1450:4864:20::545])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hc35v1rBRz2y2b
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Sep 2026 03:16:18 +1000 (AEST)
Received: by mail-ed1-x545.google.com with SMTP id 4fb4d7f45d1cf-6a6735afb87so1167503a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 10:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788542175; x=1789146975; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9g3ixuSdmQCpOEGBBcnV25oj0cDJNzVy8Tk+QtmySWs=;
        b=CNDLC0MrxYyhfbQu7N7hiKO0+qLC694GGGIfNhvVegKDRoVc0xOIDASl49MIyXOA4F
         OHB+svGbsti30Z1VE7M3c7o2f5ZqL32DRGdetyW1Dc/ozXzY3pQYx+RSHSRYbmAU18CI
         LhdpPZt+3NlDb6ri7hw5P8Rv6cUS8np1EXY1dAX1l120/qVd/+ja6UuBGLeyskMXorNG
         zKDaaWrEHR7oA7EqzfH4KBs/dUs7TGEL7OoBg2IgtWtC1JRNn0TL8EkguMzJCPv1MZ3c
         y2siIL5bdT2xDYsl5OcN51PAAmSYV90Gex+kZRsGkFq+eRQlBJkIZCUzt8ggNX3T0UKQ
         1ulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788542175; x=1789146975;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9g3ixuSdmQCpOEGBBcnV25oj0cDJNzVy8Tk+QtmySWs=;
        b=D3Yw/rjQOK+xSKK3CV+eFBELvGHYNbZLNIIPQxvx2+vr/CYdCR2ZB/+fZgIrLIYQlE
         5Z4Y5o1TAgvQAORoVMj90Luwy7HnYMzbyPddPbVASLH2HrisWNEVNoii306eHzJP8HP/
         hE67D/MeD1ALg0ABrvGAxLL8XQ1kD1icxmaKiO1DT4ChhbTMOUZgj+fWtYvDmHRsObPf
         0aLtWsg7kUQnIN50iZoCe4bsrRkddibsanswt6VsmpOWozC7Zpwi285wbW1KSMqdxPVu
         pMnp+a9rpXuW6VObghW1r4n8Cqq5SX9iSuPsU9IGJmBsXK7uuLW6zeSYXhzMqOijYWXX
         pyHw==
X-Gm-Message-State: AFuF++mnR8iEELOKcu8YW63OQz+sqIwBfaPPiAZIHEsYGFzocIRHwVVL
	M+XlgSnTacZi4ucNWMSkMRcSbKG8utZWXTBtIT+Y3tT7fzQxW2PZ7FO7/fhj5SlfYiWwNoTvOby
	CBnIJHJDERlmcmh3cjw==
X-Received: from edgi4-n2.prod.google.com ([2002:a05:6402:a584:20b0:6a5:f01e:c622])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:3203:b0:6a5:f9ab:bdfd with SMTP id 4fb4d7f45d1cf-6a7e8cb104fmr3745516a12.0.1788542175250;
 Fri, 04 Sep 2026 10:16:15 -0700 (PDT)
Date: Fri,  4 Sep 2026 17:16:08 +0000
In-Reply-To: <20260904171610.3342398-1-tarunsahu@google.com>
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
References: <20260904171610.3342398-1-tarunsahu@google.com>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904171610.3342398-3-tarunsahu@google.com>
Subject: [PATCH v4 2/3] firmware: edd: Fix kobject reference leak on
 registration failure
From: Tarun Sahu <tarunsahu@google.com>
To: Russell King <linux@armlinux.org.uk>, Geoff Levand <geoff@infradead.org>, 
	Masakazu Mokuno <mokuno@sm.sony.co.jp>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Paul Mackerras <paulus@ozlabs.org>, helgaas@kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	sourabhjain@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Tarun Sahu <tarunsahu@google.com>
Content-Type: text/plain; charset="UTF-8"

Per kobject_init_and_add() kernel-doc, calling kfree() directly on
error bypasses reference counting and skips the kobject's release
callback, leaking the reference.

Use kobject_put() instead of kfree() on registration failure to fix
this.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Tarun Sahu <tarunsahu@google.com>
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
2.55.0.979.g7e5102b832-goog


