Return-Path: <linuxppc-dev+bounces-25186-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13918C55173
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 18:47:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBZn86Lccz2y1F;
	Sat, 01 Aug 2026 04:47:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:37:3000::53df:4ee9:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785523644;
	cv=none; b=i5rj9pGfMVQOxs/wdJNrnwd4P8V1sQyxb/relq84C9w25kUWyna0tWUSocri/pAeJeZ88VcwoblQJSXGJDgh5NMX5vQqqzI0uqrJOaURpQXL3Vbz3WTeU/JkuEcUamC5n+//Bu0xYo0cjz2tzp1v/X6m2MPqGpG8ZW9gBHZjYEQZXG3x0Oz5xVT7M7jRmG/v7tjhqH1beuV8a1k87aU5zlVPRHndop+fujprpoJNo9n+oCWZDcTaIbLEpKoKWSF1PBpU/lSrcW/IZuVJVBlLWD5rPwNfcIeA60QU7Y1bV5paCzf/rxUwscZdO/cQbtliudzGQ8dllOtP5MWnWbDxoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785523644; c=relaxed/relaxed;
	bh=bIhX8t3QSjKgq2IQyEy8mzDVEpJ6eSsTOAxhl2xUW6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8IRQuQem6sAmsWWl0Lz8IuUrOhTQ+00gc2I34WWHC6aOFuY1K4ZNBYCibZ186FGOoamGonMjXQhR9wmW56/K1H7IGg2QtMs6DaTxKXOi+R2csikXfj9GLgsYPfTIt8xz7rnFb5auvl0+6PZjYH4VIENXEi0XwxfVxl5mBhXtIFEKvjI0n/O7MBybBQD3IVlQ0J972diAKWtHbI11HOkePkDsHhj/GzbfhTDbqnQM9Jwz4ilTs1+bnQZf1vWq0Y4T2xTj2xUsmMagZjYz5T4swcxUU+jAbkSineiChT17OvWSEJ1fJRgsXY7JUqXpxDWHJDyjdZzUH7moa1n9kdNqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=2a01:37:3000::53df:4ee9:0; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org) smtp.mailfrom=wunner.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wunner.de (client-ip=2a01:37:3000::53df:4ee9:0; helo=mailout2.hostsharing.net; envelope-from=lukas@wunner.de; receiver=lists.ozlabs.org)
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ee9:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBZn70VgGz2xwH
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Aug 2026 04:47:19 +1000 (AEST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id C8CE710616;
	Fri, 31 Jul 2026 20:47:10 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id AF50E60DFEAB; Fri, 31 Jul 2026 20:47:10 +0200 (CEST)
Date: Fri, 31 Jul 2026 20:47:10 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Yury Murashka <yurypm@arista.com>,
	Matthew W Carlis <mattc@purestorage.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>,
	Qingshun Wang <qingshun.wang@linux.intel.com>,
	Yicong Yang <yang.yicong@picoheart.com>, dio.sun@enflame-tech.com,
	linux-pci@vger.kernel.org,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	Terry Bowman <terry.bowman@amd.com>,
	". Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Arjun Govindjee <agovindjee@purestorage.com>,
	Ashish Karkare <ashishk@purestorage.com>,
	Jasjeet Rangi <jrangi@purestorage.com>,
	Meeta Saggi <msaggi@purestorage.com>, rhan@purestorage.com,
	sconnor@purestorage.com, an.luo@enflame-tech.com,
	fernando.hu@enflame-tech.com, bill.wu@enflame-tech.com,
	xin.wang@enflame-tech.com
Subject: Re: [PATCH 0/6] PCI/AER: Support Advisory Non-Fatal Errors
Message-ID: <amztrrIGvz8gPxQb@wunner.de>
References: <cover.1784905909.git.lukas@wunner.de>
 <20260724223903.GA1073029@bhelgaas>
 <amdnMg_J6T3Sys45@wunner.de>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amdnMg_J6T3Sys45@wunner.de>

On Mon, Jul 27, 2026 at 04:12:02PM +0200, Lukas Wunner wrote:
> There is one other sashiko finding I need to address:
> 
> It complained that in the native case, Advisory Non-Fatal Errors are
> reported with the same loglevel and ratelimiting as the accompanying
> Correctable Error.  But that's intentional.  However in the Firmware
> First case, I got that wrong in that the loglevel and ratelimiting of
> non-Advisory Non-Fatal Errors is used.  I'll come back with another
> fixup for that!

Below please find a fixup for this finding of sashiko.  With that,
I believe I have addressed all sashiko findings which are not
pre-existing issues.

This fixup is intended to be folded into the top-most commit
on pci/aer.  If you prefer a proper, separate patch to apply
on top of the branch, please let me know.  Same if you find
anything objectionable in this fixup.

Thanks!

-- >8 --

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 2a380bb9bfcb..dd2aa5dd4dda 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1028,13 +1028,15 @@ int cper_severity_to_aer(int cper_severity)
 EXPORT_SYMBOL_GPL(cper_severity_to_aer);
 #endif
 
-void pci_print_aer(struct pci_dev *dev, int aer_severity,
-		   struct aer_capability_regs *aer)
+static void __pci_print_aer(struct pci_dev *dev, int aer_severity,
+			    struct aer_capability_regs *aer,
+			    bool ratelimit_print, const char* level)
 {
 	const char *bus_type, *sev;
 	int tlp_header_valid = 0;
 	u32 status, mask;
 	struct aer_err_info info = {
+		.level = level,
 		.severity = aer_severity,
 		.first_error = PCI_ERR_CAP_FEP(aer->cap_control),
 	};
@@ -1043,12 +1045,10 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		status = aer->cor_status;
 		mask = aer->cor_mask;
 		sev = "cor";
-		info.level = KERN_WARNING;
 	} else {
 		status = aer->uncor_status;
 		mask = aer->uncor_mask;
 		sev = "uncor";
-		info.level = KERN_ERR;
 		tlp_header_valid = tlp_header_logged(status & ~mask,
 						     aer->cap_control);
 	}
@@ -1067,7 +1067,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 	 * For Advisory Non-Fatal Errors, record statistics and tracing
 	 * even if ratelimited
 	 */
-	if (!aer_ratelimit(dev, info.severity))
+	if (!ratelimit_print)
 		goto anfe;
 
 	aer_printk(info.level, dev,
@@ -1094,10 +1094,25 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
 		if (anfe_status) {
 			aer->uncor_status = anfe_status;
 			aer->uncor_mask = 0;
-			pci_print_aer(dev, AER_NONFATAL, aer);
+			__pci_print_aer(dev, AER_NONFATAL, aer,
+					ratelimit_print, level);
 		}
 	}
 }
+
+void pci_print_aer(struct pci_dev *dev, int aer_severity,
+		   struct aer_capability_regs *aer)
+{
+	/*
+	 * Precalculate ratelimit counter and log level so that Advisory
+	 * Non-Fatal Errors are treated like the accompanying Correctable Error
+	 */
+	bool ratelimit_print = aer_ratelimit(dev, aer_severity);
+	const char *level = aer_severity == AER_CORRECTABLE ? KERN_WARNING
+							    : KERN_ERR;
+
+	__pci_print_aer(dev, aer_severity, aer, ratelimit_print, level);
+}
 EXPORT_SYMBOL_GPL(pci_print_aer);
 
 /**


