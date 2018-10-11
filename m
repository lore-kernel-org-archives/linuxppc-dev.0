Return-Path: <SRS0=4kvs=MX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0300C677FC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 19:36:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 012E72075C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 19:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLmmeOo6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012E72075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42WLnH00XlzF3JR
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Oct 2018 06:36:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oLmmeOo6";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=atull@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="oLmmeOo6"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42WLkT05wvzF3JG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Oct 2018 06:34:08 +1100 (AEDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9CB7F21476
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 19:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1539286446;
 bh=zqgx2pIivn7Ux9M/b303jA60rKWMgt6xDAk/V5tHA8Y=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=oLmmeOo6RRXHw1GTGGs+zfa/aj0Tko4QB5gK65Ae6uwR1tNX7DSNCtVB/KlaqQ6ko
 tMU+cpvOXG47CWTY73JcZuMOtFx3KPpVr2XOR8hxO9PDWxiv6WRGoVjlzfRMMVGc8c
 LxjHMLriNuVSEP/vQMYUcJr6fOBc50C0kc8m6z2k=
Received: by mail-ed1-f51.google.com with SMTP id b7-v6so9337086edd.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 12:34:06 -0700 (PDT)
X-Gm-Message-State: ABuFfohEqpE1NuN7mKYYSRZRzA79R1QQj3698K76VCJjcEMWWImLfhEp
 MRwtAhioL+nhqtM03Fqf6kHGDx5Qy0G0Wd+Rb9Y=
X-Google-Smtp-Source: ACcGV61yHB6rCPVPmLKUxRzusYlst9bpNZUHCTj4c8yq/NKrVYhPfDBOuz9ohAnd+BMpSEJ1xm7OZx/c2kVQaeNS7Lg=
X-Received: by 2002:a50:8bd5:: with SMTP id
 n21-v6mr4852793edn.41.1539286444998; 
 Thu, 11 Oct 2018 12:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <CANk1AXQScT_b1_UOiVuWNcB=LiA3gvvZrw53H1XVSCNqsGPqtA@mail.gmail.com>
 <1539151495-8110-1-git-send-email-frowand.list@gmail.com>
 <f20d06c3-5db7-3547-7b8b-d43d474683f1@gmail.com>
 <CANk1AXQ+-X51unT_ZHw+wxHG3tyGUKUihVsdzOZZ2NJ2zfS3Rg@mail.gmail.com>
 <e32a99a2-1db5-80e6-5022-83cd8fd07180@gmail.com>
 <bcbba4ca-0656-aa27-c058-064fb7175d38@gmail.com>
In-Reply-To: <bcbba4ca-0656-aa27-c058-064fb7175d38@gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Thu, 11 Oct 2018 14:33:28 -0500
X-Gmail-Original-Message-ID: <CANk1AXSRifmwu1FQRY_hsuqDESEzcMET_hpLNZOeW4QLrUwsdw@mail.gmail.com>
Message-ID: <CANk1AXSRifmwu1FQRY_hsuqDESEzcMET_hpLNZOeW4QLrUwsdw@mail.gmail.com>
Subject: Re: [PATCH 05.1/16] of:overlay: missing name, phandle, linux, phandle
 in new nodes
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

On Thu, Oct 11, 2018 at 12:39 AM Frank Rowand <frowand.list@gmail.com> wrote:

[resend of my messed up rejected email of a minute ago, sorry]

