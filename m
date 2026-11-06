Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605C4606EEB0
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 00:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UN/rPNNI
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLL4q5R5Bz309w;
	Fri, 06 Nov 2026 11:43:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::246"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793925787;
	cv=none; b=e6wjd0JAIUkA7Z8eHTXG98mbXRuEe1MgKkzc3py6AP/UudxbuoLJfrfi/y9WU1wkaj5fS0u4EJOqwAFYuFDBhu5pek2O1guHszVdBHQCm/lxvJs9H8OJoBYwrrHFDLUzOBsYDAmqrvMBzYBO68IzE1ecfNlkLd1ZUmo1/V3wJuQxgZh0jvYeb1Zr3ejChrUdvUuCJQDAurMNoh6A2YeMwTT9FnVfmxrBdwpQrSAmu+I98lr5aWRTKVIW/1YgwR0iCo0kIdGvRxYoIKm+8Vv27M9TBc+VrO2tPHp/hXbNDnlfMXbBFY1EyVIGnUYtfbWZ0yifZid0e7qBWuubUKSFvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793925787; c=relaxed/relaxed;
	bh=clDl87D5pggy1VDwhZUzZxM8yGbSHZ+6BQixZZJAVUs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fu7KTk8Vt+WjZSIt+bXbH6V7Revrpav0VKfAXimeMC5oVbGNhMJ8PGwfA6AbhiXTSUIBxu57mJ3Jpjr850vLZlM85qscdLrLUm42xxoLvnIqtw/Sji4iR6SL5iy8rparPQ9X55VCNevvRSIUlWn55GN35P6taK86jCoVbSzsGmdplAJGknUtoGtc/J0HGu+AlrNPYHWQHJk7DCqYkqLMLZ3pe/lhm34CSwG44wUfg2fofqjbSUmChTVib305w1Ed/voDy+YNLSiacFL1uqSjBnKdmMY2Vlk+oDkSmDtajH7BllHzl6WCuVIFi6YtlUtBfwwXYrDtfsYn7lC+I87j8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UN/rPNNI; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::246; helo=mail-oi1-x246.google.com; envelope-from=3liltaggkdo0sbpiaprzvddvat.rdbaxcjmeer-stkaxhih.doapqh.dgv@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UN/rPNNI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=2607:f8b0:4864:20::246; helo=mail-oi1-x246.google.com; envelope-from=3liltaggkdo0sbpiaprzvddvat.rdbaxcjmeer-stkaxhih.doapqh.dgv@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x246.google.com (mail-oi1-x246.google.com [IPv6:2607:f8b0:4864:20::246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLL4n1fDbz2ygW
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 11:43:05 +1100 (AEDT)
Received: by mail-oi1-x246.google.com with SMTP id 5614622812f47-4c734afb8deso79004b6e.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 16:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793925783; x=1794530583; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=clDl87D5pggy1VDwhZUzZxM8yGbSHZ+6BQixZZJAVUs=;
        b=UN/rPNNIf7zVWP1djAv5FN+9NPPM5PMxxvR4ICUJiSPDArXTUzAF7DC+7Ofs+0Ze4M
         TxTNeZtGrMNogz5AOL57VXOYixxA9rIUcb3bqq6gaPU+nIA2JIhq92i8lALCwojvuzhb
         x5QJcmTRivgW5Vg1P/5fVAAjIWItjRMzD7hd9zKCmdXL7Shfl1MDQIH7IpQDhaAbHPui
         joe8jy1hoSvN8jiv6DWkfb2c2WffUqiKV3e5d994vsWghtNr3kaJzwTvZ7hmDv5uqcgx
         B7gkBhh7rINjQwTo8Nhnoye9ZN86uJywvkLKrjJh858VPuVxgdSHzGFh2KntK1SyPwLC
         eozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793925783; x=1794530583;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=clDl87D5pggy1VDwhZUzZxM8yGbSHZ+6BQixZZJAVUs=;
        b=Fb/EHLhOQGHfbS18t+vEtmahERpWTNp/1YtK5f+EuzFGYtHHjrr3p9B6mR1KjqAkxY
         Cwld3jrMcFjglps+zPsZtXqD3iyE7AdVIfHKvGPox6J00Us19+zJO6hGe1z+h/1Qqmhz
         fJlp8LHn1KBTzfv/C9mlk04iEdMuHT6hL2CAGroB1TdiH4Xj1A4uvh3Scdb/cIBdhvYh
         WyMzp35ns3iJq5Nsllyp52gJmTEawMTcc6mCIXw2K157BEHp7SALd1yfx679UYIe2v4k
         2drel8fJTVaC+dVbq931LRfWXVWoJbWh1e5i1D+W4F0BN8TL+hwx4wsfitR8BK6JhEsR
         3NNg==
X-Forwarded-Encrypted: i=1; AKwUvBzpMaSOtE8CXztCWbjTICxxRjB76yuaUJMWPDMETNXP0RPaCVvd7p5oNJusyWV3cX2enz00mUQQ9SmYDi4=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+Dc5p5/xt6S00sAlMQV85eDD4Iw/sZHIS3xzNkLBuNX45ZQQ3Y
	IgciEOaWfph++VzULEkLJEdxGdL4BGG1ZFY4k6enDj9pcs2T+zJqq3mpJkCHNk8mZ3zyleoDtw9
	exqP4HPSFUb9+vw==
X-Received: from iofl4-n1.prod.google.com ([2002:a05:6602:8384:10b0:9e3:4909:2e0c])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:3197:b0:564:4f93:707f with SMTP id 5614622812f47-567e1038170mr654365b6e.24.1793925782556;
 Thu, 05 Nov 2026 16:43:02 -0800 (PST)
Date: Fri,  6 Nov 2026 00:42:06 +0000
In-Reply-To: <20261106004218.604799-1-dmatlack@google.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261106004218.604799-1-dmatlack@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106004218.604799-6-dmatlack@google.com>
Subject: [PATCH v2 05/17] PCI: Save PCI-X state in the saved capability store
From: David Matlack <dmatlack@google.com>
To: kexec@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Matlack <dmatlack@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>, 
	Lukas Wunner <lukas@wunner.de>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
	"Oliver O'Halloran" <oohall@gmail.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Save and restore the PCI-X Command register through the per-device saved
capability store instead of a private pci_cap_saved_state buffer.

Reserve the register by its configuration space offset during device
setup, in pci_reserve_pcix_state(), so that the save and restore paths
no longer have to locate a buffer.

Make pci_save_pcix_state() void, so pci_save_state() no longer fails with
-ENOMEM when the PCI-X save buffer is missing. A failure to allocate the
store is reported once during device setup instead.

No other functional change intended.

Signed-off-by: David Matlack <dmatlack@google.com>
---
 drivers/pci/pci.c | 47 ++++++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index fde1dcd99e94..6cf4a64cb7e6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1900,40 +1900,40 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
 	}
 }
 
