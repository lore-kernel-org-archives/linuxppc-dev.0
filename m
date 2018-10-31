Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6856C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 21:49:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A6020821
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 21:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hRfi3Kd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A6020821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lhnW6y2wzF3Kk
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Nov 2018 08:49:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hRfi3Kd5";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=chromium.org
 (client-ip=2607:f8b0:4864:20::a44; helo=mail-vk1-xa44.google.com;
 envelope-from=dianders@chromium.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=chromium.org header.i=@chromium.org header.b="hRfi3Kd5";
 dkim-atps=neutral
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com
 [IPv6:2607:f8b0:4864:20::a44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lhkr4bcJzF3KQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Nov 2018 08:47:15 +1100 (AEDT)
Received: by mail-vk1-xa44.google.com with SMTP id b207so4315951vke.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 14:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9OZBU7xBbZRq91LmWRsKb1e+HamrGUSqJjfkZGsW5iY=;
 b=hRfi3Kd5G9/BLYolaPFaixRBSy8QElOUfTm0fyNwi5G2el/3A087MYoMPAXTtCvmr6
 aqtzB3yUpqwbaMtfyXn9KPe/xCBryhqzS5lXRDQiilI7KlDKS9tpNMeE3EhIpseZtToC
 y5ZSqIZ1fBG/MJmna3J4vq+E8lJ01mfbgfTEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9OZBU7xBbZRq91LmWRsKb1e+HamrGUSqJjfkZGsW5iY=;
 b=Ngpun1cxNVSX5Z+RD1O9wjInjmUSzrSCHg6JJYDEh5wDoDmt07qmkHWVCQ1Twrzxvt
 HMrZDKCXAOlV1aOs7SKJU1ebMq9V0bqZu2zdVb+dlce0MPPeHuEhMldaM0+x1JS0i/Vh
 k6PJIuAJfsRy68tvZiLrpU31iPX1Hen5/HkYkMRNm24h6tscx8i4qa0xcF5RdWZ3Uc80
 GeWgt0kyleBlzvRYPF4HU5HbVkYtUWJrSb+qFOLuev+QzumrWRsAKdR5fIyMTp9xzjWb
 e5Zombx+t+yWadZDM1VA7pwz7CjUWybIvbFpuHHgwP6ljLJQ/+B6c9HRUamNMhIAoeCJ
 5ekw==
X-Gm-Message-State: AGRZ1gJ/P+yZlI+OA56KzatWZJuYj/EK2NA/QcsJcH0Cx7i6ZWtXASig
 yLv4AOFoVoi55+iVV1WW3VrCsmvH3Vw=
X-Google-Smtp-Source: AJdET5cHKb0iqXxwubIprEWfWJNuSmdkywD5OupA1PGBROeBc8Nq2E58iF5xFPefHZFcrCSGRO8nIA==
X-Received: by 2002:a1f:c20d:: with SMTP id s13mr2222182vkf.9.1541022432714;
 Wed, 31 Oct 2018 14:47:12 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com.
 [209.85.217.50])
 by smtp.gmail.com with ESMTPSA id x1sm12377873vsh.5.2018.10.31.14.47.12
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Oct 2018 14:47:12 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id w194so11022341vsc.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 14:47:12 -0700 (PDT)
X-Received: by 2002:a67:6642:: with SMTP id a63mr2174631vsc.42.1541022087194; 
 Wed, 31 Oct 2018 14:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181030221843.121254-1-dianders@chromium.org>
 <20181030221843.121254-3-dianders@chromium.org>
 <20181031184050.sd5opni3mznaapkv@holly.lan>
In-Reply-To: <20181031184050.sd5opni3mznaapkv@holly.lan>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 31 Oct 2018 14:41:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V1eHo7Wz31DTMMNi394qwEaESTxJCYVE60Q7hpDEqRmQ@mail.gmail.com>
Message-ID: <CAD=FV=V1eHo7Wz31DTMMNi394qwEaESTxJCYVE60Q7hpDEqRmQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] kgdb: Fix kgdb_roundup_cpus() for arches who used
 smp_call_function()
