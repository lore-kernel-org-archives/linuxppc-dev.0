Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17037.26222.23591.13083@cargo.ozlabs.ibm.com>
Date: Fri, 20 May 2005 14:24:14 +1000
From: Paul Mackerras <paulus@samba.org>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050519131844.7D707C1512@atlas.denx.de>
References: <1116478614.918.75.camel@gaston>
	<20050519131844.7D707C1512@atlas.denx.de>
Cc: linuxppc64-dev@ozlabs.org, linuxppc-embedded@ozlabs.org,
	u-boot-users@lists.sourceforge.net, linuxppc-dev@ozlabs.org
Subject: Re: [U-Boot-Users] RFC: Booting the Linux/ppc64 kernel without Open
	Firmware HOWTO (#2)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wolfgang Denk writes:

> But my biggest concern is that we  should  try  to  come  up  with  a
> solution  that  has  a  wider  acceptance. Especially from the U-Boot
> point of view it is not exactly nice that each of  PowerPC,  ARM  and
> MIPS  use  their very own, completely incompatible way of passing in-
> formation from the boot loader to the kernel.

I am familiar with birecs and I have looked at the ARM atags
structure, which is the same as birecs at an abstract level, i.e. a
list of arbitrary blobs of data, each with a binary tag and a size.

As far as MIPS is concerned, there didn't seem to be any single
consistent way of passing information from the bootloader to the
kernel.  They seem to be in a similar mess to ppc32 in this respect.
I want to avoid that mess for ppc64 by stating now, while there is
only one embedded ppc64 board that runs linux (the Maple eval board)
that there is one true way to pass information into the kernel at boot
time, and that is a flattened device tree.

Birecs and atags are both OK at representing a specified, limited set
of items of information, such as the location and size of an initrd
image or the total amount of memory in a system.  They fall down when
it comes to giving information about the devices in the system and
their interconnections.  For instance, atags has a structure for
representing a frame buffer - but what if you have two video cards in
your system?

Essentially, each element in the birecs/atags list is like a property
in a device tree that has only one node, and the entire birecs/atags
list is like a 1-node device tree.  What the device tree gives you is
the ability to organize those pieces of information hierarchically so
that it becomes obvious when you have multiple instances of a device
(e.g. a PCI host bridge), what pieces of information apply to which
device instances, and which devices have to be used to get to certain
other devices.

Thus, my opinion is that the device tree is technically superior to
the birecs/atags approach.  The device tree has also proven itself to
be capable of representing the information that the kernel needs about
all sorts of systems from the very small to the very large.  Unless
you can come up with something even better, ppc64 won't be changing.
In particular we're not going to go back to anything like birecs or
atags.

Also, given that a minimal flattened device tree fits in well under
1kB, any arguments about "excessive" memory usage will need to be
accompanied by specific code and data sizes of a real-world example.

> As is, your proposal will add just another incompatible way of  doing
> the  same  thing  (of course we will have to stay backward compatible
> with U-Boot to allow booting older kernels, too).

U-Boot currently doesn't support any ppc64 machines, does it?  So
how is there a backward compatibility issue?

Ben's proposal is for ppc64, at least as present.  If the ppc32
embedded developers decide they want to use a device tree, that would
be good, but it will proceed by 

> Why don't we try to come up with a solution that is acceptable to the
> other architectures as well? 

Other architectures are welcome to move to using a device tree.  The
problem is going to be convincing them to spend the effort to make the
change.  None of the other architectures currently have a solution
that is appealing.

Paul.
