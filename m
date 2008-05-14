Return-Path: <dan@embeddedalley.com>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173]) by ozlabs.org (Postfix) with SMTP id 9E34BDDEFF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 May 2008 02:29:51 +1000 (EST)
In-Reply-To: <482AFCC5.2070907@nanometrics.ca>
References: <482AFCC5.2070907@nanometrics.ca>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <07769C41-66EB-48C5-9494-3BBE34447BBD@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: 8xx: Work around CPU15 erratum.
Date: Wed, 14 May 2008 12:23:20 -0400
To: Ben Gardiner <BenGardiner@nanometrics.ca>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 14, 2008, at 10:52 AM, Ben Gardiner wrote:

> So there likely are reasons why the following is not possible:

That's way too much code for a tlb exception handler.
 From a system resource perspective, you are much better
off with a small and efficient piece of tlb loading code,
always invalidating pages on both ends and taking the
tlb exception fault.   Unfortunately, this could cause some
thrashing edge cases, so a little intelligence would be
needed.   Exception processing isn't free, and it quickly
destroys the cache footprint of your application, further
slowing down the entire system.  The tlb reload handler
goal should be maximum of 8 instructions and 4 memory
accesses, not 4K of elaborate conditional testing.  :-)

Thanks.

	-- Dan
