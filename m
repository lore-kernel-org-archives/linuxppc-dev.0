Return-Path: <linas@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 991F767B56
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 05:24:00 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e36.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7IJNvIU011641
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 15:23:57 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7IJNvT1363640
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 13:23:57 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7IJNuJu010516
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 13:23:56 -0600
Date: Fri, 18 Aug 2006 14:23:56 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/4]: powerpc/cell spidernet low watermark patch.
Message-ID: <20060818192356.GD26889@austin.ibm.com>
References: <20060811170337.GH10638@austin.ibm.com>
	<20060811170813.GJ10638@austin.ibm.com>
	<1155771820.11312.116.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1155771820.11312.116.camel@localhost.localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 17, 2006 at 01:43:40AM +0200, Benjamin Herrenschmidt wrote:
> 
> Sounds good (without actually looking at the code though :), that was a
> long required improvement to that driver. Also, we should probably look
> into using NAPI polling for tx completion queue as well, no ?

Just for a lark, I tried using NAPI polling, while disabling all TX
interrupts. Performance was a disaster: 8Mbits/sec, fom which I conclude
that the tcp ack packets do not flow back fast enough to allw reliance
on NAPI polling for transmit.

I was able to get as high as 960 Mbits/sec in unusal circumstances, 
at 100% cpu usage. Oprofile indicates that the next major improvement
would be to add scatter/gather, which I'll take a shot at next week,
if I don't get interrupted. However, I'm getting interrupted a lot these
days.

--linas
