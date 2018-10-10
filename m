Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A59C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 20:44:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AFA520870
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 20:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBrJZ3xw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AFA520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VmKZ34S9zF1Pw
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 07:44:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bBrJZ3xw";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=atull@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="bBrJZ3xw"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VmGp4nHmzDrpp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 07:41:38 +1100 (AEDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5AAC62087A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 20:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1539204096;
 bh=OrkN7KxkdSvrc20wJ/hQZ38586lSQ2+xdkl1UolA0h0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=bBrJZ3xw1TDHbaEGmYsqNwjqFqdExNUfhc8ruLJZes+6Jg6fy1lRoyWzUXb27q4Q8
 9Hmq3lbJ6FiXDiDwwztDtGuhUhRMSs5T2Nec2XGPoMx/4HrBgkuyViJl3mFEvf22uK
 9fGUZQbyyIREeO6x81h6QYtXm0z3cIPVQvT+KQeE=
Received: by mail-ed1-f54.google.com with SMTP id x31-v6so6192735edd.8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 13:41:36 -0700 (PDT)
X-Gm-Message-State: ABuFfogNPJqa9yGCp5PwDTHXVBM1O0YYG8IHdFNLVlxWvgf8x0cfYQKu
 sE6BWrmhH8+SvqZ7y0zu9GDbpGLsPUuPnBzPFT4=
X-Google-Smtp-Source: ACcGV63nyI/0I8uFmSBnmEJuKkDRZ+XJXPkaDLjKWvgtGflR9DOorpwtDSz08RqG4ZI0bqe32TNblg7hOFl3SZHYrcQ=
X-Received: by 2002:a17:906:32d9:: with SMTP id
 k25-v6mr35353869ejk.211.1539204094756; 
 Wed, 10 Oct 2018 13:41:34 -0700 (PDT)
MIME-Version: 1.0
References: <CANk1AXQScT_b1_UOiVuWNcB=LiA3gvvZrw53H1XVSCNqsGPqtA@mail.gmail.com>
 <1539151495-8110-1-git-send-email-frowand.list@gmail.com>
 <f20d06c3-5db7-3547-7b8b-d43d474683f1@gmail.com>
In-Reply-To: <f20d06c3-5db7-3547-7b8b-d43d474683f1@gmail.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 10 Oct 2018 15:40:58 -0500
X-Gmail-Original-Message-ID: <CANk1AXQ+-X51unT_ZHw+wxHG3tyGUKUihVsdzOZZ2NJ2zfS3Rg@mail.gmail.com>
Message-ID: <CANk1AXQ+-X51unT_ZHw+wxHG3tyGUKUihVsdzOZZ2NJ2zfS3Rg@mail.gmail.com>
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

On Wed, Oct 10, 2018 at 1:49 AM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 10/09/18 23:04, frowand.list@gmail.com wrote:
> > From: Frank Rowand <frank.rowand@sony.com>
> >
> >
> > "of: overlay: use prop add changeset entry for property in new nodes"
> > fixed a problem where an 'update property' changeset entry was
> > created for properties contained in nodes added by a changeset.
> > The fix was to use an 'add property' changeset entry.
> >
> > This exposed more bugs in the apply overlay code.  The properties
> > 'name', 'phandle', and 'linux,phandle' were filtered out by
> > add_changeset_property() as special properties.  Change the filter
> > to be only for existing nodes, not newly added nodes.
> >
> > The second bug is that the 'name' property does not exist in the
> > newest FDT version, and has to be constructed from the node's
> > full_name.  Construct an 'add property' changeset entry for
> > newly added nodes.
> >
> > Signed-off-by: Frank Rowand <frank.rowand@sony.com>
> > ---
> >
> >
> > Hi Alan,
> >
> > Thanks for reporting the problem with missing node names.
> >
> > I was able to replicate the problem, and have created this preliminary
> > version of a patch to fix the problem.
> >
> > I have not extensively reviewed the patch yet, but would appreciate
> > if you can confirm this fixes your problem.
> >
> > I created this patch as patch 17 of the series, but have also
> > applied it as patch 05.1, immediately after patch 05/16, and
> > built the kernel, booted, and verified name and phandle for
> > one of the nodes in a unittest overlay for both cases.  So
> > minimal testing so far on my part.
> >
> > I have not verified whether the series builds and boots after
> > each of patches 06..16 if this patch is applied as patch 05.1.
> >
> > There is definitely more work needed for me to complete this
> > patch because it allocates some more memory, but does not yet
> > free it when the overlay is released.
> >
> > -Frank
> >
> >
> >  drivers/of/overlay.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 67 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> > index 0b0904f44bc7..9746cea2aa91 100644
> > --- a/drivers/of/overlay.c
> > +++ b/drivers/of/overlay.c
> > @@ -301,10 +301,11 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
> >       struct property *new_prop = NULL, *prop;
> >       int ret = 0;
> >
> > -     if (!of_prop_cmp(overlay_prop->name, "name") ||
> > -         !of_prop_cmp(overlay_prop->name, "phandle") ||
> > -         !of_prop_cmp(overlay_prop->name, "linux,phandle"))
> > -             return 0;
> > +     if (target->in_livetree)
> > +             if (!of_prop_cmp(overlay_prop->name, "name") ||
> > +                 !of_prop_cmp(overlay_prop->name, "phandle") ||
> > +                 !of_prop_cmp(overlay_prop->name, "linux,phandle"))
> > +                     return 0;
>
> This is a big hammer patch.
>
> Nobody should waste time reviewing this patch.

