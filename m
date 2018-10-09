Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03F0ECDE3A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 18:43:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D81120644
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 18:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwToXpWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D81120644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42V5j20yRyzF3NB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 05:43:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RwToXpWw";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=atull@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="RwToXpWw"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42V5fQ1WYjzF3MR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 05:41:17 +1100 (AEDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4C688214C5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 18:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1539110475;
 bh=Pu5u9uOc5+jx9VPeTRAKBI1uFev6LJzI8nPYY8ar9xw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=RwToXpWwBtyyiGkN7d08PHhAATnPaTsSUyDs/X3kqBqbxtBnkDJi4EDcjraz5JsTj
 Gc9pjsLt/JbGhW3JP9R0nsE01rCkbfHmKKlHnFq6aG1Rjjue/d5EEBoKmxqpA5uSYc
 KlCD53SejQI1pKyMm9ueCp8uRPCrJ9UovOz2FCOA=
Received: by mail-ed1-f49.google.com with SMTP id c1-v6so2648962ede.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Oct 2018 11:41:15 -0700 (PDT)
X-Gm-Message-State: ABuFfojTCAbAzsZwt0eac6nEgQeR5Cnjiifu3LRnUQ27G/G6JB4+Ul/2
 ZMCud7CG2cR0R8lvEVI7Ju0hyeHVnXcQgHisDTk=
X-Google-Smtp-Source: ACcGV60KVAmjCWn3P4uhbgB3oZQAN5IxjwZJwTK8M6v+CbJeJ8ix9tK2cnceoblq4+01DF1KgYhumATszjWS7mLcv50=
X-Received: by 2002:a17:906:5d10:: with SMTP id
 g16-v6mr28935957ejt.168.1539110473640; 
 Tue, 09 Oct 2018 11:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
 <1538712767-30394-10-git-send-email-frowand.list@gmail.com>
 <CANk1AXQFTfdwy9n+WH2k98w6oyqLj3wLDRfaMmtTGk66sJjqUw@mail.gmail.com>
 <CANk1AXRi90nFNTji+7RVPC-hb9NFX5+gJo6OpCKvyuVx8eX3Fw@mail.gmail.com>
 <25287d7e-a87a-36c3-2af1-694c2f756c22@gmail.com>
In-Reply-To: <25287d7e-a87a-36c3-2af1-694c2f756c22@gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Tue, 9 Oct 2018 13:40:37 -0500
X-Gmail-Original-Message-ID: <CANk1AXTKLm4c6_4oNPnDppJFL192BUfkgc3tuxWPQzfSXrGOmA@mail.gmail.com>
Message-ID: <CANk1AXTKLm4c6_4oNPnDppJFL192BUfkgc3tuxWPQzfSXrGOmA@mail.gmail.com>
Subject: Re: [PATCH 09/16] of: overlay: validate overlay properties
 #address-cells and #size-cells
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

On Mon, Oct 8, 2018 at 7:02 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 10/08/18 11:46, Alan Tull wrote:
> > On Mon, Oct 8, 2018 at 10:57 AM Alan Tull <atull@kernel.org> wrote:
> >>
> >> On Thu, Oct 4, 2018 at 11:14 PM <frowand.list@gmail.com> wrote:
> >>>
> >>> From: Frank Rowand <frank.rowand@sony.com>
> >>>
> >>> If overlay properties #address-cells or #size-cells are already in
> >>> the live devicetree for any given node, then the values in the
> >>> overlay must match the values in the live tree.
> >>
> >> Hi Frank,
> >>
> >> I'm starting some FPGA testing on this patchset applied to v4.19-rc7.
> >> That applied cleanly; if that's not the best base to test against,
> >> please let me know.
>
> I would expect -rc7 to be ok to test against.  I'm doing the development
> of it on -rc1.
>
> Thanks for the testing.
>

I'll try to be quick about it, but I expect it will take a few days to
hit everything and explain it here.

>
> >> On a very simple overlay, I'm seeing this patch's warning catching
> >> things other than #address-cells or #size-cells.
>
> #address-cells and #size-cells escape the warning for properties on an
> existing (non-overlay) node if the existing node already contains them
> as a special case.  Those two properties are needed in the overlay to
> avoid dtc compiler warnings.  If the same properties already exist in
> the base devicetree and have the same values as in the overlay then
> there is no need to add property update changeset entries in the overlay
> changeset.  Since there will not be changeset entries for those two
> properties, there will be no memory leak when the changeset is removed.
>
> The special casing of #address-cells and #size-cells is part of the
> fix patches that are a result of the validation patches.  Thus a little
> bit less memory leaking than we have today.

Makes sense.  Thanks for the explanation.

