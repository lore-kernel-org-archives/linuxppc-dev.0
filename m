Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 49B6FB7B65
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 08:15:30 +1100 (EST)
Received: by yxe8 with SMTP id 8so2604853yxe.17
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 13:15:29 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <18304285.1257929369240.JavaMail.ngmail@webmail19.ha2.local>
References: <18304285.1257929369240.JavaMail.ngmail@webmail19.ha2.local>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 12 Nov 2009 14:15:09 -0700
Message-ID: <fa686aa40911121315h4374711ftf07314cc4d9e7aff@mail.gmail.com>
Subject: Re: [PATCH] mpc5200/gpt: tiny fix for gpt period limitation
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
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

On Wed, Nov 11, 2009 at 1:49 AM, Albrecht Dre=DF <albrecht.dress@arcor.de> =
wrote:
> This patch fixes a limitation of the 5200's period.
>
> Signed-off-by: Albrecht Dre=DF <albrecht.dress@arcor.de>

Okay, I've applied this and patches 1 & 2 from your series.  I'm
waiting for a reply from Wim to know whether or not I should also pick
up patch 3.  BUT, you're on my shit list.  Patch 2 in your series
conflicts with this patch.  I had to fix it up by hand.  This patch
should have been part of the series, or at least base the series on
this patch.  Take a look in my -test branch and make sure I fixed it
right.

g.

> ---
>
> =A0arch/powerpc/include/asm/mpc52xx.h =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A0arch/powerpc/platforms/52xx/mpc52xx_gpt.c | =A0 =A06 +++---
> =A02 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mpc52xx.h b/arch/powerpc/include/as=
m/mpc52xx.h
> index 707ab75..933fb8f 100644
> --- a/arch/powerpc/include/asm/mpc52xx.h
> +++ b/arch/powerpc/include/asm/mpc52xx.h
> @@ -279,7 +279,7 @@ extern void mpc52xx_restart(char *cmd);
> =A0/* mpc52xx_gpt.c */
> =A0struct mpc52xx_gpt_priv;
> =A0extern struct mpc52xx_gpt_priv *mpc52xx_gpt_from_irq(int irq);
> -extern int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *gpt, int per=
iod,
> +extern int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *gpt, u64 per=
iod,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int continuous);
> =A0extern void mpc52xx_gpt_stop_timer(struct mpc52xx_gpt_priv *gpt);
>
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/pla=
tforms/52xx/mpc52xx_gpt.c
> index 2c3fa13..77572ab 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
> @@ -378,12 +378,12 @@ EXPORT_SYMBOL(mpc52xx_gpt_from_irq);
> =A0/**
> =A0* mpc52xx_gpt_start_timer - Set and enable the GPT timer
> =A0* @gpt: Pointer to gpt private data structure
> - * @period: period of timer
> + * @period: period of timer in ns; max. ~130s @ 33MHz IPB clock
> =A0* @continuous: set to 1 to make timer continuous free running
> =A0*
> =A0* An interrupt will be generated every time the timer fires
> =A0*/
> -int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *gpt, int period,
> +int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *gpt, u64 period,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int continuous)
> =A0{
> =A0 =A0 =A0 =A0u32 clear, set;
> @@ -400,7 +400,7 @@ int mpc52xx_gpt_start_timer(struct mpc52xx_gpt_priv *=
gpt, int period,
> =A0 =A0 =A0 =A0 * arithmatic is done here to preserve the precision until=
 the value
> =A0 =A0 =A0 =A0 * is scaled back down into the u32 range. =A0Period is in=
 'ns', bus
> =A0 =A0 =A0 =A0 * frequency is in Hz. */
> - =A0 =A0 =A0 clocks =3D (u64)period * (u64)gpt->ipb_freq;
> + =A0 =A0 =A0 clocks =3D period * (u64)gpt->ipb_freq;
> =A0 =A0 =A0 =A0do_div(clocks, 1000000000); /* Scale it down to ns range *=
/
>
> =A0 =A0 =A0 =A0/* This device cannot handle a clock count greater than 32=
 bits */
>
>
> Jetzt NEU: Do it youself E-Cards bei Arcor.de!
> Stellen Sie Ihr eigenes Unikat zusammen und machen Sie dem Empf=E4nger ei=
ne ganz pers=F6nliche Freude!
> E-Card Marke Eigenbau: HIER KLICKEN: http://www.arcor.de/rd/footer.ecard
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
