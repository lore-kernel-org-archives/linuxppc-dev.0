Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2506C04AA5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 20:50:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58D18205F4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 20:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcELgDSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D18205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YrDZ2NpgzF3Rw
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 07:50:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GcELgDSo";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=atull@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="GcELgDSo"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YrB05w8yzF3K6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 07:48:08 +1100 (AEDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AAB6D21471
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 20:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1539636487;
 bh=JXM4dTHOeob3RWc/nUgVLdTN5k61sK2Xqt0+vocWjyU=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=GcELgDSoCDHKccqw/Rt1tWRjGcs6LMt3ZBPkaaFAcS4wF/zzr9DLjbQg+sXBUD5A/
 84VhxQF2JJ4/mBXILcvOcd3DgXKINd+NugebeIWgWvcCzhMUiAIt+nBdNLKlCl8/9u
 NzEpye4wHhzkGVX5MVMVp7eqQpVHvWdNa2BxpaJs=
Received: by mail-ed1-f43.google.com with SMTP id c22-v6so19179555edc.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 13:48:06 -0700 (PDT)
X-Gm-Message-State: ABuFfojMymQJ4Thp0qBq4/kLkN77Ovnk8NP3L0OWk1uC7q9d4CWVd9K0
 vjxitG2Khg4cmOTX4C14URWeKP648+bQmJ5lH0Y=
X-Google-Smtp-Source: ACcGV63r2Etnz5wNhGt7WdeMTaPua3FdIM3fJl3V5qM49W7Ku9fXyKuGXm9ekxqT+1vFW+WrfGmnUzfFqhROsjj8ies=
X-Received: by 2002:a17:906:7384:: with SMTP id
 f4-v6mr20598685ejl.8.1539636484958; 
 Mon, 15 Oct 2018 13:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <1539563070-12969-1-git-send-email-frowand.list@gmail.com>
 <CANk1AXTmY7v03m7NNZHVtzyU1Mwm0GYtOJQzmObFLASs=PEfLA@mail.gmail.com>
 <34775737-d82b-b766-16d7-ac2de3231948@gmail.com>
In-Reply-To: <34775737-d82b-b766-16d7-ac2de3231948@gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Mon, 15 Oct 2018 15:47:28 -0500
X-Gmail-Original-Message-ID: <CANk1AXRmF8ANrz-aBcmbYA_uJM-iEX7vbGWONFbr5pQBa_9VEQ@mail.gmail.com>
Message-ID: <CANk1AXRmF8ANrz-aBcmbYA_uJM-iEX7vbGWONFbr5pQBa_9VEQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/18] of: overlay: validation checks, subsequent fixes
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

On Mon, Oct 15, 2018 at 3:24 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 10/15/18 12:21, Alan Tull wrote:
> > On Sun, Oct 14, 2018 at 7:26 PM <frowand.list@gmail.com> wrote:
> >>
> >> From: Frank Rowand <frank.rowand@sony.com>
> >>
> >> Add checks to (1) overlay apply process and (2) memory freeing
> >> triggered by overlay release.  The checks are intended to detect
> >> possible memory leaks and invalid overlays.
> >>
> >> The checks revealed bugs in existing code.  Fixed the bugs.
> >>
> >> While fixing bugs, noted other issues, which are fixed in
> >> separate patches.
> >>
> >> *****  Powerpc folks: I was not able to test the patches that
> >> *****  directly impact Powerpc systems that use dynamic
> >> *****  devicetree.  Please review that code carefully and
> >> *****  test.  The specific patches are: 03/16, 04/16, 07/16
> >>
> >> FPGA folks:
> >>
> >>   I made the validation checks that should result in an
> >>   invalid live devicetree report "ERROR" and cause the overlay apply
> >>   to fail.
> >>
> >>   I made the memory leak validation tests report "WARNING" and allow
> >>   the overlay apply to complete successfully.  Please let me know
> >>   if you encounter the warnings.  There are at least two paths
> >>   forward to deal with the cases that trigger the warning: (1) change
> >>   the warning to an error and fail the overlay apply, or (2) find a
> >>   way to detect the potential memory leaks and free the memory
> >>   appropriately.
> >
> > I reran my FPGA testing.  The strings are fixed, no longer NULL.  I
>
> Thanks for the further testing!
>
>
> > have functionality back, my test passes now.  I'm seeing the intended
> > warnings about any properties added to existing nodes.  That includes
> > warnings about added symbols.  Below is a simplified part to show some
> > of what I'm seeing.
> >
> > By the way my testing is all using Pantelis' DT overlay configfs interface.
> >
> > root@arria10:~# ./apply-static-region.sh
> >
> > Applying dtbo: socfpga_arria10_socdk_sdmmc_ghrd_ovl_ext_cfg.dtb
> >
> > [ 1821.088640] OF: overlay: WARNING: add_changeset_property(), memory
> > leak will occur if overlay removed.  Property:
> > /soc/base_fpga_region/ranges
> > [ 1821.103307] OF: overlay: WARNING: add_changeset_property(), memory
> > leak will occur if overlay removed.  Property:
> > /soc/base_fpga_region/external-fpga-config
> > [ 1821.117359] OF: overlay: WARNING: add_changeset_property(), memory
> > leak will occur if overlay removed.  Property:
> > /soc/base_fpga_region/clocks
> > [ 1821.130130] OF: overlay: WARNING: add_changeset_property(), memory
> > leak will occur if overlay removed.  Property:
> > /soc/base_fpga_region/clock-names
> > [ 1821.143449] OF: overlay: WARNING: add_changeset_property(), memory
> > leak will occur if overlay removed.  Property: /__symbols__/clk_0
> > [ 1821.155357] OF: overlay: WARNING: add_changeset_property(), memory
> > leak will occur if overlay removed.  Property: /__symbols__/ILC
> > [ 1821.167074] OF: overlay: WARNING: add_changeset_property(), memory
> > leak will occur if overlay removed.  Property:
> > /__symbols__/freeze_controller_0
> > [ 1821.180171] OF: overlay: WARNING: add_changeset_property(), memory
> > leak will occur if overlay removed.  Property:
> > /__symbols__/sysid_qsys_0
> > [ 1821.192662] OF: overlay: WARNING: add_changeset_property(), memory
> > leak will occur if overlay removed.  Property: /__symbols__/led_pio
> > [ 1821.204720] OF: overlay: WARNING: add_changeset_property(), memory
> > leak will occur if overlay removed.  Property: /__symbols__/button_pio
> > [ 1821.217034] OF: overlay: WARNING: add_changeset_property(), memory
> > leak will occur if overlay removed.  Property: /__symbols__/dipsw_pio
> > [ 1821.231977] of-fpga-region soc:base_fpga_region:fpga_pr_region0:
> > FPGA Region probed
> > [ 1821.240144] altera_freeze_br ff200450.freeze_controller: fpga
> > bridge [freeze] registered
> >
> > root@arria10:~# ./apply-static-region.sh root@arria10:~# rmdir
> > /sys/kernel/config/device-tree/overlays/1-socfpga_arria10_socdk_sdmmc_ghrd_ovl_ext_cfg.dtb
> >
>
>
> > [ 1823.805564] OF: ERROR: memory leak - destroy cset entry: attach
> > overlay node /soc/base_fpga_region/clk_0 with refcount 2
>
> That is indicating that an unbalanced of_node_get() / of_node_put()
> exists for that node.  I'll have to update that message to be more
> explicit about that.

