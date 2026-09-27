Return-Path: <linuxppc-dev+bounces-28350-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A332C9830E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 22:19:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htJkp0hclz2yK7;
	Mon, 28 Sep 2026 08:19:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::10"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790533229;
	cv=none; b=YIjjrt2WTxjZWShwRraJFjGCsxU/DNK5r5+FhemzBLmWZPtm0nwkPjWdzAZx3hJ97miA48DlMQJ/++U5mFeoNkWuAz9ayn+X0PIaPym/nySMPrC6pLGgoW4eUL3W1dhX5zEcfZDloej0glqtkBUh6nnSZMHRSvOG7ycCRit7AVAKJw+FES5ddh7tAso9jkOgrBTv7/gu9zGa4B4tKpXgTRo1Lnfwg7F5rnYvwcn+tG80dyZ5D3NH234oWBW7Fte9p25JBP5TlVejrBTArXDBNFtRbjg0Vf7WBzS0npTpP/HeBbI8SjL1h/8SgoCShYD1rNz7lAku/YND/m0crIhdww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790533229; c=relaxed/relaxed;
	bh=DAfIRjqX3j9SJ+2tHHyzYdgAbG7vEZeWXs9def6Qdmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O41kivb3rmMbpDvEC+c8+Gbg1ASMgcRT39ef1DSfqxI3UlUhWzlRaxDtoXx6YhyEVSd3Vg564thFBay51wEF3ouZ91bS+xIIjbYLNc6ZTuxqlD1CviMtU0qJK1MDbWHI3kAw5mN3BuBuzwGqcdW6gmpEiP/kso6OvzVHrJcb5Rd458dxb+CzC6ZXfSFzV76U4HlNsMwoRDGUS2kfe8Ba0JWdZrVqu3wAtRZ3GR6zaPaezNhjkUYHiNRseVwHHVwn2tjtujNiITXBtf2r6U+B4EjX8/utPH/GmaKSgirK3J3BIc1OE5W0OkYVaXPTRbb4CZjtw2LHw0qdHD38V2RKMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WoyXdQpy; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WoyXdQpy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:31::10; helo=mail-wm2-x10.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com [IPv6:2a00:1450:4864:31::10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htCRJ4r0Xz2ydN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 04:20:28 +1000 (AEST)
Received: by mail-wm2-x10.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso25781205e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 11:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790533225; x=1791138025; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DAfIRjqX3j9SJ+2tHHyzYdgAbG7vEZeWXs9def6Qdmg=;
        b=WoyXdQpyu9idol/J1sob0eCprOVXrIxDRAqzEl4lVkRLy8Ji3CkGDW17T7EY17OE13
         IYf+XLAGvFyA18EF6n7MMCWDBlRyXxvJ3gAV0taBz/4j8av3ZdNcEvqDyJLWFSTWDrFr
         DUySUgdOkQtM8mpQSj/yuY+msRGRXATpbU43mWaEQ3Kqd8U7a1XDp+IucvX3P+PmUNcK
         KW5Gseh3+D+E1Pv1S6oT9Nzaye6Zm+ZKbO9PfdP00oGCa6DhbT2ysjOzKm2BHb/8a8rA
         VJJTjq1TNqKnG/wpptR2b0rA6v+p8Z+waZWox0YzxD68hkIETdRq371WZDB/3gtVRA3d
         VAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790533225; x=1791138025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DAfIRjqX3j9SJ+2tHHyzYdgAbG7vEZeWXs9def6Qdmg=;
        b=nD8NdX9RUsZ3uA+yyLrWE0waAKJ+y8oY9+Ugl+6AtRoeOi5TO5yvXMo4vLE5c8jrlU
         /keFMzSQLdyVkcExRrp8pcl0JsHzAHzFL6chqqA+7NmnpwOXmMUiT1T1C9eMuGAA+DXI
         +/EAI3ETjBsNfEDxS5b/iNIm9IqfG7CHMml9lssM+jDHFOUI6EWQW3Ms7LwaxhSA9LlH
         kUb2T3d/4QJ6tuhWoTlWQi8otuZw7A5xSkcslD5Q2xpShEq58FYoiyFPgyyToLbsA90J
         cZ/CgTn4dkHQM12p9G9Lz1b/+ynHWg2N4sy/gj/E937AvR2IHsewgIsZhRcNu6SHW66F
         iREg==
X-Forwarded-Encrypted: i=1; AKwUvByneqb8veToSuM3DxePChsZnPtpw4szozZTgWmpr+1b2wzvpzYa0uYMusGX7uwha0VajMnRDxHOdS0nh8o=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kkRG+vYYCVwxgPFE2w/oSfvWuAcbv4P9M4+/Z70GjpD91uMYJ3
	yv9llXS48bzm7SXPol/S10SWjzhaBuzlexgOVQuGdfsUIG3qiR0B2d5+
X-Gm-Gg: AYBFou24SclILICfDr0ctFFd4B3igovsHo7HPJ2TQBEZqZSn3f4OIzbqFY+g9oyVSKL
	RGbCyIQBm2AodDi3Eo68lQj1cFbdZq+t8Yl7BLpVTC491gQdohFmft78Zw9w31rC+6jUr+DMyuc
	sS6j2qNZLiV64Pg9HbucIBp4KjTkxRIcP5zpuEoPnf1V5XN/HbpVULsfNA1sKtcr0J+t/wbjqS9
	coOmuC9JHmG7H4GC6DQ4fyESgD4baRwU82r/jQJuQgdqlsEbK21Ba09oiR+YPF6aD0fY0LwBMRz
	GapPFz9NgwOhmFAOQuyCSxAabUoWhvq1DCuCl4Sqyp6OhDMWRCCS3j/pMY3QBVBLxcD3jWpijfc
	E2+VeCZmW0egPhIY/Whbbm4UaifSt9ZxV4HwhwaCsxQZE6QyV5xZkJEcx51m9RiVZunz0iaO/C2
	tMvrUO9XAdoGrAyjKNGD+ebFTqI4W34uCmPlegyI/8KN22ND6i6wYJnLfy2izpQEcYyUP9IXdSl
	PNebqHqF7qmvftw/bVar/2uVmpDqzQhZp0cSVKOkFWEesTzgeqYGGgZ2yS7LPVHnog=
X-Received: by 2002:a05:600c:870c:b0:49e:8377:c880 with SMTP id 5b1f17b1804b1-49fe7bd0128mr187827025e9.33.1790533225384;
        Sun, 27 Sep 2026 11:20:25 -0700 (PDT)
Received: from f3a6eae2255e.fritz.box (dynamic-002-214-014-217.2.214.pool.telefonica.de. [2.214.14.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a002d1d8d5sm38371585e9.0.2026.09.27.11.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 11:20:24 -0700 (PDT)
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Kees Cook <kees@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Abhin Parekadan Jose <abhinjoses@gmail.com>
Subject: [PATCH RFC v4 2/5] PCI: pciehp: Add pci_hp_wait_link_change()
Date: Sun, 27 Sep 2026 18:20:13 +0000
Message-ID: <20260927182017.938565-3-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260927182017.938565-1-abhinjoses@gmail.com>
References: <20260927182017.938565-1-abhinjoses@gmail.com>
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
Content-Transfer-Encoding: 8bit

pci_hp_spurious_link_change() awaits the end of a code section causing
spurious link changes, such as a Secondary Bus Reset, and then tells
whether such a section has executed, using test_and_clear_bit() on
PCI_LINK_CHANGED. The answer is one-shot: only the first caller sees
true.

Split the wait out into pci_hp_wait_link_change(), which leaves
PCI_LINK_CHANGED alone, and implement pci_hp_spurious_link_change() on
top of it. Test PCI_LINK_CHANGING with test_bit_acquire(), so that the
caller's subsequent accesses are ordered after the end of the code
section even if wait_event() returns without sleeping. No functional
change intended.

Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>
Assisted-by: LLM

---
Changes since RFC v2:
- Test PCI_LINK_CHANGING with test_bit_acquire(). (Sashiko)

RFC v2: https://lore.kernel.org/all/20260927165459.829900-3-abhinjoses@gmail.com/
Sashiko review of v2: https://lore.kernel.org/all/20260927170355.759301F000FF@smtp.kernel.org/
---
 drivers/pci/hotplug/pci_hotplug_core.c | 21 +++++++++++++++++++--
 drivers/pci/pci.h                      |  1 +
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index fadcf98a8a660..75524fe2bec6e 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -528,6 +528,24 @@ void pci_hp_unignore_link_change(struct pci_dev *pdev)
 	wake_up_all(&pci_hp_link_change_wq);
 }
 
+/**
+ * pci_hp_wait_link_change - await end of code section causing spurious link changes
+ * @pdev: PCI hotplug bridge
+ *
+ * Await the end of a concurrently executing code section which is causing
+ * spurious link changes on the Secondary Bus of @pdev, if there is one.
+ *
+ * Unlike pci_hp_spurious_link_change(), leave the record that such a code
+ * section has executed in place.  May be called by hotplug drivers which need
+ * the link to have settled, but not the cause of a link change, so that they
+ * don't take the answer away from the caller of pci_hp_spurious_link_change().
+ */
+void pci_hp_wait_link_change(struct pci_dev *pdev)
+{
+	wait_event(pci_hp_link_change_wq,
+		   !test_bit_acquire(PCI_LINK_CHANGING, &pdev->priv_flags));
+}
+
 /**
  * pci_hp_spurious_link_change - check for spurious link changes
  * @pdev: PCI hotplug bridge
@@ -551,8 +569,7 @@ void pci_hp_unignore_link_change(struct pci_dev *pdev)
  */
 bool pci_hp_spurious_link_change(struct pci_dev *pdev)
 {
-	wait_event(pci_hp_link_change_wq,
-		   !test_bit(PCI_LINK_CHANGING, &pdev->priv_flags));
+	pci_hp_wait_link_change(pdev);
 
 	return test_and_clear_bit(PCI_LINK_CHANGED, &pdev->priv_flags);
 }
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 175273756c183..cfa0202bf610b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -360,6 +360,7 @@ static inline int pci_proc_detach_bus(struct pci_bus *bus) { return 0; }
 
 /* Functions for PCI Hotplug drivers to use */
 int pci_hp_add_bridge(struct pci_dev *dev);
+void pci_hp_wait_link_change(struct pci_dev *pdev);
 bool pci_hp_spurious_link_change(struct pci_dev *pdev);
 
 /* Lock for read/write access to pci device and bus lists */
-- 
2.51.1