To: Daniel Thompson <daniel.thompson@linaro.org>
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-mips@linux-mips.org,
 dalias@libc.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 LKML <linux-kernel@vger.kernel.org>, paulus@samba.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, linux-hexagon@vger.kernel.org,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 kgdb-bugreport@lists.sourceforge.net, jhogan@kernel.org,
 linux-snps-arc@lists.infradead.org, Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 Vineet Gupta <vgupta@synopsys.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ralf Baechle <ralf@linux-mips.org>, rkuo@codeaurora.org, paul.burton@mips.com,
 Jason Wessel <jason.wessel@windriver.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

On Wed, Oct 31, 2018 at 11:40 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Oct 30, 2018 at 03:18:43PM -0700, Douglas Anderson wrote:
> > diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> > index f3cadda45f07..9a3f952de6ed 100644
> > --- a/kernel/debug/debug_core.c
> > +++ b/kernel/debug/debug_core.c
> > @@ -55,6 +55,7 @@
> >  #include <linux/mm.h>
> >  #include <linux/vmacache.h>
> >  #include <linux/rcupdate.h>
> > +#include <linux/irq.h>
> >
> >  #include <asm/cacheflush.h>
> >  #include <asm/byteorder.h>
> > @@ -220,6 +221,39 @@ int __weak kgdb_skipexception(int exception, struct pt_regs *regs)
> >       return 0;
> >  }
> >
> > +/*
> > + * Default (weak) implementation for kgdb_roundup_cpus
> > + */
> > +
> > +static DEFINE_PER_CPU(call_single_data_t, kgdb_roundup_csd);
> > +
> > +void __weak kgdb_call_nmi_hook(void *ignored)
> > +{
> > +     kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
> > +}
> > +
> > +void __weak kgdb_roundup_cpus(void)
> > +{
> > +     call_single_data_t *csd;
> > +     int cpu;
> > +
> > +     for_each_cpu(cpu, cpu_online_mask) {
> > +             csd = &per_cpu(kgdb_roundup_csd, cpu);
> > +             smp_call_function_single_async(cpu, csd);
> > +     }
>
> smp_call_function() automatically skips the calling CPU but this code does
> not. It isn't a hard bug since kgdb_nmicallback() does a re-entrancy
> check but I'd still prefer to skip the calling CPU.

I'll incorporate this into the next version.


> As mentioned in another part of the thread we can also add robustness
> by skipping a cpu where csd->flags != 0 (and adding an appropriately
> large comment regarding why). Doing the check directly is abusing
> internal knowledge that smp.c normally keeps to itself so an accessor
> of some kind would be needed.

Sure.  I could add smp_async_func_finished() that just looked like:

int smp_async_func_finished(call_single_data_t *csd)
{
  return !(csd->flags & CSD_FLAG_LOCK);
}

My understanding of all the mutual exclusion / memory barrier concepts
employed by smp.c is pretty weak, though.  I'm hoping that it's safe
to just access the structure and check the bit directly.

...but do you think adding a generic accessor like this is better than
just keeping track of this in kgdb directly?  I could avoid the
accessor by adding a "rounding_up" member to "struct
debuggerinfo_struct" and doing something like this in roundup:

  /* If it didn't round up last time, don't try again */
  if (kgdb_info[cpu].rounding_up)
    continue

  kgdb_info[cpu].rounding_up = true
  smp_call_function_single_async(cpu, csd);

...and then in kgdb_nmicallback() I could just add:

  kgdb_info[cpu].rounding_up = false

In that case we're not adding a generic accessor to smp.c that most
people should never use.


I'll wait to hear back from you if you think the accessor is OK.  It
seems like it might be nice not to have to add something to smp.c just
for this one use case.


> > +}
> > +
> > +static void kgdb_generic_roundup_init(void)
> > +{
> > +     call_single_data_t *csd;
> > +     int cpu;
> > +
> > +     for_each_possible_cpu(cpu) {
> > +             csd = &per_cpu(kgdb_roundup_csd, cpu);
> > +             csd->func = kgdb_call_nmi_hook;
> > +     }
> > +}
>
> I can't help noticing this code is very similar to kgdb_roundup_cpus. Do
> we really gain much from ahead-of-time initializing csd->func?

Oh!  Right...  At first I thought about just trying to put the "csd"
on the stack in kgdb_roundup_cpus() but then I realized that it needed
to persist past the end of kgdb_roundup_cpus().  ...and once I gave up
on the idea of putting it on the stack I decided I needed the init.

...but you're right that I don't really.  The only thing I'm initting
is the function pointer and it totally wouldn't hurt to just init that
over and over again every time kgdb_roundup_cpus() is called.

-Doug
