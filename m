Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9544667A79
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Jun 2005 06:46:47 +1000 (EST)
In-Reply-To: <20050627133930.GA9109@logos.cnet>
References: <20050625145318.GA32117@logos.cnet>
	<f14f5f5aebd45879c39c6ce69f29c004@embeddededge.com>
	<20050626143004.GA5198@logos.cnet>
	<20050627133930.GA9109@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f5d1cb54913dd31385d15fe1f2e5b12d@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 27 Jun 2005 16:46:44 -0400
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx: map_page() skip pinned region and tlbie debugging
	aid
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 27, 2005, at 9:39 AM, Marcelo Tosatti wrote:

> Bullshit, map_page()'s call for flush_HPTE() is conditioned by 
> "mem_init_done",
> and mapin_ram() is called before mem_init_done is set.

Excuse me?

>> The IMMR space is a 16kB window (correct?), so I wonder if it might
>> be better to the use occupied pinned slot for another more accessed
>> region (an 8MB one preferably!).
>
> Thats still some food for thought...

Actually, most 8xx systems map the IMMR, plus other external
devices (including flash memory), into a packed space at the top
of the address range.  The 8M mapping catches the IMMR space,
but also many of these other devices subject to ioremap().  In
some systems, they trade off mapping the IMMR, or data pages,
to get an additional 8M of peripheral IO space.

The data space pinning is the big trade off right now.  You can
pin 4 entries, or 32M of space.  If you only have 16M of real
memory, the other two 8M entries can be used to cover IO space.
This is one (of a a few) advantages of using dynamic large
pages instead of pinned entries.  You could map more 8M
spaces for IO.  The problem is all of these have been custom
initialization and mapping code.

You see, this just keeps growing in features and complexity :-)
It would be nice for ioremap() to consider multiple, dynamic 8M
pages on 8xx like it does BATs on traditional PPC.  It will do
this .... someday soon.

Perhaps I should go back and push some of this dynamic 8M
page stuff.  It would eliminate the tlbie() problems, give us
more flexibility.  Damn, not enough hours in a day ....


Thanks.


	-- Dan
