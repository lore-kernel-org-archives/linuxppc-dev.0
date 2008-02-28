Return-Path: <jwilson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id 3CA0CDDD0C
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 14:21:54 +1100 (EST)
From: Jarod Wilson <jwilson@redhat.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 1/2] firewire: endianess fix
Date: Wed, 27 Feb 2008 22:21:38 -0500
References: <20080220220326.GA22328@uranus.ravnborg.org>
	<200802271458.28401.jwilson@redhat.com>
	<1204166422.15052.334.camel@pasglop>
In-Reply-To: <1204166422.15052.334.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200802272221.38985.jwilson@redhat.com>
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Stefan Richter <stefanr@s5r6.in-berlin.de>,
	sparclinux@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
	Sam Ravnborg <sam@ravnborg.org>,
	Harvey Harrison <harvey.harrison@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 27 February 2008 09:40:22 pm Benjamin Herrenschmidt wrote:
> On Wed, 2008-02-27 at 14:58 -0500, Jarod Wilson wrote:
> > On Saturday 23 February 2008 06:24:17 am Stefan Richter wrote:
> > > The generation of incoming requests was filled in in wrong byte order
> > > on machines with big endian CPU.
> > >
> > > Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
> > > Cc: sparclinux@vger.kernel.org
> > > Cc: linuxppc-dev@ozlabs.org
> > > ---
> > >
> > > This patch is a shot in the dark, based on a warning when building with
> > > C=1 CHECKFLAGS="-D__CHECK_ENDIAN__".  Is it really a fix, or was the
> > > previous code accidentally correct?
> > >
> > > This needs to be tested on different big endian PCs, if possible with
> > > the Apple Uninorth FireWire controller and other types of controllers.
> > > One test which involves ohci->request_generation is simply with an
> > > SBP-2 device (harddisk, CD-ROM...).  Does SBP-2 login etc. work?
> >
> > Works just fine with the Apple UniNorth controller in my powerbook in
> > cursory testing. Tested with multiple sbp2 hard disks, plugging and
> > unplugging, mounting and unmounting, etc.
>
> Which specific rev/version of the uninorth controller ?

lspci says Apple Computer Inc. UniNorth 2 FireWire (rev 81), pci id 106b:0031, 
subsys id 106b:5811.

(Its a circa 2004 Aluminum 15" PowerBook G4 @ 1.67GHz, fwiw).

> There is the "interesting" one has vendorID Apple and deviceID 0x0018,
> the normal ones have different deviceIDs (and are just lucent
> controllers afaik).

Under Mac OS X, system.log says "FireWire (OHCI) Apple ID 31 built-in now 
active". Could still be lucent though, judging by the subsys device ID of 
5811, which matches up w/the Lucent/Agere FW323. But no, apparently I don't 
have the interesting one.


-- 
Jarod Wilson
jwilson@redhat.com
