Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B626AC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 19:57:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D0F82184C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 19:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lP/NX9sW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0F82184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43K8231nwrzDqMd
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 06:57:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lP/NX9sW";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="lP/NX9sW"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43K7fK4fDDzDqNH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 06:40:24 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id i12so8604274pfo.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 11:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=TUW7JqMm/20Ve1m4CrpEQUQb3YihKsE0PnwO35c3oY4=;
 b=lP/NX9sW5V/T1Si/tQftCb0yJ6lVyUpwU06O2dM04fXoIZITq3AUBggPdVe8p9KZ6r
 HozC783vaxcpI2UguP6uUwejtf9gqNCL5gRLHfhVrV69Pg5cKhwceJH9BXN1sQadBYfZ
 UcnBHjATQ89X6VglXhMg72II+A/W+ZBUrqjZs/lPKTEcWY5P+Pi1o5mFfoPyo5OOhiW3
 3BqQ0aTPA1OZqTwn8zC+FnS22Kdg+X3N3YkLEIgt0RmsW8/7/YQqZqpwAja+ZpHK+hwz
 pvgneHjOz0d3RcI11WXS5G7IoHkBLCbm0V6HQc1tpdSwqn5bz9nR8I2Rg0aE/vy+mzWZ
 hmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=TUW7JqMm/20Ve1m4CrpEQUQb3YihKsE0PnwO35c3oY4=;
 b=Kus+RQAadRpEC3D2AYhDywvSA/JkW8lBgkoQQXZQvcL1H9bZyyrQxf7tlaKdeV5Bmi
 IiFUHHu++qs4tjmF/hvEu/aQ+7DiWf86qNmLHlCcyqN0RzlaUNlxrU3S+NU5Yw6n9TQ6
 XGr1Ae6e96ofCVWt2kYtG0srRWW6CghxOzXcSn5+ZyiR5qj5l5e+zGe9LbzjJ5ybs0gV
 zgjWoHsgRds8jch8VteQ1AvVkvEKv/JA9wpsd3GgmTa58nicJgCFWB3oRDauacw6m0Fd
 D6FCMMFCWjI3SY3R+d65SR19QrbrHURX9z76JmE/57VhUkiovk6K9jCgjGMyO9s/Mk9a
 +SKw==
X-Gm-Message-State: AA+aEWb5LYuY7hyNSz7pNy1c/Ea3daslSng1LH+tSCf4BGJ6f59sQSiP
 CTh1J3PXI+bf6jEXBQX3UuK/J+au
X-Google-Smtp-Source: AFSGD/XG1c7tF/edMTT9V+SwV6crMZ3Y8dH6GPUw9//UJzH1/n3tsTrBJB79R6KGZgi1OOR2Jgt/CA==
X-Received: by 2002:a62:1043:: with SMTP id y64mr18117460pfi.78.1545162023096; 
 Tue, 18 Dec 2018 11:40:23 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id b202sm29493069pfb.88.2018.12.18.11.40.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 18 Dec 2018 11:40:22 -0800 (PST)
From: frowand.list@gmail.com
To: robh+dt@kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 0/2] of: phandle_cache, fix refcounts, remove stale entry
Date: Tue, 18 Dec 2018 11:40:01 -0800
Message-Id: <1545162003-11577-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
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
Cc: devicetree@vger.kernel.org, Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, Juliet Kim <minkim@us.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Frank Rowand <frank.rowand@sony.com>

Non-overlay dynamic devicetree node removal may leave the node in
the phandle cache.  Subsequent calls to of_find_node_by_phandle()
will incorrectly find the stale entry.  This bug exposed the foloowing
phandle cache refcount bug.

The refcount of phandle_cache entries is not incremented while in
the cache, allowing use after free error after kfree() of the
cached entry.

Changes since v2:
  - patch 2/2: add temporary variable np in __of_free_phandle_cache_entry()
    to improve readability
  - patch 2/2: explain reason for WARN_ON() in comment
  - patch 2/2: add Fixes tag in patch comment

Changes since v1:
  - make __of_free_phandle_cache() static
  - add WARN_ON(1) for unexpected condition in of_find_node_by_phandle()
  
Frank Rowand (2):
  of: of_node_get()/of_node_put() nodes held in phandle cache
  of: __of_detach_node() - remove node from phandle cache

 drivers/of/base.c       | 101 ++++++++++++++++++++++++++++++++++++------------
 drivers/of/dynamic.c    |   3 ++
 drivers/of/of_private.h |   4 ++
 3 files changed, 83 insertions(+), 25 deletions(-)

-- 
Frank Rowand <frank.rowand@sony.com>

