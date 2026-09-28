Return-Path: <linuxppc-dev+bounces-28417-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF72CA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 17:40:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htpVs60N6z2yqq;
	Tue, 29 Sep 2026 03:40:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1048"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790617237;
	cv=none; b=ge0uC3pEct+h1/s74amYvbCikAz46XKcK0unqvwnB1Auirm2HIeSLq5UufZvao/euUBghPAY5SAI4tOYCzGpUCT+05nl9vaDHbKfJFRPN0OCDEZfuB0PsA390rmcn/Rin55M4Lhyc/j94M8vnc1XuFOX/Rwwb0+FoW3fp/7eRxWC+avW62AAnfWthQYQOOCWgb4UiSzF8BDHxPjNKuyveb/IEEgfrUt5ULn1AFhk8rPSS9NxPSvvI0/OeJm8VYkn2gJxOo3RZXn2Z4R+XERRR+6UnkTrmHSTp6j0bsf1DtSoiU3r/TRkShfvICm8L/3trTCCnedbsUYBYpF9dhZrgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790617237; c=relaxed/relaxed;
	bh=sw50tyOgJDy5SizTNDQpXrNC0JD8AqhCQeUwJLrCoro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MReFF4ZXtFH4Il3vYkMW29KK8b0CPJeOIYAxU4HeCHM/VKN9LmmjPtm9BvdOuKXD4kap5P53owHaBqVP6fasUT9u72NoBfdJ3OcdkdWYaBTXyAMXKzAVngFtO3rtUmSYQ9j+ysnLzhU1z8+SslqrnDwnWRkKmk63vhkFQQcL12n7nDQqaqDF+1kUJ1jFhW5eLWVOmuYWraOp2S/HuF8oZva9QLn1iNcCVCzitqsRRjkECxtQK+v+D2r9z7ksAnppQ01ClBfvojiTrk97LJIT5Q7rsMCUhUwyCCdtGr4plLph6nJZTK73qP4YQbC+3hMibIS5iS1pl7VFpKBSKpr35w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Zh5s1WjN; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1048; helo=mail-pj1-x1048.google.com; envelope-from=3kaa6ag0kdcytcvjqfrtkacpmiqqing.eqonkpwzrre-fgxnkuvu.qbncdu.qti@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Zh5s1WjN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--rathodpriyank.bounces.google.com (client-ip=2607:f8b0:4864:20::1048; helo=mail-pj1-x1048.google.com; envelope-from=3kaa6ag0kdcytcvjqfrtkacpmiqqing.eqonkpwzrre-fgxnkuvu.qbncdu.qti@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1048.google.com (mail-pj1-x1048.google.com [IPv6:2607:f8b0:4864:20::1048])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htpVr1J7tz2yMK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 03:40:35 +1000 (AEST)
Received: by mail-pj1-x1048.google.com with SMTP id 98e67ed59e1d1-3a47617a0b3so1066433a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 10:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617234; x=1791222034; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sw50tyOgJDy5SizTNDQpXrNC0JD8AqhCQeUwJLrCoro=;
        b=Zh5s1WjNTBUx6Bt5MOiA4TNnY/E5jbFpPasyTpi0IOYuDiWx0wnneVd/wEq1y/DUOZ
         qN8kF2Cfw/ud5ROMvOYZfSau362edHLsTn8dvx61xdQfjuwLH7f4/X2ZBw5JGbG8cVH6
         /Qak8aYRSBUkB8D963d/HLL3LmMdS6tlRST8EN+b9KKqClH0I5NmHpN5ThcB69QTOEiM
         8yfjNZYLyNXtisRGDPDurf5g7KHrQ/dYA6vT81wxw5fZV44axCZ8k7jmByU7IRQHLIv8
         dLThNUE/BkneQ0OkQp9hBxJm735EdGbZjH7r7KWt3Sc7g/7lyEz7FvAH4dIWsD8WFMoQ
         bNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617234; x=1791222034;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sw50tyOgJDy5SizTNDQpXrNC0JD8AqhCQeUwJLrCoro=;
        b=pp/qttlT2nBwLJX3r92JwW9mg76AlzNibmNd5stzcIAJ1ttdup/S1mjT+frDO656ke
         YVlInY1f744MpsD78QufXRnnkuSHGse+Ugen16Aqa5wQRLXpqMgVudXWmPw3rDrlEp4y
         82JFfwDwAroBHMWXg/boZMtbJNL/baGeofkGJvO2PdzjhYXgPjOjCGd0gJ5JrpU60uJ2
         fBTB/rNL/+iAjOFsS+mBYPd/hECkqSrPKKeFMwFK0pWYXV3SJwJwZjamdjmyqDBhlK6s
         KGKYVqIOGtra/nLihLU7MK4PeDSAEz92d063WffEVWgCGM7XzY3XgBEEZqvJXTOr8qqp
         nBPQ==
X-Forwarded-Encrypted: i=1; AKwUvBx64GG+psPkQFpeoxf/52NeVXOwj4eMedNM5PEgfmRXZ3R3jH5zkZfxcFEwn9Z1QDNTKhqVg62FKhjFfYo=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJPJv+DkC5l/VSNKRwJug03RAJ6Ot9wDKxnbweFAXkZow0MzO9L
	YeOtiNSH/85h8r0qYtbcW9LpfWWqD+ZYG2fttoAQkqUJgUsSLu7STSsmRQcNqbp5/7fK4vf9YRJ
	ROwyOcPStUr05iG0L5zEQHR9Q/9NniUYkBA==
X-Received: from pjyo13.prod.google.com ([2002:a17:90a:eb8d:b0:3a0:dfb1:6c07])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3a46:b0:3a2:b04e:8086 with SMTP id 98e67ed59e1d1-3a2b04e8389mr2449084a91.44.1790617233471;
 Mon, 28 Sep 2026 10:40:33 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:40:12 +0000
In-Reply-To: <20260928-b4-fix-aer-memleaks-v5-0-ba6b94c9c9a6@google.com>
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
References: <20260928-b4-fix-aer-memleaks-v5-0-ba6b94c9c9a6@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260928-b4-fix-aer-memleaks-v5-1-ba6b94c9c9a6@google.com>
Subject: [PATCH v5 1/3] PCI/AER: Fix memory leak in aer_recover_queue() on
 kfifo buffer overflow
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Lukas Wunner <lukas@wunner.de>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, 
	Jonathan Cameron <jic23@kernel.org>, 
	"=?utf-8?q?Ilpo_J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Shiju Jose <shiju.jose@huawei.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>, 
	stable@vger.kernel.org
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
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
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
2.56.0.rc1.315.gc6ed9934b7-goog


