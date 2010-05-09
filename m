Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f212.google.com (mail-gx0-f212.google.com
	[209.85.217.212]) by ozlabs.org (Postfix) with ESMTP id 40128B7D28
	for <linuxppc-dev@ozlabs.org>; Mon, 10 May 2010 08:04:52 +1000 (EST)
Received: by gxk4 with SMTP id 4so2072950gxk.2
	for <linuxppc-dev@ozlabs.org>; Sun, 09 May 2010 15:04:50 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1273011539-13994-1-git-send-email-agust@denx.de>
References: <g2xc2d0b6ec1005041339r9c40822w7a642f9bba976820@mail.gmail.com>
	<1273011539-13994-1-git-send-email-agust@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 10 May 2010 00:04:30 +0200
Message-ID: <i2xfa686aa41005091504ve2b35a09m23cd2dc13a331f86@mail.gmail.com>
Subject: Re: [PATCH] serial: mpc52xx_uart: fix null pointer dereference
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, leonardo.lists@gmail.com, gregkh@suse.de,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 5, 2010 at 12:18 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Commit 6acc6833510db8f72b5ef343296d97480555fda9
> introduced NULL pointer dereference and kernel crash
> on ppc32 machines while booting. Fix this bug now.
>
> Reported-by: Leonardo Chiquitto <leonardo.lists@gmail.com>
> Signed-off-by: Anatolij Gustschin <agust@denx.de>

Thanks for being so quick to pick up on this Anatolij.  I've been
traveling and not able to respond to stuff.  I see that Greg has
already picked this up (thanks Greg!), but FWIW:

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Actually, now that I look, this fix needs to go into Linus' tree right
away (not just linux-next) since the offending patch went in during
the 2.6.34 merge window.

Greg, I can either pick this up and push it out to Linus tomorrow, or
let you do it.  Whichever you prefer.  Let me know so I don't cause
conflicts in your tree.

On another note, this patch isn't actually the right fix, but that's
because this driver is such a horribly bad example of handling private
data that doing the right thing requires some re-architecting.  The
driver should not need any of that extra code in the module_init hook.
 For now this is the best thing to do, but I'll dig into it tomorrow
and see if I can churn out a patch to fix it properly for the 2.6.35
merge window.

Cheers and thanks,
g.

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
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
