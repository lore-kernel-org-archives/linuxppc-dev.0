Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18726.33949.586733.530967@cargo.ozlabs.ibm.com>
Date: Fri, 21 Nov 2008 20:51:25 +1100
From: Paul Mackerras <paulus@samba.org>
To: joakim.tjernlund@transmode.se
Subject: Re: times(2) sys call bug?
In-Reply-To: <1227259869.5224.123.camel@gentoo-jocke.transmode.se>
References: <1227193640.5224.90.camel@gentoo-jocke.transmode.se>
	<20081120103733.6f347180@zod.rchland.ibm.com>
	<1227199742.5224.99.camel@gentoo-jocke.transmode.se>
	<18725.63534.3316.841949@cargo.ozlabs.ibm.com>
	<1227259869.5224.123.camel@gentoo-jocke.transmode.se>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Joakim Tjernlund writes:

> > +	force_successful_syscall_return();
> >  	return (long) jiffies_64_to_clock_t(get_jiffies_64());
> 
> Why is 64 bits ops used here when you only use 32 bits? 

If HZ is 1000, jiffies_64_to_clock_t is going to divide jiffies by 10,
so we need to start with 64 bits in order to get the top few bits
of a 32-bit result correct.

> BTW, I think time(2) needs this:

In principle you are correct, but it's only going to matter for a
little over an hour some time in the year 2106. :)

Paul.
