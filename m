Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 63689DE05F
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jan 2009 18:46:06 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <cb298a870901231259h6bd1ae2ag2baeb20173219664@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <02f6bf324a381ee5c2fc5e91313dbca9@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: Maple PPC970 kexec crash-dump problems
Date: Sat, 24 Jan 2009 01:52:45 -0600
To: Benjamin Walsh <walsh.benj@gmail.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat Jan 24 at 07:59:47 EST in 2009, Benjamin Walsh wrote:
> I am trying to use kexec with a crash dump kernel on a Maple board 
> (Motorola
> ATCA6101 to be precise). This board is running a two-CPU PPC970FX. I am
> running a 2.6.27-10 kernel and have tried both older kexec-tools and 
> the
> newest ones. I have tried SMP and non-SMP kernels.

Once you start the second cpu it is likly executing instructions 
somewhere.

Priory to 2.6.27 you had to compile a fixxed offset kerenl to run 
kdump.  With 2.6.27 that option was removed and replaced with teh 
relocatable kerenl.  However, becasue of the way linux interacts with 
open firmware, the kernel will still move itself to 0 unless a specific 
flag is set.   The location of the flag was changed twice during the 
merge process, and the patches for kexec-tools were not made until 
early this year.

> Using kexec -l to fast boot works correctly. However, loading a crash 
> dump
> kernel and triggering a crash via echo c > /proc/sysrq-trigger simply 
> hangs
> the board. I have traced the sequence down to after the call to
> kexec_copy_flush(), when the CPU returns to real-address mode (bl
> real_mode). At this point I have no further debugging information.


> Two things could help me:
>
> - Getting the fix if this is a known issue and a fix exists. I have 
> looked
> at recent patches and nothing lept to mind, mostly relocatable kernel
> support.

That is a major change.

That said, I don't know if anyone has tested kexec panic beyond pseries 
for 64 bit powerpc.

I know Paul originally prototyped the relocatable patch on a powermac, 
but I dont' know what if any smp testing he performed.   And you said 
you are actualy on maple not a powermac, so the startup issues are 
different.

> - Obtaining the address of the serial port @3f8 in real mode. The init
> sequence with udbg ON says that the physical address of the port is
> 0xf40003f8; however, setting it up in poll mode and trying to stuff
> characters in the tx buffer doesn't produce anything.

Ah yes.  In real mode you can only talk to cacheable memory without 
implementation specific assistance.  However, if you look in the kernel 
for the maple early udbg support, you will find the code you need to 
talk to that serial port in real mode.

>
> Has anyone recently tried to use the serial port in real mode ?
>
> Thanks for any help.
>
> Ben

Hope this gets you started.  I wrote a lot of the kernel code, but I 
had the advantage of external jtag access to the processor to see where 
it when ended up when it went astray.

milton
