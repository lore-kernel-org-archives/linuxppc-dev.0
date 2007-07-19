Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3ECD2DE165
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 01:33:04 +1000 (EST)
Message-ID: <469F8427.1060708@freescale.com>
Date: Thu, 19 Jul 2007 10:32:55 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 04/61] 8xx: Work around CPU15 erratum.
References: <20070718013259.GC15238@ld0162-tx32.am.freescale.net>
	<8503FAAA-42DF-4082-A755-773837490CA7@kernel.crashing.org>
In-Reply-To: <8503FAAA-42DF-4082-A755-773837490CA7@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> The CPU15 erratum on MPC8xx chips can cause incorrect code execution
>> under certain circumstances, where there is a conditional or indirect
>> branch in the last word of a page, with a target in the last cache  line
>> of the next page.  This patch implements one of the suggested
>> workarounds, by forcing a TLB miss whenever execution crosses a page
>> boundary.  This is done by invalidating the pages before and after the
>> one being loaded into the TLB in the ITLB miss handler.
> 
> 
> So you never found a bug workaround without the terrible
> overhead of this one?  A shame :-(

The only lower-overhead workaround I know of requires compiler 
modifications (and I made it configurable to allow for that possibility).

-Scott
