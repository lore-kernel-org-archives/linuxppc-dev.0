Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26377C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 04:33:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4DE92086A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 04:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZq/zKOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4DE92086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445JPs3PB0zDqSw
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 15:33:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::141; helo=mail-it1-x141.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="AZq/zKOY"; 
 dkim-atps=neutral
Received: from mail-it1-x141.google.com (mail-it1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445JMv271mzDqSM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 15:32:11 +1100 (AEDT)
Received: by mail-it1-x141.google.com with SMTP id l15so1392006iti.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 20:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yftF1RPdL2CxQP0nSnz58TTBahtvyJK7k+m8g0ZWhfo=;
 b=AZq/zKOYoJ8SoIOnBVF1TPErpo6b6Xl54o4/8MoUC8F4b6L/iXfOMvhn3chnEYoSpg
 hwRMLd0Z1Rt8dfMD/LZjSfHT0CwYFA+3dhBzV86iBi7f3JjGx7Td6rc7MRUXc2724NS2
 3fXr9MeRzktyFOuNV+VYiiRQ5xENdKJDVt5TeWJGj3advZlzEvvbo669ksLdl6TqyVqB
 1CKC3cfKpt0E5kjopQCqO3hDOoUeB8VMwkPcf0TFMCNoDmKHIMv6xLCMOkccfIbtz/sF
 IHhkPKiEHEAcp2IwSwcjBjVoaCs7TVnR7o4WQTEE/djcCUhQscURHpTE89u981GPeWxb
 djyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yftF1RPdL2CxQP0nSnz58TTBahtvyJK7k+m8g0ZWhfo=;
 b=kf02IdovgZqUq6IekMPCVeu/v7Lje5ULyD5noKogCgYU/a1gAT/q3GxnxrKqNSf1G+
 8Sy/f0PhwSgX83gBCetqJX2fncrT01Wvvl52kHf+PS3DY2MXXcYqH2f2p86S5S67FYjv
 /5mLblTNGlB6Od8VrF//l/lLComOUlcI7mTOn4QXc72lZfoQy1eHBf0KeezXs+yRMzpZ
 m5qskjMGibJmcterH8gXwx2Xj7echgim8esFimBsK6B9sTJcM4M/x0v9YjDB48CeHEXr
 0MU29GBOP7gw5frIvjVPY1Us0vpd46XVsOFT1a1KIEs2EWG1OnLiKt5sZU28qIHtzxW/
 uAsw==
X-Gm-Message-State: AHQUAua2BKyc+ZLBfJSjiRLhCzzp3XDiIQhyUHz99JHhYVboqZolxYZy
 ujt3zxyr+GZuwq/NDJVXtt26wjCM6HBEp78bgiMb2Q==
X-Google-Smtp-Source: AHgI3Ib6b8JljpcNyQnh6hLRrciRVYQON16IFPW7a1iAc1NcnG3gX3/1IW6V4H/J1z/179g7X2ArtTa3ookt4LonTCk=
X-Received: by 2002:a24:9102:: with SMTP id i2mr1195276ite.4.1550809928607;
 Thu, 21 Feb 2019 20:32:08 -0800 (PST)
MIME-Version: 1.0
References: <f232553753fe148118646c9013a3d962c19b58ec.1550121250.git.sbobroff@linux.ibm.com>
 <20190222032320.GA4334@tungsten.ozlabs.ibm.com>
In-Reply-To: <20190222032320.GA4334@tungsten.ozlabs.ibm.com>
From: Oliver <oohall@gmail.com>
Date: Fri, 22 Feb 2019 15:31:57 +1100
Message-ID: <CAOSf1CFezjdgu1idFXmGoXUof0kPyAFcii30MMXXiuoVj0mJ7w@mail.gmail.com>
Subject: Re: [PATCH 1/1] powerpc/64: Adjust order in pcibios_init()
To: Sam Bobroff <sbobroff@linux.ibm.com>
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

On Fri, Feb 22, 2019 at 2:24 PM Sam Bobroff <sbobroff@linux.ibm.com> wrote:
>
> Hey all,
>
> After some consideration, I've decided to post a v2 of this patch that
> will make it a bit safer (although I haven't seen any problems with it)
> and make it a little easier to refactor some of the EEH code that
> interacts with the hooks.

Can you be a little more specific?

> Cheers,
> Sam.
>
> On Thu, Feb 14, 2019 at 04:14:42PM +1100, Sam Bobroff wrote:
> > The pcibios_init() function for 64 bit PowerPC currently calls
> > pci_bus_add_devices() before pcibios_resource_survey(), which seems
> > incorrect because it adds devices and attempts to bind their drivers
> > before allocating their resources (although no problems seem to be
> > apparent).
> >
> > So move the call to pci_bus_add_devices() to after
> > pcibios_resource_survey().
> >
> > This will also allow the ppc_md.pcibios_bus_add_device() hooks to
> > perform actions that depend on PCI resources, both during rescanning
> > (where this is already the case) and at boot time, which should
> > support improvements and refactoring.
> >
> > Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
> > ---
> > Hi everyone,
> >
> > I've tested this on a P9 for both the host and a KVM guest, and the change
> > hasn't caused any differences in PCI resource assignments or the general boot
> > messages.
> >
> > I've also had a go at inspecting most of the code used by pci_bus_add_devices()
> > and pcibios_resource_survey() and it doesn't look like there are going to be
> > any changes in behaviour caused by reordering.  It might be worth mentioning
> > that the hotplug path (see pcibios_finish_adding_to_bus()) already does
> > resource allocation before calling pci_bus_add_devices().
> >
> > However, it would be great if someone could test this change on some older
> > hardware or comment on wether we should make the same change on 32 bit machines.
> >
> > Cheers,
> > Sam.
> >
> >  arch/powerpc/kernel/pci_64.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
> > index 9d8c10d55407..1ce28888dbdb 100644
> > --- a/arch/powerpc/kernel/pci_64.c
> > +++ b/arch/powerpc/kernel/pci_64.c
> > @@ -58,14 +58,16 @@ static int __init pcibios_init(void)
> >       pci_add_flags(PCI_ENABLE_PROC_DOMAINS | PCI_COMPAT_DOMAIN_0);
> >
> >       /* Scan all of the recorded PCI controllers.  */
> > -     list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
> > +     list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
> >               pcibios_scan_phb(hose);
> > -             pci_bus_add_devices(hose->bus);
> > -     }
> >
> >       /* Call common code to handle resource allocation */
> >       pcibios_resource_survey();
> >
> > +     /* Add devices. */
> > +     list_for_each_entry_safe(hose, tmp, &hose_list, list_node)
> > +             pci_bus_add_devices(hose->bus);
> > +
> >       printk(KERN_DEBUG "PCI: Probing PCI hardware done\n");
> >
> >       return 0;
> > --
> > 2.19.0.2.gcad72f5712
> >
