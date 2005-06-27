Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0F57667A77
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Jun 2005 06:53:49 +1000 (EST)
In-Reply-To: <20050627145603.GB9810@logos.cnet>
References: <20050625145318.GA32117@logos.cnet>
	<f14f5f5aebd45879c39c6ce69f29c004@embeddededge.com>
	<20050627142803.GA9810@logos.cnet>
	<014331894c585b85c6bb419d72110125@embeddededge.com>
	<20050627145603.GB9810@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1211765437f56f11b6e4bfa2f2d8136f@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 27 Jun 2005 16:53:39 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx: tlbie debugging aid (try #2)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 27, 2005, at 10:56 AM, Marcelo Tosatti wrote:

> Note: this was just a test module doing tlbie(0xc0000100)...
> Hum, it should also print out the address in question...

Oh, I see.  I thought it was a bug with loading a module
in general, since it allocates from vmalloc() space.

>> How much real memory on your board?
>
> 128M

No problem.

>> We need to ensure VMALLOC_START is beyond
>> the pinned entries.
>
> Right now VMALLOC_START is before the IMMR pinned space.

Sorry, I wasn't clear :-)  I meant we need to ensure VMALLOC_START
is beyond the pinned _data_ area.

> Oh! What are the side effects of such pinning as the
> code is today?

The code maps 24M of data space, plus 8M of IMMR (and anything
that follows).  So, if you don't have enough real memory, you can
end up with both a pinned entry and vmalloc() trying to share the same
VM space, which is a bad thing.  The problem depends on the amount
of real memory, plus the "offset" hole of the vmalloc() space.

> For what purpose? Sorry I don't get you, please be more
> verbose.

Just to prevent what I mentioned in the previous paragraph.
Since you have lots of real memory, this doesn't affect you.

Thanks.


	-- Dan
