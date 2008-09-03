Return-Path: <prodyuth@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 07D3BDE4E8
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 06:33:09 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id u2so1952119uge.14
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Sep 2008 13:33:07 -0700 (PDT)
Message-ID: <49c0ff980809031333g1b63694bkffbacb0ae8112120@mail.gmail.com>
Date: Wed, 3 Sep 2008 13:33:07 -0700
From: "prodyut hazarika" <prodyuth@gmail.com>
To: "David Jander" <david.jander@protonic.nl>
Subject: Re: Efficient memcpy()/memmove() for G2/G3 cores...
In-Reply-To: <200809021512.10132.david.jander@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <200808251131.02071.david.jander@protonic.nl>
	<200809010923.28616.david.jander@protonic.nl>
	<1220261775.5234.217.camel@gentoo-jocke.transmode.se>
	<200809021512.10132.david.jander@protonic.nl>
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>,
	munroesj@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

>  These could probably go to glibc
> as new general purpose memxxx() routines. You will probably see
> a big increase once dcbz is added to the copy/memset functions.

glibc memxxx for powerpc are horribly inefficient. For optimal performance,
we should should dcbt instruction to establish the source address in cache, and
dcbz to establish the destination address in cache. We should do
dcbt and dcbz such that the touches happen a line ahead of the actual copy.

The problem which is see is that dcbt and dcbz instructions don't work on
non-cacheable memory (obviously!). But memxxx function are used for both
cached and non-cached memory. Thus this optimized memcpy should be smart enough
to figure out that both source and destination address fall in
cacheable space, and only then
used the optimized dcbt/dcbz instructions.

You can expect to see a significant jump in memxxx function after
using dcbt/dcbz.

Thanks,
Prodyut Hazarika
