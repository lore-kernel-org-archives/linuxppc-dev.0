Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607DEC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 04:31:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC3B620834
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 04:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Txvvydwn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3B620834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RH0C4B78zF3K7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 14:31:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Txvvydwn";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Txvvydwn"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RGbx6LvNzF3Fl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 14:14:21 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id m77-v6so4425731pfi.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Oct 2018 21:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TSvuFcg8dSVKckHCq64beWOdH/WxX+9HQwnn/E0dljs=;
 b=Txvvydwn/k63hOxYlZwYdwaQIAjsth2Jaw4zbDNdTvqPzUBK/bEWuzmAxECzPr/rYB
 5ee7eBaNw1FbEYKkJ4M/WHi1t1nNCDk5vVrtbTuzDmVpBWywMHZMCbtMkyDjKD+IEShv
 Fshm8YpT/NObVTDG3rnXVe9X1gblxeezdCDtpJNZ6XLbQc01eR7O2FLjyBGIcN4G6a+V
 WHIFJ4Mp/4B0eZ2NxalIRlvpGQaQx8112Pd0FQJX3TymYYILDXlRQ1T4QgysP/e8XVsX
 dikNHoa/BUjMAwOGD35MjuM2ynoK/ZjKzfpqn+GqHfMZZUmhddS/DuBQPxc4FUro5AW8
 rA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=TSvuFcg8dSVKckHCq64beWOdH/WxX+9HQwnn/E0dljs=;
 b=bbyCXjpwxZWRa7X/kRdziy2JLNnaUVaC8Wru0lKipE08gELvCMh7VVTb/1MzINxV0R
 P4R/L2gT+xf5CLZBbT2fHdxiY2BlBW7KYny8HScaClvrzlCfS6avCo2bhmDeJWHegqeN
 giRgsg5ccNYcj32whtnNmQCGPOoPi3MKoFSk58zXLYhRRbitk5Km5BWbP3zc7KOiy3Zi
 zGjZhwhlB+Ec6U21h5/fkQajN450IM8W7AQ2/xz22PKEbcLkh1MJDkxhcg7KorqntPo4
 hm6UBxmW91f5oBorh2tEYY2DfDrjPWA87Nc6H+1yqLlBUCmm3m74LkM/hzHfoLVnCXO/
 rogw==
X-Gm-Message-State: ABuFfohv8m9cnqtQh9z9vT5+zzwwEaaPUccUOgzpgSHecUmqZy760nBN
 edKqLRwGzLTuBYub6VSDbTs=
X-Google-Smtp-Source: ACcGV60Nq66DYWpjLNnNkOqwngvmQOK1t9t7z+KD3D9MvbeI/Z+r0dGjkV540jzK0as9aN/rEEhBDw==
X-Received: by 2002:a63:eb07:: with SMTP id
 t7-v6mr8409158pgh.441.1538712859586; 
 Thu, 04 Oct 2018 21:14:19 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id n63-v6sm277975pfn.9.2018.10.04.21.14.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 04 Oct 2018 21:14:19 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 06/16] of: overlay: do not duplicate properties from overlay
 for new nodes
Date: Thu,  4 Oct 2018 21:12:37 -0700
Message-Id: <1538712767-30394-7-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
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

When allocating a new node, add_changeset_node() was duplicating the
properties from the respective node in the overlay instead of
allocating a node with no properties.

When this patch is applied the errors reported by the devictree
unittest from patch "of: overlay: add tests to validate kfrees from
overlay removal" will no longer occur.  These error messages are of
the form:

   "OF: ERROR: ..."

and the unittest results will change from:

   ### dt-test ### end of unittest - 203 passed, 7 failed

to

   ### dt-test ### end of unittest - 210 passed, 0 failed

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/overlay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 0b0904f44bc7..c113186e222c 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -393,7 +393,7 @@ static int add_changeset_node(struct overlay_changeset *ovcs,
 			break;
 
 	if (!tchild) {
-		tchild = __of_node_dup(node, node_kbasename);
+		tchild = __of_node_dup(NULL, node_kbasename);
 		if (!tchild)
 			return -ENOMEM;
 
-- 
Frank Rowand <frank.rowand@sony.com>

