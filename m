Return-Path: <liml@rtr.ca>
Received: from mail.rtr.ca (ottawa-hs-64-26-128-89.s-ip.magma.ca
	[64.26.128.89]) by ozlabs.org (Postfix) with ESMTP id 72283DDF0F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Apr 2007 01:15:38 +1000 (EST)
Message-ID: <461BA2BB.6040101@rtr.ca>
Date: Tue, 10 Apr 2007 10:44:11 -0400
From: Mark Lord <liml@rtr.ca>
MIME-Version: 1.0
To: Michael <michaelzwrk@gmail.com>
Subject: Re: IDE driver in polling mode
References: <1ea6be8e0704100635ydbf1538i782e796c99891e5d@mail.gmail.com>
	<461B9D04.2000109@ru.mvista.com>
In-Reply-To: <461B9D04.2000109@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ide@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Michael wrote:
> 
>> I'd like to know whether it is possible to use IDE driver (ide-disk)
>> in polling mode, instead of using IRQ.

This should be doable, with a small amount of hacking.
Mostly, you just need to use add_timer() to set up a polling
function that simply calls ide_intr() and then does add_timer()
again for the next poll.

For your purposes, it could be as simple as five lines of C.

Cheers
