Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E9D9767CC4
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Oct 2006 12:47:16 +1100 (EST)
Subject: Re: glibc-2.5 test suite hangs/crashes the machine
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Bailey <jbailey@ubuntu.com>
In-Reply-To: <1161966154.18515.1.camel@localhost.localdomain>
References: <45419F79.2020300@ubuntu.com>
	<1161966154.18515.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Oct 2006 12:47:05 +1100
Message-Id: <1162172825.25682.139.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Fabio Massimo Di Nitto <fabbione@ubuntu.com>,
	Paul Mackerras <paulus@samba.org>, Steve Munroe <sjmunroe@us.ibm.com>,
	Ben Collins <ben.collins@ubuntu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-10-27 at 12:22 -0400, Jeff Bailey wrote:
> Le vendredi 27 octobre 2006 à 07:56 +0200, Fabio Massimo Di Nitto a
> écrit :
> > Hi everybody,
> > 
> > i am in the process of bootstrapping the new toolchain for ubuntu and I am
> > hitting a problem building glibc-2.5 on ppc.
> > 
> > This behaviour has been reproduced on 2.6.15/2.6.17 and 2.6.19-rc2 (where the
> > machine crashes) and with ppc32 and ppc64 kernels.
> > A hard reboot of the machine is required to get rid of the Zl processes hanging
> > around that keep spinning the CPU at 100%.
> > 
> > I did place sources here: http://people.ubuntu.com/~fabbione/benh/
> > 
> > but i start to believe it is a kernel bug we are exploiting only now.
> > 
> > Any hint or help for what to look for would be extremely appreciated.
> 
> Heya Fabio, just an update, it looks like the tests that are zombie'ing
> are the nptl tst-robust[1-8] tests.  According to /proc/##/wchan, the
> tasks are cheerfully spinning in do_exit.

So I've built that glibc with debian 2.6.16 kernel headers (since Fabio
says the problem doesn't happen with glibc built with 2.6.19 headers)
and have ran that with 2.6.19-rc3-git-du-jour.

The machine didn't crash, nor did I see any zombie with those
tst-robust[1-8], however, I did get as SIGBUS with tst-robustpi1. I've
tracked it down to being an alignment exception. It looks like glibc is
doing a lwarx on a non-aligned value, though I can't say precisely
what's up here. I don't know how I can get a backtrace when running
those test-cases... the test harness seems to catch signals, I suppose
it could be modified to spit one out.

At this point, it would be useful to have somebody who knows glibc to
tell us:

 - what are those tst-robust all about ? (what do they do "special" that
might trigger bad reactions with older kernels)
 - how can glibc ever do atomic operations on a non-aligned value ?

Ben.
