Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F751C67839
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 06:45:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 456AD204FD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 06:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ak48fdZD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 456AD204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GLf95Y8rzDqyb
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 17:45:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ak48fdZD";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ak48fdZD"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GLbK4MM3zDqvH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 17:43:09 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id z23so2281497plo.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2018 22:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=gA0jjFvqXawpO1c/FWHMHxoWZzQrmYYLnCnbfaTehzE=;
 b=Ak48fdZDPscI3Qhx1DAK4DG/Lv8F46+49EEd8YjVksMlMauCCPTaYSBM45NGUzJeBT
 fEj0EvnQijn9j0KNnphonzZPYmanio3BGJOlEAqDCUTKGscMeFZlwnS6ndzkbgfq441G
 wXMhRqOcyDEOo6yrb9vYuxIuJY4t5WK+OyVsVVh1haJ3JXysr1HP6G1p2Gf+GBtuuRjd
 xBMEDz6w9yy8o3+M+5bPFCoeQVk4RfYFr6KJIlCoi6X2si/PxuYrupKCJr0X7aW6as/X
 baLrv5PEGH2jgqmvn2eAJEUq6LOQQL4RsB6koyaqSs9YvQVxIhUhypzkR2SIz2fgDGBt
 8bWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=gA0jjFvqXawpO1c/FWHMHxoWZzQrmYYLnCnbfaTehzE=;
 b=MyoqB7pMKIfwiDNoZn7f6T5V0lL2knbNC+TSgiUEHd5pZeQG2rWA+RRgTwRCgga9eW
 C95TzDQDp6apn3bYhcX6zMRNgyjLFGPyj88vAyjX21Oqj3roB4XGAvuVvM1LsxfVK1Zb
 snc/sP+AmoXK0b+kFZ2EBKjwIa59Tp1+QbhqB7hsSXZvHT/Z0/ZwJxLSXAod9BlF8g5d
 GJmmGSgZQPluiGZ9g9ahZmVSI3ZezkbBCy5S1dJ+JFX9pyFQCTrcjWImolF63VjFHaUR
 K339aTCAoCWQ4WXRhJE7IObDV8SwaceYws2PnXLDqKsb15KMYS3hkaic2j8gmWEoVNkg
 u27g==
X-Gm-Message-State: AA+aEWYExZVWJr15Q1iay4QluX+UXTXQvIs6n7J9hciVuPyssPFZiBAQ
 lY9uFuBdg5J9HvI7idVXyxs=
X-Google-Smtp-Source: AFSGD/Uzums1zq7oRmh4e5OOMk9lMXexedYaD0dtu3Fhpcn4gwhDe8IpveS0B0EwIHtUdalwzQyNCA==
X-Received: by 2002:a17:902:9a4c:: with SMTP id
 x12mr1762839plv.94.1544769787653; 
 Thu, 13 Dec 2018 22:43:07 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id e16sm5132645pfn.46.2018.12.13.22.43.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 13 Dec 2018 22:43:06 -0800 (PST)
From: frowand.list@gmail.com
To: robh+dt@kernel.org, Michael Bringmann <mwb@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/2] of: phandle_cache, fix refcounts, remove stale entry
Date: Thu, 13 Dec 2018 22:42:49 -0800
Message-Id: <1544769771-5468-1-git-send-email-frowand.list@gmail.com>
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

Frank Rowand (2):
  of: of_node_get()/of_node_put() nodes held in phandle cache
  of: __of_detach_node() - remove node from phandle cache

 drivers/of/base.c       | 99 ++++++++++++++++++++++++++++++++++++-------------
 drivers/of/dynamic.c    |  3 ++
 drivers/of/of_private.h |  4 ++
 3 files changed, 81 insertions(+), 25 deletions(-)

-- 
Frank Rowand <frank.rowand@sony.com>

