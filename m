Return-Path: <linuxppc-dev+bounces-28419-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 210C7CA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 17:40:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htpVt6vKMz30WT;
	Tue, 29 Sep 2026 03:40:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1047"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790617238;
	cv=none; b=h4PAEhhUiWJB02i44do58N4VCVT+pSdScygZoj7/zBgAK+WBWIXb8eNzwijqfHq1H2Jmxg8tqb2I7vVzdjaECAiVjfiQ0uLgPKVlYVOFOwrj19/JuJH41P1aFs25HFDjiz6UO5XRnlsDwFB+21yapqY3MN5NTErazP17kJXI99GdcBcKbKiGzAR9w9TcDY4roGpRD607mdewLARvaMY68s2fhi6z1ztYqiVVX2Vp/7KcW3V5QI4yVMwsNOKrTQ3uKPiCPijFAFBwffeuywivcqqB8Cf45K92o2zgWYRgRpIX2g2SVvCGd5MYzhRSzEcZ68Pmwq/y8/D8Fe7lNheSbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790617238; c=relaxed/relaxed;
	bh=cnJQd6bdeFsZrWHaIElFpdpCIChAmHD+YCH6lWp5XiY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mt6+78jDUNa2AM/qQ6oCm8J7NRvyGjrfR7tZj7XoCDGA2v6Dzg/rS1044A7b0owHiR4mBO0Jw7KtkF/98M7GM4fnY4RBwjnsQPhRAndmgruO1d0zHF5TK7B+KMNERkhG/RUBMcyN22Fv4oDZrBKQBUZnZALwiDZPS66C8WtbfTMcrAQRRNCDOK9TrrhVnwyTR4rkaAIb+5z8UXQIUP2OzwhHeNhFLOIFjnBSRYsSKvxxFnhNmIHTPjOkQkhXIF1vvbdAuMa/ITyk0Vi6ObnklNcGOhp6sTtOXGSymFYGrya//SXHQlPY+AS5ohOs+C0ZlA57RgUb6hxAjiGDNTNiVQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KFi58aO/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1047; helo=mail-pj1-x1047.google.com; envelope-from=3kqa6ag0kdccudwkrgsulbdqnjrrjoh.frpolqxassf-ghyolvwv.rcodev.ruj@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=KFi58aO/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--rathodpriyank.bounces.google.com (client-ip=2607:f8b0:4864:20::1047; helo=mail-pj1-x1047.google.com; envelope-from=3kqa6ag0kdccudwkrgsulbdqnjrrjoh.frpolqxassf-ghyolvwv.rcodev.ruj@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1047.google.com (mail-pj1-x1047.google.com [IPv6:2607:f8b0:4864:20::1047])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htpVr7256z2ySj
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 03:40:36 +1000 (AEST)
Received: by mail-pj1-x1047.google.com with SMTP id 98e67ed59e1d1-39d865b11b4so3943530a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 10:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617235; x=1791222035; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cnJQd6bdeFsZrWHaIElFpdpCIChAmHD+YCH6lWp5XiY=;
        b=KFi58aO/jGjCKtDjYcb+C+2aG2IZtwj+0T71/fbwYS757UkvsYZ/+ii4iZzn3Zf8iT
         Of9hTQ+Rd5Muy8jiRR5h9VuZCtKnpoDcQryB1PCEPRPtAfGVr5/gpUl1SgfPGiTCVbiJ
         XUqRE92wwPtJUWOvE4eBUsnKIi7lxioEK62OUblL/0zDj0bya6c5TBqG+1nKQjCnX61c
         MDjsgvVB66aixvyN0630GgiZyYKy4S2eqRzhJ7NxLfiFDaA1V0HnThZUgrQbeykjTLM5
         qKi70oRoO2yDCvSDDgBJ9DOPqu24l+fMR9FiKICNZpmyUxbVj/CKjd4sq5DajNnA/L9y
         knbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617235; x=1791222035;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cnJQd6bdeFsZrWHaIElFpdpCIChAmHD+YCH6lWp5XiY=;
        b=gL7oehjcrrN6ueo4jJ5ps/oSsP6fxjKT+WjC3p8c72tmu9lweUc51iTYauUZ+7b/4p
         t1m+DAd/dRFG1NMfETYpnb5jXDXw0t2Wn98SvxBux8OhLNw1o3JX48zg6AS4jge1HGfP
         hctmFlUPKXx9PUCjJU90WjAbQpf3v9a1aU9fdokmfDZx8P4w6lCcDwaCvklBIPE5ZMrZ
         LF3QJIeKP4iq/6FOmcccp4UYAZ0JLkCbaoLj6/keRuOr26/if2SltxH5oP9hUOHm9918
         KV3ide/rVopffuGF0EzJfBO8DaiWvh75ki8lkktOtggQNAprHDQ3nv7rOoUUlHImz23i
         yvLQ==
