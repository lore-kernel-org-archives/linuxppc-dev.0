Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 94720DDEE7
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 01:47:36 +1000 (EST)
Message-ID: <480770EE.9060407@ru.mvista.com>
Date: Thu, 17 Apr 2008 19:46:54 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: RFC: MPC5200 PSC AC97 driver
References: <47FDEF9B.5000506@semihalf.com>	<200804171619.56615.jbe@pengutronix.de>	<4807684C.4000508@genesi-usa.com>	<200804171723.27002.jbe@pengutronix.de>
	<4807701F.9030105@genesi-usa.com>
In-Reply-To: <4807701F.9030105@genesi-usa.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt Sealey wrote:

>>>> +    /* the fifo starts right after psc ends */
>>>> +    priv->fifo = (struct mpc52xx_psc_fifo*)&priv->psc[1];    /* 
>>>> FIXME */

>>> Wouldn't

>>>     priv->fifo = (struct mpc52xx_psc_fifo*) (priv->psc + sizeof(struct
>>> mpc52xx_psc));

>>> Be a little less obtuse use of C?

>> "priv->psc" is of type "struct mpc52xx_ac97_priv*". If I add 0x58 to 
>> it, wouldn't I add 0x58 times the size of "struct mpc52xx_ac97_priv"?

> I always got a result of MBAR+PSC_OFFSET(n)+0x58 out of it as I expected.

> priv->psc is of type struct mpc52xx_psc * which means it's just pointer
> arithmetic. If you add a value to it (not increment or so as if it's
> an array) then it just adds the value, no?

    Of course no -- that'll be pointer arithmetic unless you cast the pointer 
to an integer type.

WBR, Sergei
