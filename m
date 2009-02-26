Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by ozlabs.org (Postfix) with ESMTP id C2179DDDA2
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Feb 2009 10:45:27 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Ira Snyder <iws@ovro.caltech.edu>
Subject: Re: [RFC v2] virtio: add virtio-over-PCI driver
Date: Fri, 27 Feb 2009 00:44:52 +0100
References: <20090224000002.GA578@ovro.caltech.edu>
	<200902262334.33778.arnd@arndb.de>
	<20090226231742.GB19959@ovro.caltech.edu>
In-Reply-To: <20090226231742.GB19959@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200902270044.53683.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
	Jan-Bernd Themann <THEMANN@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 27 February 2009, Ira Snyder wrote:
> On Thu, Feb 26, 2009 at 11:34:33PM +0100, Arnd Bergmann wrote:
> > I guess the best option for doing it in Linux then would be to have
> > a board control driver (not sure if this already exists) that exports
> > high-level functions to set up the inbound and outbound windows.
> > 
> 
> Nothing like it exists. The OF device tree doesn't even describe these
> registers. The code in arch/powerpc/sysdev/fsl_pci.c uses some registers
> near these, but it gets their address by masking the low bits off the
> addresses from the device tree and adding the offsets of the new
> registers. Nasty.
> 
> I'll do this for now:
> 1) Get the message unit registers from my device tree
> 2) Encapsulate all use of get_immrbase() to a single function
> 
> That way it could be easily replaced in the future when something more
> suitable comes along.

Ok. However, I don't expect this to get fixed magically. Ideally,
you would start a new file for the board control in arch/powerpc/sysdev
and export the function from there, otherwise you do it the way you
suggested.
Then we can tell the fsl_pci and other people to use the same
method and source file to access the board control.
> 
> I didn't think about this at all. This driver could be used to boot a
> (guest) system over NFS, so in that case there isn't a userspace running
> yet, to allow configuration. This is essentially my use case, though I
> haven't implemented it yet.
> 
> Also, I hate designing user interfaces :) Any concrete suggestions on
> design would be most welcome.

Don't worry about it for now, just put all the hardcoded virtio_net
specific stuff into a file separate from the hardware specific
files so that we have a nice kernel level abstraction to build a
user abstraction on top of.

	Arnd <><
