Return-Path: <shemminger@vyatta.com>
Received: from mail.vyatta.com (mail.vyatta.com [76.74.103.46])
	by ozlabs.org (Postfix) with ESMTP id 67ED2DDDF6
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Feb 2009 09:41:23 +1100 (EST)
Date: Wed, 18 Feb 2009 14:31:16 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
To: David Miller <davem@davemloft.net>
Subject: Re: net_device_ops support in bridging and fec_mpc52xx.c
Message-ID: <20090218143116.69948299@extreme>
In-Reply-To: <20090218.134852.118040610.davem@davemloft.net>
References: <ae4f76fd0902180241s28458450hd91ebf8da94ceb53@mail.gmail.com>
	<20090218.134852.118040610.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, henk.stegeman@gmail.com, bridge@osdl.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 18 Feb 2009 13:48:52 -0800 (PST)
David Miller <davem@davemloft.net> wrote:

> From: Henk Stegeman <henk.stegeman@gmail.com>
> Date: Wed, 18 Feb 2009 11:41:14 +0100
> 
> Please CC: netdev, now added, on all networking reports and patches.
> 
> Thank you.
> 
> > I discovered the hard way that because linux bridging uses
> > net_device_ops, bridging only works with network drivers that publish
> > their device operations trough net_device_ops.
> > 
> > In my case running:
> > 
> > brctl addif br0 eth0 (where eth0 fec_mpc52xx.c did not yet support
> > net_device_ops) gave me a:
> > 
> > Unable to handle kernel paging request...
> > 
> > After changing fec_mpc52xx.c to support net_device_ops the problem was fixed.
> > 
> > If possible some kind of detection in the bridging software is i think
> > mostly appreciated for early detection of this problem, as it is
> > pretty hard to relate the error message to a not updated driver.
> > 
> > cheers,
> > 
> > Henk

The normal register_netdevice stuff take care of setting up net_device_ops
for old style drivers. Was there something different about how this
device was being setup?
