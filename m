Date: Mon, 22 May 2000 22:10:56 -0700
From: Matt Porter <mmporter@home.com>
To: tjroberts@lucent.com, linuxppc-embedded@lists.linuxppc.org
Message-Id: <slrn8ik4mu.349.mmporter@liberty.chnd1.az.home.com>
Subject: Re: QUERY: Embedded PowerPC Linux?
References: <39243D0C.68406C9D@lucent.com> <slrn8iernk.lpg.mmporter@liberty.chnd1.az.home.com> <39289187.3AEDEE47@chicago.avenew.com>
Reply-To: mporter@mvista.com
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


[This message has also been posted.]
On Sun, 21 May 2000 20:46:47 -0500, Tom Roberts <TomRoberts@chicago.avenew.com>
 wrote:
>Matt Porter wrote:
>> I've worked on several embedded 750 ports recently in which I've implemented
>> some preliminary concepts that should make things _much_ easier when porting
>> embedded 6xx/7xx systems that don't conform to chrp/pmac/prep specs.
>>
>> You basically follow MACH_prep and/or MACH_gemini since they are much
>> simpler than pmac.  Provide kernel/head.S, mm/init.c, and kernel/setup.c
>> changes where necessary for your MACH type.  I generally prefer setting
>> up a PReP style memmap unless I'm on a CPCI board and need all that extra
>> PCI mem space (to map other boards RAM into).
>
>Good advice, and that's what I was doing. However -- head.S is
>incredibly convuoluted and complicated -- it's like someone insisted on
>shaving nanoseconds and bytes everywhere possible, which is silly given
>the rest of Linux....

head.S is the start of everything.  Look at romInit.s in VxWorks or the
equivalent in another RTOS.  Jumping through the early hoops to setup
memory management and the like is usually ugly.  This isn't to say that
head.S isn't ugly, it is.  Obviously the tons of #ifdefs do not make
the code very readable but it is a design decision that ensures that
memory management (and other core changes) don't have to be spread
throughout many files for every board that shares the same processor.
I know firsthand that adding a generic change that affects VxWorks BSPs
is a nightmare simply because each BSP is a completely independent set
of files.

>My other problem is that I do not have any sort of boot ROM, and
>head.S does not fully initialize the CPU. I am running on an MPC604,
>and I cannot get it to execute past the point where the icache is
>enabled (enabling the dcache is OK). I can boot another OS on the
>board (which it just so happens I wrote), and I put the complete CPU
>initialization of that OS in before jumping to address 0 -- no go.

Again, we are talking about kernel/head.S, right?  Well, no.  Linux
isn't going to be what you want it to be into you add to it.  The
kernel/head.S entry point assumes that it came from a firmware spawned
bootloader that set up these things.

This particular problem sounds rather odd, if possible it would help if
you could post your early init code (that you merged from your own
OS) and the modified head.S somewhere and give a pointer to it.

I have several ports in which I simply set the MSR to a known value,
disable/invalidate icache/dcache/L2cache, clear the BATs, configure
the memory controller/PCI bridge, and then set R4-7 to know values from
a JTAG emulator script.  I can simply load/boot vmlinux at this point with
no problems.

>> One sore point is that MACH_<board> is defined as a single bit flag so we
>> will run out of those with the many MACH types that want to be in the
>> kernel in the near future.  That should probably get fixed up to something
>> with more longevity.
>
>It is not clear to me that a single build will support multiple
>boards/machines.

Look for CONFIG_PPC_ALL and read the Makefiles to see the instances of
all the chrp*.o, pmac*.o, and prep*.o objects being linked together.
System type is determined at runtime.

>I think we need to separate the CPU from the machine....

It's being worked on as far as making a framework for non-chrp/pmac/prep
6xx/7xx/74xx ports.  There just hasn't been a real pressing need until
lately.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
