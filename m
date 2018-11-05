Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F6EC0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 15:34:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 460702081D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 15:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u6Uyp8W7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460702081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pcDY39stzF197
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 02:34:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="u6Uyp8W7";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="u6Uyp8W7"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pc3h46yczDrJP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 02:26:56 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id y4so3935707pgc.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Nov 2018 07:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=5upJeVS2/PUxAj2eWycRTvspVro5k0eON4BnhkKqWZI=;
 b=u6Uyp8W7CAXr3If/J9mb+gSZrPK2+8YjQ17sTmNYPRbH6N8EiJwyBNUGCwaab1xbCn
 hsTDxLAKGHi4iFGR8qpgCjjjnvuaQfCg60dxseZkrmXDekssxZALvnaeUqL4wCK63lo+
 rYeRHTU3cGMuZyODz1YcKHgZ7ie/mWyDggx1ekXPlP6+7uR/oYOP+REtaPb+CVAmJBza
 5STEzs3YivUmVhOz7RL3lWzGIB6GjvXCl5GCuYSN7YslQQ2KklxECBIHZhMwVJzipmUz
 YOl14me/40Eqqwc7/H4MtOXWK+/WVPJlkO5YUKwnuFubT8nDoIZep7PbtSdoWkJzpT7E
 McqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=5upJeVS2/PUxAj2eWycRTvspVro5k0eON4BnhkKqWZI=;
 b=K0Cn7V19ArrTJZpalR54kiYwxbPCAqPAJvFG1Dt7DelSC5d9jos5b/c4E4PUk0B4bx
 tUPShDbMCtRDMWvY5MKh3ZJ8GUt4P7G2Fv+8NZWpokMFxrug5OVviv9P0EpvyKbubRQm
 T0Vrk3BfujOsg2RHACgTdwp5nUcMbT+hABy2SYYUL5gQ2cy75LnCNrDTV+uz3EYfUGWN
 PWZfrjHq/5cPSUq1P2Aw6YM3htWbe/sk67G0SfPA8WWRCLAwCDMZl3DP1antL8bBoCXn
 GfmhdcBxfS2RNwyqHrOeIEoS4JGe69MdfsOVjvbd4KWYcAlWjvzEclY/T3uYCBBR27m5
 TXtQ==
X-Gm-Message-State: AGRZ1gLZo7pl/CM/tJXBUxMuC2KdEMUtg356BG70B1GF9kc8CPbhDUMj
 IXnpqayPY4YVq/bnoaseCKI=
X-Google-Smtp-Source: AJdET5eft/ysZdTfPBISQiwUgbtavcV7Z1PcH9C5ex7/2/drzVi7qckOucK4A6jPF2vbqtiH0x0big==
X-Received: by 2002:a62:5b43:: with SMTP id
 p64-v6mr23081205pfb.122.1541431614863; 
 Mon, 05 Nov 2018 07:26:54 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id u76-v6sm37260578pfa.176.2018.11.05.07.26.53
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 05 Nov 2018 07:26:54 -0800 (PST)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v6 02/18] of: overlay: add missing of_node_put() after add new
 node to changeset
Date: Mon,  5 Nov 2018 07:24:59 -0800
Message-Id: <1541431515-25197-3-git-send-email-frowand.list@gmail.com>
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

The refcount of a newly added overlay node decrements to one
(instead of zero) when the overlay changeset is destroyed.  This
change will cause the final decrement be to zero.

After applying this patch, new validation warnings will be
reported from the devicetree unittest during boot due to
a pre-existing devicetree bug.  The warnings will be similar to:

  OF: ERROR: memory leak before free overlay changeset,  /testcase-data/overlay-node/test-bus/test-unittest4

This pre-existing devicetree bug will also trigger a WARN_ONCE() from
refcount_sub_and_test_checked() when an overlay changeset is
destroyed without having first been applied.  This scenario occurs
when an error in the overlay is detected during the overlay changeset
creation:

  WARNING: CPU: 0 PID: 1 at lib/refcount.c:187 refcount_sub_and_test_checked+0xa8/0xbc
  refcount_t: underflow; use-after-free.

  (unwind_backtrace) from (show_stack+0x10/0x14)
  (show_stack) from (dump_stack+0x6c/0x8c)
  (dump_stack) from (__warn+0xdc/0x104)
  (__warn) from (warn_slowpath_fmt+0x44/0x6c)
  (warn_slowpath_fmt) from (refcount_sub_and_test_checked+0xa8/0xbc)
  (refcount_sub_and_test_checked) from (kobject_put+0x24/0x208)
  (kobject_put) from (of_changeset_destroy+0x2c/0xb4)
  (of_changeset_destroy) from (free_overlay_changeset+0x1c/0x9c)
  (free_overlay_changeset) from (of_overlay_remove+0x284/0x2cc)
  (of_overlay_remove) from (of_unittest_apply_revert_overlay_check.constprop.4+0xf8/0x1e8)
  (of_unittest_apply_revert_overlay_check.constprop.4) from (of_unittest_overlay+0x960/0xed8)
  (of_unittest_overlay) from (of_unittest+0x1cc4/0x2138)
  (of_unittest) from (do_one_initcall+0x4c/0x28c)
  (do_one_initcall) from (kernel_init_freeable+0x29c/0x378)
  (kernel_init_freeable) from (kernel_init+0x8/0x110)
  (kernel_init) from (ret_from_fork+0x14/0x2c)

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index f5fc8859a7ee..7613f7d680c7 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -379,7 +379,9 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
 		if (ret)
 			return ret;
 
-		return build_changeset_next_level(ovcs, tchild, node);
+		ret = build_changeset_next_level(ovcs, tchild, node);
+		of_node_put(tchild);
+		return ret;
 	}
 
 	if (node->phandle && tchild->phandle)
-- 
Frank Rowand <frank.rowand@sony.com>

