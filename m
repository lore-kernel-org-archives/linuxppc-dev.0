Return-Path: <linuxppc-dev+bounces-26201-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323FBC61DD9
	for <linuxppc-dev@archiver.kernel.org>; Sun, 30 Aug 2026 20:28:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hY3cC0tMZz2xwN;
	Mon, 31 Aug 2026 06:28:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::546"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788121723;
	cv=none; b=oyxwZ+Bu8R3hL0kHq8EneX8gv5FzCpZYSejsd9b64Lyubipbva6myCVKfngVPGAODhh+DbIZS0SX3hgRNcxC211qrCC7uhKSt0LVew04EuzugPJZ/wTibicEakPPewEqPO+gQk6ZURA59NOf/a/jfjPK67bndrUj2SZVzf1Vkc0hmf9mP/BLBb8Wo3+8LhopTf79j+B3r7q4Nt6oeZ3tGwk2h+4XstD9R0xyibB8J7e69gjGJ5RjTYFDZH58y3gBuQY3lGGJrKK8SJaPDP4IB9fOdx/pUUxiI3LTOVuqtYYTSkeQby/VrRUQci9mQTV9HVLfmo3rGEda1Jjjuhh9Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788121723; c=relaxed/relaxed;
	bh=li9ks3fzgj1JF/ynP8/WlTAM/bKVb0+AaGC4hKm7+4g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hqZ5Pat5dwwLREPTtA0BY2nejKtOfMUTijS9Em77ycvAE9s6oeTZ9d3F4/0eOQsjTmBIkVS2rQmnMPrkCr8pJbiY7/MMF2MgkmDrSmcIOslPwfBqQZgETF2qekipQPn2wmusQWO9a4wsoWvZmE2XMrLCAz173aJQX5sZodNyxr0iawJ/+CtdqnJdO4ysYtv7z428uSTdMX21SpU56GwamHEBpZLp9vZsYnuRFSQQya60BDUvgpGDcwZtx5S70pILriknqoTg6BULw+msjRIFB0H1v31swRDU+2HFsbWrpvOMmducTlErEGioIthX9EJBhiwaaOMuKbIJhI7VRGsC0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=V9v5MgCB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::546; helo=mail-pg1-x546.google.com; envelope-from=3dzkuag0kdeg1k3rynz1s8kxuqyyqvo.mywvsx47zzm-no5vs232.y9vkl2.y1q@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=V9v5MgCB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--rathodpriyank.bounces.google.com (client-ip=2607:f8b0:4864:20::546; helo=mail-pg1-x546.google.com; envelope-from=3dzkuag0kdeg1k3rynz1s8kxuqyyqvo.mywvsx47zzm-no5vs232.y9vkl2.y1q@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x546.google.com (mail-pg1-x546.google.com [IPv6:2607:f8b0:4864:20::546])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hY3c94Rptz2xr2
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2026 06:28:41 +1000 (AEST)
Received: by mail-pg1-x546.google.com with SMTP id 41be03b00d2f7-cc1c5810451so3657621a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2026 13:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788121718; x=1788726518; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=li9ks3fzgj1JF/ynP8/WlTAM/bKVb0+AaGC4hKm7+4g=;
        b=V9v5MgCBTifv6F3MASCUFIEpEgD2riEfHgwP2QxeQlyRtGQPzn1hIEISYd6GLBPDCP
         ylfQFFxLXz4RF+sC8uvR02bp+XW4vBtRJaNJaJkPWR2cbUCj0bZZT6nRnwYB3nLhLhpc
         Afht4tbx4PWLhnSLWqyEbAwQBtAyCy+ZsmQSOFJwRlvBAUpvb/jOxCC4LejBGvSV/Ehv
         kRJ8xxFZtd6CDWCf6XTK1JELjRfSpEeKpWzoR6v1uYticNP+LrhEFX2Urlzlq2tAaEzv
         i8Ew3CNBHRaxdfOTduDO737MZrG6RW2AYU1zubN9h88REMgFLUqowo7WjPt0gIGPGEMF
         DKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788121718; x=1788726518;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=li9ks3fzgj1JF/ynP8/WlTAM/bKVb0+AaGC4hKm7+4g=;
        b=MblIPUbxRp9rMiPfjrBqvrm7fFOL3UU0o8+SSBOi6Kis8xh0tznE/taKMifHGJMeeS
         YKwW2GwZox2pecB5mO3TGQKLT8YhnSVCtVOL55UR4Gulgp57xvIftcsEh8fSmTW942sb
         Nwma/1bBudSKZEyzRzH5NmWrKz4cSe31fVv/e4A49B9Nr3WqCm+KK+O90VbtbvPDa1Py
         Gm0cvhXSjNHlUTSpK6Ugj8p9nn+qg6y4pRhvWFknbFMdIc3AqSsd36EWYvq4XrXXo7gF
         xVFNmca2CJbQPQDizk/u5tmdQ/mNaVGPsNyoP1bDB+VaLmpHBmhtN3W11rSueruyGvcT
         ABoQ==
X-Gm-Message-State: AFuF++m+0TytlfcrkTZJZot5YeVHLqDNF32lqd9WASYUrPOjScn2f/TZ
	JWsNT3vzGO9A67t8u742DDLCChKWj24OVGryHnS+mvdKGdV5tjl0GudbPpr9dJNs3YTilYoTDqQ
	uS9T52M1+5ZMnM5nSEM0N6DoFlzGNomZGMw==
X-Received: from pgca19-n1.prod.google.com ([2002:a05:6a02:6393:10b0:c92:460e:4f73])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:218c:b0:857:7317:cff1 with SMTP id d2e1a72fcca58-8577317d1a1mr20165511b3a.18.1788121717681;
 Sun, 30 Aug 2026 13:28:37 -0700 (PDT)
Date: Sun, 30 Aug 2026 20:28:28 +0000
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
X-B4-Tracking: v=1; b=H4sIAGuSlGoC/x2MQQqAIBAAvxJ7bsEsTPpKdLBcaykstEKI/p50H
 IaZByIFpghd8UCgmyPvPkNVFjAtxs+EbDODFFIJXQt0nNBQwEBu2i9/4kZmRVW32unGKjkayO2 RNaf/2w/v+wEceHDWZwAAAA==
X-Change-Id: 20260830-fix-aer-refcount-leak-6378f84d62ba
X-Mailer: b4 0.14.3
Message-ID: <20260830-fix-aer-refcount-leak-v1-1-64e1013add12@google.com>
Subject: [PATCH] PCI/AER: Fix struct pci_dev reference leak in aer_process_err_devices()
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Stefan Roese <stefan.roese@mailbox.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Priyank Rathod <rathodpriyank@google.com>
Content-Type: text/plain; charset="utf-8"

When an AER error occurs, candidate error-source devices are identified
and recorded into e_info->dev[] via add_error_device(), which increments
each device's reference count with pci_dev_get().

If is_error_source() matches a device purely by Requester/Completer ID
match (e_info->id == pci_dev_id(dev)), the device is added to e_info->dev[]
even if it lacks the AER extended capability (dev->aer_cap == 0).

Later, during aer_process_err_devices(), aer_get_device_error_info()
returns 0 when dev->aer_cap is 0 (or if no active error status is read),
causing aer_process_err_devices() to skip handle_error_source().
Previously, handle_error_source() was responsible for calling
pci_dev_put(dev). When handle_error_source() was skipped, pci_dev_put()
was never invoked, permanently leaking the struct pci_dev reference.

Decouple device reference release from error handling by removing
pci_dev_put() from handle_error_source() and calling pci_dev_put()
unconditionally for all recorded devices in aer_process_err_devices().

Fixes: 1ab4a3c80508 ("PCI/AER: Stop ruling out unbound devices as error source")
Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
When native PCIe Advanced Error Reporting (AER) handles an error signaled
by a Root Port or Root Complex Event Collector (RCEC) via
aer_isr_one_error_type(), candidate error-source devices are identified
by walking the downstream hierarchy in find_source_device().

During this walk, each matching device is enqueued into e_info->dev[] by
add_error_device(), which increments the device's reference count via
pci_dev_get(dev).

1. The Vulnerable Use Cases:
============================
is_error_source() matches devices through two distinct mechanisms:
  a) Explicit Requester/Completer ID match:
     if (e_info->id == pci_dev_id(dev))
         return true;
  b) Uncorrectable/Correctable status register inspection across the hierarchy.

