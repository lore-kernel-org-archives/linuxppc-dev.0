Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18165.60185.316393.213864@cargo.ozlabs.ibm.com>
Date: Sun, 23 Sep 2007 14:27:05 +1000
From: Paul Mackerras <paulus@samba.org>
To: Rob Landley <rob@landley.net>
Subject: Re: [PATCH 1/2] qemu platform, v2
In-Reply-To: <200709221416.21580.rob@landley.net>
References: <boot-8-00.miltonm@bga.com> <qemu-8-01.miltonm@bga.com>
	<20070922095546.GA14185@lst.de>
	<200709221416.21580.rob@landley.net>
Cc: linuxppc-dev@ozlabs.org, Christoph Hellwig <hch@lst.de>,
	Milton Miller <miltonm@bga.com>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rob Landley writes:

Just to correct a few misconceptions:

> 2) PowerPC uses a device tree supplied by the hardware to identify the 
> available hardware, even for stuff living on PCI busses which it could 
> theoretically probe for but doesn't.

The device tree doesn't have to include anything that can be probed
for.  On some platforms (e.g. pSeries) we choose to use the device
tree rather than probing, but on most other platforms we probe.

> I'd be following this more closely if compiling a device tree didn't currently 
> require an external utility (dtc or some such) that doesn't come with the 
> Linux kernel.  No other target platform I've built kernels for requires such 
> an environmental dependency.

No?  You haven't built kernels for other platforms that have external
dependencies such as perl, gcc, make, binutils, etc.? :)

>  (This is a problem both for hardwiring the 
> device tree into the kernel and for building a new boot rom from the linux 
> kernel's ppc boot wrapper that would contain such a device tree to feed to 
> the kernel.)

It's only really been a problem for ps3 so far, since the embedded
guys don't seem to have any difficulty with installing dtc.  We are
looking at what to do for ps3 and prep, and the answer may well
involve bundling dtc in the kernel source (it's not too big, around
3400 lines).

Paul.
