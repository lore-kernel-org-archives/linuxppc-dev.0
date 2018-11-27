Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C82C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 04:02:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D550208E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 04:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QcPHoePk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D550208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433qqZ30m4zDqTC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 15:02:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QcPHoePk";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::e42; helo=mail-vs1-xe42.google.com;
 envelope-from=dianders@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="QcPHoePk";
 dkim-atps=neutral
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com
 [IPv6:2607:f8b0:4864:20::e42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433qlG2KpSzDqKP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 14:58:34 +1100 (AEDT)
Received: by mail-vs1-xe42.google.com with SMTP id v205so12885640vsc.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 19:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tjUd6rh9Oz+kjGbUZS5mymEL2IOV7D6CriXwQhdsMjU=;
 b=QcPHoePkZX1rXMUYdsVjgFNEGwWi1t+kNzgHHl7f02t25QRLbxRsn38LV2ypdJ1Bet
 e0+PckNHOH/jab6l82SPjcFUnqnD3WPfuEI6R4N3zDp97pjS+o0tFeOUkhgdRhgDOJYl
 Tkr5tUn3ZIRFk36wyPZPqRF9qxyxgtvKyaE9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tjUd6rh9Oz+kjGbUZS5mymEL2IOV7D6CriXwQhdsMjU=;
 b=NQqeuBaOHNZajtYYYhAxVE/zUJxP91xRXmMACLMI/rjzNyOjJS4vJ4tsCwx4GKuG+H
 JDHVqcGJRaN/IHSeWF5jf61aaERg+UKQqPjjnMqX1NF/MafEMGwjyoFUgO0hRf308K8B
 44fDTpGwHdIP30/x6xr27bNeLcHQiMKww9hykOfPQOJ4XGnRFyQzV+PmJz7/lMKfs4T+
 uc6sKpDG/TKntW6KXbv9iTOZHRymjb0aZOxFoXbljOjMxXNN7eOEXDMjsCGBnbvnVrKt
 6UF8PUG/Bu4NmLaFWSbsDGsZmaPgP+Po8pAUKhckjcBSVJJSmQ/SN+hVhfZ9WHGqjMqZ
 jzvA==
X-Gm-Message-State: AGRZ1gJHIgGOKDzk+idDnxS7UYmS1bpcnECb20YQFbFm6nMdHWjt62cJ
 3GekkahbxBnXdTjrkZsLW2U7xs0eGOg=
X-Google-Smtp-Source: AJdET5dDNuQQQAiWu5x/QHTPmuI53cHwgWmei5qOa78Qu0lRhUYHIATIlnWb6CRJ/165VDcsThMA/Q==
X-Received: by 2002:a67:c29c:: with SMTP id k28mr13329490vsj.130.1543291111506; 
 Mon, 26 Nov 2018 19:58:31 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com.
 [209.85.217.43])
 by smtp.gmail.com with ESMTPSA id q192sm1131510vkf.47.2018.11.26.19.58.31
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Nov 2018 19:58:31 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id p74so12911323vsc.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 19:58:31 -0800 (PST)
X-Received: by 2002:a67:6cc1:: with SMTP id
 h184mr13126300vsc.149.1543290760514; 
 Mon, 26 Nov 2018 19:52:40 -0800 (PST)
MIME-Version: 1.0
References: <20181112182659.245726-1-dianders@chromium.org>
 <20181112182659.245726-3-dianders@chromium.org>
 <20181114220744.GB4044@brain-police>
In-Reply-To: <20181114220744.GB4044@brain-police>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 26 Nov 2018 19:52:27 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WYa8Hfo0hN8eqTBsjGY7A0nnQBoG1nSrvQ92we+v5kuA@mail.gmail.com>
Message-ID: <CAD=FV=WYa8Hfo0hN8eqTBsjGY7A0nnQBoG1nSrvQ92we+v5kuA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
To: Will Deacon <will.deacon@arm.com>
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
Cc: linux-mips@linux-mips.org, dalias@libc.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, paulus@samba.org,
 linux-hexagon@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 kgdb-bugreport@lists.sourceforge.net, jhogan@kernel.org,
 linux-snps-arc@lists.infradead.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Vineet Gupta <vgupta@synopsys.com>, LKML <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, rkuo@codeaurora.org, paul.burton@mips.com,
 Jason Wessel <jason.wessel@windriver.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

