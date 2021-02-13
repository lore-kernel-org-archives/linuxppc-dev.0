Return-Path: <SRS0=q7yE=HP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB74BC433E0
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Feb 2021 16:27:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFA6F64E26
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Feb 2021 16:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA6F64E26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DdG4C2BLCzDyvs
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Feb 2021 03:27:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.microsoft.com (client-ip=13.77.154.182;
 helo=linux.microsoft.com; envelope-from=nramas@linux.microsoft.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com
 header.a=rsa-sha256 header.s=default header.b=TYk3+BGa; 
 dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DdFj157BCzDqJ2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Feb 2021 03:11:01 +1100 (AEDT)
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net
 [73.42.176.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id ADC6D209B8B1;
 Sat, 13 Feb 2021 08:11:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ADC6D209B8B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1613232661;
 bh=3ZkSY16/A6jEMMDvYg81oT12Nx3LNN+s2BXcdoqegDg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TYk3+BGaC4CRawy3oTgbn6xBsXpaz0VjdKrdodCZBKhWfIWC49sAF9EQnpX91j8BW
 l3XlLCW1a/G2amb2eDnWUYVXgfzWuUSVwIxUwlb3stEUVgoviAZbUI2sfAplqkHFak
 waJ01XblV00eprkoC27XKsDUdsPzdPJpKga3nk6k=
From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
 takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, will@kernel.org,
 joe@perches.com, catalin.marinas@arm.com, mpe@ellerman.id.au
Subject: [PATCH v18 09/11] kexec: Use fdt_appendprop_addrrange() to add ima
 buffer to FDT
Date: Sat, 13 Feb 2021 08:10:47 -0800
Message-Id: <20210213161049.6190-10-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210213161049.6190-1-nramas@linux.microsoft.com>
References: <20210213161049.6190-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
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
Cc: mark.rutland@arm.com, tao.li@vivo.com, paulus@samba.org,
 vincenzo.frascino@arm.com, frowand.list@gmail.com, sashal@kernel.org,
 masahiroy@kernel.org, jmorris@namei.org, allison@lohutok.net, serge@hallyn.com,
 devicetree@vger.kernel.org, pasha.tatashin@soleen.com,
 prsriva@linux.microsoft.com, hsinyi@chromium.org,
 linux-arm-kernel@lists.infradead.org, christophe.leroy@c-s.fr,
 mbrugger@suse.com, balajib@linux.microsoft.com, dmitry.kasatkin@gmail.com,
 linux-kernel@vger.kernel.org, james.morse@arm.com,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

fdt_appendprop_addrrange() function adds a property, with the given name,
to the device tree at the given node offset, and also sets the address
and size of the property.  This function should be used to add
"linux,ima-kexec-buffer" property to the device tree and set the address
and size of the IMA measurement buffer, instead of using custom function.

Use fdt_appendprop_addrrange() to add  "linux,ima-kexec-buffer" property
to the device tree.  This property holds the address and size of
the IMA measurement buffer that needs to be passed from the current
kernel to the next kernel across kexec system call.

Remove custom code that is used in setup_ima_buffer() to add
"linux,ima-kexec-buffer" property to the device tree.

Co-developed-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Prakhar Srivastava <prsriva@linux.microsoft.com>
Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 drivers/of/kexec.c | 57 ++++------------------------------------------
 1 file changed, 5 insertions(+), 52 deletions(-)

diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
index 8f9ce5c7f47b..5f7fc626f47f 100644
--- a/drivers/of/kexec.c
+++ b/drivers/of/kexec.c
@@ -216,36 +216,6 @@ static void remove_ima_buffer(void *fdt, int chosen_node)
 }
 
 #ifdef CONFIG_IMA_KEXEC
-/**
- * write_number - Convert number to big-endian format
- *
- * @p:		Buffer to write the number to
- * @value:	Number to convert
- * @cells:	Number of cells
- *
- * Return: 0 on success, or negative errno on error.
- */
-static int write_number(void *p, u64 value, int cells)
-{
-	if (cells == 1) {
-		u32 tmp;
-
-		if (value > U32_MAX)
-			return -EINVAL;
-
-		tmp = cpu_to_be32(value);
-		memcpy(p, &tmp, sizeof(tmp));
-	} else if (cells == 2) {
-		u64 tmp;
-
-		tmp = cpu_to_be64(value);
-		memcpy(p, &tmp, sizeof(tmp));
-	} else
-		return -EINVAL;
-
-	return 0;
-}
-
 /**
  * setup_ima_buffer - add IMA buffer information to the fdt
  * @image:		kexec image being loaded.
@@ -257,32 +227,15 @@ static int write_number(void *p, u64 value, int cells)
 static int setup_ima_buffer(const struct kimage *image, void *fdt,
 			    int chosen_node)
 {
-	int ret, addr_cells, size_cells, entry_size;
-	u8 value[16];
+	int ret;
 
 	if (!image->ima_buffer_size)
 		return 0;
 
-	ret = get_addr_size_cells(&addr_cells, &size_cells);
-	if (ret)
-		return ret;
-
-	entry_size = 4 * (addr_cells + size_cells);
-
-	if (entry_size > sizeof(value))
-		return -EINVAL;
-
-	ret = write_number(value, image->ima_buffer_addr, addr_cells);
-	if (ret)
-		return ret;
-
-	ret = write_number(value + 4 * addr_cells, image->ima_buffer_size,
-			   size_cells);
-	if (ret)
-		return ret;
-
-	ret = fdt_setprop(fdt, chosen_node, "linux,ima-kexec-buffer", value,
-			  entry_size);
+	ret = fdt_appendprop_addrrange(fdt, 0, chosen_node,
+				       "linux,ima-kexec-buffer",
+				       image->ima_buffer_addr,
+				       image->ima_buffer_size);
 	if (ret < 0)
 		return -EINVAL;
 
-- 
2.30.0

