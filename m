Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f201.google.com (mail-yw0-f201.google.com
	[209.85.211.201]) by ozlabs.org (Postfix) with ESMTP id D87991007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 07:00:42 +1100 (EST)
Received: by ywh39 with SMTP id 39so20282616ywh.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Jan 2010 12:00:41 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <200912220805.20200.roman.fietze@telemotive.de>
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
	<200912220805.20200.roman.fietze@telemotive.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 11 Jan 2010 13:00:21 -0700
Message-ID: <fa686aa41001111200q2cfb4b5cs838f27a84bb1c89a@mail.gmail.com>
Subject: Re: [PATCH 07/13] powerpc/5200: LocalPlus driver: reset BestComm when
	committing new request
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

On Tue, Dec 22, 2009 at 12:05 AM, Roman Fietze
<roman.fietze@telemotive.de> wrote:
>

Again, need a description as to 'why?'

> Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
> ---
> =A0arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c | =A0 =A04 +++-
> =A01 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc=
/platforms/52xx/mpc52xx_lpbfifo.c
> index 8d8a63a..a7cd585 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
> @@ -398,6 +398,8 @@ int mpc52xx_lpbfifo_submit(struct mpc52xx_lpbfifo_req=
uest *req)
> =A0 =A0 =A0 =A0req->buffer_not_done_cnt =3D 0;
> =A0 =A0 =A0 =A0req->pos =3D 0;
>
> + =A0 =A0 =A0 bcom_gen_bd_rx_reset(lpbfifo.bcom_rx_task);
> + =A0 =A0 =A0 bcom_gen_bd_tx_reset(lpbfifo.bcom_tx_task);
> =A0 =A0 =A0 =A0mpc52xx_lpbfifo_kick(req);
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&lpbfifo.lock, flags);
>
> @@ -456,7 +458,7 @@ mpc52xx_lpbfifo_probe(struct of_device *op, const str=
uct of_device_id *match)
> =A0 =A0 =A0 =A0lpbfifo.bcom_rx_task =3D bcom_gen_bd_rx_init(4,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 res.start + offsetof(struct mpc52xx_sclpc, fifo=
_data),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 BCOM_INITIATOR_SCLPC, BCOM_IPR_SCLPC,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A016*1024*1024);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A016 * 1024 * 1024);

Unrelated change.  Please drop.

g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
