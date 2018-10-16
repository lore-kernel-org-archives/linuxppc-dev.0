Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69722C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 03:25:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C654C20869
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 03:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNWp6OTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C654C20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Z1065LR1zF3WB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 14:25:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cNWp6OTI";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="cNWp6OTI"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YzzV0Lv7zF3Vt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 13:39:34 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id q17-v6so10218171plr.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 19:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VS64Bboo/cHvVCqyzYbNqD36WUkYJGIhe/8UN1uSi10=;
 b=cNWp6OTIr9yNPrhjf6nUHyWFwdqYPcsARgDVtqR1LXavRAKnv2rzoWqg4PF9vRV0qS
 6Cnk6gYyBHX33GKTwjHdNxQ4/tsbdEqeL6wpX/rqj+idxmRYRl6jaCzwuAVpmF+zdOud
 qTaXMvEZHnwuFCvAcbWDdZK4pwD58c4awu+Rfu/pX/Axalpak0FVnEzIIZ7EaOA3Lyb1
 97K2wdGV+1t3LFURiNuJA35R3T1lkNXFXUpb8tcZ3/CY1GkPeipx/ODf9Dr2w0SArTqJ
 qKMO6eJWRRDXykH7M6iTnVPleDItYDTI2bSo9Juh22lPEYKGb5EzGQq2RZeQIvjbZIvH
 QYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VS64Bboo/cHvVCqyzYbNqD36WUkYJGIhe/8UN1uSi10=;
 b=G0zh9R1DGKjK6xJX8ETgsV3D3faSQhZ+rh82Qu4AwgQJQMAikVAzavOQ0z9casqZW9
 DuCAMVxLebvDMNY/EqE39QkO1DgQoSv2qPB+8psJnrLRiu+pTcmz6pjbmmD8OuI+D3/b
 Yp5dZsLnx2Vg6SEV2FL2ScKPHE479ijDyUTvJ/Liw0gVcOUdTj4PRGPFJUz/pgKLZORY
 zoxaZpw1rfHnPAESGFwi3XTtBcDg8yTW/SnuMPBVzMKFrXyOMXBp+Ywvgn7naEGJWRmd
 YoShHw4eyzggrDrtLyzIGr/ckt3SZy7pbKS3M9VLweq4oYidr+hpKpgPBSM8muKCjS2i
 cT5w==
X-Gm-Message-State: ABuFfoiBkMWCPClEaQCPPEWwpK+x7EZNZ3ItlZvIHXguFWbJl0dhEycK
 su7DeB49gfabaQsmTnUn1ZGQTZIM
X-Google-Smtp-Source: ACcGV60Nfmmqbpzyw/70EkH3YYM6S3SkEI8I/6UhrD9vPf0vQ86RliJfFLgwooPXLM9IMHyjqz/QUA==
X-Received: by 2002:a17:902:b611:: with SMTP id
 b17-v6mr19578346pls.217.1539657572500; 
 Mon, 15 Oct 2018 19:39:32 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id u79-v6sm18620287pfd.117.2018.10.15.19.39.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 15 Oct 2018 19:39:32 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v4 17/18] of: unittest: find overlays[] entry by name instead
 of index
Date: Mon, 15 Oct 2018 19:37:37 -0700
Message-Id: <1539657458-24401-18-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
References: <1539657458-24401-1-git-send-email-frowand.list@gmail.com>
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
Cc: devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Frank Rowand <frank.rowand@sony.com>

One accessor of overlays[] was using a hard coded index value to
find the correct array entry instead of searching for the entry
containing the correct name.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 1c2bd8503095..785985bdbfa6 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -2178,7 +2178,7 @@ struct overlay_info {
 OVERLAY_INFO_EXTERN(overlay_bad_phandle);
 OVERLAY_INFO_EXTERN(overlay_bad_symbol);
 
-/* order of entries is hard-coded into users of overlays[] */
+/* entries found by name */
 static struct overlay_info overlays[] = {
 	OVERLAY_INFO(overlay_base, -9999),
 	OVERLAY_INFO(overlay, 0),
@@ -2201,7 +2201,8 @@ struct overlay_info {
 	OVERLAY_INFO(overlay_bad_add_dup_prop, -EINVAL),
 	OVERLAY_INFO(overlay_bad_phandle, -EINVAL),
 	OVERLAY_INFO(overlay_bad_symbol, -EINVAL),
-	{}
+	/* end marker */
+	{.dtb_begin = NULL, .dtb_end = NULL, .expected_result = 0, .name = NULL}
 };
 
 static struct device_node *overlay_base_root;
@@ -2231,6 +2232,19 @@ void __init unittest_unflatten_overlay_base(void)
 	u32 data_size;
 	void *new_fdt;
 	u32 size;
+	int found = 0;
+	const char *overlay_name = "overlay_base";
+
+	for (info = overlays; info && info->name; info++) {
+		if (!strcmp(overlay_name, info->name)) {
+			found = 1;
+			break;
+		}
+	}
+	if (!found) {
+		pr_err("no overlay data for %s\n", overlay_name);
+		return;
+	}
 
 	info = &overlays[0];
 
@@ -2278,11 +2292,10 @@ static int __init overlay_data_apply(const char *overlay_name, int *overlay_id)
 {
 	struct overlay_info *info;
 	int found = 0;
-	int k;
 	int ret;
 	u32 size;
 
-	for (k = 0, info = overlays; info && info->name; info++, k++) {
+	for (info = overlays; info && info->name; info++) {
 		if (!strcmp(overlay_name, info->name)) {
 			found = 1;
 			break;
-- 
Frank Rowand <frank.rowand@sony.com>

