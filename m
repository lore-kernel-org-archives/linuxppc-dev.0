Date: Mon, 17 Dec 2001 19:16:52 +0100
From: Uwe Steinmann <steinm@majestix.fernuni-hagen.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Uwe Steinmann <steinm@majestix.fernuni-hagen.de>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Again PCMCIA problems
Message-ID: <20011217191652.A8703@gehtnix.fernuni-hagen.de>
References: <20011212140119.A12086@gehtnix.fernuni-hagen.de> <20011212144414.7330@smtp.adsl.oleane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011212144414.7330@smtp.adsl.oleane.com>; from benh@kernel.crashing.org on Wed, Dec 12, 2001 at 03:44:14PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Dec 12, 2001 at 03:44:14PM +0100, Benjamin Herrenschmidt wrote:
> >
> >include memory 0x90000000-0x90ffffff
> >include port 0x0fff-0x1fff
>
> Some cards wants ports below 0xfff, and make sure the
> memory range you provide is actually available
> (do a cat /proc/iomem to check that). If the memory
> is allocated to cardbus (which happens on some machines
> which pre-configure the cardbus bridge from OF), it will
> not be userable by pcmcia
>
> I'd also suggest you update your kernel as some pcmcia
> fixes were lost around 2.4.16 and recovered later during
> 2.4.17-pre cycle, yours may still lack them.
>
> Ben.
Thanks for the help so far, I got finally a bit further, and it looks
very promissing but ran into another problem. For some reason the request for
irg 58 failled.

Dec 17 16:46:50 pb cardmgr[10624]: re-loading config file
Dec 17 16:46:52 pb cardmgr[10624]: initializing socket 0
Dec 17 16:46:52 pb cardmgr[10624]: socket 0: AVM ISDN-Controller A1
Dec 17 16:46:53 pb cardmgr[10624]: executing: 'modprobe isdn'
Dec 17 16:46:53 pb cardmgr[10624]: executing: 'modprobe hisax id=hisax1 type=26 protocol=2'
Dec 17 16:46:53 pb kernel: avma1_cs: testing i/o 0x140-0x149
Dec 17 16:46:53 pb kernel: avma1_cs: checking at i/o 0x140, irq 58
Dec 17 16:46:53 pb kernel: HiSax: Card 1 Protocol EDSS1 Id=HiSax (0)
Dec 17 16:46:53 pb kernel: HiSax: AVM A1 PCMCIA driver Rev. 1.1.4.1
Dec 17 16:46:53 pb kernel: AVM A1 PCMCIA: io 0x140 irq 58 model 1 version 2
Dec 17 16:46:53 pb kernel: AVM A1 PCMCIA: ISAC version (0): 2086/2186 V1.1
Dec 17 16:46:53 pb kernel: AVM A1 PCMCIA: HSCX version A: V2.1  B: V2.1
Dec 17 16:46:53 pb kernel: AVM A1 (PCMCIA): IRQ 58 count 0
Dec 17 16:46:53 pb kernel: HiSax: couldn't get interrupt 58
Dec 17 16:46:53 pb kernel: HiSax: Card AVM A1 (PCMCIA) not installed !
Dec 17 16:46:53 pb kernel: HiSax: module installed

>From my previos experiences with pcmcia I would guess the irg 58 isn't
too bad, somehow it isn't quite right in this case.

My config.opts looks like the following:

include port 0x100-0x4ff, port 0x1000-0x17ff
include memory 0x80080000-0x8008ffff

There is not statement in my configuration which forces the use of irq 58.

There has been another problem, probably not related to the one above.
In order to make the AVM A1 PCMCIA card work as much as it works now,
it needs a patch for
pcmcia-cs which includes a kernel module called avma1_cs.c. This
module uses the function kfree_s() which seems to be not available
in kernel 2.4.17-rc1-benh. I wonder if kfree is a replacement for it, although
it misses the second parameter of kfree_s()?

  Uwe


--
  MMK GmbH, Hagen
  Uwe.Steinmann@mmk-hagen.de
  Tel: +2331 987 4528    Fax: +2331 987 375

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