I wasn't clear if you still could use the testing so I did re-run my
test.  This patch adds back some of the missing properties, but the
the kobject names aren't set as dev_name() returns NULL:

* without this patch some of_node properties don't show up in sysfs:
root@arria10:~# ls
/sys/bus/platform/drivers/altera_freeze_br/ff200450.\<NULL\>/of_node
clocks            compatible        interrupt-parent  interrupts        reg

* with this patch, the of_node properties phandle and name are back:
root@arria10:~#  ls
/sys/bus/platform/drivers/altera_freeze_br/ff200450.\<NULL\>/of_node
clocks            compatible        interrupt-parent  interrupts
 name              phandle           reg

root@arria10:~# cat
/sys/bus/platform/drivers/altera_freeze_br/ff200450.\<NULL\>/of_node/name
freeze_controllerroot@arria10:~#  ("freeze_controller" w/o the \n so
the name is correct)

* with or without the patch I see the behavior I reported yesterday,
kobj names are NULL.
root@arria10:~# ls /sys/bus/platform/drivers/altera_freeze_br/
bind             ff200450.<NULL>  uevent           unbind

root@arria10:~# ls /sys/bus/platform/drivers/altera_gpio/
bind             ff200010.<NULL>  ff200020.<NULL>  ff200030.<NULL>
uevent           unbind

Alan

Alan

>
> The following part should not be needed (though the above section might have
> to become _slightly_ more complex).
>
> -Frank
> >
> >       if (target->in_livetree)
> >               prop = of_find_property(target->np, overlay_prop->name, NULL);
> > @@ -443,10 +444,13 @@ static int build_changeset_next_level(struct overlay_changeset *ovcs,
> >               struct target *target, const struct device_node *overlay_node)
> >  {
> >       struct device_node *child;
> > -     struct property *prop;
> > +     struct property *prop, *name_prop;
> > +     bool has_name = false;
> >       int ret;
> >
> >       for_each_property_of_node(overlay_node, prop) {
> > +             if (!strcmp(prop->name, "name"))
> > +                     has_name = true;
> >               ret = add_changeset_property(ovcs, target, prop, 0);
> >               if (ret) {
> >                       pr_debug("Failed to apply prop @%pOF/%s, err=%d\n",
> > @@ -455,6 +459,57 @@ static int build_changeset_next_level(struct overlay_changeset *ovcs,
> >               }
> >       }
> >
> > +     /*
> > +      * With FDT version 0x10 we may not have the name property,
> > +      * recreate it here from the unit name if absent
> > +      */
> > +
> > +     if (!has_name) {
> > +             const char *p = target->np->full_name, *ps = p, *pa = NULL;
> > +             int len;
> > +
> > +             /*
> > +              * zzz
> > +              * TODO: stash name_prop on a list in ovcs, to be freed
> > +              * after overlay removed
> > +              */
> > +
> > +             while (*p) {
> > +                     if ((*p) == '@')
> > +                             pa = p;
> > +                     else if ((*p) == '/')
> > +                             ps = p + 1;
> > +                     p++;
> > +             }
> > +
> > +             if (pa < ps)
> > +                     pa = p;
> > +             len = (pa - ps) + 1;
> > +
> > +             name_prop = kmalloc(sizeof(*name_prop), GFP_KERNEL);
> > +             if (!name_prop)
> > +                     return -ENOMEM;
> > +
> > +             name_prop->name = kstrdup("name", GFP_KERNEL);
> > +             name_prop->value = kmalloc(len, GFP_KERNEL);
> > +             if (!name_prop->name || !name_prop->value) {
> > +                     ret = -ENOMEM;
> > +                     goto err_free_name_prop;
> > +             }
> > +
> > +             memcpy(name_prop->value, ps, len - 1);
> > +             ((char *)name_prop->value)[len - 1] = 0;
> > +
> > +             name_prop->length = strlen(name_prop->value) + 1;
> > +
> > +             ret = add_changeset_property(ovcs, target, name_prop, 0);
> > +             if (ret) {
> > +                     pr_debug("Failed to apply name_prop @%pOF/%s, err=%d\n",
> > +                              target->np, name_prop->name, ret);
> > +                     goto err_free_name_prop;
> > +             }
> > +     }
> > +
> >       for_each_child_of_node(overlay_node, child) {
> >               ret = add_changeset_node(ovcs, target, child);
> >               if (ret) {
> > @@ -466,6 +521,13 @@ static int build_changeset_next_level(struct overlay_changeset *ovcs,
> >       }
> >
> >       return 0;
> > +
> > +err_free_name_prop:
> > +     kfree(name_prop->name);
> > +     kfree(name_prop->value);
> > +     kfree(name_prop);
> > +     return ret;
> > +
> >  }
> >
> >  /*
> >
>
