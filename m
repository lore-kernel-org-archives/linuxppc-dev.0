Return-Path: <Gang.Liu@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 10E802C00BA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Nov 2013 15:48:18 +1100 (EST)
Message-ID: <1385095656.16677.39.camel@linux>
Subject: Re: [PATCH] powerpc/gpio: Fix the wrong GPIO input data on
 MPC8572/MPC8536
From: Liu Gang <Gang.Liu@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Date: Fri, 22 Nov 2013 12:47:36 +0800
In-Reply-To: <1384993966.1403.466.camel@snotra.buserror.net>
References: <1384499789-3631-1-git-send-email-Gang.Liu@freescale.com>
 <1384901494.1403.383.camel@snotra.buserror.net>
 <1384916079.16677.26.camel@linux>
 <1384993966.1403.466.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
 linuxppc-dev@lists.ozlabs.org, r61911@freescale.com, b07421@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-11-20 at 18:32 -0600, Scott Wood wrote:
> For userspace value setting, it looks like gpiolib blocks the write if
> the pin if FLAG_IS_OUT is set.  This suggests that this is an error
> condition for other uses as well.  Though, I notice that
> mpc8xxx_gpio_dir_out() calls gpio_set() before actually changing the
> direction.  So it may be useful to avoid races where the wrong value is
> output briefly after the direction is changed (especially in open drain
> situations, where the signal could have a meaningful default even before
> we begin outputting).  But that raises the question of how you'd do that
> from userspace, and it also renders the to-be-output value as write-only
> data (until the direction is actually changed), since a readback would
> get the input value instead.
> 
> > So maybe it's better to eliminate the effects of the ->data to the
> > input pins when reading the status, regardless of the possible changes
> > of the pins and the data.
> > Do you think so?
> 
> Perhaps, but that doesn't require you to modify ->data in the get()
> function.
> 
> -Scott
> 
I think you considered about this more comprehensive.
I'll update the code without the modification of ->data in the get()
function, and also with the comments from Anatolij.

Best Regards,
Liu Gang
