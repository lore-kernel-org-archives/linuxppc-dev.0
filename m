Return-Path: <linuxppc-dev+bounces-25308-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5787CC55182
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 23:14:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDXZQ32C8z307v;
	Tue, 04 Aug 2026 09:14:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::448"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785793872;
	cv=none; b=nE0lxyGhlYcJJDozG9UHUQSk0IBP1qoKfEtTjl/8xOK/cRIzaqK+iiAE11EKXRdn8L3//6lIU4UaK8yLsJ5Dj003mJcL8BSQDCtUCRzQ5HiPl7F5fwng7NJ8mxzcgcEedrl6hsdTOOr2ILeelbTHyGcDMrykmbGkYYp/x+yGsU+g5NS6fWGfFZjXnvntQYoM3O3TJnpI97Pihml/ndpSaib5ulmXmfeE6u2t2xy5ysUZgtZWTuDUnvObltAsTJm8ISW8khPoN6B2zsma/WeJxGXdt25R3wll/3DV3B6rJAsQu9y8t34nOsyDPrDdlqT6m8kBXTz/zlkOCF6731cYdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785793872; c=relaxed/relaxed;
	bh=V3RiD/GImmxOZZ69pO9kk8WyvHse/kOu0dWQ2OD9gW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V1YbzNQEWhqqbyxckTh31lsakMvdKd3RHKNzWo/6Da4beAEkJXwT7nDpfqCShRzpmCzT0q0Lv6oaTnaym7t66rUPEJunXbcvVX+KrQ9mpci+HyyU0MPBuWNjtYRPoeKd5Dm3BDla51UHoDxsTif++UiXs7uETm6FOwOnE9i8dK+TQ6IMPEdxUi/gJXdgGAGLYiuWERdqWIsh5gYns7j8f+CkASjaD6+JytI1R9VdgmgxxKlKclV/LurRel3nDGpYdtD8H2HA9Wtb6V54RCf7Z/LfSi6ljZYWCkPz/BUDjBCImcTneIAVvELfTe72hP3Dxou7h74jSm7q5JofwVdMcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nLYExH7P; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::448; helo=mail-pf1-x448.google.com; envelope-from=3sw1xag0kdiqzi1pwlxzq6ivsowwotm.kwutqv25xxk-lm3tq010.w7tij0.wzo@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=nLYExH7P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--rathodpriyank.bounces.google.com (client-ip=2607:f8b0:4864:20::448; helo=mail-pf1-x448.google.com; envelope-from=3sw1xag0kdiqzi1pwlxzq6ivsowwotm.kwutqv25xxk-lm3tq010.w7tij0.wzo@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x448.google.com (mail-pf1-x448.google.com [IPv6:2607:f8b0:4864:20::448])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDVjp6PkZz2yMn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 07:51:10 +1000 (AEST)
Received: by mail-pf1-x448.google.com with SMTP id d2e1a72fcca58-84f0d3ab2f4so1178250b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 14:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785793868; x=1786398668; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V3RiD/GImmxOZZ69pO9kk8WyvHse/kOu0dWQ2OD9gW0=;
        b=nLYExH7P/EKMDx2s0KxXNUqkoTKNkIv9L30cYthyBGbfTVu81r07yUSzoPHqN7p+an
         vDsK6epZjbM3NAgdJZVCPMNJz53Ypd51Ph9ER5sgoIaTRxUgw2Kg+2js50UJ0HK8Zr4Z
         8z9Ih0kwSv1dxMVSKw66g74YztaQC1S64J4/M+/NTqgo9A0vkZKG/Fr0ekFZsA2G1eX6
         YDhL6JzWOwuAwSSp+QjI6WEiuLa2Fh4dc/a31TDxwouZS+rUq36/kqwTprIEYJJ+hB6N
         2KcPh2oFKa9K+9XJCWFqK/r/tDgqirqoHvidqt1lrn3Q0kR9H2AtH+CzD7OQ4yLc3BHS
         Anew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785793868; x=1786398668;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V3RiD/GImmxOZZ69pO9kk8WyvHse/kOu0dWQ2OD9gW0=;
        b=SCGQenog0jxSLn6TB5yPmJ6eZW86ih8CLGgR5ts67C6Bcmt486QUCjil/Dkf1LdUXG
         BboT/NEox/3hQzstoLHnDF3A0cDegutUgJ0mDAxkzYLPUYtC7J2Z9qwMfkcfYhxLiY6d
         E++ZZmfsJ0SfXKuuctIgkHQDyb8BJwvxsyQpClvPD0wY94iyTwNHpka2zufaW6R0rQzI
         sa0dSQgLwS9LrZ0HESd8VQM6f6waz+vV9AFRqEiAuo0GvNPesgTl6T8h9c9JOQvE/F35
         Lx3ROY+7nQwQvpQ1aVt/cPfsSXhK56rzXQn6IQLpmfQ4IpAl0hc0OSVBcx1CaSfr3LvQ
         Qg3w==
X-Gm-Message-State: AOJu0Yy9H0IHkCEXCT6/paoaqWqNYcejNvYUV4KmiEcC9wgcfAOPmh4/
	9ugrCD5YchDe2qMPW7hovk7UBgdVzPp8/5WBh64sWYjsID9I6CYK2nnJ94LAj/fNB43jIaOM9pr
	qGHzz0Y4C1DEeVpsrWd46RmVA0iXr78pO+g==
X-Received: from pfet15.prod.google.com ([2002:aa7:938f:0:b0:84b:62d1:9fe3])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4293:b0:848:2ae4:d2ba with SMTP id d2e1a72fcca58-84ee4864ed1mr9846295b3a.28.1785793867656;
 Mon, 03 Aug 2026 14:51:07 -0700 (PDT)
Date: Mon, 03 Aug 2026 21:51:05 +0000
In-Reply-To: <20260803-b4-fix-aer-memleaks-v3-0-e87159611933@google.com>
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
References: <20260803-b4-fix-aer-memleaks-v3-0-e87159611933@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260803-b4-fix-aer-memleaks-v3-1-e87159611933@google.com>
Subject: [PATCH v3 1/2] PCI/AER: Fix memory leak in aer_recover_queue() on
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


