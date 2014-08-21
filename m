Return-Path: <rcj4747@gmail.com>
Received: from mail-oi0-x231.google.com (mail-oi0-x231.google.com
 [IPv6:2607:f8b0:4003:c06::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 194FA1A000B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Aug 2014 01:51:40 +1000 (EST)
Received: by mail-oi0-f49.google.com with SMTP id u20so6743282oif.8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 08:51:38 -0700 (PDT)
Message-ID: <53F61586.3000107@gmail.com>
Date: Thu, 21 Aug 2014 10:51:34 -0500
From: Robert Jennings <rcj4747@gmail.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 Himangi Saraogi <himangi774@gmail.com>
Subject: Re: [PATCH] powerpc/pseries: Drop unnecessary continue
References: <20140813091847.GA3078@himangi-Dell>
 <1408596086.9307.3.camel@concordia>
In-Reply-To: <1408596086.9307.3.camel@concordia>
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
 Paul Mackerras <paulus@samba.org>, Brian King <brking@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512



On 08/20/2014 11:41 PM, Michael Ellerman wrote:
> On Wed, 2014-08-13 at 14:48 +0530, Himangi Saraogi wrote:
>> Continue is not needed at the bottom of a loop.
> 
> True.
> 
> I wonder though, is the code trying to continue to the outer loop?
> I stared at it for a minute but it wasn't obvious.
> 
> I wonder if Robert still remembers?

I don't recall what the intent was here.  Can't believe that it's been
almost 5 years since I wrote this.  I wish I had left a few more
comments in the code for me to go on.

Obviously the continue should be removed since it's not doing
anything.  I don't believe that we'd want a continue statement in
there to get outer loop.  That would change the current cmm_page_array
pointer (pa_curr) to the next in the list after it may have just been
reassigned to pa_last->next.

It may be the case that an earlier version of the code had statements
in the inner loop after that continue that I wanted to skip, or I just
did something silly.

- --Rob

> cheers
> 
>> diff --git a/arch/powerpc/platforms/pseries/cmm.c
>> b/arch/powerpc/platforms/pseries/cmm.c index 2d8bf15..fc44ad0
>> 100644 --- a/arch/powerpc/platforms/pseries/cmm.c +++
>> b/arch/powerpc/platforms/pseries/cmm.c @@ -555,7 +555,6 @@ static
>> int cmm_mem_going_offline(void *arg) pa_last = pa_last->next; 
>> free_page((unsigned long)cmm_page_list); cmm_page_list =
>> pa_last; -				continue; } } pa_curr = pa_curr->next;
> 
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJT9hV/AAoJEHQMPZ7t8u1zkNIP/1UMhxuNOHaYucs6nuiKT+HY
i0fDGKAluFrF7pv1Onon9LPUEPSL4Smr7l+FoSSJOP59vHg7F3HnkMu43GQi9X9o
KTQTzt5v0XjKeoKaZcgRD5wIp2J9Rz7CVd3RuYrXZGbIo5WC793Ko+8bEMQkSZv3
75e15WuK1J37e7RHIEmj82oeNj8HAWphkS2+c4JyBWCwVABNLOmC9oY0H2UjPQKe
IOsd8GfHMc4ML+Mrfe14ejsNl7XAfy+Q+Mvot/tuZqSq6G1YiX6MQAXk2yW7QAvE
7tfKZvyPVHylERs5Otk4wwh1YmA0RMTjbf3rkPUyUQs14esOa9aOiVDbFci++C/t
m8c3bF3RbdlWaygnDAodWMH4IP7q9mmLMgk6TZ0LNypOUsqedblHrsNKKnC3jm/y
ju/PzLeU5vJ5UoKF+X6jKpHJB5pLh6v4PVWixXKc0nMiGsg/U/RLDxgow+aA2tfx
psttc5DsxucUqlt1X7Y3yUULOI5mNx4tB/Pd37vTG+KJ16UOzAwuc8oQ/9ulVIj0
omW1+qW0MzXQ0Mezt1iqtN8bqarkj3z/aLZ6vjetnDg60JNlEofpSnJb6ANixJlj
PL/nk3LZjjY6UW79ttikrSnsp6fAUIv8ykxukGZLdO/tUj4pUA5H/2Ab5P1SR0Cx
4M1e9AUR+xvU7KDfYryr
=9qwq
-----END PGP SIGNATURE-----
