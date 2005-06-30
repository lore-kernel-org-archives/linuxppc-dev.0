Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0246867BC8
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jul 2005 04:52:19 +1000 (EST)
In-Reply-To: <42C4162E.4030602@anagramm.de>
References: <42C40BD0.8040408@anagramm.de>
	<658739DB-540F-4AFC-80DC-BBF0C2AD70F4@freescale.com>
	<42C4162E.4030602@anagramm.de>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <427c70958bb995dad4fbad2e6ff121bc@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 30 Jun 2005 14:52:15 -0400
To: Clemens Koller <clemens.koller@anagramm.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC85xx DMA support for Kernel 2.6?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 30, 2005, at 11:56 AM, Clemens Koller wrote:

> *Sigh*... no holiday for me this summer .-(

Before you start, just make sure such a thing is really a performance
enhancement.  Yes, the DMA does run in parallel with the core, but often
the overhead of the set up and clean up interrupt is more code and time
that if you just copied the data in a loop.  If possible, integrate the 
DMA
processing into other driver work, clean up a previous DMA the next time
the driver needs to use it, not with a separate completion handler.

Thanks.

	-- Dan
