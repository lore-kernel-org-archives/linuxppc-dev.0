From: Alan Mimms <alan@packetengines.com>
To: LiuTao <tliu@ict.ac.cn>,
        "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: What does KERNELBASE mean?
Date: Tue, 4 Jan 2000 21:07:45 -0800
Content-Type: text/plain
References: <3872CF70.45BCE11C@ict.ac.cn>
In-Reply-To: <3872CF70.45BCE11C@ict.ac.cn>
MIME-Version: 1.0
Message-Id: <00010421101502.00773@alan.corp.packetengines.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This .long stuff dates back to the POWER architecture (IBM) beginnings of
PowerPC wherein IBM and later Apple defined a three (or even longer) word table
of contents entry for each global entry point.  The first word was the pointer
to the function, the second word was the pointer to be used for the
subroutine's duration for its TOC register value and the third word was some
kinda magical language defined extra thingie nobody ever used as far as I know.

Effectively, its a larger style function pointer.

The boot ROMs on some PowerPC machines (Apple's Open Firmware for example)
expect the entry point of a loaded image to have one of these at the entry
point location.  They simply load the value there and jump to it to start the
loaded image.

 On Tue, 04 Jan 2000, LiuTao wrote:
> Hi:
> 
> In linux/arch/ppc/kernel/head.S, what does KERNELBASE mean?
> What does the following mean?
> ".long	TOPHYS(__start),0,0"
> 
> Thanks.
> 
> LiuTao
-- 
Alan Mimms     Packet Engines, Inc.     Spokane, Washington [99214-0497]
  USA, Earth, Sol, Milky Way, The Local Group, Virgo Supercluster, U0
Despite the cost of living, have you noticed how popular it remains?
  -- Steven Wright?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
