Date: Mon, 1 Dec 2003 12:11:19 +0100
From: Remco Post <r.post@sara.nl>
To: Christian Kujau <evil@g-house.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.6 PReP issues, still freezing
Message-Id: <20031201121119.768fb4c1.r.post@sara.nl>
In-Reply-To: <3FC9EEC6.8040507@g-house.de>
References: <3FC9EEC6.8040507@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 30 Nov 2003 14:21:10 +0100
Christian Kujau <evil@g-house.de> wrote:

>
> hi,
>
> after more days of compiling (at least now i know my ppc has good RAM
> :-) ) and testing serveral kernels, i think now it's not a
> network-related but a ppc-specific problem.
>
> Andrew Morton gave me the hint to just copy drivers/net/tulip/ from the
> working 2.5.30 kernel to a recent one. i've done so; i've copied all
> tulip stuff to a fresh 2.6.0-test11 kernel, after booting i was able to
> load the module, but a following "ifconfig eth1 192.168.2.1" freezed the
> machine -- as every kernel after 2.5.30 i was able to compile.
>
> a fix from Jeff Garzik went to linuxppc-dev (i saw it on lkml too),
> subject was "2.6 PReP fix? (Was: [jgarzik@pobox.com: [PATCH/CFT] de2104x
> fixes])". i found out, that i can load 3 different modules for my card:
>
> 00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip 21140
> [FasterNet] (rev 22)
>          Flags: bus master, medium devsel, latency 0, IRQ 11
>          I/O ports at 1800 [size=128]
>          Memory at c300a000 (32-bit, non-prefetchable) [size=128]
>          Expansion ROM at c1040000 [disabled] [size=256K]
>
>
> /lib/modules/2.6.0-test11/kernel/drivers/net/tulip:
> de2104x.ko  de4x5.ko  tulip.ko
>
> /lib/modules/2.5.30/kernel/drivers/net/tulip:
> de2104x.o  de4x5.o  tulip.o
>
> and every module gave me a freeze with 2.6.0-test11 (oh, i forgot to
> test, if de2104x.o and de4x5.o are working correctly with 2.5.30 since
> i've used always "tulip")
>
> and so, this makes me think it's a ppc-specific problem. no, i don't say
> it's easier now to fix, perhaps it's even harder, because a lot has
> changed in the ppc port too. if we could blame the device-driver, the
> codesize to play with would be a lot smaller...
>
> but since really no other PReP people complain, i think i'll stay with
> 2.4. a while. the machine is not that fast and i need a faster one
> anyway...
>

I stopped complaining a while back (2.5.60 something) since I got absolutely
no response. I'm one of the lucky (?) few who have a motorola powerstack
(II) mobo.

> Thank you for your time,
> Christian.
> --
> BOFH excuse #389:
>
> /dev/clue was linked to /dev/null
>
>
>


--
Met vriendelijke groeten,

Remco Post

SARA - Reken- en Netwerkdiensten                      http://www.sara.nl
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer industry
didn't even foresee that the century was going to end." -- Douglas Adams

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
