Message-ID: <3EBAE51D.2C41C9CE@mvista.com>
Date: Thu, 08 May 2003 16:15:41 -0700
From: Scott Anderson <scott_anderson@mvista.com>
MIME-Version: 1.0
To: James Don <JDon@spacebridge.com>
Cc: "''linuxppc-embedded@lists.linuxppc.org' '" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: advice please: virtex pro 2
References: <DB0585C9F6F9D411BE8F00D0B7896A4CC0660A@SNCMAIL>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


James Don wrote:
> sorry ;-)
>
> does "it just works" mean plug and play with a reference design ... or do
> you mean it was so difficult to get running you know something else is wrong
> ... or does that mean you just got it working today?

Ah, sorry I was too terse.  It means I used it on the ML300 for
debugging the kernel and drivers.  I also used it to load the
kernel into memory so I didn't have to muck with the CompactFlash.
I mainly used its gdbserver interface, but also did use the telnet
interface at times.  The BDI2000 config file I used was very terse.
The System ACE took care of initializing the hardware so by the
time the BDI got control, most things were pretty much taken care of.
Here's the INIT section from my file:
  [INIT]
  ; init core register
  WSPR    954     0x00000000      ;DCWR: Disable data cache write-thru
  WSPR    1018    0x00000000      ;DCCR: Disable data cache
  WSPR    1019    0x00000000      ;ICCR: Disable instruction cache
  WSPR    982     0x00000000      ;EVPR: Exception Vector Table @0x00000000
  ; Setup MMU info
  WM32    0x000000F0  0x00000000  ;invalidate page table base

Hope that was better,
    Scott Anderson
    scott_anderson@mvista.com   MontaVista Software Inc.
    (408)328-9214               1237 East Arques Ave.
    http://www.mvista.com       Sunnyvale, CA  94085

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
