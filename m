Date: Tue, 23 Jan 2001 12:24:21 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: Dan Malek <dan@mvista.com>
cc: Jeff Hartmann <jhartmann@valinux.com>, michdaen@iiic.ethz.ch,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
In-Reply-To: <3A6CCF31.C44706E2@mvista.com>
Message-ID: <Pine.GSO.4.10.10101231007300.15023-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Mon, 22 Jan 2001, Dan Malek wrote:

> The PowerPC port, except for a couple of processors (4xx and 8xx again)
> could never use virt_to_phys on any dynamically allocated (vmalloc()'ed)
> space.  All of the drivers/devices that used these macros were using
> ioremapped() or static buffers.  Perhaps the PCI mapping functions are
> implementing some of this, and I need to take a look.

virt_to_phys is only guaranteed to work on normal kernel memory and on
nothing else. Drivers that use that function will not work on certain
architectures. With the new pci mapping you have the same problem as with
ioremapped memory, one has to store both pointers somewhere in the driver.

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
