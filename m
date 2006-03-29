Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 51F2367A00
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 14:12:04 +1100 (EST)
Subject: Re: [OT] ppc64 serialization problem
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg Smith <gsmith@nc.rr.com>
In-Reply-To: <1143597506.3075.53.camel@localhost.localdomain>
References: <1143597506.3075.53.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 14:11:42 +1100
Message-Id: <1143601903.3585.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-03-28 at 20:58 -0500, Greg Smith wrote:
> We have a multi-threaded app running on a p520 in 64 bit mode.
> 
> Thread A does
> 
> pthread_mutex_lock(&lock);
> u32 &= ~bitA;
> pthread_mutex_unlock(&lock);
> 
> and Thread B does
> 
> pthread_mutex_lock(&lock);
> u32 |= bitB;
> A = u32;
> B = u32;
> pthread_mutex_unlock(&lock);
> 
> On rare occasions, values A and B will differ!  In the examples that I
> have seen, there is contention with `lock'.  This phenomenon does not
> occur on ppc32 or a number of other architectures that we support.

How did you actually "look" at A and B ? is that also protected by the
lock ?

> I confess I do not know the linux version nor the glibc version nor what
> pthreads implementation is being used.  I'll find that out shortly.

That's fairly important to know those yes.

> What I am curious about is where the problem might lie
> (kernel/lib/pthreads/app) so I can ask the right people.
> 
> Thank you for your patience,
> Greg Smith
> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
