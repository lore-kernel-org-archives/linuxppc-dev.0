Return-Path: <seanm@seanm.ca>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 0F9E7DDDFC
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 10:41:07 +1000 (EST)
Date: Sun, 4 May 2008 20:41:04 -0400
From: Sean MacLennan <seanm@seanm.ca>
To: <linuxppc-dev@ozlabs.org>
Subject: WARNING: mutexes are preferred for single holder semaphores
Message-ID: <20080504204104.7eea7618@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a bit OT, but I got the warning in the subject from
checkpatch.pl for a piece of code. The code *is* using a mutex. Does it
actually mean I shouldn't use a mutex?

The code declares a global mutex:

	static DECLARE_MUTEX(list_lock);

The odds of two accesses to the list_lock at the same time are zero.
But it would be Very Bad(tm) if it did happen. Since the odds of
contention are near zero, the cost of the mutex is near zero, so I put
it in.

I think I can safely ignore the warning, but I want to make sure....

Cheers,
  Sean
