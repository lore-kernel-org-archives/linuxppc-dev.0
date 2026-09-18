Return-Path: <linuxppc-dev+bounces-27746-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5EBC982D7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 17:25:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmfdX1S1qz30TL;
	Sat, 19 Sep 2026 03:25:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1047"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789752304;
	cv=none; b=lFDVFSStYopq917cSxOfBo6RUQZqP4dq68mQ22OspgXvuqVzKfOlvwHaVSEQFIEZkUBaf7pMV7m/CVtads8hBtiQAMhv8Rv9iMkPXmFt3vhT7ekBg3WiZ48rO4ulP7Z4UU8mJR/3J1HOflIW2pBqsk1L3688SHd4xl6tQe016lKBqpTPKJXkjMNjd7/grVRfjp8jM7TQYq5aJvnXYe0HcB0Uu7jnlKImmX4GQO0LfvkkCm7SJ2zIMhsbFSwDTCPCPj3pWg3rdPCK51q5k+3ujpor6aVSqev1wILo7s/znp8P6K1HDstK0vp+RJYb7pIjU6J8o2zdFVTUqzyzzjF1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789752304; c=relaxed/relaxed;
	bh=72PNOxgvBxEa/OyDxE8+wmcHMjmCVv+wNt0o6l7GD3A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d1oeJBSytzqrqXZaE9rUQdl3qSkwsruiTlcmGQrw4eFNqcxyyD2bAHbw6QaBWYuzex4TzXYCQGlDUsRsMGG2lRnuN/wVOBR20OO6iEF92CT1KBl5egax3Yvs+E4LB6xLnX196rhJDZkamLNwqkjOkCX1cbWKrjb3JpWgBjKWT9OJ/G8hoU1wvgHsgHfFbsIagu/kBt/eskZgV+ZIaOvU2Vt8xKe+aGGQ5yz1PXsX6afRFLfn1lHoyc0s8yL62sTO1AnhRq9j0cRayHoCq85xEfkPEH91zOX3yqIC1dLl9B7yHo8XoVxORTTp4eQIcV88N4d+c+w5fQObloQkdBwp8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=qKG/JfcD; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1047; helo=mail-pj1-x1047.google.com; envelope-from=37hotag0kdouyhaovkwypfhurnvvnsl.jvtspubewwj-klcspzaz.vgshiz.vyn@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=qKG/JfcD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--rathodpriyank.bounces.google.com (client-ip=2607:f8b0:4864:20::1047; helo=mail-pj1-x1047.google.com; envelope-from=37hotag0kdouyhaovkwypfhurnvvnsl.jvtspubewwj-klcspzaz.vgshiz.vyn@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1047.google.com (mail-pj1-x1047.google.com [IPv6:2607:f8b0:4864:20::1047])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmfdW21Zkz30Nl
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 03:25:03 +1000 (AEST)
Received: by mail-pj1-x1047.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so1235089a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 10:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789752301; x=1790357101; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=72PNOxgvBxEa/OyDxE8+wmcHMjmCVv+wNt0o6l7GD3A=;
        b=qKG/JfcDosDKYVDlpprPijXbdmv0kJbbb/yObze+qLlxUA6zgGO75UT9/iVYE6z3Ub
         J+NvzJg4cHnG9ncVvrPsu6ltyC5b3Rj9jVCTlXTndHCGg7LwJqatg1lCesbeh5SJhHan
         nJH94OkovmIZQ+UipxwYJFpeImEymcZHdKAcSAiuxkQhCQyQsjmzdXBV6hjy27l9Qa5Z
         A0EAGzW1F7F5aK0NDqTatWgopB8X5+oa82jRmIqxBueVaBHgpDxa8Bdx4YHm3N3crNo3
         q4mLZUesnu3RWFMwtQaLGEaYYL+17kWkbElHu1IIsNvB7E57QTooPkAubsFzA63jPNoR
         6BVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789752301; x=1790357101;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=72PNOxgvBxEa/OyDxE8+wmcHMjmCVv+wNt0o6l7GD3A=;
        b=AH5RUKS8Nqcyti9axhBg6WO60lttAXZA45GB6YA6N68rhw5RhijoA/p0ff7RVFpRX4
         UX/TPIRMcpI+FOsu2dLWUa/Rdtc/7k8xivDJ02P/bCiP9B67IpGx+M1EwytJEfbJa1gU
         iDDgaBYjY78eYQUS6nCeuijDiYFruHbKfh7HjNjarJFUmjOif8gGfCW/RNPnLT9MkQP1
         eqXyxhHix+mNQw4ePV+Ix/6iGGoqOyS3nMI8MmW4NwS3s/pccHZ2dZf8BxVgDhnkuZl+
         ov4w4kFaCrWXVeDCsyUy5Ff/g5BOYTcgYAYeoti0A6Jkqsm/NolDcMbmGyM3HbG9n+zw
         r6kg==
X-Forwarded-Encrypted: i=1; AKwUvByDJRT1N/2PQff4bZdcoL/a/lo1GpKQwVtI09MFgAYXYi3CjQI5TAOKGZ5jt28uoEve/DH3fGu+QhdXf20=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nR1t5/AgS16A/KcC3Kp3rQ6qCYhtC1EuNOYViOtK/RRMb9hRQk
	Nru0Bs+sjhcs2yW9zPl/z8tFk7GSIAICvA/asHIMqvEzJ6XV/N4HK1gcmjmf8iklM22cccA+N8U
	Iilhj5uWLhHdE4NQMfGz9yG3iJOq1yspxMQ==
X-Received: from pjue21.prod.google.com ([2002:a17:90a:e4d5:b0:39e:6e36:d13d])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e7c9:b0:39d:f615:725e with SMTP id 98e67ed59e1d1-39e54bc3a8emr6915187a91.13.1789752300888;
 Fri, 18 Sep 2026 10:25:00 -0700 (PDT)
Date: Fri, 18 Sep 2026 17:24:59 +0000
In-Reply-To: <20260918-b4-fix-aer-memleaks-v4-0-f0a2c21ed1d1@google.com>
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
References: <20260918-b4-fix-aer-memleaks-v4-0-f0a2c21ed1d1@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260918-b4-fix-aer-memleaks-v4-1-f0a2c21ed1d1@google.com>
Subject: [PATCH v4 1/2] PCI/AER: Fix memory leak in aer_recover_queue() on
 kfifo buffer overflow
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Priyank Rathod <rathodpriyank@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

When ACPI APEI/GHES processes PCIe AER error records, it allocates memory
for aer_capability_regs (aer_regs) from ghes_estatus_pool and passes it
to aer_recover_queue() to be enqueued into aer_recover_ring.

If kfifo_in_spinlocked() fails due to a buffer overflow,
aer_recover_queue() logged an error message but returned without freeing
aer_regs. Because the entry was rejected and never inserted into the
queue, aer_recover_work_func() could never dequeue or free it, leaking
the allocated ghes_estatus_pool memory.

aer_recover_queue() returns void, so the caller ghes_handle_aer() cannot
free the buffer itself: ownership is transferred to the AER code, which
until now only released it on the success path.

Free aer_regs via ghes_estatus_pool_region_free() when
kfifo_in_spinlocked() fails on buffer overflow.

Fixes: e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption when error status data has multiple sections")
Cc: stable@vger.kernel.org
Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
 drivers/pci/pcie/aer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d8dcd238fda1..b013b853b555 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1415,11 +1415,14 @@ void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 	};
 
 	if (kfifo_in_spinlocked(&aer_recover_ring, &entry, 1,
-				 &aer_recover_ring_lock))
+				 &aer_recover_ring_lock)) {
 		schedule_work(&aer_recover_work);
-	else
+	} else {
 		pr_err("buffer overflow in recovery for %04x:%02x:%02x.%x\n",
 		       domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
+		ghes_estatus_pool_region_free((unsigned long)aer_regs,
+					      sizeof(struct aer_capability_regs));
+	}
 }
 EXPORT_SYMBOL_GPL(aer_recover_queue);
 #endif

-- 
2.55.0.1082.g2b9226bbc0-goog


