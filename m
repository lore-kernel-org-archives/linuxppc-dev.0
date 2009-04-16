Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id E96C7DE137
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 08:04:52 +1000 (EST)
Date: Fri, 17 Apr 2009 02:04:51 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Roderick Colenbrander <thunderbird2k@gmail.com>
Subject: Re: RFC Patch: Use x86 init_hwif in the alim15x3 for x86-like
	PowerPC systems
Message-ID: <20090416220451.GA8636@oksana.dev.rtsoft.ru>
References: <c8485d470904150202s1f5c8cd7p34f0eaf4872f3e17@mail.gmail.com>
	<c8485d470904150734s47ce0f27y3ae984355e823d9f@mail.gmail.com>
	<200904162130.01237.bzolnier@gmail.com>
	<20090416205735.GA26519@oksana.dev.rtsoft.ru>
	<c8485d470904161427w31ff313dsb651aa1f53bbacea@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <c8485d470904161427w31ff313dsb651aa1f53bbacea@mail.gmail.com>
Cc: linux-ide@vger.kernel.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 16, 2009 at 11:27:34PM +0200, Roderick Colenbrander wrote:
> On Thu, Apr 16, 2009 at 10:57 PM, Anton Vorontsov
> <avorontsov@ru.mvista.com> wrote:
> > On Thu, Apr 16, 2009 at 09:30:00PM +0200, Bartlomiej Zolnierkiewicz wrote:
> >>
> >> Hi,
> >>
> >> On Wednesday 15 April 2009 16:34:22 Roderick Colenbrander wrote:
> >> > Hi,
> >> >
> >> > I'm using a Xilinx ML510 it features a PowerPC 440 cpu inside a
> >> > Virtex-5 FPGA. The board also contains a ALI M1533 south bridge
> >> > for IDE, USB and Audio. I did a lot of work to get the pci bus working
> >> > on this board and it works correctly but the default init code
> >> > of the alim15x3 driver doesn't work for me. The driver explicitly
> >> > disabled some initialization code for powerpc after uncommenting this
> >> > code it works properly. Benjamin Herrenschmidt and I think this
> >> > !CONFIG_PPC check should be removed because the system behaves
> >> > like a real 'x86' system (also the i8259 interrupt controller is used).
> >>
> >> Ben, I guess you are OK with the change and there are no longer other
> >> platforms requiring CONFIG_PPC check below?  [I don't see your ACK here]
> >
> > I'd like to nak this patch. It'll break MPC8610HPCD boards.
> >
> > See commit 6d1cee44361b8d06ccd1812e80448d86ae60dfe3
> >
> > I'm not sure how should we handle this for Xilinx PPC, MPC8610
> > PPC and Sparc all at the same time, but it's obvious that #ifdef
> > isn't enough any longer...
> >
> >
> >
> 
> If it is really a board specific issue (in case of powerpc it appears
> to be one) we could also use the default_irq override in ppc_md. What
> do you think?

Um, I don't see "default_irq" in the ppc_md. Do you want to add one?

I wonder if DECLARE_PCI_FIXUP_*() mechanism will work... see
arch/powerpc/platforms/fsl_uli1575.c as an example for board-specific
PCI fixups.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
