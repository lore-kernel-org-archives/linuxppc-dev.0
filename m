Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6BCB2B6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 18 Aug 2009 07:19:02 +1000 (EST)
Received: from mail-gx0-f215.google.com (mail-gx0-f215.google.com
	[209.85.217.215]) by ozlabs.org (Postfix) with ESMTP id C9257DDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Aug 2009 07:19:00 +1000 (EST)
Received: by gxk11 with SMTP id 11so4511611gxk.16
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Aug 2009 14:18:59 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4A83A976.60608@denx.de>
References: <4A83A976.60608@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 17 Aug 2009 15:18:37 -0600
Message-ID: <fa686aa40908171418k57ce5ff6iac44a72171bcf14a@mail.gmail.com>
Subject: Re: simple gpio driver
To: hs@denx.de
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 12, 2009 at 11:49 PM, Heiko Schocher<hs@denx.de> wrote:
> Hello Anton,
>
> i am trying to use the arch/powerpc/sysdev/simple_gpio.c driver,
> for accessing some gpios, and found, that u8_gpio_get()
> returns not only a 1 or a 0, instead it returns the real bit
> position from the gpio:
>
> gpio =A0 =A0return
> base =A0 =A0value
> 0 =A0 =A0 =A0 0/0x01
> 1 =A0 =A0 =A0 0/0x02
> 2 =A0 =A0 =A0 0/0x04
> 3 =A0 =A0 =A0 0/0x08
> 4 =A0 =A0 =A0 0/0x10
> 5 =A0 =A0 =A0 0/0x20
> 6 =A0 =A0 =A0 0/0x40
> 7 =A0 =A0 =A0 0/0x80
>
> I also use the arch/powerpc/platforms/52xx/mpc52xx_gpio.c and
> mpc52xx_gpt.c drivers, they all return for a gpio just a 1 or 0,
> which seems correct to me, because a gpio can have only 1 or 0
> as state ... what do you think?

I think returning '1' is perhaps slightly 'better' (however you define
that), but I don't think the caller should make any assumptions beyond
zero/non-zero.

>
> I solved this issue (if it is) with the following patch:
>
> diff --git a/arch/powerpc/sysdev/simple_gpio.c b/arch/powerpc/sysdev/simp=
le_gpio.c
> index 43c4569..bb0d79c 100644
> --- a/arch/powerpc/sysdev/simple_gpio.c
> +++ b/arch/powerpc/sysdev/simple_gpio.c
> @@ -46,7 +46,7 @@ static int u8_gpio_get(struct gpio_chip *gc, unsigned i=
nt gpio)
> =A0{
> =A0 =A0 =A0 =A0struct of_mm_gpio_chip *mm_gc =3D to_of_mm_gpio_chip(gc);
>
> - =A0 =A0 =A0 return in_8(mm_gc->regs) & u8_pin2mask(gpio);
> + =A0 =A0 =A0 return (in_8(mm_gc->regs) & u8_pin2mask(gpio) ? 1 : 0);

For clarity, the brackets should be just around the & operands, and
"!=3D 0" instead of "? 1 : 0" might result in slightly smaller code.

return (in_8(mm_gc->regs) & u8_pin2mask(gpio)) !=3D 0;
