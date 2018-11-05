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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E65C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 15:58:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8287F20827
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 15:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3xyPFDc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8287F20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pcmH5sp8zF22h
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 02:58:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O3xyPFDc";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="O3xyPFDc"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pc3y0tw2zF14S
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 02:27:10 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id j13-v6so4577555pff.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Nov 2018 07:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=9a1Olt+9gSUcbGlkI6FmhtduS6tNkDQuhvu9c7HHqj8=;
 b=O3xyPFDcNS2dnS+8JnF108IoMYgXaZ/rnA3tKIJseMtXIt0x990YQOTHGWMd4b9ZMV
 R2+rzKxGvXBh19xumPpYNV1dY1zbsEq3wXgUV6EpaZUcLyI8SWX/GZdWfs+mTeU3MLa/
 BgbMUhxyyaXDkFi6s1sqFVt+m3HNx6uFa0eGQFGLwZLpiqxHmtxk4p8AC0UCuYVbyRHe
 j/wb/6bk9aG23NWxJydv1Tlncp3VdBi7oHiW4w8zdNFYgW1hBiPQmpNomzcVjL/UDi5O
 gBjXm+3cKAY2yMrSeDLY0O0iDrBFdQhWbR+ZamAgksAZiD+kB9BBbzpcWtZMp3DBBpKP
 LT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=9a1Olt+9gSUcbGlkI6FmhtduS6tNkDQuhvu9c7HHqj8=;
 b=Q0Kkx7f2SK47cpNMDq7kd/p4EyttIf9KunbtUyDrW64oA7ckTYkm4OgXZ1J9I92cgM
 bY8bf7fMD5AmgyTEJUv+onW0qvgxzbK8PIZqhW4R++gfapm0hx98Yvbtee66fw/2QF3D
 Tj9BwWgs5WXRFQ3TtcN1L7wG/3n/MTynr6ZAn3chT7cRmFW4+56fUwjnt8BkQzM3DfRF
 MEy/pxBkFu4+IAO0DyKdKP1pnm58HSduvf1cF4YdOM3WHBp6KHY7//fBlWrXoQSmVzPi
 Q8USrsRS0wXWjeH+6oxBe6FsuNf0DIndiMrgOJfMnxTkODZCVgEuVc1MfOJ+y19VoP5d
 oVfg==
X-Gm-Message-State: AGRZ1gIzJ/lpeiehXJYnwGkFLXWbQUT4eN8cr7b9Sev/FA/EJuuM4DSm
 NN2CfTlDCX2nkCpq/xD+6ow=
X-Google-Smtp-Source: AJdET5egE2Aa2DXxhVqb8fJ6iiWUubsYaPiZCCyVUya6OAgk2jxk+Rs2izKJifIVGoYIahf2P1ytEQ==
X-Received: by 2002:a63:9809:: with SMTP id q9mr20600008pgd.109.1541431628530; 
 Mon, 05 Nov 2018 07:27:08 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id u76-v6sm37260578pfa.176.2018.11.05.07.27.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 05 Nov 2018 07:27:08 -0800 (PST)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v6 12/18] of: overlay: check prevents multiple fragments add
 or delete same node
Date: Mon,  5 Nov 2018 07:25:09 -0800
Message-Id: <1541431515-25197-13-git-send-email-frowand.list@gmail.com>
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

Multiple overlay fragments adding or deleting the same node is not
supported.  Replace code comment of such, with check to detect the
attempt and fail the overlay apply.

Devicetree unittest where multiple fragments added the same node was
added in the previous patch in the series.  After applying this patch
the unittest messages will no longer include:

   Duplicate name in motor-1, renamed to "controller#1"
   OF: overlay: of_overlay_apply() err=0
   ### dt-test ### of_overlay_fdt_apply() expected -22, ret=0, overlay_bad_add_dup_node
   ### dt-test ### FAIL of_unittest_overlay_high_level():2419 Adding overlay 'overlay_bad_add_dup_node' failed

   ...

   ### dt-test ### end of unittest - 210 passed, 1 failed

but will instead include:

   OF: overlay: ERROR: multiple overlay fragments add and/or delete node /testcase-data-2/substation@100/motor-1/controller

   ...

   ### dt-test ### end of unittest - 211 passed, 0 failed

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

checkpatch errors "line over 80 characters" and "Too many leading tabs"
are ok, they will be fixed later in this series

 drivers/of/overlay.c | 58 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 49 insertions(+), 9 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index c8f88b0836a3..8af8115bd36e 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -392,14 +392,6 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
  *       a live devicetree created from Open Firmware.
  *
  * NOTE_2: Multiple mods of created nodes not supported.
- *       If more than one fragment contains a node that does not already exist
- *       in the live tree, then for each fragment of_changeset_attach_node()
- *       will add a changeset entry to add the node.  When the changeset is
- *       applied, __of_attach_node() will attach the node twice (once for
- *       each fragment).  At this point the device tree will be corrupted.
- *
- *       TODO: add integrity check to ensure that multiple fragments do not
- *             create the same node.
  *
  * Returns 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
  * invalid @overlay.
@@ -517,6 +509,54 @@ static int build_changeset_symbols_node(struct overlay_changeset *ovcs,
 }
 
 /**
+ * check_changeset_dup_add_node() - changeset validation: duplicate add node
+ * @ovcs:	Overlay changeset
+ *
+ * Check changeset @ovcs->cset for multiple add node entries for the same
+ * node.
+ *
+ * Returns 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
+ * invalid overlay in @ovcs->fragments[].
+ */
+static int check_changeset_dup_add_node(struct overlay_changeset *ovcs)
+{
+	struct of_changeset_entry *ce_1, *ce_2;
+	char *fn_1, *fn_2;
+	int name_match;
+
+	list_for_each_entry(ce_1, &ovcs->cset.entries, node) {
+
+		if (ce_1->action == OF_RECONFIG_ATTACH_NODE ||
+		    ce_1->action == OF_RECONFIG_DETACH_NODE) {
+
+			ce_2 = ce_1;
+			list_for_each_entry_continue(ce_2, &ovcs->cset.entries, node) {
+				if (ce_2->action == OF_RECONFIG_ATTACH_NODE ||
+				    ce_2->action == OF_RECONFIG_DETACH_NODE) {
+					/* inexpensive name compare */
+					if (!of_node_cmp(ce_1->np->full_name,
+					    ce_2->np->full_name)) {
+						/* expensive full path name compare */
+						fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
+						fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
+						name_match = !strcmp(fn_1, fn_2);
+						kfree(fn_1);
+						kfree(fn_2);
+						if (name_match) {
+							pr_err("ERROR: multiple overlay fragments add and/or delete node %pOF\n",
+							       ce_1->np);
+							return -EINVAL;
+						}
+					}
+				}
+			}
+		}
+	}
+
+	return 0;
+}
+
+/**
  * build_changeset() - populate overlay changeset in @ovcs from @ovcs->fragments
  * @ovcs:	Overlay changeset
  *
@@ -571,7 +611,7 @@ static int build_changeset(struct overlay_changeset *ovcs)
 		}
 	}
 
-	return 0;
+	return check_changeset_dup_add_node(ovcs);
 }
 
 /*
-- 
Frank Rowand <frank.rowand@sony.com>

