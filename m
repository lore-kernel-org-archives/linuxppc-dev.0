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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11990C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 16:01:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C4720827
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 16:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAcLQZ+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C4720827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pcq32VXVzF1pY
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 03:01:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dAcLQZ+u";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="dAcLQZ+u"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pc3z3Y4bzF14S
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 02:27:11 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id y4so3935983pgc.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Nov 2018 07:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=3Z3nGqFbCCtLnxBc0KYMQRI67pewNP5b0P9UghLEHqY=;
 b=dAcLQZ+uSkZfRFL3SkpRiX6AxTYWkoYR2WKt1kiDqCUDv6UE82ixDurnZVc5uabgr7
 owFRlyMlKR8Asvv9EEERBes88/3Pl7hj3z6Xw22zzjlBjoOzEK1YhaK75islllseIVlb
 esXyBFr2TqCrhJSeWDa+BG4z7T+8vUVkSiZYRflmpEhFoHCkYamPmP2LsPd53L4Ar1aM
 MOtJfwfxW/Nru4nTzQXIlX/+Zi4oEsq16NLYaVvEKiUEV0Z8cb1iAxBSnrOiyTh8pKIc
 D2nr45iEyRNRzE5J/LUdbsWp1YqpFlR0AHUpsoUsmORaTb0F+O4K0sML6kROuU+XFbhA
 2tDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=3Z3nGqFbCCtLnxBc0KYMQRI67pewNP5b0P9UghLEHqY=;
 b=oovNdu75PXmLpJQtNwNVMB8g7+TEIdpoG9No2oOWD31BJ910DGkcLUP7ArVdtczv0F
 iOli6YsC8XJlaD1cPsB7WwSvtnOhg/Y8x5eRKq+/xCEVzdAX535Xo7TolBuAqAWQRBGt
 JMlJY87lZxxKqXoysc0P4IeirqWUQk0qjaMNbpH6pvVhUPm+0d1FHP7VDTzMSDujiLfj
 t8AehyVRMP/2VJEXlf0v9tcKOJKXawPc5Nrj4qwP+MMzX+cBnIVWKtT5Zrec3WsLziOn
 QMOQxD0vlrwb47HkDFZDqCcoDVXtL8J4bgwTbVlBQJJJem654EvpggaOwDVdSO+k/Y/2
 jChg==
X-Gm-Message-State: AGRZ1gL2hhgGqKGepPw90isbTaxub9IwVlgI1sWO122FxNm0Xhb77I+C
 GgzRYlueSGH+noEeroO0RDg=
X-Google-Smtp-Source: AJdET5egA+zm1ie1wcOUS+T3PF7/02+QuCdZVbFjuiFixZnTqMiQ3pVznpgbTfHFPcsEWnV9p4lO4A==
X-Received: by 2002:a63:2109:: with SMTP id h9mr20578310pgh.277.1541431629785; 
 Mon, 05 Nov 2018 07:27:09 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id u76-v6sm37260578pfa.176.2018.11.05.07.27.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 05 Nov 2018 07:27:09 -0800 (PST)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v6 13/18] of: overlay: check prevents multiple fragments
 touching same property
Date: Mon,  5 Nov 2018 07:25:10 -0800
Message-Id: <1541431515-25197-14-git-send-email-frowand.list@gmail.com>
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

Add test case of two fragments updating the same property.  After
adding the test case, the system hangs at end of boot, after
after slub stack dumps from kfree() in crypto modprobe code.

Multiple overlay fragments adding, modifying, or deleting the same
property is not supported.  Add check to detect the attempt and fail
the overlay apply.

Before this patch, the first fragment error would terminate
processing.  Allow fragment checking to proceed and report all
of the fragment errors before terminating the overlay apply. This
is not a hot path, thus not a performance issue (the error is not
transient and requires fixing the overlay before attempting to
apply it again).

After applying this patch, the devicetree unittest messages will
include:

   OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/rpm_avail

   ...

   ### dt-test ### end of unittest - 212 passed, 0 failed

The check to detect two fragments updating the same property is
folded into the patch that created the test case to maintain
bisectability.

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c                               | 118 ++++++++++++++-------
 drivers/of/unittest-data/Makefile                  |   1 +
 .../of/unittest-data/overlay_bad_add_dup_prop.dts  |  24 +++++
 drivers/of/unittest-data/overlay_base.dts          |   1 +
 drivers/of/unittest.c                              |   5 +
 5 files changed, 112 insertions(+), 37 deletions(-)
 create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_prop.dts

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 8af8115bd36e..184cc2c4a931 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -508,52 +508,96 @@ static int build_changeset_symbols_node(struct overlay_changeset *ovcs,
 	return 0;
 }
 
