Message-ID: <3FC9EEC6.8040507@g-house.de>
Date: Sun, 30 Nov 2003 14:21:10 +0100
From: Christian Kujau <evil@g-house.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.6 PReP issues, still freezing
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi,

after more days of compiling (at least now i know my ppc has good RAM
:-) ) and testing serveral kernels, i think now it's not a
network-related but a ppc-specific problem.

Andrew Morton gave me the hint to just copy drivers/net/tulip/ from the
working 2.5.30 kernel to a recent one. i've done so; i've copied all
tulip stuff to a fresh 2.6.0-test11 kernel, after booting i was able to
load the module, but a following "ifconfig eth1 192.168.2.1" freezed the
machine -- as every kernel after 2.5.30 i was able to compile.

a fix from Jeff Garzik went to linuxppc-dev (i saw it on lkml too),
subject was "2.6 PReP fix? (Was: [jgarzik@pobox.com: [PATCH/CFT] de2104x
fixes])". i found out, that i can load 3 different modules for my card:

00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip 21140
[FasterNet] (rev 22)
         Flags: bus master, medium devsel, latency 0, IRQ 11
         I/O ports at 1800 [size=128]
         Memory at c300a000 (32-bit, non-prefetchable) [size=128]
         Expansion ROM at c1040000 [disabled] [size=256K]


/lib/modules/2.6.0-test11/kernel/drivers/net/tulip:
de2104x.ko  de4x5.ko  tulip.ko

/lib/modules/2.5.30/kernel/drivers/net/tulip:
de2104x.o  de4x5.o  tulip.o

and every module gave me a freeze with 2.6.0-test11 (oh, i forgot to
test, if de2104x.o and de4x5.o are working correctly with 2.5.30 since
i've used always "tulip")

and so, this makes me think it's a ppc-specific problem. no, i don't say
it's easier now to fix, perhaps it's even harder, because a lot has
changed in the ppc port too. if we could blame the device-driver, the
codesize to play with would be a lot smaller...

but since really no other PReP people complain, i think i'll stay with
2.4. a while. the machine is not that fast and i need a faster one anyway...

Thank you for your time,
Christian.
--
BOFH excuse #389:

/dev/clue was linked to /dev/null


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
