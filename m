From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15390.52568.449162.783080@argo.ozlabs.ibm.com>
Date: Tue, 18 Dec 2001 16:00:08 +1100 (EST)
To: Uwe Steinmann <steinm@majestix.fernuni-hagen.de>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Again PCMCIA problems
In-Reply-To: <20011217191652.A8703@gehtnix.fernuni-hagen.de>
References: <20011212140119.A12086@gehtnix.fernuni-hagen.de>
	<20011212144414.7330@smtp.adsl.oleane.com>
	<20011217191652.A8703@gehtnix.fernuni-hagen.de>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Uwe Steinmann writes:

> Thanks for the help so far, I got finally a bit further, and it looks
> very promissing but ran into another problem. For some reason the request for
> irg 58 failled.
>
> Dec 17 16:46:50 pb cardmgr[10624]: re-loading config file
> Dec 17 16:46:52 pb cardmgr[10624]: initializing socket 0
> Dec 17 16:46:52 pb cardmgr[10624]: socket 0: AVM ISDN-Controller A1
> Dec 17 16:46:53 pb cardmgr[10624]: executing: 'modprobe isdn'
> Dec 17 16:46:53 pb cardmgr[10624]: executing: 'modprobe hisax id=hisax1 type=26 protocol=2'
> Dec 17 16:46:53 pb kernel: avma1_cs: testing i/o 0x140-0x149
> Dec 17 16:46:53 pb kernel: avma1_cs: checking at i/o 0x140, irq 58
> Dec 17 16:46:53 pb kernel: HiSax: Card 1 Protocol EDSS1 Id=HiSax (0)
> Dec 17 16:46:53 pb kernel: HiSax: AVM A1 PCMCIA driver Rev. 1.1.4.1
> Dec 17 16:46:53 pb kernel: AVM A1 PCMCIA: io 0x140 irq 58 model 1 version 2
> Dec 17 16:46:53 pb kernel: AVM A1 PCMCIA: ISAC version (0): 2086/2186 V1.1
> Dec 17 16:46:53 pb kernel: AVM A1 PCMCIA: HSCX version A: V2.1  B: V2.1
> Dec 17 16:46:53 pb kernel: AVM A1 (PCMCIA): IRQ 58 count 0
> Dec 17 16:46:53 pb kernel: HiSax: couldn't get interrupt 58

On powerbooks, the card functional interrupt is shared with the card
controller interrupt.  That is, your HiSax card will use the same
interrupt for its operations as the TI cardbus controller.  Thus, if
the HiSax driver doesn't include SA_SHIRQ in the flags value to the
request_irq call, the request_irq will fail.  I would say that is what
you are seeing.

In other words, drivers for cardbus and pcmcia cards will fail on
powerbooks if they are not willing to share their interrupt line.
fail.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
