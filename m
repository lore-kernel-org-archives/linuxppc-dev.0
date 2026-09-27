Return-Path: <linuxppc-dev+bounces-28338-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FCCC9832F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 18:14:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htCJf6NGKz2yfS;
	Mon, 28 Sep 2026 04:14:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=83.223.78.233
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790532882;
	cv=none; b=Hmf2PLHjGRh95OZ7FtLvsvSqQnuVTRBljc1hqZ7rwx6KAXWejom3vwZTG1U5xfmn1rVTYGT4fcdkS8QPVNHzWhgMa420FvwJHa80AprTZuBhbBTfDKuToKyvZ6JZT/f9nmsAm/Zr91l2yaiHUUBYSGG308FX7xxR95uHgNkJOhD/vN3M+9hL71XX1SXceRoDNXU/BRZo6WWwGcZEy4Kn+mq1mKXzNKIlt+P/AO9TtNuZKpXbZJ2If5TOdsJWp9Ca9nARey1GJ35EV4SC5RSysFyxJpoPvjvbxbPhR6K1HI4aUD/Wt6XvLfegoz7xVba1xHZ2tuNmYxwY40+PsTlUbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790532882; c=relaxed/relaxed;
	bh=/bIZQQ7WX4tvbx85D3UMX23fUDfWIpn5CkvO1rCTKYA=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=dV7LMI1WN2STgSeIBVsUTwjy2eQe5lzMMnV5MWMSqq6NF2U6Hzcc2M39C2Nnf0WGn2/7vO+y8wXNulFPU9DrhgIT48/SEYS8hE43nCSb9/oG7m5Bd83psZtcPSjREyphK/KmO4GSJ1/adO0cOnyXt7sHaygHfm2OOuM66qIYeoowEUvqcrLdnLLzdF8koIthyphky5WMLflRuWrnCAAqg1gGhKCjV/zc2V9SWKns9fH+Krgrr3NTntqGzKb9lwnobZdwhVsS/UXjNlWmQKgIH7IkhoqkDCM5jF6C61R62Xe56ilELPnsx+lNhjst/VuaSYHNxBiZyv5D1789p+HdeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=83.223.78.233; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=83.223.78.233; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 171 seconds by postgrey-1.37 at boromir; Mon, 28 Sep 2026 04:14:42 AEST
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htCJf11jRz2ydN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 04:14:42 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id BABB910DE0;
	Sun, 27 Sep 2026 20:14:38 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A6D43625294D; Sun, 27 Sep 2026 20:14:38 +0200 (CEST)
Message-ID: <1a00e832eab9539f7328f5d547f11b67e17bd0da.1790531238.git.lukas@wunner.de>
In-Reply-To: <cover.1790531238.git.lukas@wunner.de>
References: <cover.1790531238.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 27 Sep 2026 20:02:04 +0200
Subject: [PATCH 4/7] PCI/AER: Drop AER native check from handles_cxl_errors()
To: Bjorn Helgaas <helgaas@kernel.org>, Raag Jadav <raag.jadav@intel.com>, Riana Tauro <riana.tauro@intel.com>, Yury Murashka <yurypm@arista.com>, "Matthew W Carlis" <mattc@purestorage.com>, linux-pci@vger.kernel.org
Cc: "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, Aravind Iddamsetty <aravind.iddamsetty@intel.com>, Srinivasa Adatrao <srinivasa.adatrao@intel.com>, Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>, Keith Busch <kbusch@kernel.org>
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

Drop a superfluous call to pcie_aer_is_native() from handles_cxl_errors().

The call is superfluous because the function is only called from:

  aer_probe()
    cxl_rch_enable_rcec()
      handles_cxl_errors()

...and aer_probe() is only invoked if an AER port service was instantiated
in get_port_device_capability(), which is conditional on:

  (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
   pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
  pci_aer_available() &&
  dev->aer_cap && (pcie_ports_native || host->native_aer))

...and the last line of those conditions is equivalent to
pcie_aer_is_native().

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/pcie/aer_cxl_rch.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
index e471eefec9c4..9cc2d5749b9d 100644
--- a/drivers/pci/pcie/aer_cxl_rch.c
+++ b/drivers/pci/pcie/aer_cxl_rch.c
@@ -87,8 +87,7 @@ static bool handles_cxl_errors(struct pci_dev *rcec)
 {
 	bool handles_cxl = false;
 
-	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
-	    pcie_aer_is_native(rcec))
+	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC)
 		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
 
 	return handles_cxl;
-- 
2.53.0


