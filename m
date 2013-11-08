Return-Path: <scottwood@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 161BB2C0077
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Nov 2013 08:16:24 +1100 (EST)
Message-ID: <1383945372.23598.211.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/85xx: don't init the mpic ipi for the SoC which
 has doorbell support
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Fri, 8 Nov 2013 15:16:12 -0600
In-Reply-To: <20131108015446.GA31761@pek-khao-d1.corp.ad.wrs.com>
References: <1383808637-26769-1-git-send-email-haokexin@gmail.com>
 <1383845691.23598.125.camel@snotra.buserror.net>
 <20131108015446.GA31761@pek-khao-d1.corp.ad.wrs.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-11-08 at 09:54 +0800, Kevin Hao wrote:
> On Thu, Nov 07, 2013 at 11:34:51AM -0600, Scott Wood wrote:
> > On Thu, 2013-11-07 at 15:17 +0800, Kevin Hao wrote:
> > > It makes no sense to initialize the mpic ipi for the SoC which has
> > > doorbell support. So set the smp_85xx_ops.probe to NULL for this
> > > case. Since the smp_85xx_ops.probe is also used in function
> > > smp_85xx_setup_cpu() to check if we need to invoke
> > > mpic_setup_this_cpu(), we introduce a new setup_cpu function
> > > smp_85xx_basic_setup() to remove this dependency.
> > 
> > Is there any harm caused by setting up the IPIs?
> 
> No real harm. Just make no sense to do so and it does cause confusion
> when you cat /proc/interrupts and get something like this:
>   507:          0          0   OpenPIC   2043 Edge      ipi call function
>   508:          0          0   OpenPIC   2044 Edge      ipi reschedule
>   509:          0          0   OpenPIC   2045 Edge      ipi call function single
>   DBL:       7053      10137   Doorbell interrupts
> 
> > 
> > What about other MPIC setup, such as setting the current task priority
> > register?
> 
> This is done by the invoking of function mpic_setup_this_cpu() in
> smp_85xx_setup_cpu().

OK...  Why are you splitting out smp_85xx_basic_setup()?  Where do you
call it other than from smp_85xx_setup_cpu()?  Couldn't you have just
removed the conditional without splitting up the function?  The change
log says it's "to check if we need to invoke mpic_setup_this_cpu()"
which doesn't make sense since we always want to call
mpic_setup_this_cpu() if we have an MPIC.

-Scott
