Return-Path: <rdreier@cisco.com>
Received: from sj-iport-1.cisco.com (sj-iport-1.cisco.com [171.71.176.70])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-1.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7FD48DDEE7
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 16:10:06 +1100 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: FW: [PATCH] powerpc/mm: Export HPAGE_SHIFT
References: <20090203164930.GA10101@mtls03> <ada8wonnh3t.fsf@cisco.com>
	<1233712248.16867.131.camel@pasglop>
	<20090203211329.d6190a08.akpm@linux-foundation.org>
	<aday6wmn2vr.fsf@cisco.com>
	<20090203222601.747ca8b7.akpm@linux-foundation.org>
	<adad4dym2zp.fsf@cisco.com> <1233791729.4612.28.camel@pasglop>
Date: Wed, 04 Feb 2009 21:10:02 -0800
In-Reply-To: <1233791729.4612.28.camel@pasglop> (Benjamin Herrenschmidt's
	message of "Thu, 05 Feb 2009 10:55:29 +1100")
Message-ID: <ada7i45lb9x.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eli Cohen <eli@mellanox.co.il>, Andrew Morton <akpm@linux-foundation.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > Note that g_u_p() has all sort of shortcommings... we were discussing
 > some of that recently due to bugs reported from the field.
 > 
 > The problem mostly is that you cannot guarantee that the physical page
 > will remain mapped to that virtual address in the process. For example,
 > if your code is part of some library used by an application, and that
 > application somewhere does a fork/exec (for example, a system() call to
 > run a shell helper), copy-on-write will hit, and you may end up with
 > the child process getting the original physical page and the original
 > process getting the copy...

Believe me, I'm well aware of that.  We added VM_DONTCOPY to allow apps
to fork() without the child triggering COW, but that means only the
parent process can use the mapped memory (and the app has to worry about
page boundaries etc).

 > We've been discussing that at KS with various people, Linus says g_u_p()
 > sucks, don't do that :-) Most of the time, the other approach should be
 > used, ie, the driver allocates memory, and userspace mmap's it, in which
 > case you get access to the VMA to set flags such as don't copy on fork.

Yes, but unfortunately MPI says apps can allocate memory however they
damn well please... in any case these issues are all-too-well-known in
the RDMA world for quite a while.

Thanks,
  Roland
