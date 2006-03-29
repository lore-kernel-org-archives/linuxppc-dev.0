Return-Path: <gsmith@nc.rr.com>
Received: from ms-smtp-04-eri0.southeast.rr.com
	(ms-smtp-04-lbl.southeast.rr.com [24.25.9.103])
	by ozlabs.org (Postfix) with ESMTP id 791E3679F7
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 12:58:31 +1100 (EST)
Received: from [192.168.1.103] (cpe-069-134-161-101.nc.res.rr.com
	[69.134.161.101])
	by ms-smtp-04-eri0.southeast.rr.com (8.13.4/8.13.4) with ESMTP id
	k2T1wRcb013009
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2006 20:58:29 -0500 (EST)
Subject: [OT] ppc64 serialization problem
From: Greg Smith <gsmith@nc.rr.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Tue, 28 Mar 2006 20:58:26 -0500
Message-Id: <1143597506.3075.53.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We have a multi-threaded app running on a p520 in 64 bit mode.

Thread A does

pthread_mutex_lock(&lock);
u32 &= ~bitA;
pthread_mutex_unlock(&lock);

and Thread B does

pthread_mutex_lock(&lock);
u32 |= bitB;
A = u32;
B = u32;
pthread_mutex_unlock(&lock);

On rare occasions, values A and B will differ!  In the examples that I
have seen, there is contention with `lock'.  This phenomenon does not
occur on ppc32 or a number of other architectures that we support.

I confess I do not know the linux version nor the glibc version nor what
pthreads implementation is being used.  I'll find that out shortly.

What I am curious about is where the problem might lie
(kernel/lib/pthreads/app) so I can ask the right people.

Thank you for your patience,
Greg Smith