-static int pci_save_pcix_state(struct pci_dev *dev)
+static void pci_save_pcix_state(struct pci_dev *dev)
 {
 	int pos;
-	struct pci_cap_saved_state *save_state;
 
 	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
 	if (!pos)
-		return 0;
+		return;
 
-	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
-	if (!save_state) {
-		pci_err(dev, "buffer not found in %s\n", __func__);
-		return -ENOMEM;
-	}
+	pci_save_cap_word(dev, pos + PCI_X_CMD);
+}
 
-	pci_read_config_word(dev, pos + PCI_X_CMD,
-			     (u16 *)save_state->cap.data);
+static void pci_reserve_pcix_state(struct pci_dev *dev)
+{
+	int pos, rc;
 
-	return 0;
+	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
+	if (!pos)
+		return;
+
+	rc = pci_reserve_saved_cap(dev, pos + PCI_X_CMD, sizeof(u16));
+	if (rc)
+		pci_err(dev, "unable to reserve PCI-X save state (%pe)\n",
+			ERR_PTR(rc));
 }
 
 static void pci_restore_pcix_state(struct pci_dev *dev)
 {
-	int i = 0, pos;
-	struct pci_cap_saved_state *save_state;
-	u16 *cap;
+	int pos;
 
-	save_state = pci_find_saved_cap(dev, PCI_CAP_ID_PCIX);
 	pos = pci_find_capability(dev, PCI_CAP_ID_PCIX);
-	if (!save_state || !pos)
+	if (!pos)
 		return;
-	cap = (u16 *)&save_state->cap.data[0];
 
-	pci_write_config_word(dev, pos + PCI_X_CMD, cap[i++]);
+	pci_restore_cap_word(dev, pos + PCI_X_CMD);
 }
 
 /**
@@ -1953,11 +1953,7 @@ int pci_save_state(struct pci_dev *dev)
 	dev->state_saved = true;
 
 	pci_save_pcie_state(dev);
-
-	i = pci_save_pcix_state(dev);
-	if (i != 0)
-		return i;
-
+	pci_save_pcix_state(dev);
 	pci_save_dpc_state(dev);
 	pci_save_aer_state(dev);
 	pci_save_ptm_state(dev);
@@ -3749,10 +3745,7 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 	int error;
 
 	pci_reserve_pcie_state(dev);
-
-	error = pci_add_cap_save_buffer(dev, PCI_CAP_ID_PCIX, sizeof(u16));
-	if (error)
-		pci_err(dev, "unable to preallocate PCI-X save buffer\n");
+	pci_reserve_pcix_state(dev);
 
 	error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_LTR,
 					    2 * sizeof(u16));
-- 
2.56.0.455.g6c5a503b38-goog


