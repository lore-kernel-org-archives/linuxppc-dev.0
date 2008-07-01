Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 43A31DDF2B
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 16:24:37 +1000 (EST)
Subject: RE: [PATCH 12/60] microblaze_v4: Generic dts file for platforms
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
In-Reply-To: <20080630033943.332471860046@mail171-va3.bigfish.com>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-6-git-send-email-monstr@seznam.cz>
	<1214483429-32360-7-git-send-email-monstr@seznam.cz>
	<1214483429-32360-8-git-send-email-monstr@seznam.cz>
	<1214483429-32360-9-git-send-email-monstr@seznam.cz>
	<1214483429-32360-10-git-send-email-monstr@seznam.cz>
	<1214483429-32360-11-git-send-email-monstr@seznam.cz>
	<1214483429-32360-12-git-send-email-monstr@seznam.cz>
	<1214483429-32360-13-git-send-email-monstr@seznam.cz>
	<fa686aa40806272249l7eae0c34k43a20ad41672b77a@mail.gmail.com>
	<1d3f23370806291702g4344a2f9lb62f85cbb475fca4@mail.gmail.com>
	<20080630033943.332471860046@mail171-va3.bigfish.com>
Content-Type: text/plain
Date: Tue, 01 Jul 2008 16:21:42 +1000
Message-Id: <1214893302.20711.102.camel@pasglop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	will.newton@gmail.com, hpa@zytor.com,
	John Linn <linnj@xilinx.com>, monstr@seznam.cz,
	drepper@redhat.com, John Williams <john.williams@petalogix.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> As for the copyright, I haven't been able to find much information on
> whether or not generated files are even copyrightable.  One might
> argue that they
> don't have sufficient 'creative value' to be copyrightable.  Or
> arguably, they are as copyrightable by the generator author as by the
> author or the .mhs file.
> I admit in this case, I've followed the safe route by claiming a
> copyright, which at least at Xilinx has significant precedent.

Also, thinking about your idea of sticking bits in BRAM etc...

what would be nice would be the ability to "merge" trees. We've been
talking about that multiple times, it would be useful at several levels:

 - We could provide pre-made DTs for known CPUs (ie, 440GP, 440GX,
405EX, ...)
 - Boards can then include that, and then "override" some properties
(clocks, PHY wiring, ...)
 - That could be done at the binary level too so that the BRAM contains
on "overlay" on top of the base ref. platform device-tree that comes
with the kernel for example.

This is slightly different between doing that in the .dts source via
some kind of #include vs. doing that by merging blobs but we could make
it be essentially be the same internally: The #include generates a blob
that is then "merged in".

Just random thoughts...

Ben.
 
