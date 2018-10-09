Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F4DC67879
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 00:05:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF3332089D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 00:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDP895Kg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3332089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TctS15zkzF3CZ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 11:05:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZDP895Kg";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=frowand.list@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZDP895Kg"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Tcqq14xLzF3BX
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 11:02:46 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id 1-v6so10754347plv.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Oct 2018 17:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tJn7Ds5PmiBAyO1t63a5/79tLr3bHD5hDyfYg43cliQ=;
 b=ZDP895Kgb4ZI4gd2dzR2E7rX3vleLWmA63+mAzwintwKsFhNYILaKG4IR/H/FbIh90
 UUXR3BfV2hykS0i3RLyQ6keC4of01oA4WVDsvgJ+FaGvunoekgajNIz6R2zzJItXC7Jk
 8Gf84xnNLACFSYg+h1A6BHu5SLAvUBUIXBWCfzJEAdcypzcPQ0NclVw5OCY8qc9VuamK
 NRctGpFTmsqrqd1XvfogPF3nKmwIg6bnnr7YC5OY6xX/mLpIGCBsKmGJutfk5C6Rv6W4
 8Ihlz0rmO/EQ5TE67+zHBWknekLYuz5ckj7dQXh7t1ZUlc7JcM9W17u3c8kM9j6jYe3q
 cg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tJn7Ds5PmiBAyO1t63a5/79tLr3bHD5hDyfYg43cliQ=;
 b=OKRQLVQp85ReYjfGxI9ToXWsQRYYpfFbQskfMN3iTm5+wClvl4pf8r+qWeuFBQ+mpt
 iEMW8GYsf7hrS1o4BLfPTwqvMJSEZaeR5ffFQTy+yptHNME+KAWCgme2GBQtB6C1856C
 VXiSRUNfmsFqNmQqrjRuklt3+pfE9jgYq7KQ5aK1ZImlMaWAUHXkKsTWgibE6flDXkQO
 e4H7QMIQhzv6olOxFXLA/G2Ul1PAk624M1Nfca6k4JZUYHeQOio8dxI/rT4eRyvjZARs
 bM9UQLJUOXB3dVN89zdX7XhllxpNxEVgUinn57e+ciVK1rg1XnKI1HNw+XWQRdl1Eyft
 Aj3Q==
X-Gm-Message-State: ABuFfohX2v86BXvp9XPrKGtn26m0GAT8xvJ2NFCrJb/6AWrQUAef+FWK
 Nin5xsBHRHYu8QFbjP4oYv0=
X-Google-Smtp-Source: ACcGV62p8Rrj9/JFFVWgPpoIw1CP6Riq7uujum80VoOI9VgRHw6d5IsUuweHIc7Grrxd9RZn/sDn2g==
X-Received: by 2002:a17:902:8c90:: with SMTP id
 t16-v6mr25513967plo.251.1539043364872; 
 Mon, 08 Oct 2018 17:02:44 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net.
 [24.6.192.50])
 by smtp.gmail.com with ESMTPSA id x186-v6sm26437415pfx.152.2018.10.08.17.02.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Oct 2018 17:02:44 -0700 (PDT)
Subject: Re: [PATCH 09/16] of: overlay: validate overlay properties
 #address-cells and #size-cells
To: Alan Tull <atull@kernel.org>
References: <1538712767-30394-1-git-send-email-frowand.list@gmail.com>
 <1538712767-30394-10-git-send-email-frowand.list@gmail.com>
 <CANk1AXQFTfdwy9n+WH2k98w6oyqLj3wLDRfaMmtTGk66sJjqUw@mail.gmail.com>
 <CANk1AXRi90nFNTji+7RVPC-hb9NFX5+gJo6OpCKvyuVx8eX3Fw@mail.gmail.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <25287d7e-a87a-36c3-2af1-694c2f756c22@gmail.com>
Date: Mon, 8 Oct 2018 17:02:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANk1AXRi90nFNTji+7RVPC-hb9NFX5+gJo6OpCKvyuVx8eX3Fw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

