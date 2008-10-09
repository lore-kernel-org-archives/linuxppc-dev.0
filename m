Return-Path: <domino@mikroswiat.pl>
Received: from jupiter.az.pl (jupiter.az.pl [62.146.68.61])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 190C4DDF1F
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Oct 2008 21:23:39 +1100 (EST)
Message-ID: <48EDD905.6070609@mikroswiat.pl>
Date: Thu, 09 Oct 2008 12:12:21 +0200
From: Dominik Bozek <domino@mikroswiat.pl>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: performance: memcpy vs. __copy_tofrom_user
References: <48ECC611.3030309@mikroswiat.pl>	<20081008154212.GA21723@secretlab.ca>
	<18669.28058.495259.72182@cargo.ozlabs.ibm.com>
In-Reply-To: <18669.28058.495259.72182@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:

> When I looked at this last (which was a few years ago, I'll admit), I
> found that the vast majority of memcpy calls were for small copies,
> i.e. less than 128 bytes, whereas __copy_tofrom_user was often used
> for larger copies (usually 1 page).  So with memcpy the focus was more
> on keeping the startup costs low, while __copy_tofrom_user was
> optimized more for bandwidth.
>
> The other point is that the kernel memcpy doesn't consume a noticeable
> amount of CPU time (at least not on any workload I've seen), so it
> hasn't been a target for aggressive optimization.
>   


Actually I made couple of other tests on that mpc8313. Most of them are
to ugly to publish them, but... My problem is that I have to boost the
gigabit interface on the mpc8313. I made simple substitution and
__copy_tofrom_user was used instead of memcpy. I know, it's wrong, but I
speedup that way the network interface for about 10%.

I made also some calculation based on the results I had send. One
__copy_tofrom_user of 1500B compensate profit from 258 memcpy of 8B. But
of course this is the case of mpc8313 (333MHz core, DDR2 at 266MHz). On
other hardware it may work differently and to make any binding
conclusion we need to see some results done on other cpus.
Unfortunately, right now, I don't have any other ppc to make such test
and compare it.
Other hand my test do not cover all cases. I believe most of small
transfer involve data already cached. This is big point for current memcpy.

Maybe there is another solution. Method, agressive or "low cost setup",
will be chosen depend on the size of the copied block and fixed limit.
Limit shall be known at compile time and related to the chosen cpu/platfrom.

If someone ask for other tests. I had optimized memcpy for cases when
transfer size is known at compile time and... hard to say if the system
was "faster", but for sure I didn't notice any boost at network
interface. Maybe my optimization was bad. It's possible with me.

Dominik
