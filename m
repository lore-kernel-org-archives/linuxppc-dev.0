Return-Path: <neko@genesi-usa.com>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.190])
	by ozlabs.org (Postfix) with ESMTP id A8F33DE208
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 01:43:37 +1000 (EST)
Received: by gv-out-0910.google.com with SMTP id p33so16343gvf.14
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 08:43:34 -0700 (PDT)
Message-ID: <4807701F.9030105@genesi-usa.com>
Date: Thu, 17 Apr 2008 16:43:27 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Juergen Beisert <jbe@pengutronix.de>
Subject: Re: RFC: MPC5200 PSC AC97 driver
References: <47FDEF9B.5000506@semihalf.com>
	<200804171619.56615.jbe@pengutronix.de>
	<4807684C.4000508@genesi-usa.com>
	<200804171723.27002.jbe@pengutronix.de>
In-Reply-To: <200804171723.27002.jbe@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Juergen Beisert wrote:
> On Thursday 17 April 2008 17:10, Matt Sealey wrote:
>> Juergen Beisert wrote:
>>> Hi,
>>> +	/* the fifo starts right after psc ends */
>>> +	priv->fifo = (struct mpc52xx_psc_fifo*)&priv->psc[1];	/* FIXME */
>> Wouldn't
>>
>> 	priv->fifo = (struct mpc52xx_psc_fifo*) (priv->psc + sizeof(struct
>> mpc52xx_psc));
>>
>> Be a little less obtuse use of C?
> 
> "priv->psc" is of type "struct mpc52xx_ac97_priv*". If I add 0x58 to it, 
> wouldn't I add 0x58 times the size of "struct mpc52xx_ac97_priv"?

I always got a result of MBAR+PSC_OFFSET(n)+0x58 out of it as I expected.

priv->psc is of type struct mpc52xx_psc * which means it's just pointer
arithmetic. If you add a value to it (not increment or so as if it's
an array) then it just adds the value, no?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