X-Forwarded-Encrypted: i=1; AKwUvBz7IXeOYlsTZiN4ydWYvUUaUhMmni1U+yXKcjvb0U3jQW7zGunlfHz0UJpCfsCj8d0TfwhdvOHq2nqJUmk=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLxH9Lf821utuYCLMIrD8IMVx+rr85wh0rgTjyGwgzytXDjrQWc
	QRxy9pUrbMqZmNWJp9LrWHpxrC3HZmd32yaX8nG4cVPLaYSMKxScspzKiCvoVVV/mJwb8tsAHc0
	OpPxz12noXcGkVfC6jLmiJizHYC/jJOvZdw==
X-Received: from pgav19.prod.google.com ([2002:a05:6a02:2dd3:b0:cc7:ab3a:23c7])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:498c:b0:3a0:903b:f253 with SMTP id 98e67ed59e1d1-3a09875d77cmr11025914a91.18.1790617234359;
 Mon, 28 Sep 2026 10:40:34 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:40:13 +0000
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
Message-ID: <20260928-b4-fix-aer-memleaks-v5-2-ba6b94c9c9a6@google.com>
Subject: [PATCH v5 2/3] PCI/AER: Fix memory leak in aer_recover_work_func()
 when pci_dev is missing
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
for aer_capability_regs (entry.regs) from ghes_estatus_pool and queues
the entry into aer_recover_ring.

In aer_recover_work_func(), items are popped from aer_recover_ring via
kfifo_get(). If pci_get_domain_bus_and_slot() fails to find a matching
pci_dev, the code previously executed 'continue', bypassing the call to
ghes_estatus_pool_region_free(). As a result, the memory allocated for
entry.regs from ghes_estatus_pool was leaked.

This is reachable whenever the device reported by firmware is not (or is
no longer) present in the PCI device tree, e.g. after hot-removal or when
firmware reports an error for a device the kernel never enumerated.

Refactor aer_recover_work_func() to ensure ghes_estatus_pool_region_free()
is called unconditionally for every dequeued entry, releasing the pool
memory even when pci_dev is missing.

Fixes: e2abc47a5a1a ("ACPI: APEI: Fix AER info corruption when error status data has multiple sections")
Cc: stable@vger.kernel.org
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
 drivers/pci/pcie/aer.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index b013b853b555..a6600801af6e 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1366,14 +1366,13 @@ static void aer_recover_work_func(struct work_struct *work)
 	while (kfifo_get(&aer_recover_ring, &entry)) {
 		pdev = pci_get_domain_bus_and_slot(entry.domain, entry.bus,
 						   entry.devfn);
-		if (!pdev) {
+		if (!pdev)
 			pr_err_ratelimited("%04x:%02x:%02x.%x: no pci_dev found\n",
 					   entry.domain, entry.bus,
 					   PCI_SLOT(entry.devfn),
 					   PCI_FUNC(entry.devfn));
-			continue;
-		}
-		pci_print_aer(pdev, entry.severity, entry.regs);
+		else
+			pci_print_aer(pdev, entry.severity, entry.regs);
 
 		/*
 		 * Memory for aer_capability_regs(entry.regs) is being
@@ -1385,13 +1384,15 @@ static void aer_recover_work_func(struct work_struct *work)
 		ghes_estatus_pool_region_free((unsigned long)entry.regs,
 					    sizeof(struct aer_capability_regs));
 
-		if (entry.severity == AER_NONFATAL)
-			pcie_do_recovery(pdev, pci_channel_io_normal,
-					 aer_root_reset);
-		else if (entry.severity == AER_FATAL)
-			pcie_do_recovery(pdev, pci_channel_io_frozen,
-					 aer_root_reset);
-		pci_dev_put(pdev);
+		if (pdev) {
+			if (entry.severity == AER_NONFATAL)
+				pcie_do_recovery(pdev, pci_channel_io_normal,
+						 aer_root_reset);
+			else if (entry.severity == AER_FATAL)
+				pcie_do_recovery(pdev, pci_channel_io_frozen,
+						 aer_root_reset);
+			pci_dev_put(pdev);
+		}
 	}
 }
 

-- 
2.56.0.rc1.315.gc6ed9934b7-goog


