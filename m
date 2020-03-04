Return-Path: <SRS0=d5Dh=4V=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD65C3F2D1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2020 08:52:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA022166E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2020 08:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pu1LyzfN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA022166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48XSLX0jthzDqW7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2020 19:52:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d;
 helo=mail-pl1-x62d.google.com; envelope-from=kernelfans@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=pu1LyzfN; dkim-atps=neutral
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48XSJC6np0zDqLj
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2020 19:50:17 +1100 (AEDT)
Received: by mail-pl1-x62d.google.com with SMTP id x17so714767plm.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2020 00:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=woJvO5E8fpJd4Q5CNOWhDsXW01yY8MLHyUaA7/jn7L4=;
 b=pu1LyzfNlpYzzHymyQuajEB74i2lHX8Mpq9rMdimauTbQ+i1tjPg/y+r3eEDpkIM9G
 O+3eb3tKIQN6wFbpXqhzxbbsD3A8mz5GBC09X8HWyBWGYQiQXHYX8e6CfRLlSKmvr5/u
 dOcWD9lFIZZz1kdr/9W95dIbYHhEZJ8XUFpS65GSR7pYSIxsleLOYNOTA4IiDWSHJ99M
 pSkYyxSylco/8a8uZ3qFLQLdLr/CJc1x/Yg+B8XQ97Ps9rrAmEenRm46n9RBiisIGdEn
 /IKJWOzvVCG1mtB2yLuBN5uHwaOz9dtlMqpClJmvk+Qf6K0tjf5sTM2PRLrDmsUe5mod
 thCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=woJvO5E8fpJd4Q5CNOWhDsXW01yY8MLHyUaA7/jn7L4=;
 b=puYQR2W5hgxXUlNJ2SEgsuZB5U0D9+VHgFQ7QuW5BvMfjL94rNzaIjwVDMOT5p+U3k
 mjMGS68IqTFocpfuyr80dPLWK8Whtbg/xz5kFIVSYY+XWE0zUPBIpln2ZsHHANQ87jzm
 MGJqtQpdyLibLGZakHeSwP+BLYq6pIBRygb6G4+bLsXli6Ot2sw53nRxyMl8WLx6mXR2
 sdzMFZqKcDztGGDf10gtnPzC6vMbz3sbyPvBH8n3CLzBcKP6T6JwuuSoHy61CaA7XKAb
 BT7tIWvBFooeoxASIlU6SbKZevAalTBcc6qHkzJ38aqwS0l1AqFA5WSyYVzFyq7jh7Xd
 /ssA==
X-Gm-Message-State: ANhLgQ3My1+68JNyE42ZLkTgF/jIV/AJ3U0TfqfbzY/L0w3PwxfbC7Xg
 ii0Jbp4g+BvHdRmp/8DnKbUTEBY=
X-Google-Smtp-Source: ADFU+vt8VxQR7hpj3VOexVfbtnLYfwkksuVYM4nJGhYVwbz4PwS8vVumrMrIQErowUuuVIfmYcMmkw==
X-Received: by 2002:a17:902:9890:: with SMTP id
 s16mr2016577plp.77.1583311814491; 
 Wed, 04 Mar 2020 00:50:14 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id v123sm463085pfb.85.2020.03.04.00.50.09
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 04 Mar 2020 00:50:14 -0800 (PST)
From: Pingfan Liu <kernelfans@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCHv3 0/2] pseries/scm: buffer pmem's bound addr in dt for kexec
 kernel
Date: Wed,  4 Mar 2020 16:47:28 +0800
Message-Id: <1583311651-29310-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1582882895-3142-1-git-send-email-kernelfans@gmail.com>
References: <1582882895-3142-1-git-send-email-kernelfans@gmail.com>
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
Cc: Andrew Donnellan <ajd@linux.ibm.com>, kexec@lists.infradead.org,
 Pingfan Liu <kernelfans@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Dan Williams <dan.j.williams@intel.com>,
 Frank Rowand <frowand.list@gmail.com>, Hari Bathini <hbathini@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

V2 -> V3:
   in [2/2], EXPORT_SYMBOL(new_property) and EXPORT_SYMBOL_GPL(of_add_property)

To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Oliver O'Halloran <oohall@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Donnellan <ajd@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: kexec@lists.infradead.org

Pingfan Liu (2):
  powerpc/of: split out new_property() for reusing
  pseries/scm: buffer pmem's bound addr in dt for kexec kernel

 arch/powerpc/platforms/pseries/of_helpers.c | 29 +++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/of_helpers.h |  3 +++
 arch/powerpc/platforms/pseries/papr_scm.c   | 33 ++++++++++++++++++++---------
 arch/powerpc/platforms/pseries/reconfig.c   | 26 -----------------------
 drivers/of/base.c                           |  1 +
 5 files changed, 56 insertions(+), 36 deletions(-)

-- 
2.7.5

