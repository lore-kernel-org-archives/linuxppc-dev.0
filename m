Return-Path: <linuxppc-dev+bounces-27744-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E941C982D8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 17:24:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmfdL2PBDz2xft;
	Sat, 19 Sep 2026 03:24:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::545"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789752294;
	cv=none; b=cwzOBsnq/8K5WqOKfpogFWnxuU8HdTc65PpozSbAZL/+js6bfEU6oSdvs7QGV96YUftuOWtI5IRgeKtJwLGCyD7LWKlWWt0HtY0aYI2EL9OR9xmjnwLh4FVtHJoCvBuTPtGdOceyjt9FywVHcaIbelQ9jrbJCxDdKC13Rt4UXMNH1HbP78PE5FyR98Iyc3QSVcKJRPtub+3whQ2RnIA5CQg1QuuRqWT63qimUMkXZqnD/flw4L+EG14K2LYr2332Ip5jkn29LpBhdNpOb1vWG+1Asf85hA+FGGQHODd3jgYcSOKAHZYru2LHLigXkljrj/oqxvwciCDjxfHa7OVkOA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789752294; c=relaxed/relaxed;
	bh=MK8SQon571KaD8P7buh1T6LtzzA2FoPJEodcHPYT2dM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nJlcRqDgOTeSSf3DxCD6RSDPo3kchQ/1G3XTJxldgtyE+vJSsasz9irDt7Z4R8I6fR0Y0bOba+jvlGUf7JqvH/sfO/x8q1GoS7c3DCC383zf+OfNvsGZFbGGqwzy4ERCvLQDZqSGrUM1XL+aYVg2krM79/wYCNgcrjLXxXJyGWxckunNGULN5VzX4nv7H5ORu9fHFo6XiudW1GGq+kcAmNaa824XBDZ/eo3yPNpH7/ySEK5vqNTf9SddDVXoGzs1PWoAG+/EE7D3sEqb7VVZ0XbGJKtyFYqCfrJMx2zRUdm9xUy609ocyalhTfTZrCPkLgNojQHHt9mTXSb3Ep2gQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cUS/qFKj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::545; helo=mail-pg1-x545.google.com; envelope-from=34hotag0kdnkm5ocj8kmdt5ifbjjbg9.7jhgdipskk7-89qgdnon.jug56n.jmb@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--rathodpriyank.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=cUS/qFKj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--rathodpriyank.bounces.google.com (client-ip=2607:f8b0:4864:20::545; helo=mail-pg1-x545.google.com; envelope-from=34hotag0kdnkm5ocj8kmdt5ifbjjbg9.7jhgdipskk7-89qgdnon.jug56n.jmb@flex--rathodpriyank.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x545.google.com (mail-pg1-x545.google.com [IPv6:2607:f8b0:4864:20::545])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmfdJ5SFbz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 03:24:51 +1000 (AEST)
Received: by mail-pg1-x545.google.com with SMTP id 41be03b00d2f7-cc1b8088203so917477a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 10:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789752289; x=1790357089; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MK8SQon571KaD8P7buh1T6LtzzA2FoPJEodcHPYT2dM=;
        b=cUS/qFKjkYEHpAEfPfxvLdwm+kpRtZh3QhRQEig82gsog80k21EK1WXOA4M8b4Zd/5
         amODFI/hX8mJZzjshjlKshT4q0NrTeqqKeUwvKRVy6pAmvTO2YK0cYEAENSU/iCx2PzN
         PBo22Tbl8vcqDPoy6e86XlK/1kPNxz2S0LFSCLzPTb+ueJjZliwIhwQflwyuHsZEf2m4
         ZlbhNaYNKDWqf9ggP0UuHco6+waxl4w4VWM22BBjOs66GqubRXDApZAO1nBvcRzgaWMz
         u0en9oh4Q1CGhbL629eGARoLFhM8J4uj6H93gQNX9ssfkyrXezM3BDz5Oefc3qoWAhR2
         y24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789752289; x=1790357089;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MK8SQon571KaD8P7buh1T6LtzzA2FoPJEodcHPYT2dM=;
        b=PvkYwbfFRstMyLqqH8YX/RLBUdyFVe2rFnGddIbAj2wTNhr9EY5Fot5G7FdnjWYQNb
         Q6o57OfWTMfGyIfjlEoMGymBJBm5m8K0FM+K9g5QvfXjjY7x3MmD6O4mV3YTG/SeHGbt
         nCVusaUU68WdveZYrFtAgtA3LHtFUQ40J8UaV+UlTHdv74f+Q+/3kOyY1awEIF1wDYGn
         0B12ne+WE2SnIMY00/jEFv12sI1o+GpcLzqGgtyBtuOKkiCcPsyatFCLPkecTudYmp6k
         blL3jIBn8d6iSVfxU6dSZRdPVRSJCb5bUzuN0XPBGlh2b7/bZYMiWp9ZO2zf+/B0j2LM
         1snQ==
X-Forwarded-Encrypted: i=1; AKwUvBzlY1M0/DhxcMe1vbHemZtBM9sbLtztnuJ0JyYyOng7zAHRBbR7fwZV4SXb5XaKAc1ufwo/GqekH1lxgvQ=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kUg63OthZ0JXeo12y3XuGD990sjsz/NZAMUKmZLtu3iNRjBSBL
	dAesbqOls6qkoKOlbRMbfACi1jcFUfSNNvg18wZlmyVoQm/5ttE0vpLGyfL1E09474f9dSweftR
	1L6dVmdDCH/Gm5+dxWByM2EfExg40QCJ3Pg==
X-Received: from pjbct5.prod.google.com ([2002:a17:90a:f585:b0:39e:574c:5672])
 (user=rathodpriyank job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:384d:b0:39e:6c6a:4b67 with SMTP id 98e67ed59e1d1-39e6c6a5448mr417570a91.49.1789752288464;
 Fri, 18 Sep 2026 10:24:48 -0700 (PDT)
Date: Fri, 18 Sep 2026 17:24:48 +0000
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
X-B4-Tracking: v=1; b=H4sIAN9zrWoC/4WNQQ6CMBBFr0Jm7Zi2kEpceQ/DotJpmYiUtEgwp
 He3cgGX7//893dIFJkSXKsdIq2cOEwF1KmCfjCTJ2RbGJRQWrS1QMcbGooYyfXhPS04knmiri+
 taxur1cNA2c6l5u3w3rvCA6clxM9xs8pf+s+4SpSoG5JC1sZaqW4+BD/SuQ8v6HLOXxh77/q7A AAA
X-Change-Id: 20260830-fix-aer-refcount-leak-6378f84d62ba
X-Mailer: b4 0.14.3
Message-ID: <20260918-fix-aer-refcount-leak-v2-1-bdd1ff1c35a9@google.com>
Subject: [PATCH v2] PCI/AER: Fix struct pci_dev reference leak in aer_process_err_devices()
From: Priyank Rathod <rathodpriyank@google.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Stefan Roese <stefan.roese@mailbox.org>
Cc: Keith Busch <kbusch@kernel.org>, Sinan Kaya <okaya@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Priyank Rathod <rathodpriyank@google.com>
Content-Type: text/plain; charset="utf-8"

When an AER error occurs, candidate error-source devices are added to
e_info->dev[] by add_error_device(), which takes a reference with
pci_dev_get().

A device can be recorded without any error status being present: the
Requester ID fast path in is_error_source(),

	if (e_info->id == pci_dev_id(dev))
		return true;

matches purely on the ID reported by the Root Port and returns true
without reading the device's AER status registers.

In aer_process_err_devices(), handle_error_source() is called only if
aer_get_device_error_info() returns non-zero, i.e. only if an unmasked
error status bit is actually set. It returns 0 if the device has become
inaccessible (status and mask both read as all ones, so
status & ~mask == 0) or if no unmasked status bit is set.

Because handle_error_source() was responsible for calling pci_dev_put(),
skipping it permanently leaks the reference taken in add_error_device().

Decouple reference lifetime from error handling by moving pci_dev_put()
out of handle_error_source() and into the aer_process_err_devices() loop,
so every recorded device is put exactly once.

handle_error_source() is static and aer_process_err_devices() is its only
caller, so no other path is affected.

Fixes: 60271ab044a5 ("PCI/AER: Take reference on error devices")
Signed-off-by: Priyank Rathod <rathodpriyank@google.com>
---
Changes in v2:
- Corrected Fixes tag from 1ab4a3c80508 to 60271ab044a5 ("PCI/AER: Take
  reference on error devices"), which added both the pci_dev_get() in
  add_error_device() and the conditionally-reached pci_dev_put() in
  handle_error_source(). Thanks to Lukas Wunner for catching this.
- Removed the speculative topology list from the commit message. As Lukas
  pointed out, error reporting is not enabled on devices without an AER
  capability (pcie_aer_is_native() bails on !dev->aer_cap), so the
  dev->aer_cap == 0 reasoning was wrong and is gone.
- Explained instead why a device with no error status can be present in
  e_info->dev[]: the Requester ID fast path in is_error_source() matches
  on e_info->id alone, without reading any AER status register.
- Added a Fixes tag; the imbalance dates back to v4.20. I have not added
  Cc: stable, since you indicated the path is an unlikely corner case -
  happy to add it if you think it is warranted.
- Cc: Keith Busch and Sinan Kaya, author and reviewer of 60271ab044a5.
- Rebased onto v7.3-rc3+ (f259f446f519); applies cleanly to pci/next as well.
- Link to v1: https://lore.kernel.org/r/20260830-fix-aer-refcount-leak-v1-1-64e1013add12@google.com
---
 drivers/pci/pcie/aer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d8dcd238fda1..bc761410d56d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1340,7 +1340,6 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 {
 	cxl_rch_handle_error(dev, info);
 	pci_aer_handle_error(dev, info);
-	pci_dev_put(dev);
 }
 
 #ifdef CONFIG_ACPI_APEI_PCIEAER
@@ -1518,6 +1517,7 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
 		if (aer_get_device_error_info(e_info, i))
 			handle_error_source(e_info->dev[i], e_info);
+		pci_dev_put(e_info->dev[i]);
 	}
 }
 

---
base-commit: a077be4fde21ee6e751fa70eb641ef5d9bf2fc48
change-id: 20260830-fix-aer-refcount-leak-6378f84d62ba

Best regards,
-- 
Priyank Rathod <rathodpriyank@google.com>


