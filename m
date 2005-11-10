Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 2DF77686E9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Nov 2005 18:48:53 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id 7945929EBC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Nov 2005 08:47:13 +0100 (CET)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 31700-08 for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Nov 2005 08:47:12 +0100 (CET)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id 9FB7C29EBB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Nov 2005 08:47:12 +0100 (CET)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 10 Nov 2005 09:48:45 +0200
References: <200510302203.25390.pantelis.antoniou@gmail.com>
	<1131396000.4652.24.camel@gaston>
	<20051109120450.GB8588@logos.cnet>
In-Reply-To: <20051109120450.GB8588@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200511100848.46263.david.jander@protonic.nl>
Subject: Re: [PATCH 2.6.14] mm: 8xx MM fix for
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 09 November 2005 13:04, Marcelo Tosatti wrote:
>[...]
>
> ** 2.6.14 DataTLBHandler jump direct ("two exceptions"):
>
> first batch:
> avg: 287ms
> avg: 287ms
> avg: 287ms
> avg: 287ms
> avg: 287ms
>
> second batch:
> avg: 287ms
> avg: 287ms
> avg: 287ms
> avg: 287ms
> avg: 287ms
>
> ** 2.6.14 vanilla ("three exceptions"):
>
> first batch:
> avg: 288ms
> avg: 285ms
> avg: 287ms
> avg: 287ms
> avg: 288ms
>
> second batch:
> avg: 288ms
> avg: 288ms
> avg: 287ms
> avg: 287ms
> avg: 287ms
>
> ** 2.4.17 (root on RAMDISK):
>
> avg: 309ms
> avg: 313ms
> avg: 312ms
> avg: 311ms
> avg: 310ms

Hmmm. This is a lot in the line of the tests I did with (the more generic 
benchmark) nbench. After looking at those results (see my other post in this 
thread) I already suspected something like this.

> The v2.6.14's kernel jump-direct is more consistent at 287ms,
> while vanilla 2.6.14 oscillates between 285 and 288ms, but
> no significant difference between the two.
>
> v2.6's fault handling is clearly faster than 2.4's (note that the compiler
> is also different, 2.4 uses gcc 2.95 and 2.6 gcc 3.3).

I don't think the compiler does much difference here though. In my test the 
exact same compiler was used for both kernels, and the same rootfs and binary 
of nbench. gcc-3.3.3. I did also use oprofile to get an idea of where the 
code spent its most cpu time during nbench, and AFAIR flush_dcache_icache() 
took quite a chunk of it, so I assume page fault latency is of importance 
there too, and might account for the huge difference between 2.4 and 2.6.

Greetings,

-- 
David Jander
