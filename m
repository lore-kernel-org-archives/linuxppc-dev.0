Message-ID: <3A6CCF31.C44706E2@mvista.com>
Date: Mon, 22 Jan 2001 19:24:17 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Roman Zippel <zippel@fh-brandenburg.de>
CC: Jeff Hartmann <jhartmann@valinux.com>, michdaen@iiic.ethz.ch,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Gareth Hughes <gareth@valinux.com>, linuxppc-dev@lists.linuxppc.org,
        dri-devel@lists.sourceforge.net, Paul Mackerras <paulus@linuxcare.com>
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
References: <Pine.GSO.4.10.10101222326300.26751-100000@zeus.fh-brandenburg.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Roman Zippel wrote:

> AFAIK such tricks are used for mapping normal (low) memory and ioremapped
> areas. For normal memory you can use phys_to_virt()/virt_to_phys() and for
> ioremapped memory, you have to store the physical and virtual address
> yourself. What am I missing?

The PowerPC port, except for a couple of processors (4xx and 8xx again)
could never use virt_to_phys on any dynamically allocated (vmalloc()'ed)
space.  All of the drivers/devices that used these macros were using
ioremapped() or static buffers.  Perhaps the PCI mapping functions are
implementing some of this, and I need to take a look.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
