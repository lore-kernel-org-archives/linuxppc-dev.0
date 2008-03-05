Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 11A31DDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Mar 2008 22:52:35 +1100 (EST)
Subject: RE: Virtual device hdlc0 asks to que packet!
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: rmcguire@videopresence.com
In-Reply-To: <1204711476.20637.54.camel@gentoo-jocke.transmode.se>
References: <mailman.1516.1204637021.17968.linuxppc-embedded@ozlabs.org>
	<000301c87e50$2bbdc680$6405a8c0@absolut>
	<1204704716.20637.50.camel@gentoo-jocke.transmode.se>
	<002801c87e9c$f57e4430$6405a8c0@absolut>
	<1204711476.20637.54.camel@gentoo-jocke.transmode.se>
Content-Type: text/plain
Date: Wed, 05 Mar 2008 12:52:33 +0100
Message-Id: <1204717953.20637.57.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Wed, 2008-03-05 at 11:04 +0100, Joakim Tjernlund wrote:
> On Wed, 2008-03-05 at 00:43 -0800, Russell McGuire wrote:
> > Jocke,
> > 
> > I wonder how one change this? I don't remember any of the API calls
> > referencing this, so maybe the default to 1000? Or perhaps that is protocol
> > specific. I will hunt through some of Freescale's Ethernet drivers and see
> > if I can't find anything.
> 
> default is 1000 for ethernet.
> See tx_queue_len in net/ethernet/eth.c, 
> ether_setup(struct net_device *dev)
> 
> Maybe you can find out from there.

In 
  int mpc8360hdlc_register_netdev_ops(struct net_device *dev, dev_data_t *dev_data)
add	
   dev->tx_queue_len = 100;

 Jocke
