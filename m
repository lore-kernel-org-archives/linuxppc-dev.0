Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 7EDC567A7D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 10:35:24 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 8 Mar 2005 17:35:19 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B8592ED@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Matt Porter" <mporter@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Lots of memory on 826x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I can use 1GB of RAM now, if I move kernel base to 0xA0000000 and set=20
lowmem size to 1GB. (No Highmem at all)

> -----Original Message-----
> From: Matt Porter [mailto:mporter@kernel.crashing.org]=20
> Sent: Tuesday, March 08, 2005 17:30
> To: Rune Torgersen
> Cc: Kumar Gala; linuxppc-embedded@ozlabs.org
> Subject: Re: Lots of memory on 826x

> Ahh, but early ioremaps (before mm is inited) grow down from=20
> PKMAP_BASE,
> so you will be overlapping the top of lowmem with those allocations.
> It wants to be above vmalloc space.  Set HIGHMEM_START to 0xF6000000,
> IMMR/IO to 0xF8000000 and you then have vmalloc space between
> 0xF1000000-0xF5FFFFFF.

I'll try this tomorrow and see what happens.=20
(Still need to make sure our board supports 2GB....:)