On 10/08/18 11:46, Alan Tull wrote:
> On Mon, Oct 8, 2018 at 10:57 AM Alan Tull <atull@kernel.org> wrote:
>>
>> On Thu, Oct 4, 2018 at 11:14 PM <frowand.list@gmail.com> wrote:
>>>
>>> From: Frank Rowand <frank.rowand@sony.com>
>>>
>>> If overlay properties #address-cells or #size-cells are already in
>>> the live devicetree for any given node, then the values in the
>>> overlay must match the values in the live tree.
>>
>> Hi Frank,
>>
>> I'm starting some FPGA testing on this patchset applied to v4.19-rc7.
>> That applied cleanly; if that's not the best base to test against,
>> please let me know.

I would expect -rc7 to be ok to test against.  I'm doing the development
of it on -rc1.

Thanks for the testing.


>> On a very simple overlay, I'm seeing this patch's warning catching
>> things other than #address-cells or #size-cells.

#address-cells and #size-cells escape the warning for properties on an
existing (non-overlay) node if the existing node already contains them
as a special case.  Those two properties are needed in the overlay to
avoid dtc compiler warnings.  If the same properties already exist in
the base devicetree and have the same values as in the overlay then
there is no need to add property update changeset entries in the overlay
changeset.  Since there will not be changeset entries for those two
properties, there will be no memory leak when the changeset is removed.

The special casing of #address-cells and #size-cells is part of the
fix patches that are a result of the validation patches.  Thus a little
bit less memory leaking than we have today.


> What it's warning about are new properties being added to an existing
> node.  So !prop is true and !of_node_check_flag(target->np,
> OF_OVERLAY) also is true.  Is that a potential memory leak as you are
> warning?  If so, your code is working as planned and you'll just need
> to document that also in the header.

Yes, you are accurately describing what the check is catching.

The memory leak (on release) is because the memory allocated for overlay
properties is released when the reference count of the node they are
attached is decremented to zero, but only if the node is a dynamic flagged
node (as overlays are).  The memory allocated for the overlay properties
will not be freed in this case because the node is not a dynamic node.


>> I'm just getting
>> started looking at this, will spend time understanding this better and
>> I'll test other overlays.  The warnings were:
>>
>> Applying dtbo: socfpga_overlay.dtb
>> [   33.117881] fpga_manager fpga0: writing soc_system.rbf to Altera
>> SOCFPGA FPGA Manager
>> [   33.575223] OF: overlay: WARNING: add_changeset_property(), memory
>> leak will occur if overlay removed.  Property:
>> /soc/base-fpga-region/firmware-name
>> [   33.588584] OF: overlay: WARNING: add_changeset_property(), memory
>> leak will occur if overlay removed.  Property:
>> /soc/base-fpga-region/fpga-bridges
>> [   33.601856] OF: overlay: WARNING: add_changeset_property(), memory
>> leak will occur if overlay removed.  Property:
>> /soc/base-fpga-region/ranges

Are there properties in /soc/base-fpga-region/ in the base devicetree?

If not, then that node could be removed from the base devicetree and first created
in an overlay.

If so, is it possible to add an additional level of node, /soc/base-fpga-region/foo,
which would contain the properties that are warned about above?  Then the properties
would be children of an overlay node and the memory would be freed on overlay
release.

