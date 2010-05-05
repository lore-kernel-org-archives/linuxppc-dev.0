Return-Path: <leonardo.lists@gmail.com>
Received: from mail-ww0-f42.google.com (mail-ww0-f42.google.com [74.125.82.42])
	by ozlabs.org (Postfix) with ESMTP id AEFEAB7D40
	for <linuxppc-dev@ozlabs.org>; Wed,  5 May 2010 22:40:49 +1000 (EST)
Received: by wwb34 with SMTP id 34so3348885wwb.15
	for <linuxppc-dev@ozlabs.org>; Wed, 05 May 2010 05:40:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1273011539-13994-1-git-send-email-agust@denx.de>
References: <g2xc2d0b6ec1005041339r9c40822w7a642f9bba976820@mail.gmail.com>
	<1273011539-13994-1-git-send-email-agust@denx.de>
Date: Wed, 5 May 2010 09:40:47 -0300
Message-ID: <s2ic2d0b6ec1005050540nb382fc0aj70c4f132543a66aa@mail.gmail.com>
Subject: Re: [PATCH] serial: mpc52xx_uart: fix null pointer dereference
From: Leonardo Chiquitto <leonardo.lists@gmail.com>
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, gregkh@suse.de, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 4, 2010 at 7:18 PM, Anatolij Gustschin <agust@denx.de> wrote:
> Commit 6acc6833510db8f72b5ef343296d97480555fda9
> introduced NULL pointer dereference and kernel crash
> on ppc32 machines while booting. Fix this bug now.
>
> Reported-by: Leonardo Chiquitto <leonardo.lists@gmail.com>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
> =A0drivers/serial/mpc52xx_uart.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.=
c
> index a176ab4..02469c3 100644
> --- a/drivers/serial/mpc52xx_uart.c
> +++ b/drivers/serial/mpc52xx_uart.c
> @@ -1467,7 +1467,7 @@ mpc52xx_uart_init(void)
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Map the PSC FIFO Controller and init if on MPC512x.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (psc_ops->fifoc_init) {
> + =A0 =A0 =A0 if (psc_ops && psc_ops->fifoc_init) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D psc_ops->fifoc_init();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> --
> 1.7.0.4

Thanks for the quick fix, Anatolij. I just tested it and confirm it resolve=
s
the problem.

Leonardo
