Message-ID: <39AD9CE6.AA56390F@embeddededge.com>
Date: Wed, 30 Aug 2000 19:46:46 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Matt Porter <mporter@mvista.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on Motorola Sandpoint/PPMC7400
References: <20000828225504.B23679@hectic.net> <39AAF258.B43B901@mvista.com> <20000829201347.A30190@hectic.net> <39AC2AB9.D47ADE73@mvista.com> <20000828225504.B23679@hectic.net> <39AAF258.B43B901@mvista.com> <20000829201347.A30190@hectic.net> <39AC0BF9.38DB6A9A@mvista.com> <20000830220210.C5340@hectic.net> <20000830174502.A3868@cx258813-a.chnd1.az.home.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt Porter wrote:

> The bootloader relocation algorithm doesn't work when loaded at
> 0x800000.  Anything else will work.

Well, not exactly :-).  The code is actually written with some
assumptions because I couldn't make it do _everything_.  The download
should be located above the address where it is linked to execute.
For example, I download to 0x900000, the code relocates to 0x800000,
then uncompresses the kernel into the base of memory.

This follows the MPC8xx boot model with a larger memory window.
The MPC8xx had more constraints (smaller main memory 8 Mbyte start
up translation), so the load/execution addresses were lower in
memory.  Since the kernel is constantly growing and the 82xx had
a 16 MByte window, I just decided to move everything further up
in the address space.

Anything below the linked execution address (0x800000 in this case)
is considered fair game for allocation by the code, so it could
write over itself or other necessary information (like zImage or the
ramdisk).


> No clue here.

I am not sure the ramdisk stuff was ever tested.  I was just happy to
get the serial download of the kernel working and let NFS do the rest.
I am itching to fire up my 8240/Sandpoint (among other things :-), so
I may be able to help after the weekend.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
