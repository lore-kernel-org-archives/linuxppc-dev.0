Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75646606A32E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 09:49:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJkLL1Xcpz2xMQ;
	Tue, 03 Nov 2026 20:49:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793699354;
	cv=none; b=QhDVx/N1DNcBuD45G0X0r/aEk6DkysP8bBg/mCa3WHenA4vPavlLV7DV8ans3F3FiJvAypFtoo7dwqAWD5k9un4lOOTB2dkebaDIGeJ5CS58iQLn/nMKuvJBxnxF906EKz8+hCZzfuGTDSXBBzEblJ82MQrTQdLbyoxwg3EpNLQKRYcx2FdJ5tqMrAZmApOymqYtV2GGp87RAe5sdnjf/mPmAfV2g//Flh9jJmHWV5VHt+QTglmP8rJ2g0VQLSxGwvg5Jg9Vt85zuskDTLuhUBQ7Z8OlR4VjIe74TtSmMO/8MpkM+WCh6NPZIZvpK+lWGUqm9fJK1aaNswbDJHrY2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793699354; c=relaxed/relaxed;
	bh=/ox8YTThMfnvCpUAm/RezoHGpMO/i532LX4gPnwxXYw=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=YmujyMx5Dx5HtojIsIDWi4gB+MwPEWN24y9z4wSY8CIcru+qWe8In9AMUdXHW4TK5gG1S0d8YIG6KjCg748YeEY1FMHfR9telQEqlLFIt9FTKTe0yso6cftJQOk+fr0tGI02dGEkQ9S+zmsl24+XCsUfFX/eTnFrX8vio1zBLdNlkDzghEiuqfb57381APkkpFeaxv6PWNL/CkZg+evqHR/Faxygy3DpOfvb4r1tKtppRMpb1bc/RjEXze9PKqrjvScRAmwuXEUtyXu8X6Rvzrd2GMIAnrWs/kG2Lge/bbQEA7XDIxdY/mDZDHtejMceqZ2oFLatY0IbiVxkjGTZIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=83.223.78.233; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=83.223.78.233; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJkLK3BDSz2xK7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 20:49:13 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 5380910DC8;
	Tue, 03 Nov 2026 10:49:05 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 4319B600B02F; Tue,  3 Nov 2026 10:49:05 +0100 (CET)
Message-ID: <6de42407246d270c75126baa338761e6f21ab067.1793697480.git.lukas@wunner.de>
In-Reply-To: <cover.1793697480.git.lukas@wunner.de>
References: <cover.1793697480.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 3 Nov 2026 10:45:01 +0100
Subject: [PATCH 1/2] PCI/AER: Avoid NULL pointer deref on search for Error
 Source
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Alex Deucher <alexander.deucher@amd.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Keith Busch <kbusch@kernel.org>, Maciej Grochowski <Maciej.Grochowski@sony.com>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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

A Root Port's subordinate bus may be NULL if the PCI core runs out of bus
numbers on enumeration.  Yet when the AER driver searches for the source
of an Error Message, it dereferences the subordinate pointer without
checking for NULL.  Fix it.

Fixes: 28eb27cf0839 ("PCI AER: support invalid error source IDs")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
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


