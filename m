Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from agrxsusmail.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id 949D367A3F
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Mar 2006 03:20:44 +1100 (EST)
Message-ID: <440865CC.7070607@smiths-aerospace.com>
Date: Fri, 03 Mar 2006 10:50:36 -0500
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: alignment bugs in prom_init
References: <20060303135717.GA5707@suse.de>
In-Reply-To: <20060303135717.GA5707@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering wrote:
> Some G5 and pSeries models dont boot with recent kernels. The reason is
> likely the casting of pointers of stack variables to u32. One example is
> the prom_getprop() call in prom_init_stdout().
> 
> sp is 0x0023e784, val is at offset 120, which makes 0x0023e7fc. This
> address is casted to u32, which changes it to 0x0023e7f8. The firmware
> writes to the wrong addres and things go downhill very quick.
> 
> c00000000040baa8:       3b 21 00 78     addi    r25,r1,120
> ..
> c00000000040baf4:       57 28 00 38     rlwinm  r8,r25,0,0,28
> ..
> c00000000040bb10:       4b ff d3 3d     bl      c000000000408e4c <.call_prom>
> 
> If I remove the casts and pass the pointer as is, everything starts to
> work as expected? Why is all this (u32)(unsigned long) casting in
> arch/powerpc/kernel/prom_init.c required?
> 
> Does -Os vs -O2 make a difference here?
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

Hi Olaf,

The casting is 8-byte aligning the address because it is a 64 bit 
variable and it is frowned on (and on some processors, fatal) to have an 
8-byte variable misaligned (not on a 8 byte boundary).

In your example above, the variable is named "sp"... the sp is suppose 
to be on a 8 byte boundary per the EABI (quoted below... note that the 
ABI requires it to be on a 16 byte boundary):
----
The Stack Frame
Unlike the SVR4 ABI, the stack pointer (GPR1) shall maintain 8-byte 
alignment, from initialization through all routine calls and dynamic 
stack space allocation.
----
In the instance above, the proper solution (but I don't know if it is a 
realistic solution :-/) is to properly align the stack pointer on a 8 
byte boundary.  I also don't know if there are other, non sp variable, 
problems.  It sounds like the prom isn't 64 bit clean.  What are our 
options to make it 64 bit clean?

Disclaimer: Yeah, I know most PPCs handle misaligned longs, but that 
doesn't make it _right_ and it definitely doesn't make it efficient.

gvb
