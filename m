Message-ID: <001801c0135c$53caea20$0400a8c0@PeterTympanick>
From: "Peter Tympanick" <ptymps@ultsol.com>
To: "Matt Porter" <mporter@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <Pine.HPX.4.10.10008311300320.15978-100000@gra-ux1.iram.es>
Subject: Re: Linux on Motorola Sandpoint/PPMC7400
Date: Thu, 31 Aug 2000 08:01:20 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Using the Abatron BDI2000 and bdiGDB, have you figured out a way to
implement loadable device drivers for hardware using a PowerPC device?

Thanks for your help in advance.

Peter Tympanick
Sales Engineer
Ultimate Solutions, Inc.
===============================
Development Tools for Embedded Systems
Ph: 978-455-3383
Fx: 978-926-3091
Email: ptymps@ultsol.com
WWW: http://www.ultsol.com


----- Original Message -----
From: Gabriel Paubert <paubert@iram.es>
To: Dan Malek <dan@netx4.com>
Cc: Matt Porter <mporter@mvista.com>; <linuxppc-embedded@lists.linuxppc.org>
Sent: Thursday, August 31, 2000 4:13 AM
Subject: Re: Linux on Motorola Sandpoint/PPMC7400



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
