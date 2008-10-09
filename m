Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18669.58803.48011.686743@cargo.ozlabs.ibm.com>
Date: Thu, 9 Oct 2008 22:06:27 +1100
From: Paul Mackerras <paulus@samba.org>
To: Dominik Bozek <domino@mikroswiat.pl>
Subject: Re: performance: memcpy vs. __copy_tofrom_user
In-Reply-To: <48EDD905.6070609@mikroswiat.pl>
References: <48ECC611.3030309@mikroswiat.pl>
	<20081008154212.GA21723@secretlab.ca>
	<18669.28058.495259.72182@cargo.ozlabs.ibm.com>
	<48EDD905.6070609@mikroswiat.pl>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dominik Bozek writes:

> Actually I made couple of other tests on that mpc8313. Most of them are
> to ugly to publish them, but... My problem is that I have to boost the
> gigabit interface on the mpc8313. I made simple substitution and
> __copy_tofrom_user was used instead of memcpy. I know, it's wrong, but I
> speedup that way the network interface for about 10%.

Very interesting.  Can you work out where memcpy is being called on
the network data?  I wouldn't have expected that.

There is actually no strong reason not to use __copy_tofrom_user as
memcpy, in fact, as long as we are sure that source and destination
are both cacheable.

Paul.
