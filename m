Return-Path: <Marc.Howard@KLA-Tencor.com>
Received: from ca1mail04.kla-tencor.com (mailout04.kla-tencor.com
	[192.146.1.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 10BC8679E1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 May 2006 08:52:30 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Viable PPC platform? 
Date: Tue, 9 May 2006 15:52:20 -0700
Message-ID: <91B22F93A880FA48879475E134D6F0BE028A43D2@CA1EXCLV02.adcorp.kla-tencor.com>
From: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>
To: "Wolfgang Denk" <wd@denx.de>, "Eugene Surovegin" <ebs@ebshome.net>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+marc.howard=3Dkla-tencor.com@ozlabs.or
g [mailto:linuxppc-embedded-bounces+marc.howard=3Dkla->
tencor.com@ozlabs.org] On Behalf Of Wolfgang Denk
> Sent: Tuesday, May 09, 2006 3:31 PM
> To: Eugene Surovegin
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Viable PPC platform?=20
>=20
> In message <20060509171520.GA10886@gate.ebshome.net> you wrote:
> >
> > After many years of doing embedded Linux stuff I still don't=20
> > understand why people are so fond of initrd.
> >=20
> > For temporary stuff - tempfs is much better and flexible. For r/o=20
> > stuff - just make separate MTD partition (cramfs, squashfs)=20
> and mount=20
> > it directly as root. Both options will waste significantly less=20
> > memory.
>=20
> Agreed.
>=20
> And if somebody wants to see facts and numbers, please see
> http://www.denx.de/wiki/view/DULG/RootFileSystemSelection
>=20

One size does not fit all.  We have an application with a very large
file system.  It can't fit in the available flash, however we do have a
ton of RAM (512MB).  NFS is not an option nor is it desirable (latency
and availability issues).  Boot time is not an issue either in this case
as it takes the equipment many minutes to calibrate and initialize.

initrd also solves another problem.  The combined uBoot multi-image
although huge (>32 MB) represents a complete system firmware snapshot in
a single (huge) file.  By selecting the appropriate uImage the host can
guarantee the linux build, device drivers, application version and FPGA
firmware revs (the embedded board is rebooted to guarantee a repeatable
starting state).  This makes revision control for the overall system
much easier, especially since the host system is running windoze.

I agree with your general conclusion but there are specific cases where
it is not optimal.

Marc W. Howard