>
>
> > What it's warning about are new properties being added to an existing
> > node.  So !prop is true and !of_node_check_flag(target->np,
> > OF_OVERLAY) also is true.  Is that a potential memory leak as you are
> > warning?  If so, your code is working as planned and you'll just need
> > to document that also in the header.
>
> Yes, you are accurately describing what the check is catching.
>
> The memory leak (on release) is because the memory allocated for overlay
> properties is released when the reference count of the node they are
> attached is decremented to zero, but only if the node is a dynamic flagged
> node (as overlays are).  The memory allocated for the overlay properties
> will not be freed in this case because the node is not a dynamic node.
>
>
> >> I'm just getting
> >> started looking at this, will spend time understanding this better and
> >> I'll test other overlays.  The warnings were:
> >>
> >> Applying dtbo: socfpga_overlay.dtb
> >> [   33.117881] fpga_manager fpga0: writing soc_system.rbf to Altera
> >> SOCFPGA FPGA Manager
> >> [   33.575223] OF: overlay: WARNING: add_changeset_property(), memory
> >> leak will occur if overlay removed.  Property:
> >> /soc/base-fpga-region/firmware-name
> >> [   33.588584] OF: overlay: WARNING: add_changeset_property(), memory
> >> leak will occur if overlay removed.  Property:
> >> /soc/base-fpga-region/fpga-bridges
> >> [   33.601856] OF: overlay: WARNING: add_changeset_property(), memory
> >> leak will occur if overlay removed.  Property:
> >> /soc/base-fpga-region/ranges
>
> Are there properties in /soc/base-fpga-region/ in the base devicetree?

It looks like this:
               base_fpga_region {
                        #address-cells = <0x1>;
                        #size-cells = <0x1>;
                        compatible = "fpga-region";
                        fpga-mgr = <&fpga_mgr>;
                };

It is used as a target for applying DT overlays for FPGA reprogramming.

>
> If not, then that node could be removed from the base devicetree and first created
> in an overlay.

I'll give it a try and report back!

> If so, is it possible to add an additional level of node, /soc/base-fpga-region/foo,
> which would contain the properties that are warned about above?  Then the properties
> would be children of an overlay node and the memory would be freed on overlay
> release.

I expect that would not be hard.  The of-fpga-region.c driver would
only need small changes to know where to expect the properties it is
looking for.

And when the child nodes in the overlay are added to the live tree,
they would be under the added fake level. That shouldn't be a problem
either, it would just be different.

