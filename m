Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F99D67EEF
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  8 Aug 2005 01:39:46 +1000 (EST)
In-Reply-To: <20050807043110.GA6316@dmt.cnet>
References: <20050806180353.GW5210@cathedrallabs.org>
	<20050806232701.GD1099@dmt.cnet>
	<e5caa80a2cd721a4f6ee3c74ead906b2@embeddededge.com>
	<20050807043110.GA6316@dmt.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <09b0792f426f1d5883cf5d437723f075@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Sun, 7 Aug 2005 11:39:52 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] 8xx: add cpm_get_cpmp()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 7, 2005, at 12:31 AM, Marcelo Tosatti wrote:

> Aris, sounds like you should proceed with cpm_get_cpmp() and change all
> other drivers using it also.

It depends how you define the semantics of this function call.
Can you call it any (and all of the) time you need it, or does it
actually perform an ioremap() and you only want to call it
once?

I guess implemented properly it doesn't matter.  On the first
call it should do the ioremap() and on subsequent calls it
just returns the mapping.  This is one of those common
functions that should be in commproc.c.

Thanks.

	-- Dan
