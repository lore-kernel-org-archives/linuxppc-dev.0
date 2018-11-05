Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65371C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 16:10:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7E772081D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 16:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpTm6xR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7E772081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pd2G5hhGzF27h
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 03:10:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KpTm6xR1";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="KpTm6xR1"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pc4463czzF197
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 02:27:16 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id c13-v6so4605731plz.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Nov 2018 07:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zm7IxG6IbjO3cKRTTQfNVO/WR/d8v3zooZUasHWCL4g=;
 b=KpTm6xR18c+tEEBUEtizy/xfqlwu8IVfB9I14wtXp6vRKmOQI8V0vY0kpnWpaAMDhq
 0Zu2ICxnD6deM/J5jCslkSQSwt/ExkYtbGxdUfIq4tfMBat75cXMkRkvFY0/p6ZnO0Et
 jHlbNNjUJ0lUgqWohnO3FLLAbYbjrGs6YYUWuOP3hC7bDvaS2StcDmK24M9yvhLJAfBt
 spLeoiHulBi7l/cK4MLqDPzODsWFRPz+qdsC6IH0QAV2ZZcF8bL9l13FdKhwkCKs3440
 1vNEDwXwvVT/KdotqcqF4epIsAWLPjL5wfyJ5VDCXBLTv8TZqoczRDTUBJboKIG5C6i3
 oBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zm7IxG6IbjO3cKRTTQfNVO/WR/d8v3zooZUasHWCL4g=;
 b=CwZQ9FuT7LwMgeP2d23X9WWFurN1oechJRbVTbvHnmLZnk4/zrabyRrkaSwH0nilto
 sxKAx976hnM/uuZmLXbVUEFXp8A22aWYhhjU1pHIpEt5asMCgVqnphG2oEhf2UqgBvRc
 xqJEmHurmm+xr62PmIyhQ1s/d1HdPeFJRljqevguIkrX0Q7Uw81mnvwUzobSWqULd9eZ
 HLZvDy7lR8r9bFJ0FEAih7lpYPaicKeLDe9B28Tu3Ik/kwo7vMlnZn1zpmyVAovvFeS7
 8Bwc6dwiJN99AT/DX+7w2pF4ImWLH9LeuuxuvKK3HlLZcmX+yZVUzbG0BMarfaaewj85
 tpIA==
X-Gm-Message-State: AGRZ1gKLMk5cMJu4NXL1MTPka+MYtC7ljijRrh/B4e8pL51+nFle/CO/
 S/38aWXElPpckro8BHeyuUw=
X-Google-Smtp-Source: AJdET5czBNiwIoxnwGI/yuoh8U4rZt+quxDW1KN7uJjkzkCB819YYYARHDWHtB2vumds7GiuYhPWGw==
X-Received: by 2002:a17:902:82ca:: with SMTP id
 u10-v6mr21710722plz.146.1541431635052; 
 Mon, 05 Nov 2018 07:27:15 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id u76-v6sm37260578pfa.176.2018.11.05.07.27.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 05 Nov 2018 07:27:14 -0800 (PST)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v6 17/18] of: unittest: find overlays[] entry by name instead
 of index
Date: Mon,  5 Nov 2018 07:25:14 -0800
Message-Id: <1541431515-25197-18-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
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

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index d625a91a7f60..fe01c5869b0f 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -2192,7 +2192,7 @@ struct overlay_info {
 OVERLAY_INFO_EXTERN(overlay_bad_phandle);
 OVERLAY_INFO_EXTERN(overlay_bad_symbol);
 
-/* order of entries is hard-coded into users of overlays[] */
+/* entries found by name */
 static struct overlay_info overlays[] = {
 	OVERLAY_INFO(overlay_base, -9999),
 	OVERLAY_INFO(overlay, 0),
@@ -2215,7 +2215,8 @@ struct overlay_info {
 	OVERLAY_INFO(overlay_bad_add_dup_prop, -EINVAL),
 	OVERLAY_INFO(overlay_bad_phandle, -EINVAL),
 	OVERLAY_INFO(overlay_bad_symbol, -EINVAL),
-	{}
+	/* end marker */
+	{.dtb_begin = NULL, .dtb_end = NULL, .expected_result = 0, .name = NULL}
 };
 
 static struct device_node *overlay_base_root;
@@ -2245,6 +2246,19 @@ void __init unittest_unflatten_overlay_base(void)
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
 
@@ -2292,11 +2306,10 @@ static int __init overlay_data_apply(const char *overlay_name, int *overlay_id)
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

