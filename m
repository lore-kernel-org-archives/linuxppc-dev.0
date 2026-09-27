Return-Path: <linuxppc-dev+bounces-28330-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37029C98338
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 17:54:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htBs05ZXhz2yPR;
	Mon, 28 Sep 2026 03:54:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790531536;
	cv=none; b=TCPpttscLweZfO6S2cIHkvY84ggXSjCmCQT/3TAYM4EXMxUtoHExOsrw4nSvXkWK6QFWPh3kGPpGRJ5bfdRsLGvfKi1eO8FXAk6INUW2YjYhUszB/R8Y+Gnnd+Q/tpsiVSO34QS5zk3OP+xFnDixvGtTM69AHjJb9S3R6MZEDP3oHZ1T/d0JKPZjycTM8rw+D9ip1ASWOXWZ8HUKLUDvgLqbBWocL2x45Dy66S8LBGxBIbVa6k+rvzTfu5fIkcFrZ9xzYLESJRw/fCcl+HGcoPOnoe8qwryuMwY9PIqyV9TlevvFKyHPnn6I1LWM6MOnTyjPCh37qb3EMBN+VQaMpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790531536; c=relaxed/relaxed;
	bh=DAfIRjqX3j9SJ+2tHHyzYdgAbG7vEZeWXs9def6Qdmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WvCc/Jlk2hJ5YX4u1lavIjNQS++sfPVgstSBNOU+oACY+Vio7teMY3nqPIRzXjfpv9Y50d7akSh8a5PKODpCgJRvgsDUjEAIe4NtaIoZ8p9PTwjcu5F9hC6umWCVc3Z9bt+caq3iWtBnIh5zRUT3vvcYYM2U3fH58hTdCcOcCbIp62Ld1a+7QdpAqPXFe0tDmnJEPfudeFHdy770R7dqIVAc+ROArokzlyN9FzSQN5xoHTeeAeifbZVhYmr73NZwt7hi8bfugqu3dsWGFfYnfiOv5bQ2I2PzVJYhWXmjKd5ldFtjaFuxA02lDiP2lbFlovudfYVRscuIECktVxHnSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Oh9+KX0X; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Oh9+KX0X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htBpl23wCz30WT
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 03:52:15 +1000 (AEST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-48870973bddso1039034f8f.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 10:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790531532; x=1791136332; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DAfIRjqX3j9SJ+2tHHyzYdgAbG7vEZeWXs9def6Qdmg=;
        b=Oh9+KX0XMr3Ruf4t5d81M8djvvMIYi0dIcvfum/VV8E+AKzAYHMk2Z69TI5zZziiM2
         jmyChnUM9otAAEltoq1G/s5BgmWPgdmf9NrfQNQV49htjHrxa86MyvIKu/2NwEH/unIA
         uU1QXPmgxl7cqXEDc5zW5rOTQIzsHz3P4MB/Z6TvvYBX832QsKU5KoIrHppfGaaR2WBj
         NPLvo324gI1lsOI47p7HlOA4eC74dC7dpkmTJKXss662ekKrKeyQQc6i7EXUbh2ty1tv
         HMPmuZd5GxpO02+4hUfUkFslioRQJN9txCepVcKS9YNwv78FIW1QZE1PuHj5eL+iEdwA
         hBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790531532; x=1791136332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DAfIRjqX3j9SJ+2tHHyzYdgAbG7vEZeWXs9def6Qdmg=;
        b=Rcql8C1ZjSFnU0ZPWVPraBG0RXJdX4YkuMniF+hpQgBZLwa49/HeFq+4n3xS4MwTst
         8qB+ATcaop8Ra6OTSTmpMlcPpPqcP1llwekREFO9cJ+rY6gX6rFsYU1zQuJJJYkAa4zG
         y1gEr6VboggQM0vx7DzQhzflfK0PTYHS/qauvercJwdGNCee137fzpvm7243P0bKpeso
         ni5FM2uKqdpdVXNxyNbdy1CdM8mROcV9QsMH9zhF3okm6ibi+wbBzAuVdGaQDJqlOKwN
         pS+9o/8gz/9//4dRKrQxd15v/o+cM6kH5Prf8DULb47d86byg3EqqypX76Vs8q8twbrL
         LpzA==
X-Forwarded-Encrypted: i=1; AKwUvBwJ2oR1XZQqjTt0qpcIkl4LkbiWFgG3MomG4hoCh5AzVZW5h0O/Yjex1IEnRFZW8xxdp1aE7dg1JTE9ZIQ=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKXHEkK6yjDzlBisMavQfuowoev6k7nfzpDDvFqFe1ESVsRC6ki
	L4dmksA9x6zPpR+P+WIv9D3lQKGm+U05fLCUrcDymL91SNTYM/XVaNAj
X-Gm-Gg: AYBFou1YxZdb514ODNqT3NvAhB3DpHgRl6NQ9dTEJj9LBEi1iG3bBvPp6SNZmMJ/95S
	4rYg74jW1QZ6w53IL+8F4VTHi28iSlNo9jgLlZOdp6QOCSZ24eiuuP7Tju9KS7lvVRrCHGs1Mbh
	W+2ssdD7lpVFgn9qt0+4RXB3r7wupUZOTASGqU0yvXGc2BV3ggIqy0sbedG0laX13nNXIJgWx9f
	Hlm3NP7P+z5cytsgKAKwtrxt6Sx4v3rMv6LXXp5ayRh88AyiqbsrYKJIXi027Wxs2QMmjVjSZ9B
	hVOt+5N9j/eSJUJpECjUaB900eG0vCzLtaOmwI4OH4CrxZ9VUTODQjJGw599FibyJ0HBsQWFOV9
	OnP5BD9BXoyPnfEtWQrwt+soAt0P13K4fnwObdhFqf7jXNGoRWN0iajVJnsNFYQO9YlUN0oxkLp
	kz5LQvpLESD9+h+KrS03FYXyjJzOE7KgkB1xvEct7jjVAjdtmV6drz+L1x3XZhO8gcgp5xe0CZR
	7WeN69cmF3piaEfibQrwLrJ8hfCLE3Ss4YlhyP5AMovEh11g82btzedmXG67NXZ0PfbnqpCmXf7
	Ow==
X-Received: by 2002:adf:e197:0:b0:488:8cf8:1c with SMTP id ffacd0b85a97d-4888cf80236mr4089251f8f.0.1790531531795;
        Sun, 27 Sep 2026 10:52:11 -0700 (PDT)
Received: from f3a6eae2255e.fritz.box (dynamic-002-214-014-217.2.214.pool.telefonica.de. [2.214.14.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30bcc4sm22563923f8f.1.2026.09.27.10.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 10:52:11 -0700 (PDT)
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
Subject: [PATCH RFC v3 2/5] PCI: pciehp: Add pci_hp_wait_link_change()
Date: Sun, 27 Sep 2026 17:51:59 +0000
Message-ID: <20260927175203.928270-3-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260927175203.928270-1-abhinjoses@gmail.com>
References: <20260927175203.928270-1-abhinjoses@gmail.com>
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


