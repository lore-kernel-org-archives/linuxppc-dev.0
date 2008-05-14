Return-Path: <BenGardiner@nanometrics.ca>
Received: from nmxmail.nanometrics.ca (mail.nanometrics.ca [206.191.47.130])
	by ozlabs.org (Postfix) with ESMTP id 77978DDF09
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 May 2008 06:16:54 +1000 (EST)
Message-ID: <482B48DA.5080300@nanometrics.ca>
Date: Wed, 14 May 2008 16:17:30 -0400
From: Ben Gardiner <BenGardiner@nanometrics.ca>
MIME-Version: 1.0
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: 8xx: Work around CPU15 erratum.
References: <482AFCC5.2070907@nanometrics.ca>
	<07769C41-66EB-48C5-9494-3BBE34447BBD@embeddedalley.com>
In-Reply-To: <07769C41-66EB-48C5-9494-3BBE34447BBD@embeddedalley.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Dan Malek wrote:
>
> On May 14, 2008, at 10:52 AM, Ben Gardiner wrote:
>
>> So there likely are reasons why the following is not possible:
>
> That's way too much code for a tlb exception handler.
> From a system resource perspective, you are much better
> off with a small and efficient piece of tlb loading code,
> always invalidating pages on both ends and taking the
> tlb exception fault.   Unfortunately, this could cause some
> thrashing edge cases, so a little intelligence would be
> needed.   Exception processing isn't free, and it quickly
> destroys the cache footprint of your application, further
> slowing down the entire system.  The tlb reload handler
> goal should be maximum of 8 instructions and 4 memory
> accesses, not 4K of elaborate conditional testing.  :-)
>
> Thanks.
>
>     -- Dan
>
Hi Dan,
Thanks for the rapid reply :) I really appreciate you giving me an 
answer "from the horse's mouth." I would still like to experiment a 
little and I'm not really sure it is safe to use any bits in a PTE.

Assuming I was crazy enough to ruin my cache footprint; are there any 
three bits in the PTE that are safe to use for some page status 
information?

Best Regards,
Ben
