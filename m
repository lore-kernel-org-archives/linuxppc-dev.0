Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65809C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 07:59:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94550204FD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 07:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syU1Hdqz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94550204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JD7z1pRGzDqcg
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 18:59:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="syU1Hdqz";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="syU1Hdqz"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JD540tH7zDqZQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 18:56:55 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id m1so4086300pgq.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Dec 2018 23:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=NWLPnNlHrvA2ehDLVEPouumgN3Xl/PWww3ilC7E/OyM=;
 b=syU1Hdqzs+6w7Cz4C1eaj3H8xojzO9kkmJ7WLGxaibg6CkG9dcfwyuJcddMjudA1dj
 vtTHHbWgKBmhhnhGIJL4vTLHQCUmpENSIidAJZzLbGDcDS7lEpQ2tyCGiwmMVXqVSfJQ
 ZXHuK9AlddjqY0q3ThbN/rlznJIEmcoClTVVrDYEJN5J8lJJ5RG0YG66QV0cJkCaImKe
 C23/DTGG9zZbudnNEtubNRubjV1vtpWPyvkAHw3GVuvD1fF+REaePF0dSvlzgcbGtOAg
 KVgTD0/XpQuIIOxnm2Efqone4ZsQxN9xnw8Rt8jDWveHndzmjHzqiEA3zjYmrPJX02Vx
 zovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=NWLPnNlHrvA2ehDLVEPouumgN3Xl/PWww3ilC7E/OyM=;
 b=NLovwzBsOZrNF75yz/29BSVvw+7KfYJ7KK22Z3fLqta0BoZGRVEo1rHEjDj9pB8TIa
 FUOhCtgAvPZWT16OQrHnq+Fs2ZKG6+A7tBElN1iV2WqUD1cqNpOguT8EI3ueXbZkGTSB
 RnVlewStZZci5IP3Xzo1CeCJIdE0naihDIN4kAPncvN4IdWfcpqgOwq134+sO1AwGYPq
 SlmopIYv+Q1ItHzL0ibCGalBrGBmxvgmddQ2oUWgj/gy4REeHF1zHWJL2vr04zDHzKkI
 EkRUAdwdZYt6ETGn1SV0RQR5pR6OTVJNYYsHNN4sttW14yvuo3qyD5DEo3iv3v2R3iH/
 LUAg==
X-Gm-Message-State: AA+aEWa1he976oA/wT/Ya1b4uEom/BdVAIlqGSyQNXhm+W+rWrzApDOA
 oxUyz6ySfuOBDN0wR/idG9I=
X-Google-Smtp-Source: AFSGD/VJKRla6hz4SjCQHjQpp8LyQliqHcHwFd07BWwBNKQDP4JLjte2czE6YFO2c/dhAqQC6MX0YA==
X-Received: by 2002:a63:df13:: with SMTP id u19mr11346510pgg.294.1545033413247; 
 Sun, 16 Dec 2018 23:56:53 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id r8sm14216610pgr.48.2018.12.16.23.56.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 16 Dec 2018 23:56:52 -0800 (PST)
From: frowand.list@gmail.com
To: robh+dt@kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/2] of: phandle_cache, fix refcounts, remove stale entry
Date: Sun, 16 Dec 2018 23:56:34 -0800
Message-Id: <1545033396-24485-1-git-send-email-frowand.list@gmail.com>
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

Changes since v1:
  - make __of_free_phandle_cache() static
  - add WARN_ON(1) for unexpected condition in of_find_node_by_phandle()
  
Frank Rowand (2):
  of: of_node_get()/of_node_put() nodes held in phandle cache
  of: __of_detach_node() - remove node from phandle cache

 drivers/of/base.c       | 100 ++++++++++++++++++++++++++++++++++++------------
 drivers/of/dynamic.c    |   3 ++
 drivers/of/of_private.h |   4 ++
 3 files changed, 82 insertions(+), 25 deletions(-)

-- 
Frank Rowand <frank.rowand@sony.com>

