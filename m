Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E2C51679E7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 07:13:30 +1000 (EST)
In-Reply-To: <20050616144739.GA1559@logos.cnet>
References: <20050616144739.GA1559@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8efaee2824f500e906c2c05526ea3214@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 16 Jun 2005 17:13:19 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: map_page() and pinned TLB entries
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 16, 2005, at 10:47 AM, Marcelo Tosatti wrote:

> What would be an elegant way of dealing with this? We can insert
> a conditional there such that only addresses not covered
> by other mappings (in this case the 8Mbyte entry) get flushed.

I'd like to make _tlbie() a macro on 8xx that simply tests the VA
and doesn't invalidate anything in the pinned space.  Of course,
the code shouldn't be doing this anyway, and I think this
should be treated as a bug if it happens.  If the Linux VM
thinks it needs to be doing this, pinned space isn't going to work.
The _tlbie() is an exported symbol, I suspect for MOL, so
we have to accommodate that.

Thanks.


	-- Dan