This is not actually a suggestion that should be implemented right now, just trying
to understand the possible alternatives, because this would result in an arbitrary
fake level in the tree (which I don't like).

My intent is to leave these validation checks as warnings while we figure out the
best way to solve the underlying memory leak issue.  Note that some of the
validation checks result in errors and cause an overlay apply to fail.  If I
did those checks correctly, they should only catch cases where the live tree
after applying the overlay was a "corrupt" tree instead of the desired changes.

I expect that Plumbers will be a good place to explore these things.


>> Here's part of that overlay including the properties it's complaining about:
>>
>> /dts-v1/;
>> /plugin/;
>> / {
>>         fragment@0 {
>>                 target = <&base_fpga_region>;
>>                 #address-cells = <1>;
>>                 #size-cells = <1>;
>>                 __overlay__ {
>>                         #address-cells = <1>;
>>                         #size-cells = <1>;
>>
>>                         firmware-name = "soc_system.rbf";
>>                         fpga-bridges = <&fpga_bridge1>;
>>                         ranges = <0x20000 0xff200000 0x100000>,
>>                         <0x0 0xc0000000 0x20000000>;
>>
>>                         gpio@10040 {
>> so on...
>>
>> By the way, I didn't get any warnings when I subsequently removed this overlay.

Yes, I did not add any check that could catch this at release time.

-Frank


>> Alan
>>
>>>
>>> If the properties are already in the live tree then there is no
>>> need to create a changeset entry to add them since they must
>>> have the same value.  This reduces the memory used by the
>>> changeset and eliminates a possible memory leak.  This is
>>> verified by 12 fewer warnings during the devicetree unittest,
>>> as the possible memory leak warnings about #address-cells and
>>>
>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
>>> ---
>>>  drivers/of/overlay.c | 38 +++++++++++++++++++++++++++++++++++---
>>>  1 file changed, 35 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>>> index 29c33a5c533f..e6fb3ffe9d93 100644
>>> --- a/drivers/of/overlay.c
>>> +++ b/drivers/of/overlay.c
>>> @@ -287,7 +287,12 @@ static struct property *dup_and_fixup_symbol_prop(
>>>   * @target may be either in the live devicetree or in a new subtree that
>>>   * is contained in the changeset.
>>>   *
>>> - * Some special properties are not updated (no error returned).
>>> + * Some special properties are not added or updated (no error returned):
>>> + * "name", "phandle", "linux,phandle".
>>> + *
>>> + * Properties "#address-cells" and "#size-cells" are not updated if they
>>> + * are already in the live tree, but if present in the live tree, the values
>>> + * in the overlay must match the values in the live tree.
>>>   *
>>>   * Update of property in symbols node is not allowed.
>>>   *
>>> @@ -300,6 +305,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>>>  {
>>>         struct property *new_prop = NULL, *prop;
>>>         int ret = 0;
>>> +       bool check_for_non_overlay_node = false;
>>>
>>>         if (!of_prop_cmp(overlay_prop->name, "name") ||
>>>             !of_prop_cmp(overlay_prop->name, "phandle") ||
>>> @@ -322,13 +328,39 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>>>         if (!new_prop)
>>>                 return -ENOMEM;
>>>
>>> -       if (!prop)
>>> +       if (!prop) {
>>> +
>>> +               check_for_non_overlay_node = true;
>>>                 ret = of_changeset_add_property(&ovcs->cset, target->np,
>>>                                                 new_prop);
>>> -       else
>>> +
>>> +       } else if (!of_prop_cmp(prop->name, "#address-cells")) {
>>> +
>>> +               if (prop->length != 4 || new_prop->length != 4 ||
>>> +                   *(u32 *)prop->value != *(u32 *)new_prop->value)
>>> +                       pr_err("ERROR: overlay and/or live tree #address-cells invalid in node %pOF\n",
>>> +                              target->np);
>>> +
>>> +       } else if (!of_prop_cmp(prop->name, "#size-cells")) {
>>> +
>>> +               if (prop->length != 4 || new_prop->length != 4 ||
>>> +                   *(u32 *)prop->value != *(u32 *)new_prop->value)
>>> +                       pr_err("ERROR: overlay and/or live tree #size-cells invalid in node %pOF\n",
>>> +                              target->np);
>>> +
>>> +       } else {
>>> +
>>> +               check_for_non_overlay_node = true;
>>>                 ret = of_changeset_update_property(&ovcs->cset, target->np,
>>>                                                    new_prop);
>>>
>>> +       }
>>> +
>>> +       if (check_for_non_overlay_node &&
>>> +           !of_node_check_flag(target->np, OF_OVERLAY))
>>> +               pr_err("WARNING: %s(), memory leak will occur if overlay removed.  Property: %pOF/%s\n",
>>> +                      __func__, target->np, new_prop->name);
>>> +
>>>         if (ret) {
>>>                 kfree(new_prop->name);
>>>                 kfree(new_prop->value);
>>> --
>>> Frank Rowand <frank.rowand@sony.com>
>>>
> 

