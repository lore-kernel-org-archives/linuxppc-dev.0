Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B67C54EBD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Jan 2023 22:13:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Npczj5wZTz3cPl
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Jan 2023 09:13:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KlBD2/hS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=134.134.136.100; helo=mga07.intel.com; envelope-from=anirudh.venkataramanan@intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KlBD2/hS;
	dkim-atps=neutral
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Npcgl0d8Lz30RJ
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jan 2023 08:59:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673042371; x=1704578371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TG7M7IO4ZvGwossk/dYz2Y4AzoE+L3tw+oWib10OPcY=;
  b=KlBD2/hSYoMopGxLyIM0DHb3eDecRn4agl73nCpPjKVuC92MKCFXM9NP
   ttgphf9NwHnchFD/yNaIpTxgXfv9QCOmCaP1FphJsDYHEigDVg7msH1kA
   F+yiDLp9fAxQhpK9ITsi1on31qGXJ3fwkqxJuAasQX5vGlLpB93Y1FFzh
   nuqv5rJ7YGqtJGxe/r1+bEg4KjpTuD3l03SybUZ9IteeKrGAxkRj3Vx1O
   Gj8BRyjz1jZywne4TNrqruOZmtL9htcMYxm0EAq5UqaeqiLcaVouIUbqQ
   aqkCFBUJRGvrEWTuq+clJcT+01QWsvHr30cE+/juOHJ0jfhWnzsT5YDUx
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="387030702"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="387030702"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2023 13:59:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10582"; a="763652881"
X-IronPort-AV: E=Sophos;i="5.96,306,1665471600"; 
   d="scan'208";a="763652881"
Received: from avenkata-desk0.sc.intel.com ([172.25.112.60])
  by fmsmga002.fm.intel.com with ESMTP; 06 Jan 2023 13:59:16 -0800
From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next 2/7] PCI: Remove PCI IDs used by the Sun Cassini driver
Date: Fri,  6 Jan 2023 14:00:15 -0800
Message-Id: <20230106220020.1820147-3-anirudh.venkataramanan@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230106220020.1820147-1-anirudh.venkataramanan@intel.com>
References: <20230106220020.1820147-1-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 07 Jan 2023 09:09:38 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Leon Romanovsky <leon@kernel.org>, linux-pci@vger.kernel.org, linux-mips@vger.kernel.org, Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-trace-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The previous patch removed the Cassini driver (drivers/net/ethernet/sun).
With this, PCI_DEVICE_ID_NS_SATURN and PCI_DEVICE_ID_SUN_CASSINI are
unused. Remove them.

Cc: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 include/linux/pci_ids.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index b362d90..eca2340 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -433,7 +433,6 @@
 #define PCI_DEVICE_ID_NS_CS5535_AUDIO	0x002e
 #define PCI_DEVICE_ID_NS_CS5535_USB	0x002f
 #define PCI_DEVICE_ID_NS_GX_VIDEO	0x0030
-#define PCI_DEVICE_ID_NS_SATURN		0x0035
 #define PCI_DEVICE_ID_NS_SCx200_BRIDGE	0x0500
 #define PCI_DEVICE_ID_NS_SCx200_SMI	0x0501
 #define PCI_DEVICE_ID_NS_SCx200_IDE	0x0502
@@ -1047,7 +1046,6 @@
 #define PCI_DEVICE_ID_SUN_SABRE		0xa000
 #define PCI_DEVICE_ID_SUN_HUMMINGBIRD	0xa001
 #define PCI_DEVICE_ID_SUN_TOMATILLO	0xa801
-#define PCI_DEVICE_ID_SUN_CASSINI	0xabba
 
 #define PCI_VENDOR_ID_NI		0x1093
 #define PCI_DEVICE_ID_NI_PCI2322	0xd130
-- 
2.37.2

