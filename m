Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5EAC282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 05:20:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EA6D222BA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 05:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzPiRlBj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EA6D222BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43znsn0S7BzDqQt
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 16:20:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::143; helo=mail-it1-x143.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="mzPiRlBj"; 
 dkim-atps=neutral
Received: from mail-it1-x143.google.com (mail-it1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43znqz3n5DzDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 16:18:55 +1100 (AEDT)
Received: by mail-it1-x143.google.com with SMTP id y184so2848501itc.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 21:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uZznnOf6Kl86a0xsqpvMCLNpf4Ux779nlRiTz1OsQzA=;
 b=mzPiRlBjB5LI+FZGzWr3ptX/ZXOAaJu41aXmAbCXHlgZKapoNApk5lh47FOic7Mr+l
 DqeqxIrKlePsfrkZAuZDurPIcpp2otza6Cy9ydTaJ1mO+IfeEnzwOC6BsDirNtrYOjH/
 +VdI8d8/lMuoYUf4UeO1ZYfns/PJgGToeHy7FDmjbD2wk5snTTzXBZRuuITrRTpDJ96U
 bGYink1wwV1Mb59G+OmRHpUovX+dOADXq/LXauugc5ykvG4ukWeIb+u2cyd6pXHcvpJ/
 melP6SZo8+MGosGmBpCgKkKqVSkLbEeaKN7xr4Ti76mGd986bx3TsPOlK20UqNK8lczh
 xG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uZznnOf6Kl86a0xsqpvMCLNpf4Ux779nlRiTz1OsQzA=;
 b=aYd0RpB6ouqMy9rDQ8+Zy19D+I+Ys0/H31DLHnZ2JbrsXH7EbM4smYyzpvJea3OM/7
 R/izfQPUEfsHioX/a/W5d+9uxDORJYx3frrsq9xOXjyFWkJP87qktlvwclcFj+XWeEGJ
 eRDBVEw3vXUq5vPlnKqvoXJyIuAF0Q6JqsthWy+JSZdo9Xs0ehT/61k2HcjWs5zMuEsZ
 mUNjEZWRdU15iCa0P0kERKcy6YKM387ddwez2dGv33CAm5V/2TajQu19lEZtZvAvxMB7
 +YlEqzEPEOrcX3fpFG9aEycB0/wE/LIRzDpIizF2ZOye+Bgs0mvVUt3ftZaR94Y7K0RP
 ngjA==
X-Gm-Message-State: AHQUAuaSioHn/bfWustWxAzsSGJrx/Z3CklKz3CyuXT+4yGhLbE0WET7
 6gIsRCvnhMcNEJf7nd4yQX8sRPikaswQI/Qk/Gu3KA==
X-Google-Smtp-Source: AHgI3IaT24kL8AxbdNMJYsfEm7FM1RFFThP7LCGTOD6sKlYGx0pyPCbF3LQvaHvQ3QUmu9dE7HubQBVl+JbbO8ld4EU=
X-Received: by 2002:a24:9102:: with SMTP id i2mr1208969ite.4.1550035133164;
 Tue, 12 Feb 2019 21:18:53 -0800 (PST)
MIME-Version: 1.0
References: <20190208030802.10805-1-oohall@gmail.com>
 <20190208030802.10805-7-oohall@gmail.com>
 <20190213042948.GA28303@tungsten.ozlabs.ibm.com>
In-Reply-To: <20190213042948.GA28303@tungsten.ozlabs.ibm.com>
From: Oliver <oohall@gmail.com>
Date: Wed, 13 Feb 2019 16:18:41 +1100
Message-ID: <CAOSf1CEAmcCH=FrExUMyQc-qqP342gGbCFbA=REA4P5oW120TQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] powerpc/eeh: Add eeh_force_recover to debugfs
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

On Wed, Feb 13, 2019 at 3:38 PM Sam Bobroff <sbobroff@linux.ibm.com> wrote:
>
> On Fri, Feb 08, 2019 at 02:08:02PM +1100, Oliver O'Halloran wrote:
> > This patch adds a debugfs interface to force scheduling a recovery event.
> > This can be used to recover a specific PE or schedule a "special" recovery
> > even that checks for errors at the PHB level.
> > To force a recovery of a normal PE, use:
> >
> >  echo '<#pe>:<#phb>' > /sys/kernel/debug/powerpc/eeh_force_recover
>
> How about placing these in the per-PHB debugfs directory?
> echo '<#pe>' > /sys/kernel/debug/powerpc/PCI0000/eeh_force_recover
>
> > To force a scan broken PHBs:
> >
> >  echo 'null' > /sys/kernel/debug/powerpc/eeh_force_recover
>
> And keep this one where it is, and just trigger with any write (or a '1'
> or whatever)?

The per-PHB directories only exist on PowerNV. I'd rather this was
merged as-is since it handles both platforms. If we want to add the
per-PHB debugfs stuff to pseries we can do it later.

