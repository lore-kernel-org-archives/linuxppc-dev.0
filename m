Subject: Re: After Uncompresseing Linux..., what's next
From: Gary Thomas <gary@chez-thomas.org>
To: Prakash kanthi <pkanthi@yahoo.com>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20021220170607.22771.qmail@web41207.mail.yahoo.com>
References: <20021220170607.22771.qmail@web41207.mail.yahoo.com>
Content-Type: text/plain
Date: 20 Dec 2002 10:22:59 -0700
Message-Id: <1040404979.32279.6262.camel@hermes.chez-thomas.org>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2002-12-20 at 10:06, Prakash kanthi wrote:
>
> Gary,
>
> I really appreciate your help. Here is what i am
> doing. Sorry it is little long. But was necessasry.
>
> 1. I have a boot loader(xrom.elf) of size around 400KB
> which basically have menu driven tests along with an
> option to jump to linux kernel(zImage.initrd.elf).
>
> 2. xrom.elf is compiled to start at 0xfffffffc and
> jump to 0x00000000 to have rest of functionality.
> zImage.initrd.elf is compiled to start at 0x00400000.
>
> 3. I load zImage.initrd.elf first and then xrom.elf
> (xilinx tool makes sure that they are loaded to
> corresponding locations based on ELF header).
>
> 4. After loading both, i start running xrom.elf and it
> shows up a menu in my UART terminal. I jump to linux
> (0x00400000).
>
> 5. I see that linux is basically reading the board
> info, setting UART, prints some boot messages onto it
> and then performs uncompression (gunzip function takes
> the rest of linux image and puts the uncompressed code
> starting from 0x0).
>

This is just the secondary bootstrap, whose job is to
unpack the kernel image and put it at location 0x0.

> 6. Up untill, everything is ok. After this, control
> jumps to 0x0 and starts executing.
>
> My problems are,
>
> a. Once the uncompression process is done, i am not
> sure if the image is copied to 0x0 (i do see value
> changes in memory starting from 0x0).
> b. As uncompression process is embedded into
> zImage.initrd.elf, i do not objdump does not tell me
> which function it is going to execute after
> uncompression.
>

The code that executes first is found in arch/ppc/kernel/head.S
Try looking at it, and tracing the execution.  If your hardware
(debug environment) can't do things like set breakpoints and
single step, then you're probably limited to very simple
debug techniques like leaving breadcrumbs (write some number
or pattern to a known location which hopefully you can look
at when it dies).

Also, as Jim Potter pointed out, the kernel needs to be started in
the most privileged execution mode since it will be taking
over the CPU completely.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
