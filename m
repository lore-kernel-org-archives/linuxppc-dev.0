Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 4316067BC2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Sep 2006 02:52:57 +1000 (EST)
Message-ID: <45195AE5.3030100@freescale.com>
Date: Tue, 26 Sep 2006 11:52:53 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Subject: Re: local_irq_save not masking interrupts
References: <995B09A8299C2C44B59866F6391D263516C42D@zch01exm21.fsl.freescale.net>
	<451900B0.7010006@cambridgebroadband.com>
	<45194F1F.7030003@freescale.com>
	<45195296.8000405@cambridgebroadband.com>
	<451954D8.3050909@freescale.com>
	<45195882.1090003@cambridgebroadband.com>
In-Reply-To: <45195882.1090003@cambridgebroadband.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Alex Zeffertt wrote:
> It follows from what you are saying that kmalloc(,GFP_KERNEL)
> MUST NOT occur anywhere in the call chain during a critical section.
> 
> This must catch others out too.  Surely kmalloc/cache_grow should
> return NULL rather than enable interrupts.

The local_irq_enable() is intended to reverse a previous 
local_irq_save() done in the allocator (with the assumption that if 
GFP_WAIT is specified, the flags saved had IRQs enabled), not to handle 
the case where IRQs were disabled by kmalloc's caller.  Returning NULL 
would mean that slabs can never grow with GFP_KERNEL.

 > In fact, shouldn't it be
> a BUG() if kmalloc(,GFP_KERNEL) is called with IRQs disabled?

Yes.

-Scott
