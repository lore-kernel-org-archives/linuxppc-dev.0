Return-Path: <Johannes.Thumshirn@men.de>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
 [193.109.254.118])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.bemta14.messagelabs.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3EE2A2C0105
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 17:42:58 +1000 (EST)
Date: Tue, 6 Aug 2013 09:36:34 +0200
From: Johannes Thumshirn <johannes.thumshirn@men.de>
To: Leon Ravich <lravich@gmail.com>
Subject: Re: PCIE device errors after linux kernel upgrade
Message-ID: <20130806073633.GA21492@jtlinux>
References: <CAPWoNkJ3NKM-_g93LdRpjvdNFtLt-Pjpg4d4oEKC9CvkpzZ-Wg@mail.gmail.com>
 <CAPWoNkLQUbFG2vZ7wqoqqVNj4uxKz3Fa_vsSH=1_TDD=XC1f2A@mail.gmail.com>
 <CAErSpo5ZZgdpkK+QdQUEnNCEXcG_T+QBWTVoQnMTghxkX7n2HA@mail.gmail.com>
 <20130806070703.GA20622@jtlinux>
 <CAPWoNkKo6Cfg0Hr2QYBXVnUrC-UQwES65UUHfSvR3nBvZrfFoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAPWoNkKo6Cfg0Hr2QYBXVnUrC-UQwES65UUHfSvR3nBvZrfFoA@mail.gmail.com>
Cc: Johannes Thumshirn <johannes.thumshirn@men.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 06, 2013 at 10:26:18AM +0300, Leon Ravich wrote:
> Hi Johannes
> no panic just reboot.
> it is not the first read, it takes few minutes of work with pcie to reboot.
>

Ah, OK. Unfortunately I can't really help you then.

Have you looked up the error values from the EDAC driver?

If it's just a reboot without panic, could there be a watchdog resetting the
board?


>
>
> On 6 August 2013 10:07, Johannes Thumshirn <johannes.thumshirn@men.de> wrote:
> > On Mon, Aug 05, 2013 at 09:38:45AM -0600, Bjorn Helgaas wrote:
> >> [+cc linuxppc-dev]
> >>
> >> On Mon, Aug 5, 2013 at 5:17 AM, Leon Ravich <lravich@gmail.com> wrote:
> >> > Hi all ,
> >> > I am trying to upgrade ours embedded device (freescale powerPC P2020 cpu)
> >> > linux kernel  , till now we used 2.6.32 I am trying to upgrade to 3.8.13 .
> >> > I took the source from freescale git:
> >> > git://git.freescale.com/ppc/sdk/linux.git
> >> >
> >> > on our embedded device we have an FPGA connected through PCIE .
> >> >
> >> > on each boot we loading the rbf design to the FPGA and the rescan pci bus to let
> >> > kernel detect it .
> >> >
> >> > during the rescan I getting error messages:
> >> >  genirq: Setting trigger mode 0 for irq 27 failed
> >> > (mpc8xxx_irq_set_type+0x0/0xec)
> >> > [   22.060898] genirq: Setting trigger mode 0 for irq 28 failed
> >> > (mpc8xxx_irq_set_type+0x0/0xec)
> >> > [   22.069461] genirq: Setting trigger mode 0 for irq 31 failed
> >> > (mpc8xxx_irq_set_type+0x0/0xec)
> >> > [   22.078010] genirq: Setting trigger mode 0 for irq 32 failed
> >> > (mpc8xxx_irq_set_type+0x0/0xec)
> >> > [   22.086576] genirq: Setting trigger mode 0 for irq 33 failed
> >> > (mpc8xxx_irq_set_type+0x0/0xec)
> >> > [   22.095143] genirq: Setting trigger mode 0 for irq 37 failed
> >> > (mpc8xxx_irq_set_type+0x0/0xec)
> >> > [   22.103715] genirq: Setting trigger mode 0 for irq 38 failed
> >> > (mpc8xxx_irq_set_type+0x0/0xec)
> >> > [   22.112282] genirq: Setting trigger mode 0 for irq 39 failed
> >> > (mpc8xxx_irq_set_type+0x0/0xec)
> >>
> >> Hmm, I don't know much about IRQ issues.
> >>
> >> > [   37.945785] pci 0000:00:00.0: ignoring class 0x0b2000 (doesn't
> >> > match header type 01)
> >>
> >> There's a recent patch related to this:
> >> http://lkml.kernel.org/r/1374823418-1550-1-git-send-email-Chunhe.Lan@freescale.com
> >>
> >> > [   37.953640] PCIE error(s) detected
> >> > [   37.953858] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> >> > [   37.953988] pci 0000:00:00.0: BAR 8: assigned [mem 0xc0000000-0xdfffffff]
> >> > [   37.953994] pci 0000:00:00.0: BAR 7: can't assign io (size 0x10000)
> >> > [   37.954000] pci 0000:01:00.0: BAR 0: assigned [mem 0xc0000000-0xc00fffff]
> >> > [   37.954013] pci 0000:01:00.0: BAR 1: assigned [mem 0xc0100000-0xc017ffff]
> >> > [   37.954025] pci 0000:01:00.0: BAR 2: assigned [mem 0xc0180000-0xc01fffff]
> >> > [   37.954036] pci 0000:00:00.0: PCI bridge to [bus 01]
> >> > [   37.954041] pci 0000:00:00.0:   bridge window [mem 0xc0000000-0xdfffffff]
> >> > [   38.007354] PCIE ERR_DR register: 0x80020000
> >> > [   38.011613] PCIE ERR_CAP_STAT register: 0x00000041
> >> > [   38.016392] PCIE ERR_CAP_R0 register: 0x00000800
> >> > [   38.020997] PCIE ERR_CAP_R1 register: 0x00000000
> >> > [   38.025602] PCIE ERR_CAP_R2 register: 0x00000000
> >> > [   38.030207] PCIE ERR_CAP_R3 register: 0x00000000
> >> >
> >> >
> >> > and after a few minutes I linux reboot it self,
> >> >
> >> >
> >> > where can I start debugging it??
> >>
> >> I'd start by applying the header quirk patch above, then comparing the
> >> complete console log (boot with "ignore_loglevel") from 2.6.32 and
> >> 3.8.13.
> >>
> >> Bjorn
> >> _______________________________________________
> >> Linuxppc-dev mailing list
> >> Linuxppc-dev@lists.ozlabs.org
> >> https://lists.ozlabs.org/listinfo/linuxppc-dev
> >
> > Hi,
> >
> > I have a similar problem here on a P4080 based board with the same 3.8 Kernel
> > from freescale git. Does your system panic (maybe due to a machine check
> > exception)?  If yes could it be the first read from the PCI device?
> >
> > Johannes
>
>
>
> --
> Leonid Ravich
