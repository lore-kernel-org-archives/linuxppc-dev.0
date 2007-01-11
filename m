Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CA1FFDDDE9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Jan 2007 15:43:33 +1100 (EST)
In-Reply-To: <783456.20220.qm@web301.biz.mail.mud.yahoo.com>
References: <783456.20220.qm@web301.biz.mail.mud.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B8F78696-B937-4C7F-BDCC-694A2F13F61A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: External interrupts in 2.6.19
Date: Wed, 10 Jan 2007 22:42:46 -0600
To: Ben Warren <bwarren@qstreams.com>
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


On Jan 10, 2007, at 4:25 PM, Ben Warren wrote:

> Hello,
>
> I'm porting my board from 2.6.17 to 2.6.19 kernel, and
> now external interrupts aren't working any more.  I'm
> using ARCH=powerpc on an MPC8349-based custom board.
> With the old code, we called ipic_init() from board
> init code with a table of IRQ senses.  In the newer
> kernel, ipic_init() takes only an OF node as a
> parameter.  Looking at the PIC registers, the external
> IRQs are all being set to level-triggered, when they
> used to be edge-triggered.
>
> I guess I haven't been following all of the
> discussions on changes to the IPIC code, and my little
> brain can't figure out the right way to do this.  Can
> somebody please give a quick dump of how the new
> methodology is supposed to work?

I think what you want is something like the following:

struct device_node *np = of_find_node_by_type(NULL, "ipic");
struct irq_host *host = irq_find_host(np);

unsigned int virq = irq_find_mapping(host, HW_IRQ);
set_irq_type(virq, IRQ_TYPE_EDGE_FALLING);


where HW_IRQ is the IRQ # of the external IRQ.  Let me know if this  
works out.  I need to do the same update at some point and this is  
one thing I know I'd have to see if it worked out properly.

(we should also have ipic_init return the struct ipic*) so you can  
get irq_host directly right after you call ipic_init().

- k