+static int find_dup_cset_node_entry(struct overlay_changeset *ovcs,
+		struct of_changeset_entry *ce_1)
+{
+	struct of_changeset_entry *ce_2;
+	char *fn_1, *fn_2;
+	int node_path_match;
+
+	if (ce_1->action != OF_RECONFIG_ATTACH_NODE &&
+	    ce_1->action != OF_RECONFIG_DETACH_NODE)
+		return 0;
+
+	ce_2 = ce_1;
+	list_for_each_entry_continue(ce_2, &ovcs->cset.entries, node) {
+		if ((ce_2->action != OF_RECONFIG_ATTACH_NODE &&
+		     ce_2->action != OF_RECONFIG_DETACH_NODE) ||
+		    of_node_cmp(ce_1->np->full_name, ce_2->np->full_name))
+			continue;
+
+		fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
+		fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
+		node_path_match = !strcmp(fn_1, fn_2);
+		kfree(fn_1);
+		kfree(fn_2);
+		if (node_path_match) {
+			pr_err("ERROR: multiple fragments add and/or delete node %pOF\n",
+			       ce_1->np);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int find_dup_cset_prop(struct overlay_changeset *ovcs,
+		struct of_changeset_entry *ce_1)
+{
+	struct of_changeset_entry *ce_2;
+	char *fn_1, *fn_2;
+	int node_path_match;
+
+	if (ce_1->action != OF_RECONFIG_ADD_PROPERTY &&
+	    ce_1->action != OF_RECONFIG_REMOVE_PROPERTY &&
+	    ce_1->action != OF_RECONFIG_UPDATE_PROPERTY)
+		return 0;
+
+	ce_2 = ce_1;
+	list_for_each_entry_continue(ce_2, &ovcs->cset.entries, node) {
+		if ((ce_2->action != OF_RECONFIG_ADD_PROPERTY &&
+		     ce_2->action != OF_RECONFIG_REMOVE_PROPERTY &&
+		     ce_2->action != OF_RECONFIG_UPDATE_PROPERTY) ||
+		    of_node_cmp(ce_1->np->full_name, ce_2->np->full_name))
+			continue;
+
+		fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
+		fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
+		node_path_match = !strcmp(fn_1, fn_2);
+		kfree(fn_1);
+		kfree(fn_2);
+		if (node_path_match &&
+		    !of_prop_cmp(ce_1->prop->name, ce_2->prop->name)) {
+			pr_err("ERROR: multiple fragments add, update, and/or delete property %pOF/%s\n",
+			       ce_1->np, ce_1->prop->name);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 /**
- * check_changeset_dup_add_node() - changeset validation: duplicate add node
+ * changeset_dup_entry_check() - check for duplicate entries
  * @ovcs:	Overlay changeset
  *
- * Check changeset @ovcs->cset for multiple add node entries for the same
- * node.
+ * Check changeset @ovcs->cset for multiple {add or delete} node entries for
+ * the same node or duplicate {add, delete, or update} properties entries
+ * for the same property.
  *
- * Returns 0 on success, -ENOMEM if memory allocation failure, or -EINVAL if
- * invalid overlay in @ovcs->fragments[].
+ * Returns 0 on success, or -EINVAL if duplicate changeset entry found.
  */
-static int check_changeset_dup_add_node(struct overlay_changeset *ovcs)
+static int changeset_dup_entry_check(struct overlay_changeset *ovcs)
 {
-	struct of_changeset_entry *ce_1, *ce_2;
-	char *fn_1, *fn_2;
-	int name_match;
+	struct of_changeset_entry *ce_1;
+	int dup_entry = 0;
 
 	list_for_each_entry(ce_1, &ovcs->cset.entries, node) {
-
-		if (ce_1->action == OF_RECONFIG_ATTACH_NODE ||
-		    ce_1->action == OF_RECONFIG_DETACH_NODE) {
-
-			ce_2 = ce_1;
-			list_for_each_entry_continue(ce_2, &ovcs->cset.entries, node) {
-				if (ce_2->action == OF_RECONFIG_ATTACH_NODE ||
-				    ce_2->action == OF_RECONFIG_DETACH_NODE) {
-					/* inexpensive name compare */
-					if (!of_node_cmp(ce_1->np->full_name,
-					    ce_2->np->full_name)) {
-						/* expensive full path name compare */
-						fn_1 = kasprintf(GFP_KERNEL, "%pOF", ce_1->np);
-						fn_2 = kasprintf(GFP_KERNEL, "%pOF", ce_2->np);
-						name_match = !strcmp(fn_1, fn_2);
-						kfree(fn_1);
-						kfree(fn_2);
-						if (name_match) {
-							pr_err("ERROR: multiple overlay fragments add and/or delete node %pOF\n",
-							       ce_1->np);
-							return -EINVAL;
-						}
-					}
-				}
-			}
-		}
+		dup_entry |= find_dup_cset_node_entry(ovcs, ce_1);
+		dup_entry |= find_dup_cset_prop(ovcs, ce_1);
 	}
 
-	return 0;
+	return dup_entry ? -EINVAL : 0;
 }
 
 /**
@@ -611,7 +655,7 @@ static int build_changeset(struct overlay_changeset *ovcs)
 		}
 	}
 
-	return check_changeset_dup_add_node(ovcs);
+	return changeset_dup_entry_check(ovcs);
 }
 
 /*
diff --git a/drivers/of/unittest-data/Makefile b/drivers/of/unittest-data/Makefile
index 166dbdbfd1c5..9b6807065827 100644
--- a/drivers/of/unittest-data/Makefile
+++ b/drivers/of/unittest-data/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_OF_OVERLAY) += overlay.dtb.o \
 			    overlay_13.dtb.o \
 			    overlay_15.dtb.o \
 			    overlay_bad_add_dup_node.dtb.o \
+			    overlay_bad_add_dup_prop.dtb.o \
 			    overlay_bad_phandle.dtb.o \
 			    overlay_bad_symbol.dtb.o \
 			    overlay_base.dtb.o
diff --git a/drivers/of/unittest-data/overlay_bad_add_dup_prop.dts b/drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
new file mode 100644
index 000000000000..c190da54f175
--- /dev/null
+++ b/drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+/plugin/;
+
+/*
+ * &electric_1/motor-1 and &spin_ctrl_1 are the same node:
+ *   /testcase-data-2/substation@100/motor-1
+ *
+ * Thus the property "rpm_avail" in each fragment will
+ * result in an attempt to update the same property twice.
+ * This will result in an error and the overlay apply
+ * will fail.
+ */
+
+&electric_1 {
+
+	motor-1 {
+		rpm_avail = < 100 >;
+	};
+};
+
+&spin_ctrl_1 {
+		rpm_avail = < 100 200 >;
+};
diff --git a/drivers/of/unittest-data/overlay_base.dts b/drivers/of/unittest-data/overlay_base.dts
index 820b79ca378a..99ab9d12d00b 100644
--- a/drivers/of/unittest-data/overlay_base.dts
+++ b/drivers/of/unittest-data/overlay_base.dts
@@ -30,6 +30,7 @@
 			spin_ctrl_1: motor-1 {
 				compatible = "ot,ferris-wheel-motor";
 				spin = "clockwise";
+				rpm_avail = < 50 >;
 			};
 
 			spin_ctrl_2: motor-8 {
diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index f82edf829f43..f0139d1e8b63 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -2162,6 +2162,7 @@ struct overlay_info {
 OVERLAY_INFO_EXTERN(overlay_13);
 OVERLAY_INFO_EXTERN(overlay_15);
 OVERLAY_INFO_EXTERN(overlay_bad_add_dup_node);
+OVERLAY_INFO_EXTERN(overlay_bad_add_dup_prop);
 OVERLAY_INFO_EXTERN(overlay_bad_phandle);
 OVERLAY_INFO_EXTERN(overlay_bad_symbol);
 
@@ -2185,6 +2186,7 @@ struct overlay_info {
 	OVERLAY_INFO(overlay_13, 0),
 	OVERLAY_INFO(overlay_15, 0),
 	OVERLAY_INFO(overlay_bad_add_dup_node, -EINVAL),
+	OVERLAY_INFO(overlay_bad_add_dup_prop, -EINVAL),
 	OVERLAY_INFO(overlay_bad_phandle, -EINVAL),
 	OVERLAY_INFO(overlay_bad_symbol, -EINVAL),
 	{}
@@ -2435,6 +2437,9 @@ static __init void of_unittest_overlay_high_level(void)
 	unittest(overlay_data_apply("overlay_bad_add_dup_node", NULL),
 		 "Adding overlay 'overlay_bad_add_dup_node' failed\n");
 
+	unittest(overlay_data_apply("overlay_bad_add_dup_prop", NULL),
+		 "Adding overlay 'overlay_bad_add_dup_prop' failed\n");
+
 	unittest(overlay_data_apply("overlay_bad_phandle", NULL),
 		 "Adding overlay 'overlay_bad_phandle' failed\n");
 
-- 
Frank Rowand <frank.rowand@sony.com>

