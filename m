Message-ID: <3F9FF9AB.6000406@esteem.com>
Date: Wed, 29 Oct 2003 09:32:27 -0800
From: Conn Clark <clark@esteem.com>
MIME-Version: 1.0
To: Paul Miller <pmiller9@users.sourceforge.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 405EP peripheral memory access
References: <200310290808.00654.pmiller9@users.sourceforge.net>
In-Reply-To: <200310290808.00654.pmiller9@users.sourceforge.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Paul Miller wrote:
> Hi,
>
> I am new to Linux embedded programming.  I have experience programming
> microcontrollers and DSPs without an operating system, so I have some
> idea what I'm doing.  Anyhow, I'm trying to use the peripheral memory
> bus on my 405EP CerfCube from Intrinsyc.  Does anyone have an example
> that I can work from?

If I remember correctly the Cerf Cube uses PPCboot/U-Boot and ships with
the source on a CD.

>
> To setup the memory's timings, I need access to the DCR register.  In
> the PowerPC datasheet it says to use assembly instructions mtdcr and
> mfdcr.  I don't know much about assembly, but I found a kernel patch
> that uses these functions.  So, working off this patch, I tried making
> a simple program to read these registers.  When I run it, Linux reports
> an "Illegal instruction" and doesn't let me access the register.

Did you make calls to the patched kernel or paste this function into
your user mode program? Some registers are priviledged and only the
kernel is allowed to touch them. If you had this function in a user
program it won't work.
>
> Does access to this bus need to be done in "kernel mode"?  If so, where
> can I find more information about writing a kernel driver?  Ideally,
> I'd like to just open a device file and read/write to the bus.
>

I wrote my first kernel driver based on an example found at
http://www.denx.de . Though It was for kernel version 2.2.x and the
Motorla 8xx processor, the example was quite helpful and could still be
for you. Its at the botom of the page here
http://www.denx.de/e/index1.php?head=solution-se-head&main=solution-se&subnav=solution-se-subnav&logo=logo-se&mainnav=softwarenav&bottom=bottom-se

One aproach you might take is modifying the PPCBoot source and mapping
your device to a memory address and access it using the memory map
functions in the kernel.
> Thanks!
> -Paul
>
>

Its going to be ruff in the begining, but it gets easier. Have fun.

Conn Clark


--

*****************************************************************
   If you live at home long enough, your parents will move out.
  (Warning they may try to sell their house out from under you.)
*****************************************************************

Conn Clark
Engineering Stooge				clark@esteem.com
Electronic Systems Technology Inc.		www.esteem.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