Yes, that sounds good

>
> -Frank
>
> >
> > Alan
> >
> >
> > Alan
> >
> >
> >
> >>
> >> ALL people:
> >>
> >>   The validations do _not_ address another major concern I have with
> >>   releasing overlays, which is use after free errors.
> >>
> >> Changes since v2:
> >>
> >>   - 13/18: Use continue to reduce indentation in find_dup_cset_node_entry()
> >>     and find_dup_cset_prop()
> >>
> >> Changes since v1:
> >>
> >>   - move patch 16/16 to 17/18
> >>   - move patch 15/16 to 18/18
> >>   - new patch 15/18
> >>   - new patch 16/18
> >>
> >>   - 05/18: add_changeset_node() header comment: incorrect comment for @target
> >>
> >>   - 18/18: add same fix for of_parse_phandle_with_args()
> >>   - 18/18: add same fix for of_parse_phandle_with_args_map()
> >>
> >> Frank Rowand (18):
> >>   of: overlay: add tests to validate kfrees from overlay removal
> >>   of: overlay: add missing of_node_put() after add new node to changeset
> >>   of: overlay: add missing of_node_get() in __of_attach_node_sysfs
> >>   powerpc/pseries: add of_node_put() in dlpar_detach_node()
> >>   of: overlay: use prop add changeset entry for property in new nodes
> >>   of: overlay: do not duplicate properties from overlay for new nodes
> >>   of: dynamic: change type of of_{at,de}tach_node() to void
> >>   of: overlay: reorder fields in struct fragment
> >>   of: overlay: validate overlay properties #address-cells and
> >>     #size-cells
> >>   of: overlay: make all pr_debug() and pr_err() messages unique
> >>   of: overlay: test case of two fragments adding same node
> >>   of: overlay: check prevents multiple fragments add or delete same node
> >>   of: overlay: check prevents multiple fragments touching same property
> >>   of: unittest: remove unused of_unittest_apply_overlay() argument
> >>   of: overlay: set node fields from properties when add new overlay node
> >>   of: unittest: allow base devicetree to have symbol metadata
> >>   of: unittest: find overlays[] entry by name instead of index
> >>   of: unittest: initialize args before calling of_*parse_*()
> >>
> >>  arch/powerpc/platforms/pseries/dlpar.c             |  15 +-
> >>  arch/powerpc/platforms/pseries/reconfig.c          |   6 +-
> >>  drivers/of/dynamic.c                               |  68 +++--
> >>  drivers/of/kobj.c                                  |   4 +-
> >>  drivers/of/overlay.c                               | 298 ++++++++++++++++-----
> >>  drivers/of/unittest-data/Makefile                  |   2 +
> >>  .../of/unittest-data/overlay_bad_add_dup_node.dts  |  28 ++
> >>  .../of/unittest-data/overlay_bad_add_dup_prop.dts  |  24 ++
> >>  drivers/of/unittest-data/overlay_base.dts          |   1 +
> >>  drivers/of/unittest.c                              |  96 +++++--
> >>  include/linux/of.h                                 |  19 +-
> >>  11 files changed, 439 insertions(+), 122 deletions(-)
> >>  create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_node.dts
> >>  create mode 100644 drivers/of/unittest-data/overlay_bad_add_dup_prop.dts
> >>
> >> --
> >> Frank Rowand <frank.rowand@sony.com>
> >>
> >
>
