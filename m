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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6295EC0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 15:39:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C41902085A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 15:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMytgoQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41902085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pcKq68L5zF1RB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 02:39:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mMytgoQ+";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="mMytgoQ+"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pc3l2YjqzDrJP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 02:26:59 +1100 (AEDT)
Received: by mail-pg1-x544.google.com with SMTP id w3-v6so4367211pgs.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Nov 2018 07:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Xmf2+4FWEijlIl5vfn4kRuEeTCFhKbTHKq/ZS3i4VVc=;
 b=mMytgoQ+feOD4pXKV7Q0BG2xGIob9XjLF69CozYMPGeEVDYR21ZYZL/AF/SHhA18lV
 lg6J1Sl/mLwgPwuPQ3//6M2VqZ84zYiLYKDtyQQmgUpMDNEYvpGn4/xxPreY1IeF/UMp
 PWDQ+wI5LNYon8VZttDpd8+jNFihUJuAFbQ9LYojXBxpprH9PoMt+znhsIiyHHssqLpV
 0sRF5Z/fTA7MnV7MT+pF2yI1KacsbyCVnyWyVn+rPIXOa1PeJ9yYALWkeMtVYeL5htAS
 sonArD5Jrlv8wALrCbzCT7Z9KLa9q20oB4hOQgR5vuDszDIPGNdVh/ECdwepvycdbzkx
 gtcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Xmf2+4FWEijlIl5vfn4kRuEeTCFhKbTHKq/ZS3i4VVc=;
 b=iJBtEg6sZRKXLCDwbz35P6lQkE+GXKH34NoFbt9E9Xh6VvBtaIpLDAiKdteMCyHLeK
 8v+gjmoYcIZ6VL7MrNI1vraXAN+P58TwxKA0dWuPOllZKkfq30XDtKUqbYy84ccYXsYx
 lK4U6D0V3jKZAi9S0PnffDbbZa8TPux/kb45XWa2qvy4765kPkFEjv9jV3KkEgdH8F0j
 s0Rzgx1vmRNMSBGWVRz8FSPdx9oGJ9C07HBUxu8wvUAw3sjGysqzBMkuNXGnx/k/MQTZ
 9C9qvWgOB+3RnXsbkk2cKKaYcqdvQ+uq/YoOycqdEW8fuKqmq5gTX6u3HvosuMESJpyF
 TRpQ==
X-Gm-Message-State: AGRZ1gKxRxjDRvyEE2Gtgg2P+B+ElRSw7tt74gzhet6SymD69j7qgT+K
 GTUoq1AEblW+MH/CgxhROAE=
X-Google-Smtp-Source: AJdET5esmi2VWzhsDDLO+BkRwznlxVGW+PVMUFk7YPTwOMh9KjI2XzSAo1JOI3PK2rcMeX0a3YnHkg==
X-Received: by 2002:a62:3501:: with SMTP id
 c1-v6mr7008011pfa.173.1541431617720; 
 Mon, 05 Nov 2018 07:26:57 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id u76-v6sm37260578pfa.176.2018.11.05.07.26.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Mon, 05 Nov 2018 07:26:57 -0800 (PST)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v6 04/18] powerpc/pseries: add of_node_put() in
 dlpar_detach_node()
Date: Mon,  5 Nov 2018 07:25:01 -0800
Message-Id: <1541431515-25197-5-git-send-email-frowand.list@gmail.com>
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

"of: overlay: add missing of_node_get() in __of_attach_node_sysfs"
added a missing of_node_get() to __of_attach_node_sysfs().  This
results in a refcount imbalance for nodes attached with
dlpar_attach_node().  The calling sequence from dlpar_attach_node()
to __of_attach_node_sysfs() is:

   dlpar_attach_node()
      of_attach_node()
         __of_attach_node_sysfs()

Tested-by: Alan Tull <atull@kernel.org>
Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---

***** UNTESTED.  I need people with the affected PowerPC systems
*****            (systems that dynamically allocate and deallocate
*****            devicetree nodes) to test this patch.

 arch/powerpc/platforms/pseries/dlpar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index 7625546caefd..17958043e7f7 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -270,6 +270,8 @@ int dlpar_detach_node(struct device_node *dn)
 	if (rc)
 		return rc;
 
+	of_node_put(dn);
+
 	return 0;
 }
 
-- 
Frank Rowand <frank.rowand@sony.com>

