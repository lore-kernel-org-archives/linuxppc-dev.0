Return-Path: <sheutlin@gmx.de>
Received: from mail.gmx.net (pop.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id E16C42BF0E
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jan 2005 10:18:02 +1100 (EST)
Message-ID: <41E1BBA2.30008@gmx.de>
Date: Mon, 10 Jan 2005 00:17:54 +0100
From: Sebastian Heutling <sheutlin@gmx.de>
MIME-Version: 1.0
To: Marc Dietrich <marvin24@gmx.de>
References: <200412261435.13562.marc.dietrich@ap.physik.uni-giessen.de>	<200501051733.06350.marvin24@gmx.de>	<20050105165551.GA29287@pegasos>
	<200501052157.25302.marvin24@gmx.de>
In-Reply-To: <200501052157.25302.marvin24@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [FYI] linux 2.6 still not working with PReP (ppc32)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Marc Dietrich wrote:

>Hi all,
>
>I didn't recognise that the kernel from Sebastian - which was working fine 
>here - was build from the debian sources (no hint in the kernel version). 
>So I build everything again from debian source and fixed the irq's in 
>prep_pci.c.
>  
>
Erm ... well ... yes - it's a debian kernel ;).

>I can confirm now, that this debian+irq_fix kernel 2.6.8 runs fine and 
>produces no scsi timeouts!
>
>Something happend in kernels >= 2.6.9 which makes the scsi unusable. Also it 
>seems, that even in 2.6.8 kernels and with ide hard disks (Sebastians setup) 
>the scsi controller timeouts, but continues to operate - correct?
>  
>

Yep correct.
I also tried the 2.6.10 and found out that it doesn't work here as well. 
First I get a lot of lost interrupts from the IDE driver and after that 
I also get the SCSI timeouts. It must have something to do with the prep 
changes in 2.6.9. One difference in IRQ setup I noticed is in 
prep_pcibios_fixup(). If I remember correctly before 2.6.9 at least on 
this Utah machine the IRQs are assigned from Motherboard_routes[] 
without doing anything else. Now additionally the IRQ is also written 
into the devices pci config space which might not work on the 
PowerstackII Utah.
It's only a guess and I haven't had the time yet to test it.


Sebastian
