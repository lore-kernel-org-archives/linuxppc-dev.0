Message-ID: <3AEF4A65.84AC7436@mvista.com>
Date: Tue, 01 May 2001 16:44:37 -0700
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: Denton Gentry <denny@dominetsystems.com>
Cc: frowand@mvista.com, Dan Malek <dan@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405gp PCI?
References: <3AEE0E5C.955341B3@dominetsystems.com> <3AEE21DF.6C289B1C@mvista.com> <3AEF2381.755F7581@dominetsystems.com> <3AEF2AA5.5CB593C8@mvista.com> <3AEF3E8C.1EDEFA94@dominetsystems.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Denton Gentry wrote:
>
> >>   This is the Walnut eval board. I am using IBM's firmware to tftpboot
> >> a kernel, which the NFS mounts its root filesystem.
> >
> > What is the version of the firmware?  (It is reported on the console
> > when you turn on the power, eg "405GP 1.13 ROM Monitor (4/7/00)".)
>
>   It says: "405GP 1.15 ROM Monitor (8/9/00)"

That's the problem....  That version of the OpenBios changed the PLB to
PCI address mapping (the mapping is in the PMM0 registers).  The kernel
expects PLB address 0x8000'0000 to map to PCI address 0x0000'0000, and the
PMM registers should map PCI address 0x0000'0000 to PLB address 0x0000'0000.
A near future kernel will fix up the PTM and PMM registers (on the Walnut
only) to match what the kernel expects.


>   Anticipating another question: according to the silkscreen on the
> package, it is a rev D of the 405gp. The ROM Monitor says the processor
> PVR is 401100c4  (though I have no idea how to interpret that).

That PVR means Rev D.


-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
