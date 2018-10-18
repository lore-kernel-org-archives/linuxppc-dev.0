Return-Path: <SRS0=VXin=M6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D341AC67863
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 22:54:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4F4204FD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 22:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdx7lTKV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4F4204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42bkrN2gZ6zF3G8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 09:54:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cdx7lTKV";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="cdx7lTKV"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42bkj404C1zF3FL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 09:48:07 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id g21-v6so8547863pfi.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 15:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=RjThF0EvHGI6dWXNCVEiHTZA1JEA+VjGl4N3F03pIL4=;
 b=cdx7lTKV2/C6pIWAYbDnp2jfkD5EnegxH5gPCqh0f8HaL7eOGBtleFzoqWjOt2N+Ju
 Iw3Jiky64CNrQnCoxa9b1F/eGVQwVYzHkN0V1ieKtZ04wf7/uXSU6jjUfDaeOSwlNiET
 x6vDVzZvB3XUpb7Lh3T6SbNNqJDVTkCswQgXM37AprpZSciOpOdxbhfG8QKqsNiXf2kY
 T5veNJGtztD9Cq3KfIwcdDOKLuciGeXecY6Tn30sf4kjvZL+i5GryyNCPctaARN45+EI
 CrCcXuPQUi7esDG0cLoHK1XkkqhdaYLiEYuskoTN91panm3pobXAyzDyuxjrG8Hu8wDs
 QPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=RjThF0EvHGI6dWXNCVEiHTZA1JEA+VjGl4N3F03pIL4=;
 b=MzL+xVpHulwCYelR+WAOOJgzjymUytP/hPfIl//7t2dSF6fdWg32lN7W+aZIqlgnnx
 A93+8dMtRmzg3lkqx8V0dLvOvzREny3uwWwO2Q/MB3vTrG4mmgB0nZXYJSb5Y7+EMaAY
 yyAPR26whTVVnfpxUz+/PgPPReUDwEeKx4UFai2VQkrbaM/ryzD3AAktLRUXOKxB6Vjk
 dyUvCfX7t2FyhtJ5z56v6/OGmgof4qpg2YTxDLEcJIzu4QRjOtUr7OFvZseQe58HMxdx
 eDgRcMMZtx8TZDIfosYYB5BBSLbYrYHem+CcDlFAl10ddcR8IjBlkLknF+HiAak5IcRs
 G4/A==
X-Gm-Message-State: ABuFfohkBLV0rZBbxnTAEExsE9B8rqcJ2LNHOKMlzsfbIAeNzaLkYtna
 aibpQCnSStzXE8blXBd9N4M=
X-Google-Smtp-Source: ACcGV62ibQR7WjBeq0mRyagQG0W9G0+c3fSFdXNI+cxXBtiz8iAJfgYz+krmPZHO7ZTeL7YR7RqQBw==
X-Received: by 2002:a63:f553:: with SMTP id
 e19-v6mr29964602pgk.417.1539902884242; 
 Thu, 18 Oct 2018 15:48:04 -0700 (PDT)
Received: from localhost.localdomain (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id v81-v6sm38129268pfj.25.2018.10.18.15.48.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 18 Oct 2018 15:48:03 -0700 (PDT)
From: frowand.list@gmail.com
To: Rob Herring <robh+dt@kernel.org>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Alan Tull <atull@kernel.org>,
 Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v5 00/18] of: overlay: validation checks, subsequent fixes
Date: Thu, 18 Oct 2018 15:46:18 -0700
Message-Id: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
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


*** BLURB HERE ***

Frank Rowand (18):
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
  of: overlay: set node fields from properties when add new overlay node
  of: unittest: allow base devicetree to have symbol metadata
  of: unittest: find overlays[] entry by name instead of index
  of: unittest: initialize args before calling of_*parse_*()

 arch/powerpc/platforms/pseries/dlpar.c             |  15 +-
 arch/powerpc/platforms/pseries/reconfig.c          |   6 +-
 drivers/of/dynamic.c                               |  68 +++--
 drivers/of/kobj.c                                  |   4 +-
 drivers/of/overlay.c                               | 292 ++++++++++++++++-----
 drivers/of/unittest-data/Makefile                  |   2 +
 .../of/unittest-data/overlay_bad_add_dup_node.dts  |  28 ++
 .../of/unittest-data/overlay_bad_add_dup_prop.dts  |  24 ++
 drivers/of/unittest-data/overlay_base.dts          |   1 +
 drivers/of/unittest.c                              |  96 +++++--
 include/linux/of.h                                 |  25 +-
 11 files changed, 439 insertions(+), 122 deletions(-)
 create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_node.dts
 create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_prop.dts

-- 
Frank Rowand <frank.rowand@sony.com>

