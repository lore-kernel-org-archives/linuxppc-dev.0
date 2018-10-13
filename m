Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5366DC28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 05:03:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B25FA2087D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 05:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MydkuL+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B25FA2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XCJQ6ngYzF3VG
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 16:03:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MydkuL+k";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::641; helo=mail-pl1-x641.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="MydkuL+k"; 
 dkim-atps=neutral
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XC7J5LZzzF3Kn
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Oct 2018 15:55:08 +1100 (AEDT)
Received: by mail-pl1-x641.google.com with SMTP id w14-v6so6817111plp.6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 21:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=6jwtNAKUA0bImQ+OzjBieSYaakSLUGtiTllRPSG9WlA=;
 b=MydkuL+kvbcHS1s2I/c5iiBymR1vJcXEfrx9eRB6MsqaqBlxpv77t1V31NVXbg1+Q2
 cBsw95pb83+KDWFQ/sVdbH9dNaBhnQEZJoeKR8j5RJ6CGXLyAkfPAoLfwtH6cv7F4mbV
 AkV/BMca5jxzMvSUe5pSB9p866bzhxxnstDmizSIB8CFotOaj5uggnURBA1UCzmq2DQM
 mBTzHABgnBLG/r78RD3iKc3483a1p1kCFRE5Nqtoy+7wPBKukYzwNpJAKvcf7hUQ/ejH
 eDBCNik1FszHiK7qaqH1V/SHTRmGUqC4N0wO7w6P7l8aWLrc03JqrAFD/Btu3FX540Kr
 fBkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=6jwtNAKUA0bImQ+OzjBieSYaakSLUGtiTllRPSG9WlA=;
 b=FfE4KMTatIfTc0G4rkl1Rvvcrf6Lza3HdrPs4+zqu8Sfs+PTbb/rv06ID91Ede6ozk
 2adQdvZQTaRsV5beJa94D9UAEQVJYYhgSJ0HaarYmzKiy5fugHYTLSLcXKirdwqbJet8
 NRt+/G4RK6PV8EM138bZPYBNVdiW7TSA8DmRiFt5nis4aFwOHfNmcMqS88Eu0Bfjh4eO
 FWCFdGLiq1kaos2qXXVOPsO3GSJnaNfjMQNFnD/oJXvYRlhM5yEr2z4OYXCAjYUp7RzF
 RBLG6V7oWuYiag07szVK+FrVb5+0VrBUQNDFbhV3ffwU4DOAVO3Sh+3+yNm6zDgmmJlm
 jaBQ==
X-Gm-Message-State: ABuFfoiAeekiGZqeNsevEAc+rkooLm10I6UAfNCZwcrU/zcYWvCoQNg4
 KDfFmigJhWsIdnvcTW2S0uU=
X-Google-Smtp-Source: ACcGV60ogMqaNuCx7/IRfcjG5cSWNSMtzhQHNelsFGhuzfo5VZv6KdpnFX7NYhjQJVM4Y9Le8Obo+Q==
X-Received: by 2002:a17:902:5a4d:: with SMTP id
 f13-v6mr2083052plm.114.1539406507004; 
 Fri, 12 Oct 2018 21:55:07 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id h87-v6sm6959462pfj.78.2018.10.12.21.55.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 12 Oct 2018 21:55:06 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v2 02/18] of: overlay: add missing of_node_put() after add new
 node to changeset
Date: Fri, 12 Oct 2018 21:53:22 -0700
Message-Id: <1539406418-18162-3-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
References: <1539406418-18162-1-git-send-email-frowand.list@gmail.com>
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

  OF: ERROR: memory leak of_node_release() overlay node /testcase-data/overlay-node/test-bus/test-unittest4 before free overlay changeset

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

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 1176cb4b6e4e..32cfee68f2e3 100644
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

