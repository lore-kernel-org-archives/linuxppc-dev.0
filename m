Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4DFC9B7070
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2012 10:23:16 +1000 (EST)
Message-ID: <1335745382.20866.18.camel@pasglop>
Subject: Re: [PATCH] tty/serial/pmac_zilog: Fix "nobody cared" IRQ message
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Larry Finger <Larry.Finger@lwfinger.net>
Date: Mon, 30 Apr 2012 10:23:02 +1000
In-Reply-To: <4F9C830D.8040906@lwfinger.net>
References: <4F9C830D.8040906@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Andreas Schwab <schwab@linux-m68k.org>,
 linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2012-04-28 at 18:53 -0500, Larry Finger wrote:

> 
> Index: wireless-testing/drivers/tty/serial/pmac_zilog.c
> ===================================================================
> --- wireless-testing.orig/drivers/tty/serial/pmac_zilog.c	2012-04-28 
> 15:51:38.843723074 -0500
> +++ wireless-testing/drivers/tty/serial/pmac_zilog.c	2012-04-28 
> 18:34:34.053900600 -0500

Patch seems to be wrapped... I'll apply manually this time around but
check your mailer settings :-)

Cheers,
Ben.

> @@ -469,7 +469,7 @@
>   	tty = NULL;
>   	if (r3 & (CHAEXT | CHATxIP | CHARxIP)) {
>   		if (!ZS_IS_OPEN(uap_a)) {
> -			pmz_debug("ChanA interrupt while open !\n");
> +			pmz_debug("ChanA interrupt while not open !\n");
>   			goto skip_a;
>   		}
>   		write_zsreg(uap_a, R0, RES_H_IUS);
> @@ -493,8 +493,8 @@
>   	spin_lock(&uap_b->port.lock);
>   	tty = NULL;
>   	if (r3 & (CHBEXT | CHBTxIP | CHBRxIP)) {
> -		if (!ZS_IS_OPEN(uap_a)) {
> -			pmz_debug("ChanB interrupt while open !\n");
> +		if (!ZS_IS_OPEN(uap_b)) {
> +			pmz_debug("ChanB interrupt while not open !\n");
>   			goto skip_b;
>   		}
>   		write_zsreg(uap_b, R0, RES_H_IUS);
