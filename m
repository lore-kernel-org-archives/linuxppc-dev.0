Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from agrxsusmail.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id B497B67A3E
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Mar 2006 03:14:26 +1100 (EST)
Message-ID: <44086B5E.60201@smiths-aerospace.com>
Date: Fri, 03 Mar 2006 11:14:22 -0500
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

Hi Olaf, me again...

<http://gcc.gnu.org/onlinedocs/gcc-4.1.0/gcc/RS_002f6000-and-PowerPC-Options.html>

Looks like you should use -malign-natural to make it do what you want it 
to do:

-malign-natural
-malign-power
     On AIX, 32-bit Darwin, and 64-bit PowerPC GNU/Linux, the option 
-malign-natural overrides the ABI-defined alignment of larger types, 
such as floating-point doubles, on their natural size-based boundary. 
The option -malign-power instructs GCC to follow the ABI-specified 
alignment rules. GCC defaults to the standard alignment defined in the ABI.

     On 64-bit Darwin, natural alignment is the default, and 
-malign-power is not supported.

gvb