On Wed, Nov 14, 2018 at 2:07 PM Will Deacon <will.deacon@arm.com> wrote:
>
> > +void __weak kgdb_call_nmi_hook(void *ignored)
> > +{
> > +     kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
> > +}
>
> I suppose you could pass the cpu as an argument, but it doesn't really
> matter.

I probably won't change it for now if it doesn't matter...


> Also, I think there are cases where the CSD callback can run without
> having received an IPI, so we could potentially up passing NULL for the regs
> here which probably goes boom.

Hrm, good point.  This is not a new issue so I'd tend to add it to the
TODO list rather than block the series.  I'll also add a comment in
the code since I'm touching it anyway.

Interestingly enough quite a bit of things continue to work just fine
even if this is NULL.  I simulated setting this to NULL for all CPUs
and I could drop into the debugger, type "btc" to backtrace all CPUs,
attach to kgdb, etc.  ...but when I typed "cpu 1" it went boom.  So it
seems like parts of kdb use this but definitely not everything.

Also interesting is that on MIPS this is always NULL.  I have no idea
why but my patch series preserves this oddity.  Presumably if someone
was on a SMP MIPS machine and did "cpu 1" from kdb they'd go boom too.

In general kdb has a lot of crufty stuff like this in it.  We need to
work to get rid of the cruft but one step at a time I think.

I've started a kgdb-wishlist:

https://bugs.chromium.org/p/chromium/issues/list?q=label%3Akgdb-wishlist

...and this is crbug.com/908723


> > +void __weak kgdb_roundup_cpus(void)
> > +{
> > +     call_single_data_t *csd;
> > +     int this_cpu = get_cpu();
>
> Do you actually need to disable preemption here? afaict, irqs are already
> disabled by the kgdb core.

Ah, right.  I can just use raw_smp_processor_id().  Done.  I didn't
try to see if I could use smp_processor_id() since
kgdb_call_nmi_hook() already used raw_smp_processor_id(), but I can
dig if you wish.


> > +     int cpu;
> > +
> > +     for_each_cpu(cpu, cpu_online_mask) {
>
> for_each_online_cpu(cpu) ?

Done.


> I'm assuming this is serialised wrt CPU hotplug somehow?

I doubt it.  I can add it to my wishlist (crbug.com/908722) , but I
don't think it's something I'm going to try to solve right now and
it's definitely not new.  I think we need to make some sort of attempt
in kgdb_cpu_enter() to stop hotplugging, though we'd have to take into
account that we may be entering kgdb in an IRQ context so it might be
hard to grab a mutex.  We need to account for it there since that
function has code like:

> while (kgdb_do_roundup && --time_left &&
>        (atomic_read(&masters_in_kgdb) + atomic_read(&slaves_in_kgdb)) !=
>    online_cpus)
> udelay(1000);

...and that would also be broken if cpus were plugging / unplugging.

In general, at least, the worst case would be that we'd either have an
extra 1 second delay entering the debugger (because we were waiting
for a CPU to respond that's been hotplugged) or we'd enter kgdb
without stopping one of the CPUs.  Neither of those is ideal but I
don't think we'd end up in too bad shape.

Oh, but actually, I guess I should probably check the error return of
smp_call_function_single_async() and if it returns an error I should
unset rounding_up...  That would make things behave slightly better
and is probably right anyway.


Overall: thank you very much for the review and the feedback.  Sorry
I'm not really fixing everything here.  My hope is to move things to a
slightly better state but I don't have time to fix everything.
Hopefully I can find some more time soon to fix more, or perhaps
someone else will.


-Doug
