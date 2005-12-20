Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4F137689C8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Dec 2005 06:45:37 +1100 (EST)
In-Reply-To: <20051220173730.GB6404@dmt.cnet>
References: <20051220173730.GB6404@dmt.cnet>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <44a3dd7cc9683be6fdaac9cbab325c3f@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 20 Dec 2005 14:45:21 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: TLB preloading on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Dec 20, 2005, at 12:37 PM, Marcelo Tosatti wrote:

> Sum up the costs of disabling interrupts and disabling translation, 
> and you
> end up with a slow dog. Damn, the TLB exceptions are indeed efficient.

Like I've always said, make the TLB miss exception path very
short and efficient.  You have to consider the total system impact
of running this code, which includes replacing lots of cache
lines that will affect the performance of the application.

Don't be looking for "tricks" in the exception path, look for
ways outside of that we can better structure the page tables
so we can _remove_ code from the exception handler, not
add to it.  What you are doing here is an attempt to do
that, but you are executing lots more code to do this
preload than the TLB miss exception would do.

Keep trying, though, this was a good idea to test :-)

Thanks.

	-- Dan
