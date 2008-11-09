Return-Path: <bgat@billgatliff.com>
Received: from venus.billgatliff.com (venus.billgatliff.com [209.251.101.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 24389DDDFB
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  9 Nov 2008 14:26:03 +1100 (EST)
Message-ID: <49165847.1060605@billgatliff.com>
Date: Sat, 08 Nov 2008 21:25:59 -0600
From: Bill Gatliff <bgat@billgatliff.com>
MIME-Version: 1.0
To: Bruce_Leonard@selinc.com
Subject: Re: Using DMA
References: <OF36982726.7A11F196-ON882574FA.00798551-882574FA.0079F330@selinc.com>
In-Reply-To: <OF36982726.7A11F196-ON882574FA.00798551-882574FA.0079F330@selinc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: timur.tabi@gmail.com, Timur Tabi <timur@freescale.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Bruce_Leonard@selinc.com wrote:
> timur.tabi@gmail.com wrote on 11/07/2008 01:46:42 PM:
> 
>> Whether or not using async dma is worth the effort can only be
>> determined by profiling the code.  Either it's better, or it's not.
>> There's no real way to tell in advance.
>>
> 
> Pretty much the answer I expected :), I was just hoping that "wiser and 
> more experienced" minds would say "oh, well to do what you want you should 
> go in this direction".  Ah well, such is the life of a kernel hacker.
> 
> So it sounds like the async dma is the way to go, since I want to off load 
> as much as possible from the core.

One thing to watch out for is an increase in interrupt latency.  If
the DMA grabs the bus and won't turn loose until the whole transfer is
finished, your interrupts will wait along with everything else.

Many DMA controllers support a "cycle steal" mode, which lets them get
interrupted by more important things.  It slows the DMA transfer down,
but does less damage to the rest of the system.


b.g.
-- 
Bill Gatliff
bgat@billgatliff.com
