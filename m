Return-Path: <SRS0=3W5+=FD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F49C64E7D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Nov 2020 23:16:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0261220727
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Nov 2020 23:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0261220727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ckkkw6Z8TzDqyx
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Nov 2020 10:16:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.221.67; helo=mail-wr1-f67.google.com;
 envelope-from=kswilczynski@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.com
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CkkY71W2YzDrCX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2020 10:07:55 +1100 (AEDT)
Received: by mail-wr1-f67.google.com with SMTP id m6so13058130wrg.7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Nov 2020 15:07:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ff6pKCmLg5oT72OgCOHiIPYU12IbKoKvOXqEEVgg4cU=;
 b=j5UBR3WaswxgSYSdMClOPZ75eLQZ1xjMPzMq2ZdwJaStD7PBLHXqJoZEnBqsE2F3Yi
 7FR5ISEWaAtf7bHTJji+WCBUuCwold2/FrzSqVBwykV2EtB77Tj+QuILvYzBTPmaweV3
 8p1pJg8f5jb2pbMmI2mlv4FDnPp2VF8WEWWX5k7BlxE8F51sPYOthacOeN7f62U8wzZ2
 2zKN19r6lolN/h/rZVPJHHkvsF2Ee2hYN3yz/jFhInDUkZZj/7oxfhZb3pKC8PPDr8it
 L0ijfDG/+fiPGIBgqmEoaYEYcQgaGCbODw69BC6Fv76srMZjqjkAtCUd3aa2WDq8OBft
 wZbg==
X-Gm-Message-State: AOAM530lxeCi1BaXT67MnfBhwxU43WcGdk9MT9ZRNk2Nc6E/CwYb7+3H
 ZoijTfSGnPaUlRIv6vg71L4=
X-Google-Smtp-Source: ABdhPJzHI72BcK2gh0kFjWjYjgwPhW5lYayUpFmk6eoZtDqknP6gOkv3hmwsP0YHAvHXiiV7ZOzodw==
X-Received: by 2002:adf:f9c5:: with SMTP id w5mr24603230wrr.69.1606691272550; 
 Sun, 29 Nov 2020 15:07:52 -0800 (PST)
Received: from workstation.lan ([95.155.85.46])
 by smtp.gmail.com with ESMTPSA id d2sm24831005wrn.43.2020.11.29.15.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Nov 2020 15:07:52 -0800 (PST)
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v6 4/5] PCI: vmd: Update type of the __iomem pointers
Date: Sun, 29 Nov 2020 23:07:42 +0000
Message-Id: <20201129230743.3006978-5-kw@linux.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129230743.3006978-1-kw@linux.com>
References: <20201129230743.3006978-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: Heiko Stuebner <heiko@sntech.de>, Shawn Lin <shawn.lin@rock-chips.com>,
 Paul Mackerras <paulus@samba.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Jonathan Chocron <jonnyc@amazon.com>, Toan Le <toan@os.amperecomputing.com>,
 Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Michal Simek <michal.simek@xilinx.com>, linux-rockchip@lists.infradead.org,
 bcm-kernel-feedback-list@broadcom.com,
 Jonathan Derrick <jonathan.derrick@intel.com>, linux-pci@vger.kernel.org,
 Ray Jui <rjui@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>,
 linux-rpi-kernel@lists.infradead.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-arm-kernel@lists.infradead.org, Scott Branden <sbranden@broadcom.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Robert Richter <rrichter@marvell.com>,
 linuxppc-dev@lists.ozlabs.org, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Use "void __iomem" instead "char __iomem" pointer type when working with
the accessor functions (with names like readb() or writel(), etc.) to
better match a given accessor function signature where commonly the
address pointing to an I/O memory region would be a "void __iomem"
pointer.

Related:
  https://lwn.net/Articles/102232/

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/controller/vmd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 1361a79bd1e7..59fa9a94860f 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -95,7 +95,7 @@ struct vmd_dev {
 	struct pci_dev		*dev;
 
 	spinlock_t		cfg_lock;
-	char __iomem		*cfgbar;
+	void __iomem		*cfgbar;
 
 	int msix_count;
 	struct vmd_irq_list	*irqs;
@@ -326,7 +326,7 @@ static void vmd_remove_irq_domain(struct vmd_dev *vmd)
 	}
 }
 
-static char __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
+static void __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
 				  unsigned int devfn, int reg, int len)
 {
 	unsigned int busnr_ecam = bus->number - vmd->busn_start;
@@ -346,7 +346,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
 			int len, u32 *value)
 {
 	struct vmd_dev *vmd = vmd_from_bus(bus);
-	char __iomem *addr = vmd_cfg_addr(vmd, bus, devfn, reg, len);
+	void __iomem *addr = vmd_cfg_addr(vmd, bus, devfn, reg, len);
 	unsigned long flags;
 	int ret = 0;
 
@@ -381,7 +381,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 			 int len, u32 value)
 {
 	struct vmd_dev *vmd = vmd_from_bus(bus);
-	char __iomem *addr = vmd_cfg_addr(vmd, bus, devfn, reg, len);
+	void __iomem *addr = vmd_cfg_addr(vmd, bus, devfn, reg, len);
 	unsigned long flags;
 	int ret = 0;
 
-- 
2.29.2

