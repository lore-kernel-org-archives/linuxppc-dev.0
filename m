Message-Id: <200007080615.IAA00725@piglet.grunz.lu>
Date: Sat, 8 Jul 2000 08:15:50 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Trying to enable backside on a G4
To: guillaume.laures@noos.fr
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <39666CB7.DE6B2BC5@noos.fr>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Guillaume,

On   8 Jul, this message from Guillaume Laurès echoed through cyberspace:
> I'm just starting writing kernel-level code :-), and I was trying to set
> the L2CR register on a G4 upgrade for a PCI PowerMac (actually a
> 8600/250 upgraded with a XLR8 MACh Carrier G4 350/233)

If you're working on 2.4.0-style kernels, here is a patch that
implements this functionality as a kernel command line option.

If you are trying to produce a standalone program, your example code
will not work. It will only work inside the kernel, not from userspace.
You could try to build it as a module....

But then again, you can easily set the l2cr from userspace. I have this
in my /etc/rc.d/rc.sysinit:

action "Mounting proc filesystem" mount -n -t proc /proc /proc

# Now that /proc is available, set up level2 cache:
echo 0 > /proc/sys/kernel/l2cr
echo '0x29200000' > /proc/sys/kernel/l2cr
echo '0xa9200000' > /proc/sys/kernel/l2cr
action "Enabling level2 cache" echo -n

doing a 'cat /proc/sys/kernel/l2cr' will show you the current setting of
l2cr.

Be aware that there might be problems with just using the echo>
technique, as the cache needs to be invalidated before enabling it.
Normally that should happen automagically; however it didn't work for
me. That's why there are two 'echo's above.

My final l2cr value is:

[mlan@piglet ~]$ cat /proc/sys/kernel/l2cr
0xa9000000:  enabled, no parity, 512KB, +2 clock, pipelined burst SRAM, copy-back, 0.5ns hold

Have fun

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
