Return-Path: <adrian@humboldt.co.uk>
Received: from mail.humboldt.co.uk (mail.humboldt.co.uk [80.68.93.146])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4005767BB2
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Dec 2006 22:54:51 +1100 (EST)
Subject: Re: Worst case performance of up()
From: Adrian Cox <adrian@humboldt.co.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1165058151.22108.31.camel@localhost.localdomain>
References: <1164385262.11292.76.camel@localhost.localdomain>
	<1164401124.5653.86.camel@localhost.localdomain>
	<1164661336.11001.9.camel@localhost.localdomain>
	<1165055754.4380.15.camel@localhost.localdomain>
	<1165058151.22108.31.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 02 Dec 2006 11:54:44 +0000
Message-Id: <1165060484.4380.18.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-12-02 at 22:15 +1100, Benjamin Herrenschmidt wrote:
> I think we are hitting a livelock due to both CPUs trying to perform an
> atomic operation on the same cache line (or same variable even).

I agree.

> Can you remind me what CPU this on precisely ? I know that for some
> CPUs like 970's, Apple code has some weirdo workarounds around atomic
> ops involving forcing a mispredict when the stwcx. fails ... but if both
> CPUs are following the exact same pattern, I can't see another way out
> but an interrupt, unless something in the bus protocol can prevent such
> livelocks...

It's a pair of 7448s in MPX bus mode, with a Tsi109 host bridge.

-- 
Adrian Cox <adrian@humboldt.co.uk>
