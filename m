Return-Path: <neko@genesi-usa.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.24])
	by ozlabs.org (Postfix) with ESMTP id EC026DE172
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 02:37:54 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so25295qwb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 09 Oct 2008 08:37:53 -0700 (PDT)
Message-ID: <48EE2553.30903@genesi-usa.com>
Date: Thu, 09 Oct 2008 10:37:55 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: performance: memcpy vs. __copy_tofrom_user
References: <48ECC611.3030309@mikroswiat.pl>	<20081008154212.GA21723@secretlab.ca>	<18669.28058.495259.72182@cargo.ozlabs.ibm.com>	<48EDD905.6070609@mikroswiat.pl>
	<18669.58803.48011.686743@cargo.ozlabs.ibm.com>
In-Reply-To: <18669.58803.48011.686743@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Dominik Bozek <domino@mikroswiat.pl>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Dominik Bozek writes:
> 
>> Actually I made couple of other tests on that mpc8313. Most of them are
>> to ugly to publish them, but... My problem is that I have to boost the
>> gigabit interface on the mpc8313. I made simple substitution and
>> __copy_tofrom_user was used instead of memcpy. I know, it's wrong, but I
>> speedup that way the network interface for about 10%.
> 
> Very interesting.  Can you work out where memcpy is being called on
> the network data?  I wouldn't have expected that.

It probably is somewhere.. through some weird and wonderful code path that
needs some serious digging to find. At least in 2.4 memcpy was used and
optimizing it (see Freescale's libmotovec benchmarks) did produce a sizable
performance improvement. That, and offloading TCP checksumming to AltiVec
helped a lot.

No help at all on an 8313 but, relevant anyway.

Since then zero copy networking and other fancy things like the DMA
engine API (for intel ioat at least but also there is fsl dma support)
there's less to actually optimize now so you're less likely to see the
same benefits. All these got into mainline because it's essential to
have this kind of architecture to get reasonable speeds out of >gigabit
network links.

> There is actually no strong reason not to use __copy_tofrom_user as
> memcpy, in fact, as long as we are sure that source and destination
> are both cacheable.

I do think there is probably a good benefit in doing things like zeroing
pages in AltiVec and copying entire pages with AltiVec (for instance
when copy-on-write happens in an application) - NetBSD and QNX implement
at least this because it's faster than using the cache management and
works fine on uncacheable pages too (also since you're always aligned to
a page, zeroing 4kb aligned to a 4kb boundary - or whatever your page
size happens to be, the number of errors that can occur are absolutely
tiny and performance can go through the roof).

Ahem, but nobody here wants AltiVec in the kernel do they?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
