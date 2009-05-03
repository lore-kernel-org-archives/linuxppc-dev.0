Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C7E6FDDED1
	for <linuxppc-dev@ozlabs.org>; Mon,  4 May 2009 07:15:33 +1000 (EST)
Date: Sun, 03 May 2009 14:15:24 -0700 (PDT)
Message-Id: <20090503.141524.253766195.davem@davemloft.net>
To: rbrito@ime.usp.br
Subject: Re: [PATCH] powerpc: convert mace to netdev_ops
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090503114820.GA14926@ime.usp.br>
References: <20090427121633.GA29608@ime.usp.br>
	<20090427.054258.16622932.davem@davemloft.net>
	<20090503114820.GA14926@ime.usp.br>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Rog=E9rio Brito <rbrito@ime.usp.br>
Date: Sun, 3 May 2009 08:48:20 -0300

> I hope that this version is a slightly better fix to convert mace to
> netdev_ops.
> =

> This is against this morning's net-2.6 tree.
> =

> Signed-off-by: Rog=E9rio Brito <rbrito@ime.usp.br>

I'll apply this, thanks!  I made one change however.

> @@ -798,6 +807,13 @@ static irqreturn_t mace_interrupt(int irq, void =
*dev_id)
>      return IRQ_HANDLED;
>  }
>  =

> +/*
> + * In the following, the parameter "data" is treated like a pointer,=

> + * which is probably OK for 32 bit arches, but not for 64.
> + *
> + * (Are mace's found on any newer machines??) -- rbrito
> + *
> + */
>  static void mace_tx_timeout(unsigned long data)
>  {
>      struct net_device *dev =3D (struct net_device *) data;

I left this new comment out, as this is a common idiom (passing opaque
data as an 'unsigned long' argument to a callback) and casting it to a
pointer.

It also works perfectly fine on all 32-bit and 64-bit platforms.
