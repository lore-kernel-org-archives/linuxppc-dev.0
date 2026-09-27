Return-Path: <linuxppc-dev+bounces-28327-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86169C98338
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 17:52:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htBpj1HV4z30WX;
	Mon, 28 Sep 2026 03:52:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790528133;
	cv=none; b=E/JQKRSF0C1KrLOkfdz43c2agMl5AbCik5jvzfBZ1rQ6pmPG5DMhEfnztm3bUTdI8idfLLBpFIBeTROKUGA2ihcKdXJ8bRlvMmdp50vereJH02j2xbcJGeoMx1Les9DMs9cZStxh2sYi0MnboLiAXcxuWw6lup1zZ9zw8q1MwR9PRFw78byI+nr/lkENgBNW/3ZqBfQSo+ZiYeJXDH3wm/TyvASfZs2v3pWkbn23W33toTefcoCggnMcWX5+5APu6xAk9ide3SvEagYj5g+7QbqmiIP7klPb2x5tOCW7GGfz/S88Muk37zI3/Ffh5Q+UV815yVuRPwocVLYCZKp2SA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790528133; c=relaxed/relaxed;
	bh=9XImCPy7QHPoN4quLQ1lus3OWNtmBZ9BuTXdaG3JBgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mfXpHVVylJ47cZUn6MaQT8GPLlPc6w1foGKeprs13TcuvYkPN8fDgnmYZhC7cf1x4m/y0kSHkYhrCwmxrKNigRqg+hDsl/kNaJzyRC8wWVcYmdqe/ZFK5qZTC+Kon06DD4v+jzpOfKoC5q+hJRJEuaIY0XZZ6s7bM/V6umn2zlG97D98+HyF5GOoaAqrB+CZ0ckx0mWgrEF1EJYO1xPYyQ1lDN3DeqU2fU/tJUkk+fKhUIsUw0MABHnaBoPeKWq/EeOaAiLp3iQSbeldP1M7LcwPfuutFBhroog6zCwAgL69BfC+AIpfnuNaKbMJr8wpwY31pk4YLHQ9JosupykbyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k59rZOWw; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k59rZOWw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=abhinjoses@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com [IPv6:2a00:1450:4864:31::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ht9YJ0z5Tz2yDD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 02:55:32 +1000 (AEST)
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49cd4ba9f68so26816605e9.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 09:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790528129; x=1791132929; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9XImCPy7QHPoN4quLQ1lus3OWNtmBZ9BuTXdaG3JBgc=;
        b=k59rZOWwy1zmpD28f/9K2GeAG2G2I7LVLMUj77GDbNDEX2U62SoDU+vKGzOl3I4Csb
         xD3ouaKzW6SarZ0dsgP/0h+so6h+y4UNsZhST+b7RE/o2AF5qBL9NvL10AmgibQPjrGM
         7PiaE0m2gdtOOOOreQCG5QAvPXcyCDsZ3pjeEJsbfbSZ9XwLHxlWlKfyHBCvbXQ/979X
         LI/UouHD+VQIs6Qa1hyZDbpFpcHepHJTLa4ow4uKUvdHa5WuiZRz19O3Lqr8RAHPvGQ2
         5ehWk38LHIvo4L9+d9rXDRC0dy6Hp7KWGp0gMbg328jb74c3eoePCbIbi+xSzuLIgysO
         NVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790528129; x=1791132929;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9XImCPy7QHPoN4quLQ1lus3OWNtmBZ9BuTXdaG3JBgc=;
        b=sWqkFOXeex7AWt4h7nop2TVsnJ1FNfumqbofyiqu4cKgURHRlfeLeufgyh8EYXl8GQ
         pFOFtDbBTRt+62fA9PBJ6J0f31naxvIYmi9gOgw+6uewCWqiYCXvYbUXqeJqAZ0jxOoS
         msBVGWL7DxC1TwHwFCC160nFT2IVOMOuiebT39M+To1VAULH9MLzHvWG3LPChX1ox7zy
         NE++zqTA3jiuQOSUDdOK0vij6X4HR4n7ythacGSQocsb3KIZfp44hHOXRL2uXRzFSRwn
         CX7lis308JSc7DOJXB5WS8V/QFgjmz51wguEl3Iu/r4PS+tFwxhq4iA/kM4jnydDbzPL
         nLvg==
X-Forwarded-Encrypted: i=1; AKwUvBwaAfpxK6tqL3wACqMuQwGC0K8s+M3bEWb3T63xilokrlXruz4SDr2J64Tu6LN5oKivsMIYB5VqP/fLV6Y=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nJXQ3/hh+QBdVQY884PPAvvewazyNniUz5j3/aFKgZlNn50OGO
	z0yFu7mwulBUtdTBXWmVRry8krePA3n9jwtNL3ObnRx7J92AJRt2oB7V
X-Gm-Gg: AYBFou1sUE2NDztlVDQoYGqqog296GN0ybOelHTAUfAMwWdMg9iYMClIMjr6IbtT6po
	vHZkMghu02Lcrtq3DOgmUcRhQC4D8d1psaWF7wUhcA/5BNLV+oMwnYavy25996d7AlJBOFTKwAa
	H7XlxjytF9m2wISl6msNy7Zx255AlVih491B+/ERaO1nQ1Npd6JU981t2mbiED9hkbyG1MBlhx7
	2bkL9D0Ol8TiuokGxSFIJmWN47GC+s0ODDlynB/bZ4ib/Os72PkB8CO+iGu3WVEVoGdMhFE4Tsk
	nj43wp96DjclDvv6LKhFkClyZPDUielx062TraJKzeRCbTSQDpzt+wQf0ykeO6f30YyCeiXUSS/
	xx5mxvWk7lx28cOv06QDAgy03myyGtzs2Gc4xhftpwVWZea12gvavvvsOy/0j78fT/I2rxodHyI
	zXUgNd2PAIsXuJO7k9u+8t6M67oqpG8uNXJ/ADK5eRWXBtav8eF6YYYSenJNed78V5vvEvfv/wV
	Kyfu9KMG+IT7Mq7m19at5kQCQUTZD3IBcM4NXjxAP06ZspyE3b81dF2P0e67MfZ0Ms=
X-Received: by 2002:a05:600c:4745:b0:49d:10d6:fd55 with SMTP id 5b1f17b1804b1-49fe66abd7fmr201177145e9.1.1790528129026;
        Sun, 27 Sep 2026 09:55:29 -0700 (PDT)
Received: from f3a6eae2255e.fritz.box (dynamic-002-214-014-217.2.214.pool.telefonica.de. [2.214.14.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00178bebasm76167695e9.11.2026.09.27.09.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 09:55:28 -0700 (PDT)
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
Subject: [PATCH RFC v2 5/5] misc: Add edu_srpoc surprise removal POC driver
Date: Sun, 27 Sep 2026 16:54:58 +0000
Message-ID: <20260927165459.829900-6-abhinjoses@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A test driver for the QEMU edu device that reproduces the surprise
removal hang described in MST's RFC v5 thread.

- hacked in a reg to the edu device on qemu to raise a delayed irq
- This driver writes to that reg in remove and waits for the irq to be
  handled. This simulates del_gendisk() blocked in
  blk_mq_freeze_queue_wait()

remove() blocks until the delayed interrupt arrives, 600 seconds after
it is requested, or until the device is surprise removed and its
disconnect work runs.  That is the purpose of the driver, so a normal
unbind takes 600 seconds, and on a QEMU without the delayed interrupt
register it never returns.  It is only built with CONFIG_EDU_SRPOC.

Assisted-by: LLM
Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>

---
Changes since RFC v1:
- Build only with CONFIG_EDU_SRPOC, which depends on PCI, instead of
  unconditionally. (Sashiko)
- Don't claim the interrupt if the status register reads all ones,
  i.e. the device is gone. (Sashiko)
- Clear bus mastering in the probe error path and in remove(). (Sashiko)
- Document that remove() blocks by design. (Sashiko)
- Fixed a checkpatch warning about braced if() blocks.

RFC v1: https://lore.kernel.org/all/20260905183905.997833-4-abhinjoses@gmail.com/
Sashiko review: https://lore.kernel.org/all/20260905185027.291191F00A3A@smtp.kernel.org/
---
 drivers/misc/Kconfig     |  11 +++
 drivers/misc/Makefile    |   1 +
 drivers/misc/edu_srpoc.c | 171 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 183 insertions(+)
 create mode 100644 drivers/misc/edu_srpoc.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 7364931dad3a1..99457e53d21cf 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -57,6 +57,17 @@ config DUMMY_IRQ
 	  The sole purpose of this module is to help with debugging of systems on
 	  which spurious IRQs would happen on disabled IRQ vector.
 
+config EDU_SRPOC
+	tristate "QEMU edu surprise removal POC driver"
+	depends on PCI
+	help
+	  Test driver for the QEMU edu device.  Its remove() callback blocks
+	  until the device raises a delayed interrupt or is surprise removed,
+	  to reproduce a hang in remove() during surprise removal.  Needs an
+	  edu device with the delayed interrupt register at BAR0 0x30.
+
+	  If unsure, say N.
+
 config IBMVMC
 	tristate "IBM Virtual Management Channel support"
 	depends on PPC_PSERIES
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e8d8d5d88c0df..9ebcc6ce60f34 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_AD525X_DPOT_I2C)	+= ad525x_dpot-i2c.o
 obj-$(CONFIG_AD525X_DPOT_SPI)	+= ad525x_dpot-spi.o
 obj-$(CONFIG_ATMEL_SSC)		+= atmel-ssc.o
 obj-$(CONFIG_DUMMY_IRQ)		+= dummy-irq.o
+obj-$(CONFIG_EDU_SRPOC)		+= edu_srpoc.o
 obj-$(CONFIG_ICS932S401)	+= ics932s401.o
 obj-$(CONFIG_LKDTM)		+= lkdtm/
 obj-$(CONFIG_TI_FPC202)		+= ti_fpc202.o
diff --git a/drivers/misc/edu_srpoc.c b/drivers/misc/edu_srpoc.c
new file mode 100644
index 0000000000000..b74a95109dba9
--- /dev/null
+++ b/drivers/misc/edu_srpoc.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * edu_srpoc.c Surprise Removal POC driver for the QEMU edu device
+ *
+ * In remove(), schedules a delayed interrupt on the edu device and
+ * blocks waiting for it to complete. This simulates del_gendisk()
+ * blocked in blk_mq_freeze_queue_wait() on slow in-flight I/O.
+ *
+ * Surprise-remove the device during this window to reproduce the hang.
+ *
+ * edu BAR 0 registers used:
+ *   0x08  Factorial: write N to compute N! asynchronously
+ *   0x20  Status: write EDU_STATUS_IRQFACT to enable IRQ on completion
+ *   0x24  IRQ status: bit 0 = FACT_IRQ, bit 9 = DELAY_IRQ
+ *   0x30  Delayed IRQ: write N (ms). Hacked in this functionality(not upstream).
+ *   0x64  IRQ lower: write bitmask to ack
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+
+#define PCI_VENDOR_ID_EDU	0x1234
+#define PCI_DEVICE_ID_EDU	0x11e8
+
+#define EDU_REG_FACT		0x08
+#define EDU_REG_STATUS		0x20
+#define EDU_REG_DELAYED_IRQ	0x30
+#define EDU_REG_IRQ_STATUS	0x24
+#define EDU_REG_IRQ_LOWER	0x64
+
+#define EDU_STATUS_IRQFACT	0x80
+#define EDU_FACT_IRQ		BIT(0)
+#define EDU_DELAY_IRQ		BIT(9)
+
+struct edu_dev {
+	struct pci_dev		*pdev;
+	void __iomem		*regs;
+	struct completion	irq_done;
+};
+
+static irqreturn_t edu_irq_handler(int irq, void *data)
+{
+	struct edu_dev *edu = data;
+	u32 status;
+
+	status = ioread32(edu->regs + EDU_REG_IRQ_STATUS);
+	/* All ones means the device is gone; the interrupt is not ours */
+	if (!status || PCI_POSSIBLE_ERROR(status))
+		return IRQ_NONE;
+
+	iowrite32(status, edu->regs + EDU_REG_IRQ_LOWER);
+
+	if (status & (EDU_FACT_IRQ | EDU_DELAY_IRQ))
+		complete(&edu->irq_done);
+
+	return IRQ_HANDLED;
+}
+
+static void edu_disconnect(struct work_struct *work)
+{
+	struct pci_dev *pdev = container_of(work, struct pci_dev,
+					    disconnect_work);
+	struct edu_dev *edu = pci_get_drvdata(pdev);
+
+	if (!pci_test_and_clear_disconnect_enable(pdev))
+		return;
+
+	if (!edu)
+		return;
+
+	dev_info(&pdev->dev, "disconnect_work fired — unblocking remove()\n");
+	complete(&edu->irq_done);
+}
+
+static int edu_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct edu_dev *edu;
+	int err;
+
+	edu = devm_kzalloc(&pdev->dev, sizeof(*edu), GFP_KERNEL);
+	if (!edu)
+		return -ENOMEM;
+
+	edu->pdev = pdev;
+	init_completion(&edu->irq_done);
+
+	err = pci_enable_device(pdev);
+	if (err)
+		return err;
+
+	err = pci_request_regions(pdev, "edu_srpoc");
+	if (err)
+		goto err_disable;
+
+	edu->regs = pci_iomap(pdev, 0, 0);
+	if (!edu->regs) {
+		err = -ENOMEM;
+		goto err_release;
+	}
+
+	pci_set_master(pdev);
+
+	err = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI | PCI_IRQ_INTX);
+	if (err < 0)
+		goto err_iounmap;
+
+	err = request_irq(pci_irq_vector(pdev, 0), edu_irq_handler,
+			  IRQF_SHARED, "edu_srpoc", edu);
+	if (err)
+		goto err_free_vectors;
+
+	pci_set_drvdata(pdev, edu);
+
+	INIT_WORK(&pdev->disconnect_work, edu_disconnect);
+	pci_set_disconnect_work(pdev);
+
+	dev_info(&pdev->dev, "edu_srpoc probed\n");
+	return 0;
+
+err_free_vectors:
+	pci_free_irq_vectors(pdev);
+err_iounmap:
+	pci_clear_master(pdev);
+	pci_iounmap(pdev, edu->regs);
+err_release:
+	pci_release_regions(pdev);
+err_disable:
+	pci_disable_device(pdev);
+	return err;
+}
+
+static void edu_remove(struct pci_dev *pdev)
+{
+	struct edu_dev *edu = pci_get_drvdata(pdev);
+
+	iowrite32(EDU_STATUS_IRQFACT, edu->regs + EDU_REG_STATUS);
+	iowrite32(600000, edu->regs + EDU_REG_DELAYED_IRQ);
+
+	dev_info(&pdev->dev, "Waiting for IRQ in remove()\n");
+	wait_for_completion(&edu->irq_done);
+	dev_info(&pdev->dev, "Unblocked, cleaning up\n");
+
+	pci_clear_disconnect_work(pdev);
+	free_irq(pci_irq_vector(pdev, 0), edu);
+	pci_free_irq_vectors(pdev);
+	pci_clear_master(pdev);
+	pci_iounmap(pdev, edu->regs);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+}
+
+static const struct pci_device_id edu_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_EDU, PCI_DEVICE_ID_EDU) },
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(pci, edu_ids);
+
+static struct pci_driver edu_driver = {
+	.name		= "edu_srpoc",
+	.id_table	= edu_ids,
+	.probe		= edu_probe,
+	.remove		= edu_remove,
+};
+
+module_pci_driver(edu_driver);
+MODULE_AUTHOR("Abhin Parekadan Jose");
+MODULE_DESCRIPTION("edu surprise removal POC driver");
+MODULE_LICENSE("GPL");
-- 
2.51.1


