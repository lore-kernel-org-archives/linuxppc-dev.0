Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26DA0686AD
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Nov 2005 05:51:12 +1100 (EST)
In-Reply-To: <20051108175658.GO3839@smtp.west.cox.net>
References: <20051107151011.GA17161@logos.cnet>
	<b4fb08107c7bd17161f36e023035080a@embeddedalley.com>
	<200511081259.26525.david.jander@protonic.nl>
	<20051108175658.GO3839@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ae77b5dcfdaa24efebf92042907e2ce8@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Tue, 8 Nov 2005 13:57:07 -0500
To: Tom Rini <trini@kernel.crashing.org>
Cc: David Jander <david.jander@protonic.nl>, linuxppc-embedded@ozlabs.org
Subject: Re: fix swapping on 8xx?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 8, 2005, at 12:56 PM, Tom Rini wrote:

> I think Dan might be in the camp that says a properly designed embedded
> system won't need to swap.

I'm actually in the camp that knows the majority of systems
running Linux aren't workstations and don't have disk drives.
It would be nice to have selectable features for such applications.

>> It sounds tempting indeed, but should you really notice a performance 
>> increase
>> out of this?

Yes.  Most importantly it adds some predictability which is quite
measurable on this class of processor.  It was a coding mistake way
back in 2.2 that actually exposed this.  I was taking some liberties by
updating more status in the PTE than I should have, and Paulus
made me fix it in 2.4 :-)  It basically eliminates TLB faults associated
with system status tracking, since we aren't paging there isn't any
need to track page aging and such.  If you are paging, it still
functions properly, you may just not pick the most suitable pages
to steal.

Thanks.

	-- Dan