>
> On 10/10/18 14:03, Frank Rowand wrote:
> > On 10/10/18 13:40, Alan Tull wrote:
> >> On Wed, Oct 10, 2018 at 1:49 AM Frank Rowand <frowand.list@gmail.com> wrote:
> >>>
> >>> On 10/09/18 23:04, frowand.list@gmail.com wrote:
> >>>> From: Frank Rowand <frank.rowand@sony.com>
> >>>>
> >>>>
> >>>> "of: overlay: use prop add changeset entry for property in new nodes"
> >>>> fixed a problem where an 'update property' changeset entry was
> >>>> created for properties contained in nodes added by a changeset.
> >>>> The fix was to use an 'add property' changeset entry.
> >>>>
> >>>> This exposed more bugs in the apply overlay code.  The properties
> >>>> 'name', 'phandle', and 'linux,phandle' were filtered out by
> >>>> add_changeset_property() as special properties.  Change the filter
> >>>> to be only for existing nodes, not newly added nodes.
> >>>>
> >>>> The second bug is that the 'name' property does not exist in the
> >>>> newest FDT version, and has to be constructed from the node's
> >>>> full_name.  Construct an 'add property' changeset entry for
> >>>> newly added nodes.
> >>>>
> >>>> Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> >>>> ---
> >>>>
> >>>>
> >>>> Hi Alan,
> >>>>
> >>>> Thanks for reporting the problem with missing node names.
> >>>>
> >>>> I was able to replicate the problem, and have created this preliminary
> >>>> version of a patch to fix the problem.
> >>>>
> >>>> I have not extensively reviewed the patch yet, but would appreciate
> >>>> if you can confirm this fixes your problem.
> >>>>
> >>>> I created this patch as patch 17 of the series, but have also
> >>>> applied it as patch 05.1, immediately after patch 05/16, and
> >>>> built the kernel, booted, and verified name and phandle for
> >>>> one of the nodes in a unittest overlay for both cases.  So
> >>>> minimal testing so far on my part.
> >>>>
> >>>> I have not verified whether the series builds and boots after
> >>>> each of patches 06..16 if this patch is applied as patch 05.1.
> >>>>
> >>>> There is definitely more work needed for me to complete this
> >>>> patch because it allocates some more memory, but does not yet
> >>>> free it when the overlay is released.
> >>>>
> >>>> -Frank
> >>>>
> >>>>
> >>>>  drivers/of/overlay.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++----
> >>>>  1 file changed, 67 insertions(+), 5 deletions(-)
> >>>>
> >>>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> >>>> index 0b0904f44bc7..9746cea2aa91 100644
> >>>> --- a/drivers/of/overlay.c
> >>>> +++ b/drivers/of/overlay.c
> >>>> @@ -301,10 +301,11 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
> >>>>       struct property *new_prop = NULL, *prop;
> >>>>       int ret = 0;
> >>>>
> >>>> -     if (!of_prop_cmp(overlay_prop->name, "name") ||
> >>>> -         !of_prop_cmp(overlay_prop->name, "phandle") ||
> >>>> -         !of_prop_cmp(overlay_prop->name, "linux,phandle"))
> >>>> -             return 0;
> >>>> +     if (target->in_livetree)
> >>>> +             if (!of_prop_cmp(overlay_prop->name, "name") ||
> >>>> +                 !of_prop_cmp(overlay_prop->name, "phandle") ||
> >>>> +                 !of_prop_cmp(overlay_prop->name, "linux,phandle"))
> >>>> +                     return 0;
> >>>
> >>> This is a big hammer patch.
> >>>
> >>> Nobody should waste time reviewing this patch.
> >>
> >> I wasn't clear if you still could use the testing so I did re-run my
> >> test.  This patch adds back some of the missing properties, but the
> >> the kobject names aren't set as dev_name() returns NULL:
> >>
> >> * without this patch some of_node properties don't show up in sysfs:
> >> root@arria10:~# ls
> >> /sys/bus/platform/drivers/altera_freeze_br/ff200450.\<NULL\>/of_node
> >> clocks            compatible        interrupt-parent  interrupts        reg
> >>
> >> * with this patch, the of_node properties phandle and name are back:
> >> root@arria10:~#  ls
> >> /sys/bus/platform/drivers/altera_freeze_br/ff200450.\<NULL\>/of_node
> >> clocks            compatible        interrupt-parent  interrupts
> >>  name              phandle           reg
> >
> > Thanks for the testing.  I'll keep chasing after this problem today.

Glad to help!  Thanks for all your work in this area!
> >
> > This is useful data for me as I was not looking under the /sys/bus/...
> > tree that you reported, but was instead looking at /proc/device-tree/...
> > which showed the same type of problem since the overlay I was using
> > does not show up under /sys/bus/...
> >
> > I'll have to create a useful overlay test case that will show up under
> > /sys/bus/...
> >
> > In the meantime, can you send me the base FDT and the overlay FDT for
> > your test case?
>
> I now have a test case that shows the problem under /sys/bus/... so I
> no longer need the base FDT and overlay FDT for your test case.
>
> I have determined the location that sets the name to "<NULL>" but do
> not have the fix yet.  Still working on that.

I understand you're quite busy with all this, but I'm wondering
whether it might be worth it go ahead and make the properties be
kernel objects also at this point.  That would be an improvement for
the case of overlay properties added to non-overlay nodes, so the
lifespan of the overlay property memory can be coupled with the
properties kobj's instead of the node kobj's.

Alan
