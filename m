Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8CT728HvzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 10:58:51 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id hh10so1803733pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Aug 2016 17:58:51 -0700 (PDT)
Date: Wed, 10 Aug 2016 10:58:43 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Scott Wood
 <oss@buserror.net>, Alessio Igor Bogani <alessio.bogani@elettra.eu>, Paul
 Mackerras <paulus@samba.org>, Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v2 3/3] powerpc: Convert fsl_rstcr_restart to a reset
 handler
Message-ID: <20160810105843.0941fecb@roar.ozlabs.ibm.com>
In-Reply-To: <CAHQ1cqFCfS52zaGEPJU-KRTRc7rjnFmUQwQgZYms3jaaYb41bQ@mail.gmail.com>
References: <1469747238-17432-1-git-send-email-andrew.smirnov@gmail.com>
 <1469747238-17432-3-git-send-email-andrew.smirnov@gmail.com>
 <20160801140351.49119867@roar.ozlabs.ibm.com>
 <CAHQ1cqFCfS52zaGEPJU-KRTRc7rjnFmUQwQgZYms3jaaYb41bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 9 Aug 2016 11:47:37 -0700
Andrey Smirnov <andrew.smirnov@gmail.com> wrote:

> On Sun, Jul 31, 2016 at 9:03 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > On Thu, 28 Jul 2016 16:07:18 -0700
> > Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> >  
> >> Convert fsl_rstcr_restart into a function to be registered with
> >> register_reset_handler().
> >>
> >> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> >> ---
> >>
> >> Changes since v1:
> >>
> >>       - fsl_rstcr_restart is registered as a reset handler in
> >>           setup_rstcr, replacing per-board arch_initcall approach  
> >
> > Bear in mind I don't know much about the embedded or platform code!
> >
> > The documentation for reset notifiers says that they are expected
> > to be registered from drivers, not arch code. That seems to only be
> > intended to mean that the standard ISA or platform reset would
> > normally be handled directly by the arch, whereas if you have an
> > arch specific driver for a reset hardware that just happens to live
> > under arch/, then fsl_rstcr_restart / mpc85xx_cds_restart would be
> > valid use of reset notifier.  
> 
> Yeah, IMHO there's quite a bit of code in sysdev/ which in ideal world
> would go into drivers/ and I think fsl_rstcr_restart is among it
> (similar example on MIPS is drivers/power/reset/brcmstb-reboot.c).
> 
> >
> > So this change seems reasonable to me. One small question:
> >
> >  
> >> +static int mpc85xx_cds_restart_register(void)
> >> +{
> >> +     static struct notifier_block restart_handler;
> >> +
> >> +     restart_handler.notifier_call = mpc85xx_cds_restart;
> >> +     restart_handler.priority = 192;  
> >
> > Should there be a header with #define's for these priorities?  
> 
> I don't have any strong preference either way, I do however think that
> introducing such #define should go into a separate patch-set, since
> you'd probably want to propagate that change across all of the users
> of the API.

You're probably right. I was thinking because powerpc has not used it
before we could use local defines, but it really does need a global
location.

Thanks,
Nick
