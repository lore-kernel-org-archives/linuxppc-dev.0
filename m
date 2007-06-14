Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id EF0F9DDED9
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 17:54:34 +1000 (EST)
Subject: RE: ucc_geth DPRAM alloc error, 2.6.22-rc3
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Li Yang-r58472 <LeoLi@freescale.com>
In-Reply-To: <989B956029373F45A0B8AF0297081890D2ADB4@zch01exm26.fsl.freescale.net>
References: <989B956029373F45A0B8AF0297081890D2ADB4@zch01exm26.fsl.freescale.net>
Content-Type: text/plain
Date: Thu, 14 Jun 2007 09:54:31 +0200
Message-Id: <1181807671.30670.358.camel@gentoo-jocke.transmode.se>
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

On Thu, 2007-06-14 at 15:37 +0800, Li Yang-r58472 wrote:
> Try remove the following lines in rheap.c
> 
>          /* given alignment larger that default rheap alignment */
>          if (alignment > info->alignment)
>                  size += alignment - 1;
> 
> I don't know if this breaks other things, just have a try.
I did and got this alloc:
MURAM alloc, start:400, size:200(512), align:8(8)
MURAM alloc, start:600, size:208(520), align:8(8)
MURAM alloc, start:880, size:80(128), align:80(128)
MURAM alloc, start:900, size:1a0(416), align:100(256)
MURAM alloc, start:a40, size:40(64), align:20(32)
MURAM alloc, start:b00, size:100(256), align:100(256)
MURAM alloc, start:c00, size:a0(160), align:100(256)
MURAM alloc, start:c40, size:c(12), align:40(64)
MURAM alloc, start:c18, size:30(48), align:8(8)
MURAM alloc, start:c80, size:80(128), align:80(128)
MURAM alloc, start:d00, size:80(128), align:80(128)
MURAM alloc, start:d80, size:80(128), align:80(128)
MURAM alloc, start:e00, size:80(128), align:80(128)
MURAM alloc, start:e80, size:40(64), align:40(64)
MURAM alloc, start:ec0, size:40(64), align:40(64)
MURAM alloc, start:f00, size:40(64), align:40(64)
MURAM alloc, start:f40, size:40(64), align:40(64)
MURAM alloc, start:f44, size:5d(93), align:4(4)

MURAM alloc, start:f48, size:200(512), align:8(8)
MURAM alloc, start:1148, size:208(520), align:8(8)
MURAM alloc, start:1380, size:80(128), align:80(128)
MURAM alloc, start:1400, size:1a0(416), align:100(256)
MURAM alloc, start:1580, size:40(64), align:20(32)
MURAM alloc, start:1600, size:100(256), align:100(256)
MURAM alloc, start:1700, size:a0(160), align:100(256)
MURAM alloc, start:1780, size:c(12), align:40(64)
MURAM alloc, start:1758, size:30(48), align:8(8)
MURAM alloc, start:1800, size:80(128), align:80(128)
MURAM alloc, start:1880, size:80(128), align:80(128)
MURAM alloc, start:1900, size:80(128), align:80(128)
MURAM alloc, start:1980, size:80(128), align:80(128)
MURAM alloc, start:19c0, size:40(64), align:40(64)
MURAM alloc, start:1a00, size:40(64), align:40(64)
MURAM alloc, start:1a40, size:40(64), align:40(64)
MURAM alloc, start:1a80, size:40(64), align:40(64)
MURAM alloc, start:1a88, size:5d(93), align:4(4)

MURAM alloc, start:1a88, size:200(512), align:8(8)
MURAM alloc, start:1c88, size:208(520), align:8(8)
MURAM alloc, start:1f00, size:80(128), align:80(128)
MURAM alloc, start:2000, size:1a0(416), align:100(256)
MURAM alloc, start:20c0, size:40(64), align:20(32)
MURAM alloc, start:2100, size:100(256), align:100(256)
MURAM alloc, start:2200, size:a0(160), align:100(256)
MURAM alloc, start:22c0, size:c(12), align:40(64)
MURAM alloc, start:22a0, size:30(48), align:8(8)
MURAM alloc, start:2300, size:80(128), align:80(128)
MURAM alloc, start:2380, size:80(128), align:80(128)
MURAM alloc, start:2400, size:80(128), align:80(128)
MURAM alloc, start:2480, size:80(128), align:80(128)
MURAM alloc, start:2500, size:40(64), align:40(64)
MURAM alloc, start:2540, size:40(64), align:40(64)
MURAM alloc, start:2580, size:40(64), align:40(64)
MURAM alloc, start:25c0, size:40(64), align:40(64)
MURAM alloc, start:25cc, size:5d(93), align:4(4)

But I can't ping anymore

> 
> - Leo
> 
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
> > 
> > MURAM alloc, start:2630, size:200(512), align:8(8)
> > MURAM alloc, start:2838, size:208(520), align:8(8)
> > MURAM alloc, start:2a80, size:80(128), align:80(128)
> > MURAM alloc, start:2c00, size:1a0(416), align:100(256)
> > MURAM alloc, start:2de0, size:40(64), align:20(32)
> > MURAM alloc, start:2f00, size:100(256), align:100(256)
> > MURAM alloc, start:3100, size:a0(160), align:100(256)
> > MURAM alloc, start:3200, size:c(12), align:40(64)
> > MURAM alloc, start:3228, size:30(48), align:8(8)
> > MURAM alloc, start:3280, size:80(128), align:80(128)
> > MURAM alloc, start:3380, size:80(128), align:80(128)
> > MURAM alloc, start:3480, size:80(128), align:80(128)
> > MURAM alloc, start:3580, size:80(128), align:80(128)
> > MURAM alloc, start:3680, size:40(64), align:40(64)
> > MURAM alloc, start:3700, size:40(64), align:40(64)
> > MURAM alloc, start:3780, size:40(64), align:40(64)
> > MURAM alloc, start:3800, size:40(64), align:40(64)
> > MURAM alloc, start:3858, size:5d(93), align:4(4)
> > 
> > MURAM alloc, start:3858, size:200(512), align:8(8)
> > MURAM alloc, start:3a60, size:208(520), align:8(8)
> > MURAM alloc, start:3c80, size:80(128), align:80(128)
> > MURAM alloc, start:fffffff4, size:1a0(416), align:100(256)
> > 
> > some comments:
> > 
> > With these aligments, won't you waste alot of MURAM?
> > 
> > Looking at the 2 first allocs:
> >   MURAM alloc, start:1400, size:200(512), align:8(8)
> >   MURAM alloc, start:1608, size:208(520), align:8(8)
> > shouldn't the second alloc have 0x1600 as start address?
> > 
> >  Jocke
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 
