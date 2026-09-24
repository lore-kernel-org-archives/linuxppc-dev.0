Return-Path: <linuxppc-dev+bounces-28138-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1673CC98318
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 17:36:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrLZl2Lvvz3bmN;
	Fri, 25 Sep 2026 03:35:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790271326;
	cv=none; b=T1+v/681hLgOLOZmL94cWZAtBoKA2nF+09qxzfpDiQ3K1my8qaxRDVlL3nJ7kZOQz8mF+SiGj0qIcpYV9kahEfbcil8+kGFtjy80sYBsRbLbgAZLN+fWvOIxN4Wf9JGeRZ4Mxkkrw9RLbFnzTyb0HmepeV5jQb5scS9RxwSAm6xIm0FL8VSc5s0tE7RQJ3avjrgEPXKqaa5KDvhABumWh6DNnoUlWWCcm3paCcUJp02pfpK0TbJL4pBQpMIwFPIt+zmfOvOrxig0JwJ6l/OJaHPbakfqDGA3d1TZ9eyGa7VDmqDYKqjAkosm7b5N28umSzJP6GXfcdolmVpsghcILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790271326; c=relaxed/relaxed;
	bh=noYPamfewYEtm9bVDAU/nSTNzs0ZIauOG0d/1Q9kwJg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=abaXLLnhV+DP+Jb+Io/OsoowYos5zFO0DAsuWT14/AofHo6S/qmwrFA8M/i4TxAgPIsER13cVUf34MJB7jTWlAbnpjqDXDNHyRgcluGLEumvC3WDnvrjnYqi7Qr6+y3TW9bkALnWrL3eM77DyUfBGIIbet7CDAcNKioJ/3JeXFE1ML3ulAW5F5BqkZW4eYfK8XNz+tDcUafTy0UPR9pt12hb1vkKqyJnaOMtd8ZLZ5Hey9fEJTE++LR9fjsCRhFaEKNdZFPn0uNgBwwxv/QddBuG8uj7c1xkmXwWKW+9NfNndULOiyNn6OZGW436iWE4F4OqgJIWb4YA3BibJfGv+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PbxPhfu6; dkim-atps=neutral; spf=pass (client-ip=209.85.215.199; helo=mail-pg1-f199.google.com; envelope-from=3vv-1aggkdeylui1tiksowwotm.kwutqv25xxk-lm3tq010.w7tij0.wzo@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=PbxPhfu6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=209.85.215.199; helo=mail-pg1-f199.google.com; envelope-from=3vv-1aggkdeylui1tiksowwotm.kwutqv25xxk-lm3tq010.w7tij0.wzo@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrLZc6jRyz30TP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 03:35:20 +1000 (AEST)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc4922b7c31so13061a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 10:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790271318; x=1790876118; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=noYPamfewYEtm9bVDAU/nSTNzs0ZIauOG0d/1Q9kwJg=;
        b=PbxPhfu6tYrjuOPVW0LjGGrKFDY/NmljY7gV9J7xrJWnXoTtw8YCLx+dHj46eO9vVt
         TPSCmLlCPljfKxWHU7FkBrN5w3k0FuX7P+9uhqVKnnhcPJhcZqP2ZbvD7zYe/jdTSGAI
         GVZP+7chPk+HQfNEtkc57LN8LSOSXxItLlaqbZdRd1y4wU6ED8Cr6Ll99L6UlSnrs/qr
         uFxGmGfR///bQQhxzUKxXfg4IHkv3hxTJXAPf7E954U1DtXE7xQv0LvRtshz4bKWEYId
         tBGO67jzYwiZ2z4QCMIZLTnxVqdCOHXVPnyI1YONlDvdJt6Bv4/vfl0CacSVffc6saig
         U66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271318; x=1790876118;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=noYPamfewYEtm9bVDAU/nSTNzs0ZIauOG0d/1Q9kwJg=;
        b=ZGPbhoiVQKqWyYVyFqvi+SpDgvasWMZo0fLVFabcvUN1kmjhhph5TjSd0lNXwZOmmh
         oTGY13OiFqUZhayyeRmCID5R2NMtzrPZE8q9BKmYbmaMzbxik+TIMQALPswaljW3bHem
         z6+qD4+6kaoev7sark2I/llaq6kLU1NBJO7f0bHYKq+q0G9tjVrg3+SBXePWXE6LY8p8
         0X6vg2vWVxwnOIS8QSvZt2sDltdq9fn5O25R699bCilesO9Zfo6L6YYbMf9bademscsP
         rDsVPbbGCdKvNqQbq8P1VK3SyHbOnr6D26NpPUJCsXUdYDYZtWIU1EQxjl8HaQZXiytK
         NLeA==
X-Forwarded-Encrypted: i=1; AKwUvBwidkRyhcGxbEU2eFrHTcTYIwAjwFcvkYvRsWKlNuAEqurRJDxZ1vyntTLiyMG6PVO4LU/hFt1A5q8g/S8=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mBhNifwtsByGJ4KNsXd8SytvJPBCjjEvOXDS6bwq7XQ27sOlZP
	fvbLMLazCjQJv6nZXwWEzRws0PBddEhkavoveYeIOBY3j04jbfPd25/kC0uSxaKJAruLALbKFTh
	O72w49YqeIicAog==
X-Received: from pltt2.prod.google.com ([2002:a17:902:d142:b0:2df:3e71:8c70])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:37c5:b0:2dd:5363:3219 with SMTP id d9443c01a7336-2df7dc2bfe2mr27467525ad.20.1790271317823;
 Thu, 24 Sep 2026 10:35:17 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:34:58 +0000
In-Reply-To: <20260924173501.856380-1-dmatlack@google.com>
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
References: <20260924173501.856380-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924173501.856380-13-dmatlack@google.com>
Subject: [PATCH 12/15] PCI/VC: Split the VC Resource Control restore into a helper
From: David Matlack <dmatlack@google.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Move the restore of the VC Resource Control register out of
pci_vc_do_save_buffer() and into pci_vc_restore_res_ctrl().

Restoring this register is more involved than the rest of the walk: the
enable bit has to be preserved across the write, the port arbitration
table may have to be reloaded, and the VC may have to be re-enabled
afterwards. Inlined in the middle of a loop that is already sizing,
saving and restoring three kinds of register, it is hard to see where
that sequence begins and ends.

No functional change intended.

Assisted-by: LLM
Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/vc.c | 51 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
index a4ff7f5f66dd..5b507207d56d 100644
--- a/drivers/pci/vc.c
+++ b/drivers/pci/vc.c
@@ -168,6 +168,37 @@ static void pci_vc_enable(struct pci_dev *dev, int pos, int res)
 		pci_err(link, "VC%d negotiation stuck pending\n", id);
 }
 
