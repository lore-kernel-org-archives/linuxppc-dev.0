Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 35A6F67BDD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Sep 2006 02:27:07 +1000 (EST)
Message-ID: <451954D8.3050909@freescale.com>
Date: Tue, 26 Sep 2006 11:27:04 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Subject: Re: local_irq_save not masking interrupts
References: <995B09A8299C2C44B59866F6391D263516C42D@zch01exm21.fsl.freescale.net>
	<451900B0.7010006@cambridgebroadband.com>
	<45194F1F.7030003@freescale.com>
	<45195296.8000405@cambridgebroadband.com>
In-Reply-To: <45195296.8000405@cambridgebroadband.com>
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
> I agree this indicates an intent to make it atomic, but I don't see how
> this could cause interrupts to become re-enabled during the request_irq()
> call.  Also, since I am calling request_irq at insmod time, i.e. in process
> context, both GFP_ flags *should* work.

You're effectively not in process context when you disable IRQs (at 
least, if you want them to stay that way).  By specifying GFP_KERNEL, 
you're giving the allocator permission to go to sleep, enable IRQs, etc. 
  The IRQ enabling will happen any time cache_grow() is called with 
GFP_WAIT (which is part of GFP_KERNEL), assuming a growable slab.

-Scott
