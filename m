Return-Path: <SRS0=4MsH=NU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4383EC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 06:11:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7458C2086C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 06:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VajyWENW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7458C2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rqXZ3SHKzF3X7
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Nov 2018 17:11:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VajyWENW";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="VajyWENW"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rqSf4TdnzF3Wd
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Nov 2018 17:07:46 +1100 (AEDT)
Received: by mail-pg1-x542.google.com with SMTP id w3-v6so395249pgs.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Nov 2018 22:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=79i22JUyVLOfuuR8WUkDKY87eLaLzqp9WcRkjfo7ANg=;
 b=VajyWENWqlTq91fpxUnnqu480vt6YSrJcLN4mm3aJqg4E/mFtMdJvXW0ZvoX54Bt0d
 YKNYSWHxPDIw6zKt0DB7cBec5ISIS/TSA9onO12KK9mGxjZTY/78KcibZLcz1CkZAYDO
 ig6r03ScKFtpwczaiIhakiuX8lyF+zbx/BOrwGsUHWTU5ULMG9J3+kX0vL/g2QWh6Eq9
 16FypJmxG1YLfdA2j/sek0TN275LJyD2rmJNlgmrV/R3eKWRKXCHQ9TuLaVN+xJj9gqc
 wYXcHa1qXIrZsfoDlcYIfZyoh7l3IfKhM7a/jVCAW8TmKKWAi3UcbXHtBxQfEdJ0Rklc
 birQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=79i22JUyVLOfuuR8WUkDKY87eLaLzqp9WcRkjfo7ANg=;
 b=Lt9gbnRyhUHfdVcrnLUkvnG2zoI7Jdn1lJhQAd/YT3bzvqi8YL3aDT7oXNGh2AcfE/
 n00blD2o8hdjfKhHxo5bj4NeXyXtKyr8d+Jd+kmHkkQWUIiBiXA0tR0xUoFvAUqaeJOl
 ZtF3bilX8qGRxbPnRlcSBW76sbOOV99PE6zr33oF/ZFEgdTx8LIYDuQDO4i57ZJthec2
 dB5fRFPPXnbUBO2Fp05Vftt/RIgrTOy4OlJVy4GtQRfOS/HHGDiDKTHntrgb4JtlmOg/
 j0oSyDJ7K4SQcdnsUF6+miS0MH+Z6YosrGowwj4VGFSvKVN0R1Fs9bEcObITk+5owMy3
 XXBQ==
X-Gm-Message-State: AGRZ1gJKwhG4IyvSlSeVKMvcLM1d+CQJI8h6ko4fqr1R4gWJnpUAgnhH
 2f/e9SFVXSE4f379aGulCsM=
X-Google-Smtp-Source: AJdET5fJdYO3GAfQ/Z/wHohJ2vzI4rYpjr5Qko8sGiSy/bxJLZHrq29FZLddGUnk4GpgqtTc9kNKmA==
X-Received: by 2002:a63:8549:: with SMTP id u70mr6352729pgd.401.1541743664239; 
 Thu, 08 Nov 2018 22:07:44 -0800 (PST)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id c70-v6sm6620722pfg.97.2018.11.08.22.07.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 08 Nov 2018 22:07:43 -0800 (PST)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v7 00/17] of: overlay: validation checks, subsequent fixes
Date: Thu,  8 Nov 2018 22:05:48 -0800
Message-Id: <1541743565-23163-1-git-send-email-frowand.list@gmail.com>
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

Changes since v6:
  - 03/18 Add acked-by from Michael Ellerman
  - 03/18 Move info from post "---" into header comment
  - 04/18 Add acked-by from Michael Ellerman
  - 03/18 Move info from post "---" into header comment, add more info
  - 07/18 Drop.

Changes since v5:
  - move from 4.19-rc1 to 4.20-rc1
  - all patches: add tested-by Alan Tull
  - 05/18: update for context change from commit a613b26a50136 ("of:
    Convert to using %pOFn instead of device_node.name")

Changes since v4:
  - 01/18: make error message format consistent, error first, path last
  - 09/18: create of_prop_val_eq() and change open code to use it
  - 09/18: remove extra blank lines

Changes since v3:
  - 01/18: Add expected value of refcount for destroy cset entry error.  Also
    explain the cause of the error.

  - 09/18: for errors of an overlay changing the value of #size-cells or
    #address-cells, return -EINVAL so that overlay apply will fail
  - 09/18: for errors of an overlay changing the value of #size-cells or
    #address-cells, make the message more direct.
    Old message:
      OF: overlay: ERROR: overlay and/or live tree #size-cells invalid in node /soc/base_fpga_region
    New message:
      OF: overlay: ERROR: changing value of /soc/base_fpga_region/#size-cells not allowed

  - 13/18: Update patch comment header to state that this patch modifies the
    previous patch to not return immediately on fragment error and
    explain this is not a performance issue.
  - 13/18: remove redundant "overlay" from two error messages.  "OF: overlay:"
    is already present in pr_fmt()

Changes since v2:

  - 13/18: Use continue to reduce indentation in find_dup_cset_node_entry()
    and find_dup_cset_prop()

Changes since v1:

  - move patch 16/16 to 17/18
  - move patch 15/16 to 18/18
  - new patch 15/18
  - new patch 16/18

  - 05/18: add_changeset_node() header comment: incorrect comment for @target

  - 18/18: add same fix for of_parse_phandle_with_args()
  - 18/18: add same fix for of_parse_phandle_with_args_map()

Frank Rowand (17):
  of: overlay: add tests to validate kfrees from overlay removal
  of: overlay: add missing of_node_put() after add new node to changeset
  of: overlay: add missing of_node_get() in __of_attach_node_sysfs
  powerpc/pseries: add of_node_put() in dlpar_detach_node()
  of: overlay: use prop add changeset entry for property in new nodes
  of: overlay: do not duplicate properties from overlay for new nodes
  of: overlay: reorder fields in struct fragment
  of: overlay: validate overlay properties #address-cells and
    #size-cells
  of: overlay: make all pr_debug() and pr_err() messages unique
  of: overlay: test case of two fragments adding same node
  of: overlay: check prevents multiple fragments add or delete same node
  of: overlay: check prevents multiple fragments touching same property
  of: unittest: remove unused of_unittest_apply_overlay() argument
  of: overlay: set node fields from properties when add new overlay node
  of: unittest: allow base devicetree to have symbol metadata
  of: unittest: find overlays[] entry by name instead of index
  of: unittest: initialize args before calling of_*parse_*()

 arch/powerpc/platforms/pseries/dlpar.c             |   2 +
 drivers/of/dynamic.c                               |  59 ++++-
 drivers/of/kobj.c                                  |   4 +-
 drivers/of/overlay.c                               | 292 ++++++++++++++++-----
 drivers/of/unittest-data/Makefile                  |   2 +
 .../of/unittest-data/overlay_bad_add_dup_node.dts  |  28 ++
 .../of/unittest-data/overlay_bad_add_dup_prop.dts  |  24 ++
 drivers/of/unittest-data/overlay_base.dts          |   1 +
 drivers/of/unittest.c                              |  96 +++++--
 include/linux/of.h                                 |  21 +-
 10 files changed, 432 insertions(+), 97 deletions(-)
 create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_node.dts
 create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_prop.dts

-- 
Frank Rowand <frank.rowand@sony.com>

