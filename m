Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7C235DDD04
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Feb 2009 12:40:40 +1100 (EST)
Subject: Re: hash-table creation...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: sumedh tirodkar <sumedhtirodkar@gmail.com>
In-Reply-To: <d2b9ccd90902062213l48c063e1gd536a347f1fbe861@mail.gmail.com>
References: <d2b9ccd90902062213l48c063e1gd536a347f1fbe861@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 08 Feb 2009 08:17:00 +1100
Message-Id: <1234041420.31963.66.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2009-02-07 at 11:43 +0530, sumedh tirodkar wrote:
> Hello,
> 
> I wanted algorithm for creating hash tables used in paging mechanism..
> In the manual that i read i got algorithm to convert Effective Address
> to Real Address using these hash tables that are created..but i could
> not find how these hash tables are created in first place using the
> Real addresses.
> Is there any document available for the same?

There's one MMU hash table. It's allocated & cleared by the kernel
during early boot or by the hypervisor and pointed to by the SDR1
register.

It's populated by code in arch/powerpc/mm/hash_low_64.S or
hash_low_32.S, typically as the result of a hash miss exception.

Ben.
