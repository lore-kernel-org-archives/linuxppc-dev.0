Date: Thu, 31 Aug 2000 13:13:20 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Dan Malek <dan@netx4.com>
cc: Matt Porter <mporter@mvista.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on Motorola Sandpoint/PPMC7400
In-Reply-To: <39AD9CE6.AA56390F@embeddededge.com>
Message-ID: <Pine.HPX.4.10.10008311300320.15978-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 30 Aug 2000, Dan Malek wrote:

> Well, not exactly :-).  The code is actually written with some
> assumptions because I couldn't make it do _everything_.  The download
> should be located above the address where it is linked to execute.
> For example, I download to 0x900000, the code relocates to 0x800000,
> then uncompresses the kernel into the base of memory.
>
> This follows the MPC8xx boot model with a larger memory window.
> The MPC8xx had more constraints (smaller main memory 8 Mbyte start
> up translation), so the load/execution addresses were lower in
> memory.  Since the kernel is constantly growing and the 82xx had
> a 16 MByte window, I just decided to move everything further up
> in the address space.
>
> Anything below the linked execution address (0x800000 in this case)
> is considered fair game for allocation by the code, so it could
> write over itself or other necessary information (like zImage or the
> ramdisk).

Well, if you have a look at PrePboot, it solves all these kind of
problems. On my MVME2600:

- when booting from network, the zImage is loaded very low in memory,
- when booting from disk, it finds itself at top of memory (~15Mb),

what the code does is first to relocate itself where it is originally
loaded (compiled with -mrelocatable) so that it can perform a basic
analyzis of the current memory layout.

Then it moves itself up or down to the top of memory (yes it can have to
move itself down to the top, as contradictory as it seems, it actually
happens quite often), sometimes with partial overlaps, clears its bss,
relocates itself once again (until this point your have to be very careful
with what the code does), and setup a basic memory management system
taking into account firmware needs to avoid stepping on firmware's toes.

At this point, reading OF device tree, decompressing the kernel,
emulating VGA ROM bioses, etc... becomes almost trivial.

	Regards,
	Gabriel.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
