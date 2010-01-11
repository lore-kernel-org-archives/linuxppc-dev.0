Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.210.179]) by ozlabs.org (Postfix) with ESMTP id C2B6D1007DA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 07:24:53 +1100 (EST)
Received: by yxe9 with SMTP id 9so10922154yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Jan 2010 12:24:51 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <200912220813.04321.roman.fietze@telemotive.de>
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
	<200912220813.04321.roman.fietze@telemotive.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 11 Jan 2010 13:24:31 -0700
Message-ID: <fa686aa41001111224t62fab22yd79c3865ea07f86d@mail.gmail.com>
Subject: Re: [PATCH 13/13] powerpc/5200: LocalPlus driver: clean up comments
To: Roman Fietze <roman.fietze@telemotive.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 22, 2009 at 12:13 AM, Roman Fietze
<roman.fietze@telemotive.de> wrote:
>
> Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>

If this description is no longer correct, then you must also add
comments describing the new behaviour.

Thanks for all the work on this.  I hope I haven't been too brutal on
my comments, but this device is subtle and the driver supports lots of
different transfer modes so I'm being cautious.  It will help if you
can tighten up your patches to split apart unrelated changes and to
write proper patch descriptions.

I look forward to your respin.

Cheers,
g.

> ---
> =A0arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c | =A0 14 --------------
> =A01 files changed, 0 insertions(+), 14 deletions(-)
>
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc=
/platforms/52xx/mpc52xx_lpbfifo.c
> index b2c92f5..a89072a 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
> @@ -206,17 +206,6 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbf=
ifo_request *req)
> =A0/**
> =A0* mpc52xx_lpbfifo_sclpc_irq - IRQ handler for LPB FIFO
> =A0*
> - * On transmit, the dma completion irq triggers before the fifo
> - * completion triggers. =A0Handle the dma completion here instead of the
> - * LPB FIFO Bestcomm task completion irq because everything is not
> - * really done until the LPB FIFO completion irq triggers.
> - *
> - * In other words:
> - * For DMA, on receive, the "Fat Lady" is the bestcom completion irq. on
> - * transmit, the fifo completion irq is the "Fat Lady". The opera (or in
> - * this case the DMA/FIFO operation) is not finished until the "Fat
> - * Lady" sings.
> - *
> =A0* Reasons for entering this routine:
> =A0* 1) PIO mode rx and tx completion irq
> =A0* 2) DMA interrupt mode tx completion irq
> @@ -411,9 +400,6 @@ void mpc52xx_lpbfifo_poll(void)
> =A0{
> =A0 =A0 =A0 =A0struct mpc52xx_lpbfifo_request *req =3D lpbfifo.req;
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* For more information, see comments on the "Fat Lady"
> - =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0if (mpc52xx_lpbfifo_is_dma(req->flags) && (req->flags & MP=
C52XX_LPBFIFO_FLAG_WRITE))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mpc52xx_lpbfifo_sclpc_irq(0, NULL);
> =A0 =A0 =A0 =A0else
> --
> 1.6.5.5
>
>
>
> --
> Roman Fietze =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Telemotive AG B=FCro M=FChlha=
usen
> Breitwiesen =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A073=
347 M=FChlhausen
> Tel.: +49(0)7335/18493-45 =A0 =A0 =A0 =A0http://www.telemotive.de
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
