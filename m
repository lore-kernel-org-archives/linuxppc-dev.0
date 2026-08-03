Return-Path: <linuxppc-dev+bounces-25311-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97AAC55182
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 23:15:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDXbL35hjz30Bd;
	Tue, 04 Aug 2026 09:15:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1048"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785794384;
	cv=none; b=QPuSSCuJb72d+Qpgp4lkZH6+4bvAGS3MGwPU0Ntb40RqoVFyCs496EtzAgkcewgbt1hI5E/krr0VFgjsVPsji/OwR1xA9m74+T/HZyJ7Ez0Y25GPwkyaAQ//FqrsUNgv8b2kOQN+HbxV/5FGbw0nr8c+BWYHj9KKQ259kJPxoSAD2qt2zM24lP1ogE74cP7RL7Hg89Lw2ioLwfRNPy2JOkqBogkemCFXcszD0rJZH1qkVbncugy+W2YmuC2mQfq6TXDOnK+JBHcmJC/ZoaYv7U0htSQJSKuQkjtuJ5+s9fu25ce4PTZm4rpscPJYCwAAmF7PQdd1uQmiHxyWsRcVaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785794384; c=relaxed/relaxed;
	bh=V3RiD/GImmxOZZ69pO9kk8WyvHse/kOu0dWQ2OD9gW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fJhcTWGtLFIpZHV+26lKKcdCdZG/Tg8uJ4hosREgW+VGH6NAVe4XY/V6cyJMY18JJS7V77jJx/+02QjNhWbdeFDW2M0OImPPI8+2mrRrm4BnkyWdYgND3nhkx9CVbNH1sjrh/x/YCehVbL8wMbE+MGOGWL6QGXpJlIZbr2tteJ5xTGcCSPW2Jd4VQ7t0iRWw0DmQ8kQ0E+YvDCJrnDTRd5akJYL3MM2IK6ShdhYhT917dC58IFZNxokBNaJQyfZyBlLupirfE4gbX+ABsGNlyJjtPOUTQt5K5BvzxR8wNizku4FLWoVYvnkBuDH1/pump/T5UndcxxAxBE4Bj8iUrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Wb5Y88w9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1048; helo=mail-pj1-x1048.google.com; envelope-from=3ta9xag0kdik4n6u1q24vbn0xt11tyr.p1zyv07a22p-qr8yv565.1cyno5.14t@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=Wb5Y88w9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--rathodpriyank.bounces.google.com (client-ip=2607:f8b0:4864:20::1048; helo=mail-pj1-x1048.google.com; envelope-from=3ta9xag0kdik4n6u1q24vbn0xt11tyr.p1zyv07a22p-qr8yv565.1cyno5.14t@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1048.google.com (mail-pj1-x1048.google.com [IPv6:2607:f8b0:4864:20::1048])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDVvg1pTpz2yMn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 07:59:42 +1000 (AEST)
Received: by mail-pj1-x1048.google.com with SMTP id 98e67ed59e1d1-38e7b87ce77so10106147a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 14:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785794381; x=1786399181; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V3RiD/GImmxOZZ69pO9kk8WyvHse/kOu0dWQ2OD9gW0=;
        b=Wb5Y88w9hAeqNTD4vFUjv0jSaRmmvXawGyfObgsuxojN9VIIzEP1rt+IkF1sPl1gcz
         HZmeuqm3soYpM+lbIgcDGPVUL/gv7+pm/iRl2lR3PNUymlaiQponsQ1TBEknHzulsXXy
         M2EsPXwKRFZ3Vj/qPUh62XRA26c5lYU8ImE9M4oXytwsKGgcUQKJhBJvUHtlXRVL3JU4
         hn50SgrMNqdxEMbuohEcEJS/ALmv7xe8llEckB/0D3O+V010rx4D5ShSxNEVWZkOoVpa
         w8oE+ClIwAPrwT/UqIuQ7R9vvlQPSVYni5C4F9pe5tYfS+DbLBVd/mp6wr+UiQ8Tlunr
         sN+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785794381; x=1786399181;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V3RiD/GImmxOZZ69pO9kk8WyvHse/kOu0dWQ2OD9gW0=;
        b=mz+EzgDPsqs/DjgI1aewqdaWA5JxeIC2BzOGtoNDfOMpfxN8osXL7WCdgqftcjVgRp
         chXK69wNj/ycOfbXOI6iH0jRShJMWVL+459piv0cRFAgw+5T5fNjf4srKlLHIyekVPtH
         KUSWCb/D6HsswyUozRRr/QYgndI3RYil9GxvADn0KtdXSKLNZVsVI8xSoEXa3zSN5QR1
         onbVxfS+yNIQA3qAFq8oGg3mH+4opLyNm04DNCZuAfFF308WTY8udAF67Q3UZYESZeeD
         jO27VfdxzGqeBTeD///AjNWFeSCJ42r+Sy0TYQGqJTteTjlExAx7GLVjZNTE8zLQvoBx
         I8kQ==
X-Gm-Message-State: AOJu0YxW+vnkXIcJWhUPk9cciumNTlAcEAgqkV8DzKVUpf7vz2eDnnaj
	7xTTBEQvKCEhjUw/aEofxCUTFx6KVfQLikDu1nbf8olG76nLpnfDXNFJzXz9An19iFeFPifTx0O
	ROtFCNdxdrkPrSY+gzu6euuqd9RnSS/J1qQ==
X-Received: from pjqq12.prod.google.com ([2002:a17:90b:584c:b0:380:f389:2b67])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4fc3:b0:381:e74f:8a6a with SMTP id 98e67ed59e1d1-38fbc4681dcmr10873794a91.16.1785794380433;
 Mon, 03 Aug 2026 14:59:40 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:59:38 +0000
In-Reply-To: <20260803-b4-fix-aer-memleaks-v2-0-fd199b0171fd@google.com>
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
References: <20260803-b4-fix-aer-memleaks-v2-0-fd199b0171fd@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260803-b4-fix-aer-memleaks-v2-1-fd199b0171fd@google.com>
Subject: [PATCH v2 1/2] PCI/AER: Fix memory leak in aer_recover_queue() on
 kfifo buffer overflow
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>
Content-Type: text/plain; charset="utf-8"

When ACPI APEI/GHES processes PCIe AER error records, it allocates memory
for aer_capability_regs (aer_regs) from ghes_estatus_pool and passes it
to aer_recover_queue() to be enqueued into aer_recover_ring.

If kfifo_in_spinlocked() fails due to a buffer overflow,
aer_recover_queue() logged an error message but returned without freeing
aer_regs. Because the entry was rejected and never inserted into the
queue, aer_recover_work_func() could never dequeue or free it, leaking
the allocated ghes_estatus_pool memory.

Free aer_regs via ghes_estatus_pool_region_free() when
kfifo_in_spinlocked() fails on buffer overflow.

Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
 drivers/pci/pcie/aer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c4fd9c0b2a54..967cde9dd519 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1274,9 +1274,12 @@ void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
 	if (kfifo_in_spinlocked(&aer_recover_ring, &entry, 1,
 				 &aer_recover_ring_lock))
 		schedule_work(&aer_recover_work);
-	else
+	else {
 		pr_err("buffer overflow in recovery for %04x:%02x:%02x.%x\n",
 		       domain, bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
+		ghes_estatus_pool_region_free((unsigned long)aer_regs,
+					    sizeof(struct aer_capability_regs));
+	}
 }
 EXPORT_SYMBOL_GPL(aer_recover_queue);
 #endif

-- 
2.55.0.571.g244d577d93-goog


