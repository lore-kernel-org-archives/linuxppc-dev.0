Return-Path: <prodyuth@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 6443DDDDFA
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 04:14:59 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id u2so39641uge.14
	for <linuxppc-dev@ozlabs.org>; Thu, 04 Sep 2008 11:14:57 -0700 (PDT)
Message-ID: <49c0ff980809041114n2ab3565fr5313fd6ac4d2b870@mail.gmail.com>
Date: Thu, 4 Sep 2008 11:14:56 -0700
From: "prodyut hazarika" <prodyuth@gmail.com>
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: Efficient memcpy()/memmove() for G2/G3 cores...
In-Reply-To: <18623.16970.61036.731524@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <200808251131.02071.david.jander@protonic.nl>
	<200809010923.28616.david.jander@protonic.nl>
	<1220261775.5234.217.camel@gentoo-jocke.transmode.se>
	<200809021512.10132.david.jander@protonic.nl>
	<49c0ff980809031333g1b63694bkffbacb0ae8112120@mail.gmail.com>
	<18623.16970.61036.731524@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, David Jander <david.jander@protonic.nl>,
	John Rigby <jrigby@freescale.com>, munroesj@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I would be careful about adding overhead to memcpy.  I found that in
> the kernel, almost all calls to memcpy are for less than 128 bytes (1
> cache line on most 64-bit machines).  So, adding a lot of code to
> detect cacheability and do prefetching is just going to slow down the
> common case, which is short copies.  I don't have statistics for glibc
> but I wouldn't be surprised if most copies were short there also.
>

You are right. For small copy, it is not advisable.
The way I did was put a small check in the beginning of memcpy. If the copy
is less than 5 cache lines, I don't do dcbt/dcbz. Thus we see a big jump
for copy more than 5 cache lines. The overhead is only 2 assembly instructions
(compare number of bytes followed by jump).


One question - How can we can quickly determine whether both source and memory
address range fall in cacheable range? The user can mmap a region of memory as
non-cacheable, but then call memcpy with that address.

The optimized version must quickly determine that dcbt/dcbz must not
be used in this case.
I don't know what would be a good way to achieve the same?

Regards,
Prodyut Hazarika