+/**
+ * pci_vc_restore_res_ctrl - Restore a VC Resource Control Register
+ * @dev: device
+ * @pos: starting position of VC capability (VC/VC9/MFVC)
+ * @res: VC resource number, ie. VCn (0-7)
+ * @ctrl: saved VC Resource Control Register
+ */
+static void pci_vc_restore_res_ctrl(struct pci_dev *dev, int pos, int res,
+				    u32 ctrl)
+{
+	int ctrl_pos = pos + PCI_VC_RES_CTRL + (res * PCI_CAP_VC_PER_VC_SIZEOF);
+	u32 tmp;
+
+	/*
+	 * For an FLR case, the VC config may remain.  Preserve enable bit,
+	 * restore the rest.
+	 */
+	pci_read_config_dword(dev, ctrl_pos, &tmp);
+	tmp &= PCI_VC_RES_CTRL_ENABLE;
+	tmp |= ctrl & ~PCI_VC_RES_CTRL_ENABLE;
+	pci_write_config_dword(dev, ctrl_pos, tmp);
+
+	/* Load port arbitration table if used */
+	if (ctrl & PCI_VC_RES_CTRL_ARB_SELECT)
+		pci_vc_load_port_arb_table(dev, pos, res);
+
+	/* Re-enable if needed */
+	if ((ctrl ^ tmp) & PCI_VC_RES_CTRL_ENABLE)
+		pci_vc_enable(dev, pos, res);
+}
+
 /**
  * pci_vc_do_save_buffer - Size, save, or restore VC state
  * @dev: device
@@ -311,23 +342,9 @@ static int pci_vc_do_save_buffer(struct pci_dev *dev, int pos,
 			if (save)
 				pci_read_config_dword(dev, ctrl_pos,
 						      (u32 *)buf);
-			else {
-				u32 tmp, ctrl = *(u32 *)buf;
-				/*
-				 * For an FLR case, the VC config may remain.
-				 * Preserve enable bit, restore the rest.
-				 */
-				pci_read_config_dword(dev, ctrl_pos, &tmp);
-				tmp &= PCI_VC_RES_CTRL_ENABLE;
-				tmp |= ctrl & ~PCI_VC_RES_CTRL_ENABLE;
-				pci_write_config_dword(dev, ctrl_pos, tmp);
-				/* Load port arbitration table if used */
-				if (ctrl & PCI_VC_RES_CTRL_ARB_SELECT)
-					pci_vc_load_port_arb_table(dev, pos, i);
-				/* Re-enable if needed */
-				if ((ctrl ^ tmp) & PCI_VC_RES_CTRL_ENABLE)
-					pci_vc_enable(dev, pos, i);
-			}
+			else
+				pci_vc_restore_res_ctrl(dev, pos, i,
+							*(u32 *)buf);
 			buf += 4;
 		}
 		len += 4;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


