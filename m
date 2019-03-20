Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535BFC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 06:26:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1C82183E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 06:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RuTdMLR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1C82183E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PKgC31PJzDqNn
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 17:25:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::d42; helo=mail-io1-xd42.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="RuTdMLR3"; 
 dkim-atps=neutral
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PKdS03B4zDq7n
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 17:24:26 +1100 (AEDT)
Received: by mail-io1-xd42.google.com with SMTP id s7so921025iom.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 23:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZLLbPiNxS9kIlENwbPXjrKmLJ52TeevFnWralsZuRfc=;
 b=RuTdMLR3bIC26rE/4nu2+O9mR42iaxjVYiwDExSQ2YJZroLCDONbic/C2qz7udIlj0
 ke+zFz2zSXQBH8/4WxKuFo3W+BBbz+JNEq45enFnOw73wH5HJjlilvnotM227FHKbCL/
 liZZYggxv7lweSxfMYw9OumJiVFv256lcC3llQuUeDcaQwOOG8nSkrEnKt+uHgeMRjZH
 73BeIZjkQ0b72+37lFHNoVY1m3KVcHz0pep1D1WxRTIOIpx7nR3ppbsx/ysriRQXbpFL
 5ObxmYRsLoR/p10HskyjkLgV/kiRUTI1avBns2urhk0KTmpVad36oZlHzv3MsF5u3WRv
 UBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZLLbPiNxS9kIlENwbPXjrKmLJ52TeevFnWralsZuRfc=;
 b=VqS6nfDBkTFRPzKLaX5lJeltnDgH0+CLP+66nzWEWRpDPdkv5kiSIS1xKneWpfoQDv
 ecHcg8URdzEjqwENmfdEgKFLGBXgwB6cnfp3CHaToiQFn/7AzjhFXDbjPEUgOg63K5tm
 E+S2uSI5gBLRa1onAwZyCOGjyL4+crzI1WK0DkJXoUs9KxAM+7Dn8xgsMP4NglG/r3kY
 8E2Y/wUPNtzro0rKLlS32VQrNyom02BY8+l0lYSO7o37AhdcYgIqPtY6IEevPhpB1phE
 0nP2dqDXt97jQQD4TvZK4VzIkVC7+yy0i07jGqp7y55AUML6REgmXoEKt2tq4EDO+24/
 3JUw==
X-Gm-Message-State: APjAAAV+vLybSBk1SFE9q5HjRj4TuxV9zqq6mqG/5NGvSF5ysO5KNM4H
 Gb2yjoKS/Po9OBj59LwNaaJTvrnoGThLVUtYNVOTuQ==
X-Google-Smtp-Source: APXvYqwzPak4im2umS2UXFpKU8KSlOeXwoU4SwnWirNBvj/Fk8zBNsPl43n9iZwVAsdXBkDEq8w5BvH2QLgNBA/bz5o=
X-Received: by 2002:a5e:db0d:: with SMTP id q13mr3816521iop.279.1553063062123; 
 Tue, 19 Mar 2019 23:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553050609.git.sbobroff@linux.ibm.com>
 <ad8cf11e3151fd39c6a9deedc0098d50274c75e4.1553050609.git.sbobroff@linux.ibm.com>
 <26b7c0de-4192-eae5-f8aa-94073b3e768e@ozlabs.ru>
In-Reply-To: <26b7c0de-4192-eae5-f8aa-94073b3e768e@ozlabs.ru>
From: Oliver <oohall@gmail.com>
Date: Wed, 20 Mar 2019 17:24:10 +1100
Message-ID: <CAOSf1CHE-2AUqQq20w88x80Z8ONpO7XLSUwSgG9Vjn8ogsK=jA@mail.gmail.com>
Subject: Re: [PATCH 5/8] powerpc/eeh: Add eeh_show_enabled()
To: Alexey Kardashevskiy <aik@ozlabs.ru>
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
Cc: Sam Bobroff <sbobroff@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 20, 2019 at 5:06 PM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>
>
>
> On 20/03/2019 13:58, Sam Bobroff wrote:
> > Move the EEH enabled message into it's own function so that future
> > work can call it from multiple places.
> >
> > Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> > ---
> >  arch/powerpc/include/asm/eeh.h |  3 +++
> >  arch/powerpc/kernel/eeh.c      | 16 +++++++++++-----
> >  2 files changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> > index fe4cf7208890..e217ccda55d0 100644
> > --- a/arch/powerpc/include/asm/eeh.h
> > +++ b/arch/powerpc/include/asm/eeh.h
> > @@ -289,6 +289,7 @@ struct pci_bus *eeh_pe_bus_get(struct eeh_pe *pe);
> >
> >  struct eeh_dev *eeh_dev_init(struct pci_dn *pdn);
> >  void eeh_dev_phb_init_dynamic(struct pci_controller *phb);
> > +void eeh_show_enabled(void);
> >  void eeh_probe_devices(void);
> >  int __init eeh_ops_register(struct eeh_ops *ops);
> >  int __exit eeh_ops_unregister(const char *name);
> > @@ -338,6 +339,8 @@ static inline bool eeh_enabled(void)
> >          return false;
> >  }
> >
> > +static inline void eeh_show_enabled(void) { }
> > +
> >  static inline bool eeh_phb_enabled(void)
> >  {
> >       return false;
> > diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> > index b14d89547895..3dcff29cb9b3 100644
> > --- a/arch/powerpc/kernel/eeh.c
> > +++ b/arch/powerpc/kernel/eeh.c
> > @@ -163,6 +163,16 @@ static int __init eeh_setup(char *str)
> >  }
> >  __setup("eeh=", eeh_setup);
> >
> > +void eeh_show_enabled(void)
> > +{
> > +     if (eeh_has_flag(EEH_FORCE_DISABLED))
> > +             pr_info("EEH: PCI Enhanced I/O Error Handling DISABLED (by eeh=off)\n");
> > +     else if (eeh_enabled())
>
>
> I'd make it eeh_has_flag(EEH_ENABLED) for clarity.
>
>
> > +             pr_info("EEH: PCI Enhanced I/O Error Handling ENABLED (capable adapter found)\n");
> > +     else
> > +             pr_info("EEH: PCI Enhanced I/O Error Handling DISABLED (no capable adapter found)\n");
> > +}
> > +
> >  /*
> >   * This routine captures assorted PCI configuration space data
> >   * for the indicated PCI device, and puts them into a buffer
> > @@ -1166,11 +1176,7 @@ void eeh_probe_devices(void)
> >               pdn = hose->pci_data;
> >               traverse_pci_dn(pdn, eeh_ops->probe, NULL);
> >       }
> > -     if (eeh_enabled())
> > -             pr_info("EEH: PCI Enhanced I/O Error Handling Enabled\n");
> > -     else
> > -             pr_info("EEH: No capable adapters found\n");
> > -
> > +     eeh_show_enabled();
>
>
> This line moves later in the series so I'd just merge this patch into
> 8/8 to reduce number of lines moving withing the patchset.
>
> In general the whole point of the EEH_ENABLED flag is fading away. Its
> meaning now is that "at least somewhere in the box for at least one
> device with enabled EEH" which does not seem extremely useful as we have
> a pci_dev or pe pretty much everywhere we look at eeh_enabled() and
> pdev->dev.archdata.edev can tell if eeh is enabled for a device.
> Although I am pretty sure this is in your list already :)

The other function is to disable attempting to detect EEH errors when
we get 0xFFs from an MMIO load, but I don't think anyone ever disables
it.

> >  }
> >
> >  /**
> >
>
> --
> Alexey
