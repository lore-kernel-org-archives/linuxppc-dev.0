Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 4EDCDDDE9F
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 17:04:19 +1000 (EST)
Subject: RE: ucc_geth DPRAM alloc error, 2.6.22-rc3
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Li Yang-r58472 <LeoLi@freescale.com>
In-Reply-To: <989B956029373F45A0B8AF0297081890D2AD35@zch01exm26.fsl.freescale.net>
References: <989B956029373F45A0B8AF0297081890D2AD35@zch01exm26.fsl.freescale.net>
Content-Type: text/plain
Date: Thu, 14 Jun 2007 09:04:16 +0200
Message-Id: <1181804656.30670.346.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-06-14 at 11:37 +0800, Li Yang-r58472 wrote:
> > -----Original Message-----
> > From: Li Yang-r58472
> > Sent: Thursday, June 14, 2007 11:15 AM
> > To: 'joakim.tjernlund@transmode.se'; 'linuxppc-dev Development'
> > Subject: RE: ucc_geth DPRAM alloc error, 2.6.22-rc3
> > 
> > > -----Original Message-----
> > > From: Joakim Tjernlund [mailto:joakim.tjernlund@transmode.se]
> > > Sent: Wednesday, June 13, 2007 10:22 PM
> > > To: 'linuxppc-dev Development'; Li Yang-r58472
> > > Subject: ucc_geth DPRAM alloc error, 2.6.22-rc3
> > >
> > > Trying to bring up a third ethernet i/f(ifconfig eth2 up) on
> > > a Freescale 832x CPU gives me this:
> > >  ifconfig eth2 up
> > >  ucc_geth_startup: Can not allocate DPRAM memory for
> p_thread_data_tx.
> > >  eth2: Cannot configure net device, aborting.
> > >  SIOCSIFFLAGS: Cannot allocate memory
> > >
> > > This worked in 2.6.20
> > Hi Joakim,
> > 
> > Thanks for the bug report.  The cause of this problem is that ucc_geth
> is set to work in 1000Mbps mode.  However, 8323 only supports
> > 100Mbps.  1000Mbps mode consumes much more MURAM for virtual FIFO.
> 
> 
> You can try adding the following property in your ucc node.
> 	phy-connection-type = "mii"

Tried that and it failed too.

   Jocke
