Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 542BCDDE1F
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Mar 2009 08:55:15 +1100 (EST)
Date: Fri, 27 Mar 2009 14:55:02 -0700 (PDT)
Message-Id: <20090327.145502.214872726.davem@davemloft.net>
To: Joakim.Tjernlund@transmode.se
Subject: Re: [PATCH 1/2] ucc_geth: Move freeing of TX packets to NAPI context.
From: David Miller <davem@davemloft.net>
In-Reply-To: <OF073D5C49.F0D791DE-ONC1257586.0040163D-C1257586.00413F47@transmode.se>
References: <1238072077-27044-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<2a27d3730903270350m52fcb837ge78c0b87cc3887d5@mail.gmail.com>
	<OF073D5C49.F0D791DE-ONC1257586.0040163D-C1257586.00413F47@transmode.se>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, leoli@freescale.com, pku.leo@gmail.com,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Fri, 27 Mar 2009 12:52:41 +0100

> pku.leo@gmail.com wrote on 27/03/2009 11:50:09:
> > It doesn't make sense to have larger napi budget than the size of RX
> > BD ring.  You can't have more BDs than RX_BD_RING_LEN in backlog for
> > napi_poll to process.  Increase the RX_BD_RING_LEN if you want to
> > increase UCC_GETH_DEV_WEIGHT.  However please also provide the
> > performance comparison for this kind of change.  Thanks
> 
> Bring it up with David Miller.

Right I told him to make this very change.

Pretty soon the driver's won't be able to select this value
and it will default to 64 everwhere anyways.

"performance comparison"?  He can't do that unless he tests
performance with two active NAPI devices on the same exact
cpu as the weight value is for fairness between devices.

So you don't tweak "weight" to make one device perform better,
you tweak it to eliminate unfairness between multiple devices.
And the only way to achieve that is to use similar values
across all devices, perhaps link-speed rated which we can't
do just yet, and that's why I told him to use 64 just like
every other driver basically does.
