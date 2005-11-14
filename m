Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EF0A56873C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Nov 2005 09:43:38 +1100 (EST)
In-Reply-To: <20051114155313.GA29411@logos.cnet>
References: <20051114152024.GA29314@logos.cnet>
	<5F8A6977-E33A-4E84-B029-D1B49716DC82@kernel.crashing.org>
	<20051114155313.GA29411@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <608ff4f57a546901e9193ebbbe368053@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 14 Nov 2005 17:43:27 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [Edson.Seabra@cyclades.com: Re: BDI and 85xx]
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 14, 2005, at 10:53 AM, Marcelo Tosatti wrote:

> Doh my bad. Attached it is.
>
>
> <8xx_gdb.diff>

Well, this probably works for you but have you
considered how it affects others?

I'm not going to get into the -ggdb flags discussion,
since I know we've had that in the past.  Why is
this needed and should it be done for everyone?

Your update of MSR_KERNEL will work for you,
but won't work on anything that isn't a Book E processor.
You can't make this a generic update to all processors.
It will fail on everything that really wants to use the
BDI_SWITCH configuration option as it was intended.
The DE in Book E conflicts with BE in traditional PPC.

This also doesn't do anything to address my real concern,
we shouldn't have to create a special kernel configuration
just to attach a debugger .........

Thanks.


	-- Dan
