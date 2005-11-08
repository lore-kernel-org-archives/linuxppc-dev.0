Return-Path: <dan@embeddedalley.com>
Received: from smtp101.biz.mail.re2.yahoo.com (smtp101.biz.mail.re2.yahoo.com
	[68.142.229.215]) by ozlabs.org (Postfix) with SMTP id 39CB1686C2
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Nov 2005 11:49:27 +1100 (EST)
In-Reply-To: <20051107151011.GA17161@logos.cnet>
References: <20051107151011.GA17161@logos.cnet>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b4fb08107c7bd17161f36e023035080a@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Date: Mon, 7 Nov 2005 19:55:39 -0500
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
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


On Nov 7, 2005, at 10:10 AM, Marcelo Tosatti wrote:

> The following is an attempt to fix swapping on 8xx by not touching
> _PAGE_ACCESSED bit if the page is not present.

Ugh ....  I suppose.  I hate assembler code macros .......
Somehow, "swapping" and "8xx" just don't belong together.
I'm tempted to add a configuration option that is the complete
opposite of this and assumes are really embedded system.
Mark pages as always accessed, data pages as always dirty,
and you can eliminate lots of TLB faults in systems that are
fairly static.

None of this should really be done in a TLB miss handler,
if there is anything that needs to be updated in a PTE, it should
be pushed out to an error function.  A TLB miss handler
should fit in a cache line ......

	-- Dan
