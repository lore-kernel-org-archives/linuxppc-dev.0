Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4C36DDDE08
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 01:01:57 +1000 (EST)
In-Reply-To: <20070718013259.GC15238@ld0162-tx32.am.freescale.net>
References: <20070718013259.GC15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8503FAAA-42DF-4082-A755-773837490CA7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 04/61] 8xx: Work around CPU15 erratum.
Date: Thu, 19 Jul 2007 17:01:45 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The CPU15 erratum on MPC8xx chips can cause incorrect code execution
> under certain circumstances, where there is a conditional or indirect
> branch in the last word of a page, with a target in the last cache  
> line
> of the next page.  This patch implements one of the suggested
> workarounds, by forcing a TLB miss whenever execution crosses a page
> boundary.  This is done by invalidating the pages before and after the
> one being loaded into the TLB in the ITLB miss handler.

So you never found a bug workaround without the terrible
overhead of this one?  A shame :-(


Segher
