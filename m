Return-Path: <SRS0=Olcr=NC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643CAC004D3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 21:27:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E1620663
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 21:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="seE+hmgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E1620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42f8k56sYdzDrPm
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 08:27:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="seE+hmgN";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=atull@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="seE+hmgN"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42f8gN5lK7zDsFP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2018 08:25:04 +1100 (AEDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9F9F220672
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 21:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1540243501;
 bh=J5KXlHq0ykYvkTpQd8RTxRXAiMeYwd3ZqmH5ZY+miK0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=seE+hmgNxKYVNoTgH8ClvDNdJ1ir4JBkHHipXuMkznuS7/mDnp5vwLAJbvUsp9sJg
 orjO/nZgMbt/qWWEpJ/7fFp7l3jTOohv9zKyVLbTV6Dnj1X4o5z7HpUFUM0guxXmm7
 9k+hv75nu5PKc0SmDxTd4dIOIbXMp7FFqp5r7zzs=
Received: by mail-ed1-f53.google.com with SMTP id r1-v6so39377782edd.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 14:25:01 -0700 (PDT)
X-Gm-Message-State: AGRZ1gIxfvy9g9bbqfETbhUNoUdfT2kc2TuOdexnNXKDC0Sfq776MFwh
 HNdq06nvXSBCGmfz8WALW9DAODP+v/6DL9givzw=
X-Google-Smtp-Source: AJdET5caEsiwVSlUwSAjryIBOEYgWxo1ZnaopgHGUj+bbgMyGw/96+OjLlidoRf+uZtC0CtEhvWeSMBKdJ/6W/dcGuU=
X-Received: by 2002:a50:cd4b:: with SMTP id
 d11-v6mr4278153edj.60.1540243499796; 
 Mon, 22 Oct 2018 14:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
In-Reply-To: <1539902796-8382-1-git-send-email-frowand.list@gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 22 Oct 2018 16:24:23 -0500
X-Gmail-Original-Message-ID: <CANk1AXSLZLn6XjC=nv3+pK_NQc_VL5MxWfOW9mLCgv_eFYvPPw@mail.gmail.com>
Message-ID: <CANk1AXSLZLn6XjC=nv3+pK_NQc_VL5MxWfOW9mLCgv_eFYvPPw@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] of: overlay: validation checks, subsequent fixes
To: Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Moritz Fischer <mdf@kernel.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 18, 2018 at 5:48 PM <frowand.list@gmail.com> wrote:
>
> From: Frank Rowand <frank.rowand@sony.com>
>
> Add checks to (1) overlay apply process and (2) memory freeing
> triggered by overlay release.  The checks are intended to detect
> possible memory leaks and invalid overlays.

I've tested v5, nothing new to report.

Alan

>
> The checks revealed bugs in existing code.  Fixed the bugs.
>
> While fixing bugs, noted other issues, which are fixed in
> separate patches.
>
> *****  Powerpc folks: I was not able to test the patches that
> *****  directly impact Powerpc systems that use dynamic
> *****  devicetree.  Please review that code carefully and
> *****  test.  The specific patches are: 03/16, 04/16, 07/16
>
> FPGA folks:
>
>   I made the validation checks that should result in an
>   invalid live devicetree report "ERROR" and cause the overlay apply
>   to fail.
>
>   I made the memory leak validation tests report "WARNING" and allow
>   the overlay apply to complete successfully.  Please let me know
>   if you encounter the warnings.  There are at least two paths
>   forward to deal with the cases that trigger the warning: (1) change
>   the warning to an error and fail the overlay apply, or (2) find a
>   way to detect the potential memory leaks and free the memory
>   appropriately.
>
> ALL people:
>
>   The validations do _not_ address another major concern I have with
>   releasing overlays, which is use after free errors.
>
> Changes since v4:
>   - 01/18: make error message format consistent, error first, path last
>   - 09/18: create of_prop_val_eq() and change open code to use it
>   - 09/18: remove extra blank lines
>
> Changes since v3:
>   - 01/18: Add expected value of refcount for destroy cset entry error.  Also
>     explain the cause of the error.
>
>   - 09/18: for errors of an overlay changing the value of #size-cells or
>     #address-cells, return -EINVAL so that overlay apply will fail
>   - 09/18: for errors of an overlay changing the value of #size-cells or
>     #address-cells, make the message more direct.
>     Old message:
>       OF: overlay: ERROR: overlay and/or live tree #size-cells invalid in node /soc/base_fpga_region
>     New message:
>       OF: overlay: ERROR: changing value of /soc/base_fpga_region/#size-cells not allowed
>
>   - 13/18: Update patch comment header to state that this patch modifies the
>     previous patch to not return immediately on fragment error and
>     explain this is not a performance issue.
>   - 13/18: remove redundant "overlay" from two error messages.  "OF: overlay:"
>     is already present in pr_fmt()
>
> Changes since v2:
>
>   - 13/18: Use continue to reduce indentation in find_dup_cset_node_entry()
>     and find_dup_cset_prop()
>
> Changes since v1:
>
>   - move patch 16/16 to 17/18
>   - move patch 15/16 to 18/18
>   - new patch 15/18
>   - new patch 16/18
>
>   - 05/18: add_changeset_node() header comment: incorrect comment for @target
>
>   - 18/18: add same fix for of_parse_phandle_with_args()
>   - 18/18: add same fix for of_parse_phandle_with_args_map()
>
>
> *** BLURB HERE ***
>
> Frank Rowand (18):
>   of: overlay: add tests to validate kfrees from overlay removal
>   of: overlay: add missing of_node_put() after add new node to changeset
>   of: overlay: add missing of_node_get() in __of_attach_node_sysfs
>   powerpc/pseries: add of_node_put() in dlpar_detach_node()
>   of: overlay: use prop add changeset entry for property in new nodes
>   of: overlay: do not duplicate properties from overlay for new nodes
>   of: dynamic: change type of of_{at,de}tach_node() to void
>   of: overlay: reorder fields in struct fragment
>   of: overlay: validate overlay properties #address-cells and
>     #size-cells
>   of: overlay: make all pr_debug() and pr_err() messages unique
>   of: overlay: test case of two fragments adding same node
>   of: overlay: check prevents multiple fragments add or delete same node
>   of: overlay: check prevents multiple fragments touching same property
>   of: unittest: remove unused of_unittest_apply_overlay() argument
>   of: overlay: set node fields from properties when add new overlay node
>   of: unittest: allow base devicetree to have symbol metadata
>   of: unittest: find overlays[] entry by name instead of index
>   of: unittest: initialize args before calling of_*parse_*()
>
>  arch/powerpc/platforms/pseries/dlpar.c             |  15 +-
>  arch/powerpc/platforms/pseries/reconfig.c          |   6 +-
>  drivers/of/dynamic.c                               |  68 +++--
>  drivers/of/kobj.c                                  |   4 +-
>  drivers/of/overlay.c                               | 292 ++++++++++++++++-----
>  drivers/of/unittest-data/Makefile                  |   2 +
>  .../of/unittest-data/overlay_bad_add_dup_node.dts  |  28 ++
>  .../of/unittest-data/overlay_bad_add_dup_prop.dts  |  24 ++
>  drivers/of/unittest-data/overlay_base.dts          |   1 +
>  drivers/of/unittest.c                              |  96 +++++--
>  include/linux/of.h                                 |  25 +-
>  11 files changed, 439 insertions(+), 122 deletions(-)
>  create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_node.dts
>  create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
>
> --
> Frank Rowand <frank.rowand@sony.com>
>
