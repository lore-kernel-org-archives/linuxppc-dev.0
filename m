Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9C6606A329
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 16:49:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLlWs5ZTgz2xNC;
	Sat, 07 Nov 2026 03:49:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=144.76.133.104
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793983769;
	cv=none; b=OlvOhk+8PL54XsNS5BTY6k8heUzJX1mybwOWdW+C99LNkYQF2vJ/kb2TW5H9qo+yPa8zj7clke80g2eJ5E4FCGZepYu9SsxBbHZ+i27ijaxzXf8R32lYhg/+AFn/DO48zWocHPjzS4byxWHUZNt0I3EpLhHRzHpbhy1KS6/gx9ePi0YjVP5uDBpHuQc7xscdWVoUf4HM1lc2OsO4r1yDLOLmL2Wo+c4ReAAjnt8ovMJ5GTbETdMM8JusVzWMpcHHK1QAyQs2bfaFjjaCLESijUvSdwjkEud1vZk/Pgg515SZTPaXj5R0W1bpN0gH1BhNRtNfwW4i8vOJzcEuAkf2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793983769; c=relaxed/relaxed;
	bh=/Yp8dsMl6Lf3ocZHFO0ONl5/mkfgVoOZEOxzvn6eqRk=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=dPaXF8pQGCHoz7vcur5hsj+AkLhuxGvj13DEvhdmqvyyb9MvB5+USMQanpcGSEuEXCwWq4ZJJySBfUFBV/FHNxA1FzmRR/PaXGgeiWKghWMFIONKf36K9x+ZqruFEgJCw6Gl/b1k56aJIG2i5XvZU9mj4zFjUCXCMze8aY0/ZCLF8yvlKrJIApWc1Zn8iRpcugrz1tJPgIj4iVWFG8lbmkdLaVW3r5SVZBAmhtCaSj2Qy+9183SgOfiPBWct9gO4lqtpTefPNmF8IRsk1ZSDaD1sw2zJONpSUw5k3663WjKlQFTwRzxlgCpYZC5ToMZV/wANbFC5GPJXydT0dCrH0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=144.76.133.104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=144.76.133.104; helo=mailout3.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [144.76.133.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLlWs150Wz2xJR
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 03:49:28 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id 87D916934;
	Fri, 06 Nov 2026 17:49:23 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 458AA602EB8B; Fri,  6 Nov 2026 17:49:23 +0100 (CET)
Message-ID: <7fb629b44a64b5b7ce0359346a61dc7d32359ca4.1793982724.git.lukas@wunner.de>
In-Reply-To: <cover.1793982724.git.lukas@wunner.de>
References: <cover.1793982724.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Fri, 6 Nov 2026 17:38:01 +0100
Subject: [PATCH v2 1/2] PCI/AER: Avoid NULL pointer deref on search for Error
 Source
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
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Alex Deucher <alexander.deucher@amd.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Keith Busch <kbusch@kernel.org>, Maciej Grochowski <Maciej.Grochowski@sony.com>, Ilpo Jaervinen <ilpo.jarvinen@linux.intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A Root Port's subordinate bus may be NULL if the PCI core runs out of bus
numbers on enumeration.  Yet when the AER driver searches for the source
of an Error Message, it dereferences the subordinate pointer without
checking for NULL.  Fix it.

Fixes: 28eb27cf0839 ("PCI AER: support invalid error source IDs")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: stable@vger.kernel.org # v2.6.31+
---
 drivers/pci/pcie/aer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index db4f607f889c..d492c7ce01e1 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1251,7 +1251,7 @@ static bool find_source_device(struct pci_dev *parent,
 
 	if (pci_pcie_type(parent) == PCI_EXP_TYPE_RC_EC)
 		pcie_walk_rcec(parent, find_device_iter, e_info);
-	else
+	else if (parent->subordinate)
 		pci_walk_bus(parent->subordinate, find_device_iter, e_info);
 
 	if (!e_info->error_dev_num)
-- 
2.53.0


