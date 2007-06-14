Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 033C0DDEDF
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 17:58:04 +1000 (EST)
Subject: RE: ucc_geth DPRAM alloc error, 2.6.22-rc3
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Li Yang-r58472 <LeoLi@freescale.com>
In-Reply-To: <989B956029373F45A0B8AF0297081890D2ADA9@zch01exm26.fsl.freescale.net>
References: <989B956029373F45A0B8AF0297081890D2ADA9@zch01exm26.fsl.freescale.net>
Content-Type: text/plain
Date: Thu, 14 Jun 2007 09:57:58 +0200
Message-Id: <1181807878.30670.363.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Liu Dave-r63238 <DaveLiu@freescale.com>
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-06-14 at 15:26 +0800, Li Yang-r58472 wrote:
> > -----Original Message-----
> > From: linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org
> [mailto:linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org] On Behalf
> Of
> > Joakim Tjernlund
> > Sent: Thursday, June 14, 2007 3:18 PM
> > To: Liu Dave-r63238
> > Cc: 'linuxppc-dev Development'
> > Subject: Re: ucc_geth DPRAM alloc error, 2.6.22-rc3
> > 
> > On Thu, 2007-06-14 at 09:03 +0200, Joakim Tjernlund wrote:
> > > On Thu, 2007-06-14 at 10:31 +0800, Dave Liu wrote:
> > > > On Wed, 2007-06-13 at 16:22 +0200, Joakim Tjernlund wrote:
> > > > > Trying to bring up a third ethernet i/f(ifconfig eth2 up) on
> > > > > a Freescale 832x CPU gives me this:
> > > > >  ifconfig eth2 up
> > > > >  ucc_geth_startup: Can not allocate DPRAM memory for
> p_thread_data_tx.
> > > > >  eth2: Cannot configure net device, aborting.
> > > > >  SIOCSIFFLAGS: Cannot allocate memory
> > > > >
> > > > > This worked in 2.6.20
> > > >
> > > > Could you print the MURAM memory usage for debug?
> > > > eg. start address and size.
> > > >
> > > > -d
> > >
> > > Like this?
> > 
> > redid with all hex, decimal within()
> > MURAM alloc, start:1400, size:200(512), align:8(8)
> > MURAM alloc, start:1608, size:208(520), align:8(8)
> > MURAM alloc, start:1880, size:80(128), align:80(128)
> > MURAM alloc, start:1a00, size:1a0(416), align:100(256)
> > MURAM alloc, start:1bc0, size:40(64), align:20(32)
> > MURAM alloc, start:1d00, size:100(256), align:100(256)
> > MURAM alloc, start:1f00, size:a0(160), align:100(256)
> > MURAM alloc, start:1fc0, size:c(12), align:40(64)
> > MURAM alloc, start:2000, size:30(48), align:8(8)
> > MURAM alloc, start:2080, size:80(128), align:80(128)
> > MURAM alloc, start:2180, size:80(128), align:80(128)
> > MURAM alloc, start:2280, size:80(128), align:80(128)
> > MURAM alloc, start:2380, size:80(128), align:80(128)
> > MURAM alloc, start:2440, size:40(64), align:40(64)
> > MURAM alloc, start:24c0, size:40(64), align:40(64)
> > MURAM alloc, start:2540, size:40(64), align:40(64)
> > MURAM alloc, start:25c0, size:40(64), align:40(64)
> > MURAM alloc, start:262c, size:5d(93), align:4(4)
> 
> Looks like you are using virtual FIFO for 100Mbps.
> 
> > some comments:
> > 
> > With these aligments, won't you waste alot of MURAM?
> > 
> > Looking at the 2 first allocs:
> >   MURAM alloc, start:1400, size:200(512), align:8(8)
> >   MURAM alloc, start:1608, size:208(520), align:8(8)
> > shouldn't the second alloc have 0x1600 as start address?
> 
> This looks like a bug of rheap.  The main problem is that at system
> startup phase, there is an allocation of size 0x400,align 0x1000.
> The rheap starts to allocate next buffer from 0x1400, instead of 0x400.

Strangely, that alloc(0x400,align 0x1000) never shows up
in the print out.

For reference I have added the same printout to
my 2.6.20 kernel, here is the initial allocs in that kernel:

MURAM alloc, start:728, size:200(512), align:8(8)
MURAM alloc, start:930, size:208(520), align:8(8)
MURAM alloc, start:b80, size:80(128), align:80(128)
MURAM alloc, start:d00, size:1a0(416), align:100(256)
MURAM alloc, start:ee0, size:40(64), align:20(32)
MURAM alloc, start:1000, size:100(256), align:100(256)
MURAM alloc, start:1200, size:a0(160), align:100(256)
MURAM alloc, start:12d8, size:8(8), align:4(4)
MURAM alloc, start:12e0, size:30(48), align:8(8)
MURAM alloc, start:1380, size:80(128), align:80(128)
MURAM alloc, start:1480, size:80(128), align:80(128)
MURAM alloc, start:1580, size:80(128), align:80(128)
MURAM alloc, start:1680, size:80(128), align:80(128)
MURAM alloc, start:1740, size:40(64), align:40(64)
MURAM alloc, start:17c0, size:40(64), align:40(64)
MURAM alloc, start:1840, size:40(64), align:40(64)
MURAM alloc, start:18c0, size:40(64), align:40(64)
MURAM alloc, start:1910, size:5d(93), align:4(4)
