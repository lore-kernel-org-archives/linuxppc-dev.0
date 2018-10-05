Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 005BEC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 04:17:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E7C20875
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 04:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jchEl9i7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E7C20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RGgX6hTpzF3Fb
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 14:17:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jchEl9i7";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="jchEl9i7"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RGbp1y8DzF3CC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 14:14:13 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id f8-v6so6192943plb.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Oct 2018 21:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=P/Y9bvgGzwc+7OPQmwq1eQQ7GH+jizDXrOBIo1holL0=;
 b=jchEl9i7tkhaKGejLemSwO/uEpqGM8uJDt6WbxcDVPy1VHxOUhgwIoVj0Gw6OkswL1
 R4MkIif67McNLS2fJjjhqwyWlMZ63guKyYk6nyrAEm3T4nar6nKd++6THYDiU0aoEUWx
 rlU/Tq9HqGoM5yePd2nQb98z28Hk4d9NRMeCOslw8Bt5IjIGpeKPt7yW6r3PqVPlKLZm
 /fB06WeQwwm1q32sWO/dY5MLbMoBmjPI6ZZuHgDkWfhURz4DcwTiGqjFHw6LPLXmTqnc
 xxVA6s1HEbnOTY/JeWZzogak1myXiqAU49Ibi5xlyqk7IvRqFNSyieCD5IEtDwBT5yiQ
 VOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=P/Y9bvgGzwc+7OPQmwq1eQQ7GH+jizDXrOBIo1holL0=;
 b=JFUocbY30et3pZlhEjfkNCzI/HBw5xuFoBlRVWUHF4LvwL3BsC7zDoDpt8lUSkq9e9
 ueg8qq6GLP091i9aE+by/1IiJlMsOMfjrnuZSPEEtxgMajpcw7V+BuKxvZKnzpswjDil
 z5UfSt8Baf9rwGIG8tfQKctEpKcfX4V75tGj949EcLuARPpukiuArzdsv7mMb5VpLnGm
 Mkq+acrk+yMJYZxOxQF8WEhzSH2BUu+ldGv8W5ucMl2ttOi7/CPRuI4eUbv7qEYFAvdn
 0VQKbGir6t82VmptfglK7s/p61wv4SHJiVLzwlSWUydjdtGJIH+lQtjSI94XfFibByc9
 Wxwg==
X-Gm-Message-State: ABuFfojP5SetcD7ZJgviukiiEQur5ebhhYE6ozsoXRwp4h38vBwJJCjA
 bvBnj+kS+KHFgF/feVvK5tI=
X-Google-Smtp-Source: ACcGV60dd0wBzBHDEaScjAbTqYrFdd+qbpvZ4uV0Dt8lcg16sM1ZFP1/qlufci3WFO+oMmtOuPW3vQ==
X-Received: by 2002:a17:902:4381:: with SMTP id
 j1-v6mr9475704pld.59.1538712852040; 
 Thu, 04 Oct 2018 21:14:12 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id n63-v6sm277975pfn.9.2018.10.04.21.14.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 04 Oct 2018 21:14:11 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 00/16] of: overlay: validation checks, subsequent fixes
Date: Thu,  4 Oct 2018 21:12:31 -0700
Message-Id: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
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
Cc: devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Frank Rowand <frank.rowand@sony.com>

Add checks to (1) overlay apply process and (2) memory freeing
triggered by overlay release.  The checks are intended to detect
possible memory leaks and invalid overlays.

The checks revealed bugs in existing code.  Fixed the bugs.

While fixing bugs, noted other issues, which are fixed in
separate patches.

*****  Powerpc folks: I was not able to test the patches that
*****  directly impact Powerpc systems that use dynamic
*****  devicetree.  Please review that code carefully and
*****  test.  The specific patches are: 03/16, 04/16, 07/16

FPGA folks:

  I made the validation checks that should result in an
  invalid live devicetree report "ERROR" and cause the overlay apply
  to fail.

  I made the memory leak validation tests report "WARNING" and allow
  the overlay apply to complete successfully.  Please let me know
  if you encounter the warnings.  There are at least two paths
  forward to deal with the cases that trigger the warning: (1) change
  the warning to an error and fail the overlay apply, or (2) find a
  way to detect the potential memory leaks and free the memory
  appropriately.

ALL people:

  The validations do _not_ address another major concern I have with
  releasing overlays, which is use after free errors.

Frank Rowand (16):
  of: overlay: add tests to validate kfrees from overlay removal
  of: overlay: add missing of_node_put() after add new node to changeset
  of: overlay: add missing of_node_get() in __of_attach_node_sysfs
  powerpc/pseries: add of_node_put() in dlpar_detach_node()
  of: overlay: use prop add changeset entry for property in new nodes
  of: overlay: do not duplicate properties from overlay for new nodes
  of: dynamic: change type of of_{at,de}tach_node() to void
  of: overlay: reorder fields in struct fragment
  of: overlay: validate overlay properties #address-cells and
    #size-cells
  of: overlay: make all pr_debug() and pr_err() messages unique
  of: overlay: test case of two fragments adding same node
  of: overlay: check prevents multiple fragments add or delete same node
  of: overlay: check prevents multiple fragments touching same property
  of: unittest: remove unused of_unittest_apply_overlay() argument
  of: unittest: initialize args before calling of_irq_parse_one()
  of: unittest: find overlays[] entry by name instead of index

 arch/powerpc/platforms/pseries/dlpar.c             |  15 +-
 arch/powerpc/platforms/pseries/reconfig.c          |   6 +-
 drivers/of/dynamic.c                               |  41 +++-
 drivers/of/kobj.c                                  |   4 +-
 drivers/of/overlay.c                               | 271 ++++++++++++++++-----
 drivers/of/unittest-data/Makefile                  |   2 +
 .../of/unittest-data/overlay_bad_add_dup_node.dts  |  28 +++
 .../of/unittest-data/overlay_bad_add_dup_prop.dts  |  24 ++
 drivers/of/unittest-data/overlay_base.dts          |   1 +
 drivers/of/unittest.c                              |  43 +++-
 include/linux/of.h                                 |  19 +-
 11 files changed, 353 insertions(+), 101 deletions(-)
 create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_node.dts
 create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_prop.dts

-- 
Frank Rowand <frank.rowand@sony.com>

