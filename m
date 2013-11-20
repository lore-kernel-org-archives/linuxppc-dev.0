Return-Path: <Gang.Liu@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8F45F2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 13:07:44 +1100 (EST)
Message-ID: <1384913245.16677.5.camel@linux>
Subject: Re: [PATCH] powerpc/gpio: Fix the wrong GPIO input data on
 MPC8572/MPC8536
From: Liu Gang <Gang.Liu@freescale.com>
To: Anatolij Gustschin <agust@denx.de>
Date: Wed, 20 Nov 2013 10:07:25 +0800
In-Reply-To: <20131119163230.70964d1f@crub>
References: <1384499789-3631-1-git-send-email-Gang.Liu@freescale.com>
 <20131119163230.70964d1f@crub>
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

On Tue, 2013-11-19 at 16:32 +0100, Anatolij Gustschin wrote:
> On Fri, 15 Nov 2013 15:16:29 +0800
> Liu Gang <Gang.Liu@freescale.com> wrote:
> 
> > For MPC8572/MPC8536, the status of GPIOs defined as output
> > cannot be determined by reading GPDAT register, so the code
> > use shadow data register instead. But if the input pins are
> > asserted high, they will always read high due to the shadow
> > data, even if the pins are set to low.
> 
> Could you please add a better description of the problem?
> I'm having some difficulties to understand the last sentence
> above. Does the issue appear if some pins were configured as
> inputs and were asserted high before booting the kernel, and
> therefore the shadow data has been initialized with these pin
> values?
> 
> Or does the issue appear if some pin has been configured as output
> first and has been set to the high value, then reconfigured as
> input? Now reading the pin state will always return high even
> if the actual pin state is low?
> 
> It seems the issue will appear in both cases. If so, please add
> this information to the commit message.
> 
Yes, you are right.
I'll updated the description more clear.

> >  	val = in_be32(mm->regs + GPIO_DAT) & ~in_be32(mm->regs + GPIO_DIR);
> > +	mpc8xxx_gc->data &= in_be32(mm->regs + GPIO_DIR);
> 
> we can reduce one in_be32() call here, i.e.
> 
> 	u32 out_mask;
> 	...
> 	out_mask = in_be32(mm->regs + GPIO_DIR);
> 	val = in_be32(mm->regs + GPIO_DAT) & ~out_mask;
> 	mpc8xxx_gc->data &= out_mask;
> 
> >  	return (val | mpc8xxx_gc->data) & mpc8xxx_gpio2mask(gpio);
> >  }
> 
> Thanks,
> 
> Anatolij
> 
Granted, it will be better to reduce one in_be32() call.
I'll improve the method based on your and Scott's comments.

Thanks
Liu Gang
