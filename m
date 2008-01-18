Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 49471DDF2C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jan 2008 02:54:08 +1100 (EST)
Message-Id: <57351E05-13DE-48F0-B0E5-28AADEF288A1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: vb <vb@vsbe.com>
In-Reply-To: <f608b67d0801152203j523ebdeavbab4412121a31a7@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: MPIC ISU
Date: Fri, 18 Jan 2008 09:54:01 -0600
References: <f608b67d0801152203j523ebdeavbab4412121a31a7@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jan 16, 2008, at 12:03 AM, vb wrote:

> Greetings,
>
> I am trying to write a BSP for an 8245 based device. One thing which
> really gets me puzzled is the 'ISU' facility in
> arch/powerpc/sysdev/mpic.c, there is also a notion of ISU-less
> platforms, etc. I looked through the chip's programmer's reference,
> even read the original AMD/Cypress OpenPIC specification - not a clue.
>
> What is it, at the very least - what does ISU stand for?
>
> I would really appreciate any hints,

Interrupt service unit.  I believe its an IBM concept.

For 8245 can you look at what the linkstation port is doing and mimic  
that.  I believe its an 8245 or 8241 so it should be close to what you  
need.

         mpic = mpic_alloc(dnp, paddr, MPIC_PRIMARY |  
MPIC_WANTS_RESET, 4, 32, " EPIC     ");
         BUG_ON(mpic == NULL);

         /* PCI IRQs */
         mpic_assign_isu(mpic, 0, paddr + 0x10200);

         /* I2C */
         mpic_assign_isu(mpic, 1, paddr + 0x11000);

         /* ttyS0, ttyS1 */
         mpic_assign_isu(mpic, 2, paddr + 0x11100);

         mpic_init(mpic);

- k