> This is not actually a suggestion that should be implemented right now, just trying
> to understand the possible alternatives, because this would result in an arbitrary
> fake level in the tree (which I don't like).

Yeah I don't love it either, but for the sake of discussion, it's
worth the mention.  I'm open for suggestions here definitely.  But yes
adding the fake level might make the DT code implementation more
straightforward at the cost of something that isn't great in the DT
itself.  We can keep scratching our heads a bit.

>
> My intent is to leave these validation checks as warnings while we figure out the
> best way to solve the underlying memory leak issue.

That is helpful.  Applying overlays may be a bit noisier for a while
until this gets ironed out.

>  Note that some of the
> validation checks result in errors and cause an overlay apply to fail.

Yes, the errors I hit were where the overlay tried to change
#address-cells.  I am thinking that we probably don't need to do that.
What we were doing was mapping multiple bridges (between the CPU and
FPGA) into different address spaces.  We probably don't have to do it
that way.  I'll try to bring in an example without making it
unnecessarily involved:

dts-v1/;
/plugin/;
/ {
        fragment@0 {
                target-path = "/soc/base_fpga_region";
                #address-cells = <1>;
                #size-cells = <1>;

                __overlay__ {
                        ranges = <0x00000000 0x00000000 0xc0000000
0x00040000>, //h2f bridge
                                 <0x00000001 0x00000000 0xff200000
0x00001000>; //lwh2f bridge
so on...

The h2f = hps (cpu) to fpga bridge = for DMA
The lwh2f = lightweight cpu to fpga = strongly ordered bridge for
register access

This will raise ERROR messages, but if I change it to the following,
it seems happier.
                        ranges = <0xc0000000 0xc0000000 0x00040000>,
                                 <0x00000000 0xff200000 0x00001000>;

Maybe we should be using dma-ranges for part of this anyway.

>  If I
> did those checks correctly, they should only catch cases where the live tree
> after applying the overlay was a "corrupt" tree instead of the desired changes.
>
> I expect that Plumbers will be a good place to explore these things.
>
>
> >> Here's part of that overlay including the properties it's complaining about:
> >>
> >> /dts-v1/;
> >> /plugin/;
> >> / {
> >>         fragment@0 {
> >>                 target = <&base_fpga_region>;
> >>                 #address-cells = <1>;
> >>                 #size-cells = <1>;
> >>                 __overlay__ {
> >>                         #address-cells = <1>;
> >>                         #size-cells = <1>;
> >>
> >>                         firmware-name = "soc_system.rbf";
> >>                         fpga-bridges = <&fpga_bridge1>;
> >>                         ranges = <0x20000 0xff200000 0x100000>,
> >>                         <0x0 0xc0000000 0x20000000>;
> >>
> >>                         gpio@10040 {
> >> so on...
> >>
> >> By the way, I didn't get any warnings when I subsequently removed this overlay.
>
> Yes, I did not add any check that could catch this at release time.
>
> -Frank
>
>
> >> Alan
> >>
> >>>
> >>> If the properties are already in the live tree then there is no
> >>> need to create a changeset entry to add them since they must
> >>> have the same value.  This reduces the memory used by the
> >>> changeset and eliminates a possible memory leak.  This is
> >>> verified by 12 fewer warnings during the devicetree unittest,
> >>> as the possible memory leak warnings about #address-cells and
> >>>
> >>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> >>> ---
> >>>  drivers/of/overlay.c | 38 +++++++++++++++++++++++++++++++++++---
> >>>  1 file changed, 35 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> >>> index 29c33a5c533f..e6fb3ffe9d93 100644
> >>> --- a/drivers/of/overlay.c
> >>> +++ b/drivers/of/overlay.c
> >>> @@ -287,7 +287,12 @@ static struct property *dup_and_fixup_symbol_prop(
> >>>   * @target may be either in the live devicetree or in a new subtree that
> >>>   * is contained in the changeset.
> >>>   *
> >>> - * Some special properties are not updated (no error returned).
> >>> + * Some special properties are not added or updated (no error returned):
> >>> + * "name", "phandle", "linux,phandle".
> >>> + *
> >>> + * Properties "#address-cells" and "#size-cells" are not updated if they
> >>> + * are already in the live tree, but if present in the live tree, the values
> >>> + * in the overlay must match the values in the live tree.
> >>>   *
> >>>   * Update of property in symbols node is not allowed.
> >>>   *
> >>> @@ -300,6 +305,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
> >>>  {
> >>>         struct property *new_prop = NULL, *prop;
> >>>         int ret = 0;
> >>> +       bool check_for_non_overlay_node = false;
> >>>
> >>>         if (!of_prop_cmp(overlay_prop->name, "name") ||
> >>>             !of_prop_cmp(overlay_prop->name, "phandle") ||
> >>> @@ -322,13 +328,39 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
> >>>         if (!new_prop)
> >>>                 return -ENOMEM;
> >>>
> >>> -       if (!prop)
> >>> +       if (!prop) {
> >>> +
> >>> +               check_for_non_overlay_node = true;
> >>>                 ret = of_changeset_add_property(&ovcs->cset, target->np,
> >>>                                                 new_prop);
> >>> -       else
> >>> +
> >>> +       } else if (!of_prop_cmp(prop->name, "#address-cells")) {
> >>> +
> >>> +               if (prop->length != 4 || new_prop->length != 4 ||
> >>> +                   *(u32 *)prop->value != *(u32 *)new_prop->value)
> >>> +                       pr_err("ERROR: overlay and/or live tree #address-cells invalid in node %pOF\n",
> >>> +                              target->np);
> >>> +
> >>> +       } else if (!of_prop_cmp(prop->name, "#size-cells")) {
> >>> +
> >>> +               if (prop->length != 4 || new_prop->length != 4 ||
> >>> +                   *(u32 *)prop->value != *(u32 *)new_prop->value)
> >>> +                       pr_err("ERROR: overlay and/or live tree #size-cells invalid in node %pOF\n",
> >>> +                              target->np);
> >>> +
> >>> +       } else {
> >>> +
> >>> +               check_for_non_overlay_node = true;
> >>>                 ret = of_changeset_update_property(&ovcs->cset, target->np,
> >>>                                                    new_prop);
> >>>
> >>> +       }
> >>> +
> >>> +       if (check_for_non_overlay_node &&
> >>> +           !of_node_check_flag(target->np, OF_OVERLAY))
> >>> +               pr_err("WARNING: %s(), memory leak will occur if overlay removed.  Property: %pOF/%s\n",
> >>> +                      __func__, target->np, new_prop->name);
> >>> +
> >>>         if (ret) {
> >>>                 kfree(new_prop->name);
> >>>                 kfree(new_prop->value);
> >>> --
> >>> Frank Rowand <frank.rowand@sony.com>
> >>>
> >
>
