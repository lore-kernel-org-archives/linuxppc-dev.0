Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id CAB42DDDEB
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Aug 2007 16:11:51 +1000 (EST)
Date: Thu, 2 Aug 2007 08:11:47 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: GPIO interrupts on mpc8313e
Message-ID: <20070802061147.GA10770@moe.telargo.com>
References: <2C4FDB8D627248AE9B24BC21747E0F5D.MAI@mail.livedns.co.il>
	<20070801183616.GA24549@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070801183616.GA24549@ld0162-tx32.am.freescale.net>
Cc: Yoni Levin <yoni.l@slyde-tech.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 01/08/07 13:36 -0500, Scott Wood wrote:
> On Wed, Aug 01, 2007 at 02:45:05PM +0300, Yoni Levin wrote:
> > request_irq(74,handler,IRQF_DISABLED,"GPIO",NULL);
>                          ^^^^^^^^^^^^^
> 
> Did you try removing that flag (or calling enable_irq())?

>From interrupt.h:
38  * IRQF_DISABLED - keep irqs disabled when calling the action handler


>> irq_create_mapping(NULL,74);
>> request_irq(74,handler,IRQF_DISABLED,"GPIO",NULL);

Request irq should use virq that irq_create_mapping returns.

Maybe there's another "enable global GPIO interrupts" register, that
needs to be set too?


	Domen
