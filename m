From: Benjamin Herrenschmidt <bh40@calva.net>
To: Stefan Jeglinski <jeglin@4pi.com>,
        LinuxPPC-dev
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: usb wheel mouse, XF4.0
Date: Wed, 29 Nov 2000 18:08:00 +0100
Message-Id: <19341024103944.10099@192.168.1.2>
In-Reply-To: <p04330100b64abb5a279d@[192.168.0.1]>
References: <p04330100b64abb5a279d@[192.168.0.1]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Well, then is there any way for any user to control how the
>interrupts are dished out (assigned), say for example by moving cards
>around in the slots? Can the kernel be patched to "hardwire" the
>assignment of interrupts? (I'm talking a customs patch that only I
>apply, not a general patch for everyone).
>
>Or is this entirely an initialization problem deep in the kernel
>code? Is there any timeline for fixing it or is it a part of the
>longer-term PCI cleanup I've read about?

It's probably a problem retreiving interrupt infos from the MacOS
"hacked" device-tree in the kernel on oldworld. That's why I need your
device tree.

Timeline and Linux are non-matching concepts ;) It will be fixed once
someone figures out exactly where the error is.

>I am relatively limited in how I can move cards around as my earlier
>post reporting my slot summary will attest to,
>
><http://lists.linuxppc.org/listarcs/linuxppc-dev/200011/msg00187.html>,
>
>
>In addition, yesterday I speculated that the dual IRQ 23 might help
>explain why I was having 2.2.18preX boot problems with the aic7xxx.

Well, it can. I didn't notice that in the reports you sent me earlier, sorry.

>This can't really be the case because one of the slot summary tests
>was to remove the USB card (and all others). There was no difference,
>so my boot issue remains a separate one with its odd workaround.

Well, maybe the adaptec interrupt is wrong, not the USB one ?

The bug you were having with the Adaptec sounds really weird, according
to the tests you did, it looks like for some reason, either the kernel
is beeing damaged or something in the kernel is trashing memory.
(There's no other explanation for the crash inside __ioremap).

It could be a bootloader problem, did you try with different versions of
BootX & miBoot ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
