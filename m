Date: Tue, 18 Dec 2001 10:24:13 +0100
From: Uwe Steinmann <steinm@majestix.fernuni-hagen.de>
To: Paul Mackerras <paulus@samba.org>
Cc: Uwe Steinmann <steinm@majestix.fernuni-hagen.de>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Again PCMCIA problems
Message-ID: <20011218102413.A14636@gehtnix.fernuni-hagen.de>
References: <20011212140119.A12086@gehtnix.fernuni-hagen.de> <20011212144414.7330@smtp.adsl.oleane.com> <20011217191652.A8703@gehtnix.fernuni-hagen.de> <15390.52568.449162.783080@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15390.52568.449162.783080@argo.ozlabs.ibm.com>; from paulus@samba.org on Tue, Dec 18, 2001 at 04:00:08PM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Dec 18, 2001 at 04:00:08PM +1100, Paul Mackerras wrote:
> Uwe Steinmann writes:
>
> > Thanks for the help so far, I got finally a bit further, and it looks
> > very promissing but ran into another problem. For some reason the request for
> > irg 58 failled.
> >
> > Dec 17 16:46:50 pb cardmgr[10624]: re-loading config file
> > Dec 17 16:46:52 pb cardmgr[10624]: initializing socket 0
> > Dec 17 16:46:52 pb cardmgr[10624]: socket 0: AVM ISDN-Controller A1
> > Dec 17 16:46:53 pb cardmgr[10624]: executing: 'modprobe isdn'
> > Dec 17 16:46:53 pb cardmgr[10624]: executing: 'modprobe hisax id=hisax1 type=26 protocol=2'
> > Dec 17 16:46:53 pb kernel: avma1_cs: testing i/o 0x140-0x149
> > Dec 17 16:46:53 pb kernel: avma1_cs: checking at i/o 0x140, irq 58
> > Dec 17 16:46:53 pb kernel: HiSax: Card 1 Protocol EDSS1 Id=HiSax (0)
> > Dec 17 16:46:53 pb kernel: HiSax: AVM A1 PCMCIA driver Rev. 1.1.4.1
> > Dec 17 16:46:53 pb kernel: AVM A1 PCMCIA: io 0x140 irq 58 model 1 version 2
> > Dec 17 16:46:53 pb kernel: AVM A1 PCMCIA: ISAC version (0): 2086/2186 V1.1
> > Dec 17 16:46:53 pb kernel: AVM A1 PCMCIA: HSCX version A: V2.1  B: V2.1
> > Dec 17 16:46:53 pb kernel: AVM A1 (PCMCIA): IRQ 58 count 0
> > Dec 17 16:46:53 pb kernel: HiSax: couldn't get interrupt 58
>
> On powerbooks, the card functional interrupt is shared with the card
> controller interrupt.  That is, your HiSax card will use the same
> interrupt for its operations as the TI cardbus controller.  Thus, if
> the HiSax driver doesn't include SA_SHIRQ in the flags value to the
> request_irq call, the request_irq will fail.  I would say that is what
> you are seeing.
You were quite right. There is a define in hisax.h where I4L_IRQ_FLAGS is
set to 0. If I change this to SA_SHIRQ it works! At least the card can be
configured. I'll check if I can get an internet connection over ISDN as
soon as I'm back home.

I'll send a note to the maintainer of the hisax driver.

Thanks for the help.

  Uwe
--
  MMK GmbH, Hagen
  Uwe.Steinmann@mmk-hagen.de
  Tel: +2331 987 4528    Fax: +2331 987 375

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
