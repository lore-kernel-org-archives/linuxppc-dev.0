Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA68C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 06:08:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1C7C2087D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 06:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ah62hQjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C7C2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VNvT2JgRzF1nv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 17:08:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ah62hQjR";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ah62hQjR"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VNrt66q5zF1fD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 17:06:22 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id r9-v6so1984079pgv.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Oct 2018 23:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=4aCy5tTznrQu5jxgwpzh99WmSKO89ArK9yV9VYtEufA=;
 b=Ah62hQjRFq6E2r1YAqvgpalFraes1n93EziZXIrc4nMLgsB6Be17kz9vx8gwEx1aki
 UQS7AFHGboInTRnZLjc3an39lkWbI0bPx4C4gCfntVdxPK9gFUBgs7DPeInUHiZUq2H3
 g/JALcawT7ECbwSjR5YbNqTDXepkNwowvWPGBzoQKPyzkp45FxTJBHptvL5rSBbnheWx
 QcrrUsHFSJ8QnCJFhioypS6K+ahdxPj1hW6MBbSWV1oBUSXZkBN8Nfqx1BCdNPOGw56N
 Y35U0h/lBOO0YKZFB00NTvy3wSiixtnNWBmeBbvUHesz/UBhB2efjrv/pWPvdt4kJm/d
 xcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=4aCy5tTznrQu5jxgwpzh99WmSKO89ArK9yV9VYtEufA=;
 b=mCN4qKrzuLykqx53KNePjhg0Ku/Gqu/E5qqx7S8B3DkZMIKP+gZ4Q0QN1vNPFuERNJ
 sycRNysOwQrh8kY80vRWMsEciWk//5ct7DZ4qEwt8morw0tT24ePXW8BDE6ipk8j6lTE
 dhnwfjQY23j0i+3eqMVtzwMWlmeJJxUgT0jquG3IdXgbOnhMbMEgifMLmyEJH7V9pXxp
 A6+rnzh0mWCG/23sfjPQ5v4uctI5y2Zax5OmoRAL+c0GNciKqMo7j+QsakuJtZwErB3T
 uv7ryfNgP/W+maTXcz92cFb4+NvQ4+AIU/Z8lInDRt/PwfaVsOPFHTMcRpzrB8q9hDpm
 RGTw==
X-Gm-Message-State: ABuFfogXAYxUbMo6OSy3TOOSNdKqsnWRTr0bCdXJWumgiNJ8I62eYCzd
 gJUsFAPQLDwLXW7bmbxLCf0=
X-Google-Smtp-Source: ACcGV6108JOy4mKuw5s30kV3iVIVDBisgIboYqYzyuMG2hTPVmoU5ykaKFg5HhAVdOmF+ZLUKZUiDA==
X-Received: by 2002:a63:c44a:: with SMTP id
 m10-v6mr28749830pgg.416.1539151580757; 
 Tue, 09 Oct 2018 23:06:20 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id p84-v6sm26314354pfi.22.2018.10.09.23.06.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 09 Oct 2018 23:06:20 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 05.1/16] of:overlay: missing name, phandle, linux,
 phandle in new nodes
Date: Tue,  9 Oct 2018 23:04:55 -0700
Message-Id: <1539151495-8110-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <CANk1AXQScT_b1_UOiVuWNcB=LiA3gvvZrw53H1XVSCNqsGPqtA@mail.gmail.com>
References: <CANk1AXQScT_b1_UOiVuWNcB=LiA3gvvZrw53H1XVSCNqsGPqtA@mail.gmail.com>
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


"of: overlay: use prop add changeset entry for property in new nodes"
fixed a problem where an 'update property' changeset entry was
created for properties contained in nodes added by a changeset.
The fix was to use an 'add property' changeset entry.

This exposed more bugs in the apply overlay code.  The properties
'name', 'phandle', and 'linux,phandle' were filtered out by
add_changeset_property() as special properties.  Change the filter
to be only for existing nodes, not newly added nodes.

The second bug is that the 'name' property does not exist in the
newest FDT version, and has to be constructed from the node's
full_name.  Construct an 'add property' changeset entry for
newly added nodes.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---


Hi Alan,

Thanks for reporting the problem with missing node names.

I was able to replicate the problem, and have created this preliminary
version of a patch to fix the problem.

