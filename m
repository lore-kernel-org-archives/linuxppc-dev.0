Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 59A4467B85
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 09:55:44 +1000 (EST)
Subject: Re: [PATCH] no-execute -- please test
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17633.2179.582261.162544@cargo.ozlabs.ibm.com>
References: <787b0d920608132020q4ad2b5c2y49e25ca7ecc33536@mail.gmail.com>
	<17631.62819.24167.555967@cargo.ozlabs.ibm.com>
	<787b0d920608132141v729665ayac50674d5ad147f4@mail.gmail.com>
	<17633.2179.582261.162544@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 01:55:31 +0200
Message-Id: <1155772532.11312.121.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Albert Cahalan <acahalan@gmail.com>, linuxppc-dev@ozlabs.org,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> We have a bit per page that says if the page is icache dirty or not.
> On machines with no-execute support, we already avoid flushing the
> page until some process first tries to execute from it.  If we
> extended that to this scheme, when we made a segment executable, we
> would have to find and flush all icache-dirty pages in the segment (up
> to 65536 pages).  We wouldn't want to do that every time we made a
> segment executable - it would need to be optimized (e.g. keep a count
> per segment of icache-dirty pages in the segment).

Note that we need to change the icache flush mecanism anyway as it's
always been racy on ppc32 SMP (though very few people noticed so far :)
and ppc64 SMP with < POWER3 CPUs (without N bit).

Ben.
