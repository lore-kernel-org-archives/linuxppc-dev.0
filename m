Message-Id: <200103090705.IAA00721@piglet.grunz.lu>
Date: Fri, 9 Mar 2001 08:05:40 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: 2.4 not booting on 7600 (was: Re: 2.4.2 USB and "mon>")
To: benh@kernel.crashing.org
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20010307121954.29343@mailhost.mipsys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

On   7 Mar, this message from Benjamin Herrenschmidt echoed through cyberspace:
>>I've been unable to boot _any_ 2.3/2.4 kernels on my machine since
>>around 2.3.99 or a bit earlier. Some revisions would boot part of the
>>time, but most of them not at all. Symtom is always the same: hang
>>before initializing the framebuffer, i.e. still on the OF screen.

I should have added that there are some 2.4 kernels that _did_ boot
reliably: benh's 2.5 rsync tree (that's now dead, right?).

>>I get the 'retunring 0x... from prom_init' string, but nothing after
>>that.....
>
> That's weird ? I suppose you tried removing/moving PCI cards ?

No, because I have no reason to suspect a PCI card problem. I never had
those; I had non-functional cards because of the Io port trouble; but
never did any PCI problem lock up the box. Especially not that early in
the boot process....

But than again, I have a Matrox Millenium and a Promise IDE controller
in there; I could try removing the Matrox and see..

Also, this box has a G3 upgrade card, and seems to be weird in some
respect. I seem to be the only ne that couldn't boot from the internal
(MESH) bus with one specific hard disk; slowing the processor through
ICTC solved that problem....

> You can also try to hack printk so that it calls prom_prinf (or xmon_printf),
> that may help figure out where it goes wrong.

I'll get back to debugging. However, from my last tries in
November/December, I remember it hanging somewhere in the early stages
of init/main.c, in one of these files (this is from the patch with my
debuggiong printk's):

arch/ppc/kernel/pmac_pic.c
arch/ppc/kernel/pmac_time.c
arch/ppc/mm/init.c

This is the relevant part in init/main.c:

        lock_kernel();
        printk(linux_banner);
        setup_arch(&command_line);
+if ( ppc_md.progress ) ppc_md.progress("main: setup_arch done", 0x3eab);
        printk("Kernel command line: %s\n", saved_command_line);
+if ( ppc_md.progress ) ppc_md.progress("main: 1", 0x3eab);
        parse_options(command_line);
+if ( ppc_md.progress ) ppc_md.progress("main: 2", 0x3eab);
        trap_init();
+if ( ppc_md.progress ) ppc_md.progress("main: 3", 0x3eab);
        init_IRQ();
+if ( ppc_md.progress ) ppc_md.progress("main: 4", 0x3eab);
        sched_init();
+if ( ppc_md.progress ) ppc_md.progress("main: 5", 0x3eab);
        time_init();
+if ( ppc_md.progress ) ppc_md.progress("main: 6", 0x3eab);
        softirq_init();
+if ( ppc_md.progress ) ppc_md.progress("main: 7", 0x3eab);

Also, I've found that it would lock up at _different_ stages in early
boot, not at one specific step.

This led me to conclude that 2.4 kernels do something different in early
processor, memory or cache setup, which _may_ break something else
somewhere later.

But I'll try again and do some more debugging. Also, I'll try a boot
with the original 604/132 processor, to see whether that makes any
difference.

For the record, tried the latest bk tree yesterday evening: same hang.


Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
