Return-Path: <sheutlin@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 0CF162BF18
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Jan 2005 02:19:01 +1100 (EST)
From: Sebastian Heutling <sheutlin@gmx.de>
To: Sven Luther <sven.luther@wanadoo.fr>
In-Reply-To: <20050110063459.GA22078@pegasos>
References: <200412261435.13562.marc.dietrich@ap.physik.uni-giessen.de>
	<200501051733.06350.marvin24@gmx.de> <20050105165551.GA29287@pegasos>
	<200501052157.25302.marvin24@gmx.de> <41E1BBA2.30008@gmx.de>
	<20050110063459.GA22078@pegasos>
Content-Type: text/plain
Date: Mon, 10 Jan 2005 16:19:03 +0100
Message-Id: <1105370343.6222.32.camel@weizen.left.earth>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [FYI] linux 2.6 still not working with PReP (ppc32)
Reply-To: sheutlin@gmx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-01-10 at 07:34 +0100, Sven Luther wrote:

[...]

> > I also tried the 2.6.10 and found out that it doesn't work here as well. 
> > First I get a lot of lost interrupts from the IDE driver and after that 
> > I also get the SCSI timeouts. It must have something to do with the prep 
> > changes in 2.6.9. One difference in IRQ setup I noticed is in 
> > prep_pcibios_fixup(). If I remember correctly before 2.6.9 at least on 
> > this Utah machine the IRQs are assigned from Motherboard_routes[] 
> > without doing anything else. Now additionally the IRQ is also written 
> > into the devices pci config space which might not work on the 
> > PowerstackII Utah.
> > It's only a guess and I haven't had the time yet to test it.
> 
> Can you try the debian kernels i upload and fill bugreports against them ?

I tried the 2.6.9 kernel. Same problem as in 2.6.10. I hacked a little
in prep_pci.c/prep_pcibios_fixup() but nothing. Then I replaced
prep_pci.c and prep_setup.c by using the 2.6.8 ones to be sure that this
problem isn't coming from elsewhere and guess what: It worked again. So
something from 2.6.8 to 2.6.9 in those two files must be causing this
IRQ problem.


Sebastian
