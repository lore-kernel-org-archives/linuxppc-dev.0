Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F106CC4332F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Dec 2023 10:33:43 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=TCEU2AUr;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SrTGZ4qrBz3w95
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Dec 2023 21:33:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=TCEU2AUr;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SrTDk3CsQz3vgx
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2023 21:32:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1702549926;
	bh=RoCUu1mXewEDtm43Qq0pBWgiYLguorwyr3zE9+lEq2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TCEU2AUr0ZA04uTWvKS/i3ZVnJa0VyDib+4PiyGCQg7iYXZ0YGOJGDur97P5pyzAJ
	 ZDtG+cH7Qm4T+X/9B8J01Tj1odsNEBX7Zv7jVYv2UGg/igHIajr64YmluEtiDAktbJ
	 FYNzi99K+px1npcA6NnqaXreto/JcbyQnFH3ZgWLhJhkphXGPb0d8FRzCMmA5OYoTE
	 mi2ltw6Peioc0GwLpqNoOvumthQnpVxfsByUQS6ELu2c/csI87q8kODmX4phBHrPBG
	 geRxOfCFC/OBotVhANnyzFeit42L1QHw+6Blf+5bqiU+1uuONyJ2OrSuNgPt6FhPFz
	 cMuyAa7oMqijg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SrTDk1lzGz4xPQ;
	Thu, 14 Dec 2023 21:32:06 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v2 2/5] of: Change of_machine_is_compatible() to return bool
Date: Thu, 14 Dec 2023 21:31:49 +1100
Message-ID: <20231214103152.12269-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214103152.12269-1-mpe@ellerman.id.au>
References: <20231214103152.12269-1-mpe@ellerman.id.au>
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
Cc: robh+dt@kernel.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

of_machine_is_compatible() currently returns a positive integer if it
finds a match. However none of the callers ever check the value, they
all treat it as a true/false.

So change of_machine_is_compatible() to return bool, which will allow
the implementation to be changed in a subsequent patch.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/of/base.c  | 5 ++---
 include/linux/of.h | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

v2: New.

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 9020be2eb4d5..c82c8b77badc 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -419,10 +419,9 @@ bool of_machine_compatible_match(const char *const *compats)
  * of_machine_is_compatible - Test root of device tree for a given compatible value
  * @compat: compatible string to look for in root node's compatible property.
  *
- * Return: A positive integer if the root node has the given value in its
- * compatible property.
+ * Return: true if the root node has the given value in its compatible property.
  */
-int of_machine_is_compatible(const char *compat)
+bool of_machine_is_compatible(const char *compat)
 {
 	struct device_node *root;
 	int rc = 0;
diff --git a/include/linux/of.h b/include/linux/of.h
index e3418babc203..c5c663a7fb77 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -402,7 +402,7 @@ extern void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align));
 extern int of_alias_get_id(struct device_node *np, const char *stem);
 extern int of_alias_get_highest_id(const char *stem);
 
-extern int of_machine_is_compatible(const char *compat);
+extern bool of_machine_is_compatible(const char *compat);
 bool of_machine_compatible_match(const char *const *compats);
 
 extern int of_add_property(struct device_node *np, struct property *prop);
-- 
2.43.0

