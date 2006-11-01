Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DE0A767BE4
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Nov 2006 10:23:39 +1100 (EST)
Subject: Re: glibc-2.5 test suite hangs/crashes the machine
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steve Munroe <sjmunroe@us.ibm.com>
In-Reply-To: <OF1858F563.F89FF725-ON86257219.007D5B13-86257219.007E0EB5@us.ibm.com>
References: <OF1858F563.F89FF725-ON86257219.007D5B13-86257219.007E0EB5@us.ibm.com>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 10:22:11 +1100
Message-Id: <1162423331.25682.480.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jeff Bailey <jbailey@ubuntu.com>,
	Fabio Massimo Di Nitto <fabbione@ubuntu.com>,
	Paul Mackerras <paulus@samba.org>, Ben Collins <ben.collins@ubuntu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> So I need to delay __ASSUME_SET_ROBUST_LIST to 2.6.18 for __powerpc__ ?

The problem is not so much the headers you build with than the runtime
checks... I suppose you shouldn't bother as we are trickling down the
fixes to distros & stable series anyway.

> What about __ASSUME_FUTEX_LOCK_PI ?

I don't know, I'm very unfamiliar with that futex stuff. I need to look
more closely.

> >  - kernel 2.6.18 and current git until yesterday (fix got in today) has
> > a bug if you manage to pass a wrong futex with a non-aligned atomic
> > value, it will possibly oops the kernel. With the fix, it will return an
> > error.
> >
> > Now what seems to be a glibc issue:
> >
> >  - I've had the tst-robustpi# tests (in fact the very first one, I
> > haven't tested the others) die on me with a SIGBUS caused by glibc
> > trying to do a lwarx/starx. on an odd address.
> >
> Rayn reminded me of a bug where the new robust code did not account for the
> fact that the TID was not at the same place as i386. I think Ryan has a
> patch.

Ah ok. Can you give me the details as soon as you get them ? (In
addition to submitting the fix upstream of course :) ubuntu at least is
starting to build their next distro on top of glibc-2.5 so it would be
nice if they had the fix asap.

Thanks for looking at this !

Cheers,
Ben.