On the ID-match fast path (a), is_error_source() returns true without
checking whether the device implements the AER extended capability
(dev->aer_cap != 0). This creates a real, non-exotic situation in several
common hardware topologies and operational states:

  - Non-AER Endpoints: Simple or legacy PCIe endpoints (e.g. basic serial,
    sensor, audio, or older controller ICs) that implement standard PCIe
    capabilities (0x10) but omit the AER Extended Capability (0x0001) in
    extended configuration space.
  - Multi-function PCIe Devices: Multi-function endpoints where AER is only
    implemented on Function 0, but an error is routed or attributed to
    Function 1..7 which have dev->aer_cap == 0.
  - Devices behind PCIe-to-PCI/PCI-X Bridges: Conventional PCI devices
    aliased under a bridge's Requester ID or lacking AER registers.
  - Unbound Devices: Following commit 1ab4a3c80508 ("PCI/AER: Stop ruling out
    unbound devices as error source"), devices with dev->enable_cnt == 0 are
    no longer filtered out. An unbound, un-configured device without AER
    registers that triggers link-level errors is matched purely by ID.
  - Transient Errors / Zero Status: Devices whose AER status registers read
    as 0 or return ~0 (link down / device in D3) during config read in
    aer_get_device_error_info().

2. The Refcount Leak Mechanics:
===============================
When any of the above conditions occur:
  1. add_error_device() takes a reference: e_info->dev[i] = pci_dev_get(dev).
  2. aer_process_err_devices() iterates over e_info->dev[i] and calls
     aer_get_device_error_info(e_info, i).
  3. aer_get_device_error_info() checks 'if (!aer) return 0;' and immediately
     returns 0 because dev->aer_cap == 0.
  4. aer_process_err_devices() evaluates:
       if (aer_get_device_error_info(e_info, i))
           handle_error_source(e_info->dev[i], e_info);
     Because aer_get_device_error_info() returned 0, handle_error_source()
     is completely bypassed.
  5. Previously, handle_error_source() was the sole owner of pci_dev_put(dev).
     Bypassing handle_error_source() leaves the reference taken in step (1)
     unreleased.

3. Impact:
==========
Because the struct pci_dev reference count never reaches zero:
  - The struct device release callback pci_release_dev() is never invoked.
  - Dynamic device resources, sysfs entries, DMA mappings, and aer_info
    remain allocated in memory, even after the device is hot-unplugged or
    removed via sysfs ('echo 1 > /sys/bus/pci/devices/.../remove').
  - Under link instability or an error storm where errors are repeatedly
    attributed to a non-AER device, each error event leaks one pci_dev
    reference, leading to unbounded refcount inflation and memory leaks.

4. Proposed Fix:
================
Decouple device reference lifetime management from error reporting:
  - Remove pci_dev_put() from handle_error_source().
  - Unconditionally invoke pci_dev_put(e_info->dev[i]) in
    aer_process_err_devices() for every candidate device recorded in
    e_info->dev[] across the loop.

This ensures every pci_dev_get() in add_error_device() has a strict,
guaranteed 1:1 lifecycle match in aer_process_err_devices(), irrespective of
device capability presence, status bit reads, or driver binding state.
---
 drivers/pci/pcie/aer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c4fd9c0b2a54..2401b3a18f07 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1197,7 +1197,6 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
 	cxl_rch_handle_error(dev, info);
 	pci_aer_handle_error(dev, info);
-	pci_dev_put(dev);
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -1361,6 +1360,7 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
 		if (aer_get_device_error_info(e_info, i))
 			handle_error_source(e_info->dev[i], e_info);
+		pci_dev_put(e_info->dev[i]);
 	}
 }
 

---
base-commit: 0f23d56f17fdfc7db69d51f64c8b91bbab947aa9
change-id: 20260830-fix-aer-refcount-leak-6378f84d62ba

Best regards,
-- 
Priyank Rathod <rathodpriyank@google.com>