I have not extensively reviewed the patch yet, but would appreciate
if you can confirm this fixes your problem.

I created this patch as patch 17 of the series, but have also
applied it as patch 05.1, immediately after patch 05/16, and
built the kernel, booted, and verified name and phandle for
one of the nodes in a unittest overlay for both cases.  So
minimal testing so far on my part.

I have not verified whether the series builds and boots after
each of patches 06..16 if this patch is applied as patch 05.1.

There is definitely more work needed for me to complete this
patch because it allocates some more memory, but does not yet
free it when the overlay is released.

-Frank


 drivers/of/overlay.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 67 insertions(+), 5 deletions(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 0b0904f44bc7..9746cea2aa91 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -301,10 +301,11 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
 	struct property *new_prop = NULL, *prop;
 	int ret = 0;
 
-	if (!of_prop_cmp(overlay_prop->name, "name") ||
-	    !of_prop_cmp(overlay_prop->name, "phandle") ||
-	    !of_prop_cmp(overlay_prop->name, "linux,phandle"))
-		return 0;
+	if (target->in_livetree)
+		if (!of_prop_cmp(overlay_prop->name, "name") ||
+		    !of_prop_cmp(overlay_prop->name, "phandle") ||
+		    !of_prop_cmp(overlay_prop->name, "linux,phandle"))
+			return 0;
 
 	if (target->in_livetree)
 		prop = of_find_property(target->np, overlay_prop->name, NULL);
@@ -443,10 +444,13 @@ static int build_changeset_next_level(struct overlay_changeset *ovcs,
 		struct target *target, const struct device_node *overlay_node)
 {
 	struct device_node *child;
-	struct property *prop;
+	struct property *prop, *name_prop;
+	bool has_name = false;
 	int ret;
 
 	for_each_property_of_node(overlay_node, prop) {
+		if (!strcmp(prop->name, "name"))
+			has_name = true;
 		ret = add_changeset_property(ovcs, target, prop, 0);
 		if (ret) {
 			pr_debug("Failed to apply prop @%pOF/%s, err=%d\n",
@@ -455,6 +459,57 @@ static int build_changeset_next_level(struct overlay_changeset *ovcs,
 		}
 	}
 
+	/*
+	 * With FDT version 0x10 we may not have the name property,
+	 * recreate it here from the unit name if absent
+	 */
+
+	if (!has_name) {
+		const char *p = target->np->full_name, *ps = p, *pa = NULL;
+		int len;
+
+		/*
+		 * zzz
+		 * TODO: stash name_prop on a list in ovcs, to be freed
+		 * after overlay removed
+		 */
+
+		while (*p) {
+			if ((*p) == '@')
+				pa = p;
+			else if ((*p) == '/')
+				ps = p + 1;
+			p++;
+		}
+
+		if (pa < ps)
+			pa = p;
+		len = (pa - ps) + 1;
+
+		name_prop = kmalloc(sizeof(*name_prop), GFP_KERNEL);
+		if (!name_prop)
+			return -ENOMEM;
+
+		name_prop->name = kstrdup("name", GFP_KERNEL);
+		name_prop->value = kmalloc(len, GFP_KERNEL);
+		if (!name_prop->name || !name_prop->value) {
+			ret = -ENOMEM;
+			goto err_free_name_prop;
+		}
+
+		memcpy(name_prop->value, ps, len - 1);
+		((char *)name_prop->value)[len - 1] = 0;
+
+		name_prop->length = strlen(name_prop->value) + 1;
+
+		ret = add_changeset_property(ovcs, target, name_prop, 0);
+		if (ret) {
+			pr_debug("Failed to apply name_prop @%pOF/%s, err=%d\n",
+				 target->np, name_prop->name, ret);
+			goto err_free_name_prop;
+		}
+	}
+
 	for_each_child_of_node(overlay_node, child) {
 		ret = add_changeset_node(ovcs, target, child);
 		if (ret) {
@@ -466,6 +521,13 @@ static int build_changeset_next_level(struct overlay_changeset *ovcs,
 	}
 
 	return 0;
+
+err_free_name_prop:
+	kfree(name_prop->name);
+	kfree(name_prop->value);
+	kfree(name_prop);
+	return ret;
+
 }
 
 /*
-- 
Frank Rowand <frank.rowand@sony.com>

