Return-Path: <linuxppc-dev+bounces-28324-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6021C9832F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 17:51:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htBpC2Vnwz30Vm;
	Mon, 28 Sep 2026 03:51:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:30::e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790528122;
	cv=none; b=mWVEniVQHdUUiLOtM3lbRYnagPLP/I7wOib0XH1hoz8UCPd1CZvG2c3KgzNWwUAGfw88sTWaoaAA7w9wAcmc0CwOQ23xV/j76DO/jMhoaEqF7a4tuTiHiZMUGvB+EcCs1zipv6JZvLHFw89GZB7KAABEeQLacqY2gEgkTT7S4muEUq2AhWM3s8J19HDxkLnRvBsjXWBwv8/fhIBwqQkh6ZLam0E++oqLf0pWggDjDUm2g9aO5Ek4YS0JHvS3wiIRVj3mCbnHKjW5VJ0uQc3jJB8GbgK0LiFYm1wpQe8dVQyMFHACWCbHT9ME/XPF9ghwRoxWdv2k750DXjcqrxZC5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790528122; c=relaxed/relaxed;
	bh=nO4LPQO5B94BniGFyWk4r3/clPvyPjMU90wwNe9Utio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9kNfAg4LeCaGxgips4GLTkumhH7D5Oob1RMqUMNnJAkxx6FmlTGK3t6RiZH1iGN+JumZfkblUtwILpfJztR7OYMAPop/+jLPCmSxn/TWOWVAFDjmwdXVUpdVspMaTxunqESiGlJXWgdyR5J1IOSQWKHZi+E4BQUGXErwa5r/3EjwyYYvt6Sc7gx20WdIq8540gahlUBlIKQwQAa3EHR3k/Oa491UiIz7xknbBi4D6AAoIXPM+WhlzaTzem3mpVlEq5BSNZPOY7N++qvd32ZnKWIPgWjXZbo0htqfhNZcNFcMjzTZ+x+vkjdZVnr19pBYA05sMmtwsPkVYZyXg+Kcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QnDo5A2q; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:30::e; helo=mail-wr2-x0e.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QnDo5A2q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:30::e; helo=mail-wr2-x0e.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wr2-x0e.google.com (mail-wr2-x0e.google.com [IPv6:2a00:1450:4864:30::e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ht9Y54KyTz2yr0
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 02:55:21 +1000 (AEST)
Received: by mail-wr2-x0e.google.com with SMTP id ffacd0b85a97d-48881a62e09so1191219f8f.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 09:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790528118; x=1791132918; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nO4LPQO5B94BniGFyWk4r3/clPvyPjMU90wwNe9Utio=;
        b=QnDo5A2qpM4kdz5zMF12h2xYNVwSueW8jjZuIiL6qpCXwLakFOQnMGe9Q6hs7uEJeR
         oYfzKEadycht1HdOdbXmmrFHl98bXyantkQcCuhCg4cB6maAh0dBrRZ5gy+oYQ0L7AmB
         FXBp7a6m66jKbjjsYtc+IoQkRE7a7qcHG3G/Foq3odMVP4pyxQ0izDUpeBKaI0t1z/Vi
         hMfZCHh0fNzAOW4vDHaeKyvKegamk/fnJK9nbqHo+dTwQ1qzNmqKdtQNOpuzBvU4DhqK
         jhl4//jjLM6wSqM58DdDEmG7RmAZuQeTWwdKxopWkonkn9+Btyl9jUudP8tYmh+aZn7j
         nKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790528118; x=1791132918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nO4LPQO5B94BniGFyWk4r3/clPvyPjMU90wwNe9Utio=;
        b=yXzMIoXKu3ORtuU//PiREjRaCbhgqmTyWhg0NUa1JV9cfLekdBmCxzO5wc4WLLqxGp
         Pk3KMSM0L5icf5/sgCgXril/h+NDjKN9uJ2rjUwsdmYnDJIj4r/To7kckfeWkPz82rp8
         4rzDkN5Ratg4fCncfkaLblgVqx/qs/+3kUQ7EBpoY8XwQSctZVCPTAlbpHkXY/D2pM/R
         9DOTPzsoGRh/TvidsJrvBXTYTT44JvOiz88F9SngAbcZdL85TgjwRT4iZqUIiXw8Jrmz
         UwmgSWWi3ZQ/js0eym2XPzuMJyVeXH+D1fGvRi3kDe44Dfl3WErV4iGHhvw1TXABVtEA
         hFJQ==
X-Forwarded-Encrypted: i=1; AKwUvBzhFBLOFVXgVzGTQATpWRzWGZqaXCBupB/AHbgjQHcgMmUo3b0KBrXEntVr872A0ctPAL6i6Zqli5AQbuc=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mkCsF7zoHYonkP47/T8I19OTVj6Si+pyPoK9pyLtlCcMgjFH1S
	Yq4xKRxYFEL8aY6rse0E3hqdldxG0f3n+3Yt6Tk+0vbnN6nuhr6AKcD6
X-Gm-Gg: AYBFou38wu1PpIdKou5c8CNAbkZxOkR3NoaV/U8AMScqXYwHKE6VQIw8B+5hbuc0RwN
	ZBWZOJOyLZQpWSNPFFd/phnmXAv++Vl01dWLN4iwg8wwOxao73wqghzwTG3VkRHWhYlgA520tZh
	DeGxl2hReiJQUBNEopr4KIhZccE7XhLZt8wy0a23EAqoHZmNpAb2OamCoXiQmg+H7Nxo0WWZYQ3
	/FSDhubJuTA+KeYWur118cp4BWcvetMoLE1mHRztKHSsyG2FWvG4KpHt4kHUEfAGcWpaw6BorrT
	MwaFYD4iyniZvszycCxcn0ODpuUlA+d6FDDGvhCjhHifEcnmM4dElFa2ND+LTRoeh8igekk4rqP
	VSftO3UXi+6EcaYudZKN+s++ok/967SLcZ8SLqAhbvhXvwYfPtrHVhPlF9H291iklPZrpykAxnZ
	29cOYxh4Pfgx2i3OMJW3s4DVJvkvH5UczTHW1HKsL95c9Dv0Dohh4vzZrYj1Jn6g7wOqD2PSoDU
	FGTn3lwKfKS4UipsEpyQDfYXoqyTU/VYU/I550b9uz8iPTR4gUnfN4jx0MdUrfRB+Y=
X-Received: by 2002:a05:600c:3b87:b0:49d:1916:59c7 with SMTP id 5b1f17b1804b1-49fe66c8a4cmr227126485e9.7.1790528117881;
        Sun, 27 Sep 2026 09:55:17 -0700 (PDT)
Received: from f3a6eae2255e.fritz.box (dynamic-002-214-014-217.2.214.pool.telefonica.de. [2.214.14.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00178bebasm76167695e9.11.2026.09.27.09.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 09:55:17 -0700 (PDT)
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
Subject: [PATCH RFC v2 2/5] PCI: pciehp: Add pci_hp_wait_link_change()
Date: Sun, 27 Sep 2026 16:54:55 +0000
Message-ID: <20260927165459.829900-3-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260927165459.829900-1-abhinjoses@gmail.com>
References: <20260927165459.829900-1-abhinjoses@gmail.com>
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
top of it. No functional change intended.

Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>
Assisted-by: LLM
---
 drivers/pci/hotplug/pci_hotplug_core.c | 21 +++++++++++++++++++--
 drivers/pci/pci.h                      |  1 +
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index fadcf98a8a660..c3e0ee8b36381 100644
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
+		   !test_bit(PCI_LINK_CHANGING, &pdev->priv_flags));
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
index 23b1605e783a3..2e113806f9f95 100644
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


