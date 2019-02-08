Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B49C169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:39:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5DF12146E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 14:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mw24eyNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5DF12146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wyW64Y7QzDqKM
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 01:39:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::143; helo=mail-it1-x143.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="Mw24eyNf"; 
 dkim-atps=neutral
Received: from mail-it1-x143.google.com (mail-it1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wwck5F8zzDqXL
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Feb 2019 00:14:14 +1100 (AEDT)
Received: by mail-it1-x143.google.com with SMTP id z20so8694707itc.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Feb 2019 05:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XLE0ZJ52QG6EDB9dwSa9Rgf83hJQwNmrvd/7CGTz2AE=;
 b=Mw24eyNfv6WrPu9PD8PjLrgJD0bCtLwP3K4YV9humRmWJQRooITiVXPdaB/YIFoFTF
 iP27m1mirYxZjxs6KoqS2kR+ruEekgXqsFGvlJAOx1pnah8yZGdZlB3Iw5hiBg/57Q1b
 d2G4fEy6veXJnv7NMvEZV5G4U0fHmMVK8qQdraVZMALU3oMAo5EjD1NSDO9AvYKfhdXd
 CnXAmIit4nAibBwG1nLnItNJmebkOqlpnQ3I4koK/63JlxnJzbwS6PxOApZGB2oNzsd6
 W/QCApNZVfpRdxFuoYcVqMWIL3UVcyS/7wYMjexmry7K0oW0UOcOTHi94xC/XZkVB9gg
 Etkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XLE0ZJ52QG6EDB9dwSa9Rgf83hJQwNmrvd/7CGTz2AE=;
 b=cmUpk7b74Z3VSt/Xb90hey91lSlMTrxWVGpjH3v41T/LbK8tGa354BYdEe5/F+7AKm
 qrcTDDoQ/VqfqOcpO/eVTWXg3R/l4bV+AREEPjxLcAWaGs2rS9zIIBhWE42IzJ94LvYI
 vdpm5zV3MRoF1dcF+wKo15VKDhReCIW8FfD6vgGX7Aa4SHTHtsev25x9NhG5a2AKgRG1
 oitcx0La0UK9g77lqfokWOjUh8z68bYw+H0GehiTTQZtVg9yFjereXsZCawNoFGi+9s1
 gSRz3dTWwKuEOsLp9v9YeqJnb1T7UDW2v6Pyu+AytZX8o4e+6dlBuAy0tn/SevAlBlIq
 ICnQ==
X-Gm-Message-State: AHQUAubxJLQ/wQizeJyK9k/cwK9hOoQbOGglCXOPjJXp1FTF4jZID/1Y
 wc//09oo00heslgNLlLKFObikSJ0sU8QKFuGmpk=
X-Google-Smtp-Source: AHgI3IbRuEjrtEqvWz2hByr1jqGsuqLBQg4Pbs209QkF6gFCl+9bQ/cmAbdzXSq91duwP5tt1PnQBHmBVKh/83KiaO8=
X-Received: by 2002:a6b:ec05:: with SMTP id c5mr625887ioh.279.1549631652484;
 Fri, 08 Feb 2019 05:14:12 -0800 (PST)
MIME-Version: 1.0
References: <20190208030802.10805-1-oohall@gmail.com>
 <20190208030802.10805-3-oohall@gmail.com>
 <875ztuk3x0.fsf@concordia.ellerman.id.au>
In-Reply-To: <875ztuk3x0.fsf@concordia.ellerman.id.au>
From: Oliver <oohall@gmail.com>
Date: Sat, 9 Feb 2019 00:14:01 +1100
Message-ID: <CAOSf1CE4GES__w+Ps77Rg=uVV42F5uAetNQ3VC8GRZ0K6xZ-YA@mail.gmail.com>
Subject: Re: [PATCH 3/7] powerpc/eeh_cache: Add a way to dump the EEH address
 cache
To: Michael Ellerman <mpe@ellerman.id.au>
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 8, 2019 at 8:47 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Oliver O'Halloran <oohall@gmail.com> writes:
> > diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> > index f6e65375a8de..d1f0bdf41fac 100644
> > --- a/arch/powerpc/kernel/eeh.c
> > +++ b/arch/powerpc/kernel/eeh.c
> > @@ -1810,7 +1810,7 @@ static int __init eeh_init_proc(void)
> >                                          &eeh_enable_dbgfs_ops);
> >               debugfs_create_u32("eeh_max_freezes", 0600,
> >                               powerpc_debugfs_root, &eeh_max_freezes);
> > -#endif
> > +             eeh_cache_debugfs_init();
>
> Oops :)

Yeah :(

> > diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
> > index b2c320e0fcef..dba421a577e7 100644
> > --- a/arch/powerpc/kernel/eeh_cache.c
> > +++ b/arch/powerpc/kernel/eeh_cache.c
> > @@ -298,9 +299,34 @@ void eeh_addr_cache_build(void)
> >               eeh_addr_cache_insert_dev(dev);
> >               eeh_sysfs_add_device(dev);
> >       }
> > +}
> >
> > -#ifdef DEBUG
> > -     /* Verify tree built up above, echo back the list of addrs. */
> > -     eeh_addr_cache_print(&pci_io_addr_cache_root);
> > -#endif
> > +static int eeh_addr_cache_show(struct seq_file *s, void *v)
> > +{
> > +     struct rb_node *n = rb_first(&pci_io_addr_cache_root.rb_root);
> > +     struct pci_io_addr_range *piar;
> > +     int cnt = 0;
> > +
> > +     spin_lock(&pci_io_addr_cache_root.piar_lock);
> > +     while (n) {
> > +             piar = rb_entry(n, struct pci_io_addr_range, rb_node);
> > +
> > +             seq_printf(s, "%s addr range %3d [%pap-%pap]: %s\n",
> > +                    (piar->flags & IORESOURCE_IO) ? "i/o" : "mem", cnt,
> > +                    &piar->addr_lo, &piar->addr_hi, pci_name(piar->pcidev));
> > +
> > +             n = rb_next(n);
> > +             cnt++;
> > +     }
>
> You can write that as a for loop can't you?
>
>         struct rb_node *n;
>         int i = 0;
>
>         for (n = rb_first(&pci_io_addr_cache_root.rb_root); n; n = rb_next(n), i++) {

IIRC I did try that, but it's too long. 85 cols wide according to my editor.

>                 piar = rb_entry(n, struct pci_io_addr_range, rb_node);
>
>                 seq_printf(s, "%s addr range %3d [%pap-%pap]: %s\n",
>                        (piar->flags & IORESOURCE_IO) ? "i/o" : "mem", i,
>                        &piar->addr_lo, &piar->addr_hi, pci_name(piar->pcidev));
>         }
>
> cheers
