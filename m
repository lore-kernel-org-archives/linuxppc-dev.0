Message-Id: <200008151928.VAA00681@piglet.grunz.lu>
Date: Tue, 15 Aug 2000 21:28:11 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: bk 2.4-test7 broken
To: costabel@wanadoo.fr
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <39992943.C267C4CB@wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  15 Aug, this message from Martin Costabel echoed through cyberspace:
> I too would like to know if somebody has this kernel running.

Not me....

> Jack Howarth wrote:
>>     There are several problems with the current bitkeeper unstable
>> kernel tree.
> []
> Mine gets stuck after saying "arch: exit" and before switching from the
> prom console to the fb console (no penguin).

Mine too. I have it stuck at various points, as can be shown by many
ppc_md.progress() calls ;-). Most of the time, it stops somewhere in
init/main.c, in the early stages of start_kernel():

asmlinkage void __init start_kernel(void)
{
[...]
        lock_kernel();
        printk(linux_banner);
        setup_arch(&command_line);
        printk("Kernel command line: %s\n", saved_command_line);
        parse_options(command_line);
[sometimes never comes here.]
        trap_init();
        init_IRQ();
[it can happen in init_IRQ() as well]
        sched_init();
        time_init();
[somewhere in time_init(), I've also seen it crash]
        softirq_init();
[if it got here, it succeeded for me]
[...]

I've tried to trace via ppc_md.progress() calls where it hangs, but
that's quite useles, as it doesn't always hang at the same place.

For the record, I've seen similar hangs with 2.3.99/2.4.0 kernels
before, when I had to reboot a few times before it would succeed. Also,
I'm using quik to boot my 7600/upgraded-G3; I've not had the time to
verify how it's behaving under BootX.

Comments? Solutions?


Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
