Return-Path: <jdl@freescale.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id 6F5752BDA1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Oct 2004 01:28:47 +1000 (EST)
Received: from il06exr06.mot.com (il06exr06.mot.com [129.188.137.136])
	by motgate8.mot.com (Motorola/Motgate8) with ESMTP id i9EFU0G2021295
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 08:30:00 -0700 (MST)
Received: from postal.somerset.sps.mot.com (postal.somerset.sps.mot.com
	[163.12.132.5])
	by il06exr06.mot.com (Motorola/il06exr06) with ESMTP id i9EFSdXQ015424
	for <linuxppc-embedded@ozlabs.org>; Thu, 14 Oct 2004 10:28:40 -0500
From: Jon Loeliger <jdl@freescale.com>
To: Laurent Lagrange <lagrange@fr.oleane.com>,
	linuxppc-embedded@ozlabs.org
In-Reply-To: <010190ED-1D8F-11D9-92E7-000393DBC2E8@freescale.com>
References: <13F5C6B8-1D5B-11D9-88FA-003065F9B7DC@embeddededge.com>
	<010190ED-1D8F-11D9-92E7-000393DBC2E8@freescale.com>
Content-Type: text/plain
Message-Id: <1097767717.14656.7.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 14 Oct 2004 10:28:38 -0500
Cc: 
Subject: Re: MPC8560 problem to launch user application like /sbin/init
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2004-10-13 at 22:13, Kumar Gala wrote:
> Have you turned on emulation of FP in the kernel?
> 
> - kumar
> 
> On Oct 13, 2004, at 4:01 PM, Dan Malek wrote:
> 
> >
> >
> > On Oct 13, 2004, at 1:07 PM, Laurent Lagrange wrote:
> >
> > > The console is mapped on SCC1 port.
> >  > CCSRBAR is mapped at 0xF8000000 and immr at 0xF8080000.
> >
> > I would suggest using the standard memory map the rest of
> >  us use for 8560.  It makes the porting lots easier.

Yeah, sticking with the standard memory map will likely help.

Are you using U-Boot to front this booting operation, or
just directly coding your own setup?


> > > All things run fine until I launch the /sbin/init file from a nfs
> > > networK.

Another popular failure mode of this step is the lack of
some library, file or permisssions on a file necessary to
run the init code.  A workaround is to statically link the
init code and see if that works too.

HTH,
jdl
