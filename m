Message-ID: <3A686DFE.9030308@valinux.com>
Date: Fri, 19 Jan 2001 09:40:30 -0700
From: Jeff Hartmann <jhartmann@valinux.com>
MIME-Version: 1.0
To: michdaen@iiic.ethz.ch
CC: dri-devel@lists.sourceforge.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Dri-devel] PPC Lockup (ati-pcigart-branch)
References: <3A67B401.8282A00F@relog.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer wrote:

> [CC'ing linuxppc-dev, hopefully someone there knows what might be up...]
>
> This is where it dies:
>
>
>         /* FIXME: We should really have a kernel call for this...
>          */
>         entry->virtual = __vmalloc( (pages << PAGE_SHIFT),
>                                     GFP_KERNEL,
>                                     PAGE_KERNEL);
>
>         printk("Checkpoint 2\n");
>
>
> Checkpoint 2 is never reached, the machine is absolutely dead.
>
>
> Michel
>
>
Since your running through klogd, this might not be 'exactly' where you
die.  I would be TERRIBLY surprised if you died here.  One thing you
have to remember about kernel debugging is that you can't always trust
what is in the log.  Here is a technique that works for me when I'm
unsure of a piece of code:

Do what I suggested first, if it finds a likely problem, then great
(printk's on every line of a function).
When you get a general area where there is a failure, comment out every
line of code after that.
Line by line put the code back in.
This will help you find the hang.

This is a very common way of debugging kernel code with hangs.  There
are other alternatives.

Setup a serial console, and turn of syslogd/klogd.  This will give you
almost immediate information if you keep the output small (i.e., no
logging of lots of loop iterations or other high output stuff.)  This is
one useful tool for kernel debugging.

If through the serial console you get an Oops message, you can use
ksymoops to find out what section of code was executing right before the
Oops.  You have to do objdump usually to figure out which line of C code
caused the problem, unless the logic of the asm makes it obvious.
(i.e., I only do those types of operations on line X.)

I dunno if the kgdb patch works on powerpc, but you might try it.  You
could single step through this code since your not at a point where
interrupts are disabled.

Unfortunately kdb (built-in kernel debugger) does not work on the
powerpc.  It is REALLY useful when your debugging code when interrupts
are disabled, but it only works on ia64 and ia32 currently.  I
personally like it alot more then kgdb, even though it has some
limitations kgdb doesn't.

Hope this helps,
-Jeff


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
