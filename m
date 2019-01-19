Return-Path: <SRS0=aKpC=P3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF58C61CE4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 16:01:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B491205C9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 16:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T50w2nOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B491205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43hjHB52zZzDr1R
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Jan 2019 03:01:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::643; helo=mail-pl1-x643.google.com;
 envelope-from=groeck7@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="T50w2nOp"; 
 dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43hjFP33x5zDqx1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Jan 2019 03:00:08 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id p8so7728854plo.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 08:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version:status:lines
 :content-transfer-encoding;
 bh=DMNTSdjq7FbZTDZ9c+AvK8qmgt4eJ0hzXjL7rDvdBV0=;
 b=T50w2nOpNYrMvTGEry5nHW9qdZeSwcRR1L9KBxdonuR+IoGxDybQXDI371F50kF6/D
 X3bqG0D14kI6ezBEaA+VLTOKeFz55KnHMdeM4m8sRz7gSnUn3kDn3xeyRiC5NURyhoqf
 LzwbXCFlmG0T4Qja0lnEX8+v+vrIGygg6KCZQBXqJoUPIwychcoybkEeQj4HZvPldJcg
 Pf+g7jeiY5yelo7TwNjEKXZ0+IxuoK2oRaq4Fkd7MmbSx4NK3kG1+V6jZkZp0SjyByrj
 oZXwWChQXGUOX+SwoTB4gTTdz1iqNttcWKPegEdnZPVqG04oqOH2uh9uYUwwXRI9onB4
 tL7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:status:lines:content-transfer-encoding;
 bh=DMNTSdjq7FbZTDZ9c+AvK8qmgt4eJ0hzXjL7rDvdBV0=;
 b=tfsltVRbjn2jeJUuttJAUdzkuzhmML3KTGNGjJ5JYCJV3Z/8J1uG+wSPz0ny49Sjfi
 JJyjQcD09zymoqS9nyFsa9iXz65vmhC2T6Rtt5gK/GwUBGUh2JXpiOb0MB2W7QkmKDyC
 XI5OlmDofU8fh9Y/CAncqjOFAvaSLXZVlQ9+0wKCubZ47oEkgzxc8qXo2v5xEF2PoAA9
 Bo45oORsxXpNJhxvAtPyfltQnjA6E1NJ+BxarBtje3x2jdJvNz9k0xeguWizotKsy1GI
 OiBzSos1mUev703t7trrNWMPEqsVRUfz7QvWBP9x6jspSgmyLzUmNxEFdkjfKqf9qi0M
 c3JA==
X-Gm-Message-State: AJcUukd89HLjo8usoGNKh410TGnpoUdMX8F3aWJTNIkPw1ifsSX7oZ0a
 b5r50eyUNsrogkBI8qOC4OE=
X-Google-Smtp-Source: ALg8bN6s2HkcSmBzgSlyWHGf1yhK2wH1aHXHs7kMuDB8GkzkGbpsGMo0WqEbrsfsWw+uCgJdXH8cUA==
X-Received: by 2002:a17:902:6b87:: with SMTP id
 p7mr23708705plk.282.1547913606687; 
 Sat, 19 Jan 2019 08:00:06 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id w185sm11238567pfb.135.2019.01.19.08.00.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 19 Jan 2019 08:00:05 -0800 (PST)
From: Guenter Roeck <linux@roeck-us.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: chrp: Use device_type helpers to access the node type
Date: Sat, 19 Jan 2019 07:59:58 -0800
Message-Id: <1547913598-5471-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
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
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The node type can no longer be accessed directly, resulting in the
following build error. Use accessor function instead.

arch/powerpc/platforms/chrp/setup.c: In function ‘chrp_init_IRQ’:
arch/powerpc/platforms/chrp/setup.c:541:33: error:
	‘struct device_node’ has no member named ‘type’

Fixes: 8ce5f8415753 ("of: Remove struct device_node.type pointer")
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/powerpc/platforms/chrp/setup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/chrp/setup.c b/arch/powerpc/platforms/chrp/setup.c
index e66644e0fb40..c79f626502bf 100644
--- a/arch/powerpc/platforms/chrp/setup.c
+++ b/arch/powerpc/platforms/chrp/setup.c
@@ -538,8 +538,7 @@ static void __init chrp_init_IRQ(void)
 	/* see if there is a keyboard in the device tree
 	   with a parent of type "adb" */
 	for_each_node_by_name(kbd, "keyboard")
-		if (kbd->parent && kbd->parent->type
-		    && strcmp(kbd->parent->type, "adb") == 0)
+		if (kbd->parent && of_node_is_type(kbd->parent, "adb"))
 			break;
 	of_node_put(kbd);
 	if (kbd)
-- 
2.7.4