>
> Sam.
>
> > Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> > ---
> >  arch/powerpc/include/asm/eeh_event.h |  1 +
> >  arch/powerpc/kernel/eeh.c            | 60 ++++++++++++++++++++++++++++
> >  arch/powerpc/kernel/eeh_event.c      | 25 +++++++-----
> >  3 files changed, 76 insertions(+), 10 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/eeh_event.h b/arch/powerpc/include/asm/eeh_event.h
> > index 9884e872686f..6d0412b846ac 100644
> > --- a/arch/powerpc/include/asm/eeh_event.h
> > +++ b/arch/powerpc/include/asm/eeh_event.h
> > @@ -33,6 +33,7 @@ struct eeh_event {
> >
> >  int eeh_event_init(void);
> >  int eeh_send_failure_event(struct eeh_pe *pe);
> > +int __eeh_send_failure_event(struct eeh_pe *pe);
> >  void eeh_remove_event(struct eeh_pe *pe, bool force);
> >  void eeh_handle_normal_event(struct eeh_pe *pe);
> >  void eeh_handle_special_event(void);
> > diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
> > index 92809b137e39..63b91a4918c9 100644
> > --- a/arch/powerpc/kernel/eeh.c
> > +++ b/arch/powerpc/kernel/eeh.c
> > @@ -1805,6 +1805,63 @@ static int eeh_enable_dbgfs_get(void *data, u64 *val)
> >
> >  DEFINE_DEBUGFS_ATTRIBUTE(eeh_enable_dbgfs_ops, eeh_enable_dbgfs_get,
> >                        eeh_enable_dbgfs_set, "0x%llx\n");
> > +
> > +static ssize_t eeh_force_recover_write(struct file *filp,
> > +                             const char __user *user_buf,
> > +                             size_t count, loff_t *ppos)
> > +{
> > +     struct pci_controller *hose;
> > +     uint32_t phbid, pe_no;
> > +     struct eeh_pe *pe;
> > +     char buf[20];
> > +     int ret;
> > +
> > +     ret = simple_write_to_buffer(buf, sizeof(buf), ppos, user_buf, count);
> > +     if (!ret)
> > +             return -EFAULT;
> > +
> > +     /*
> > +      * When PE is NULL the event is a "special" event. Rather than
> > +      * recovering a specific PE it forces the EEH core to scan for failed
> > +      * PHBs and recovers each. This needs to be done before any device
> > +      * recoveries can occur.
> > +      */
> > +     if (!strncmp(buf, "null", 4)) {
> > +             pr_err("sending failure event\n");
> > +             __eeh_send_failure_event(NULL);
> > +             return count;
> > +     }
> > +
> > +     ret = sscanf(buf, "%x:%x", &phbid, &pe_no);
> > +     if (ret != 2)
> > +             return -EINVAL;
> > +
> > +     hose = pci_find_hose_for_domain(phbid);
> > +     if (!hose)
> > +             return -ENODEV;
> > +
> > +     /* Retrieve PE */
> > +     pe = eeh_pe_get(hose, pe_no, 0);
> > +     if (!pe)
> > +             return -ENODEV;
> > +
> > +     /*
> > +      * We don't do any state checking here since the detection
> > +      * process is async to the recovery process. The recovery
> > +      * thread *should* not break even if we schedule a recovery
> > +      * from an odd state (e.g. PE removed, or recovery of a
> > +      * non-isolated PE)
> > +      */
> > +     __eeh_send_failure_event(pe);
> > +
> > +     return ret < 0 ? ret : count;
> > +}
> > +
> > +static const struct file_operations eeh_force_recover_fops = {
> > +     .open   = simple_open,
> > +     .llseek = no_llseek,
> > +     .write  = eeh_force_recover_write,
> > +};
> >  #endif
> >
> >  static int __init eeh_init_proc(void)
> > @@ -1820,6 +1877,9 @@ static int __init eeh_init_proc(void)
> >               debugfs_create_bool("eeh_disable_recovery", 0600,
> >                               powerpc_debugfs_root,
> >                               &eeh_debugfs_no_recover);
> > +             debugfs_create_file_unsafe("eeh_force_recover", 0600,
> > +                             powerpc_debugfs_root, NULL,
> > +                             &eeh_force_recover_fops);
> >               eeh_cache_debugfs_init();
> >  #endif
> >       }
> > diff --git a/arch/powerpc/kernel/eeh_event.c b/arch/powerpc/kernel/eeh_event.c
> > index 19837798bb1d..539aca055d70 100644
> > --- a/arch/powerpc/kernel/eeh_event.c
> > +++ b/arch/powerpc/kernel/eeh_event.c
> > @@ -121,20 +121,11 @@ int eeh_event_init(void)
> >   * the actual event will be delivered in a normal context
> >   * (from a workqueue).
> >   */
> > -int eeh_send_failure_event(struct eeh_pe *pe)
> > +int __eeh_send_failure_event(struct eeh_pe *pe)
> >  {
> >       unsigned long flags;
> >       struct eeh_event *event;
> >
> > -     /*
> > -      * If we've manually supressed recovery events via debugfs
> > -      * then just drop it on the floor.
> > -      */
> > -     if (eeh_debugfs_no_recover) {
> > -             pr_err("EEH: Event dropped due to no_recover setting\n");
> > -             return 0;
> > -     }
> > -
> >       event = kzalloc(sizeof(*event), GFP_ATOMIC);
> >       if (!event) {
> >               pr_err("EEH: out of memory, event not handled\n");
> > @@ -153,6 +144,20 @@ int eeh_send_failure_event(struct eeh_pe *pe)
> >       return 0;
> >  }
> >
> > +int eeh_send_failure_event(struct eeh_pe *pe)
> > +{
> > +     /*
> > +      * If we've manually supressed recovery events via debugfs
> > +      * then just drop it on the floor.
> > +      */
> > +     if (eeh_debugfs_no_recover) {
> > +             pr_err("EEH: Event dropped due to no_recover setting\n");
> > +             return 0;
> > +     }
> > +
> > +     return __eeh_send_failure_event(pe);
> > +}
> > +
> >  /**
> >   * eeh_remove_event - Remove EEH event from the queue
> >   * @pe: Event binding to the PE
> > --
> > 2.20.1
> >
