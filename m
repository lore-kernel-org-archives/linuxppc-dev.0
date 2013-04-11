Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id 4D71C2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 05:58:11 +1000 (EST)
Date: Thu, 11 Apr 2013 12:50:19 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Chris Friesen <chris.friesen@genband.com>
Subject: Re: recommended method of netbooting kernel/dtb in u-boot?
Message-ID: <20130411195019.GA31025@ovro.caltech.edu>
References: <5166DA49.5000907@genband.com>
 <3B81A930-A4AB-4AA7-BC36-FCCE55D33C66@kernel.crashing.org>
 <51670344.2090101@genband.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51670344.2090101@genband.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 11, 2013 at 12:39:00PM -0600, Chris Friesen wrote:
> On 04/11/2013 12:12 PM, Kumar Gala wrote:
> >
> > On Apr 11, 2013, at 10:44 AM, Chris Friesen wrote:
> >
> >>
> >> Hi all,
> >>
> >> We've got a powerpc system that uses u-boot.  In our environment on
> >> bootup u-boot does a DHCP to get networking info, then uses TFTP to
> >> get the kernel, which then does DHCP again and NFS-mounts the
> >> initial root filesystem.
> >>
> >> What's the standard practice for this sort of thing when using
> >> device tree blobs?  Do most people use multi-file images or do they
> >> TFTP scripts to load and execute separate kernel/dtb files?
> >
> > We've normally just done multiple tftp fetches and one grabs dtb and
> > one grabs kernel.
> 
> Do you hardcode the path to the file in the firmware?  Or do you upload 
> a script that knows the path to the file?
> 
> In our case the path to the boot file(s) depends on which slot the card 
> being booted has been inserted in.  The DHCP server knows what the path 
> is, so it can set dhcpd.conf appropriately, but we need to get that 
> information to the firmware on the card being booted.
> 

Hello Chris,

I use a hardware setup which sounds similar to yours. The DHCP server
controls which file is sent to each card.

I use the FIT image format to combine a kernel, dtb, and initrd in one
package. Then the U-Boot command "dhcp $address" sets up the network and
tftp's the filename sent by the DHCP server. You don't need to invoke
the U-Boot command "tftp" if you only have one image. "dhcp" is enough.

I used the U-Boot doc/uImage.FIT/*.its examples to get started, and
wrote my own custom .its file for my board. I don't use anything other
than the vmlinux.bin.gz provided by the kernel build.

Hope it helps,
Ira
