Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f223.google.com (mail-gx0-f223.google.com
	[209.85.217.223]) by ozlabs.org (Postfix) with ESMTP id DEFF8B7C09
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 18:20:38 +1100 (EST)
Received: by gxk23 with SMTP id 23so6186703gxk.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Dec 2009 23:20:36 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <200912220802.50090.roman.fietze@telemotive.de>
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
	<200912220802.50090.roman.fietze@telemotive.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 22 Dec 2009 00:20:16 -0700
Message-ID: <fa686aa40912212320v27c22752wbf63f1d2d4b61129@mail.gmail.com>
Subject: Re: [PATCH 05/13] powerpc/5200: LocalPlus driver: fix DMA TX
	interrupt request
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

On Tue, Dec 22, 2009 at 12:02 AM, Roman Fietze
<roman.fietze@telemotive.de> wrote:
>
> Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
> ---
> =A0arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c | =A0 =A04 ++--
> =A01 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc=
/platforms/52xx/mpc52xx_lpbfifo.c
> index 2fd1f3f..1e4f725 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
> @@ -460,9 +460,9 @@ mpc52xx_lpbfifo_probe(struct of_device *op, const str=
uct of_device_id *match)
> =A0 =A0 =A0 =A0if (!lpbfifo.bcom_tx_task)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_bcom_tx;
>
> - =A0 =A0 =A0 rc =3D request_irq(bcom_get_task_irq(lpbfifo.bcom_rx_task),
> + =A0 =A0 =A0 rc =3D request_irq(bcom_get_task_irq(lpbfifo.bcom_tx_task),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpc52xx_lpbfifo_bcom_irq,=
 0,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"mpc52xx-lpbfifo-rx", &l=
pbfifo);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"mpc52xx-lpbfifo-tx", &l=
pbfifo);

Is this really what you want?  In the TX path, it is the FIFO irq that
indicates the transfer is complete (ie, the DMA fills the FIFO and
finishes before the FIFO has drained).  If both irqs were enabled,
then the DMA irq would fire first, followed by the FIFO irq.  For the
use cases I was dealing with, the next transfer cannot be kicked off
until the FIFO has drained.

In the RX path, the DMA irq indicates that the transfer is complete
(ie, the localbus fills the FIFO and finishes before the DMA drains
the FIFO.

For my use cases, the RX DMA irq was always required, but the TX DMA
irq was never needed.

Does your use case differ?

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
