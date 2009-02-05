Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 53D27DDF13
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 16:25:47 +1100 (EST)
Subject: Re: FW: [PATCH] powerpc/mm: Export HPAGE_SHIFT
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <rdreier@cisco.com>
In-Reply-To: <ada7i45lb9x.fsf@cisco.com>
References: <20090203164930.GA10101@mtls03> <ada8wonnh3t.fsf@cisco.com>
	<1233712248.16867.131.camel@pasglop>
	<20090203211329.d6190a08.akpm@linux-foundation.org>
	<aday6wmn2vr.fsf@cisco.com>
	<20090203222601.747ca8b7.akpm@linux-foundation.org>
	<adad4dym2zp.fsf@cisco.com> <1233791729.4612.28.camel@pasglop>
	<ada7i45lb9x.fsf@cisco.com>
Content-Type: text/plain
Date: Thu, 05 Feb 2009 16:24:53 +1100
Message-Id: <1233811493.4612.69.camel@pasglop>
Mime-Version: 1.0
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

On Wed, 2009-02-04 at 21:10 -0800, Roland Dreier wrote:
> > Note that g_u_p() has all sort of shortcommings... we were discussing
>  > some of that recently due to bugs reported from the field.
>  > 
>  > The problem mostly is that you cannot guarantee that the physical page
>  > will remain mapped to that virtual address in the process. For example,
>  > if your code is part of some library used by an application, and that
>  > application somewhere does a fork/exec (for example, a system() call to
>  > run a shell helper), copy-on-write will hit, and you may end up with
>  > the child process getting the original physical page and the original
>  > process getting the copy...
> 
> Believe me, I'm well aware of that.  We added VM_DONTCOPY to allow apps
> to fork() without the child triggering COW, but that means only the
> parent process can use the mapped memory (and the app has to worry about
> page boundaries etc).

Right, but then you need to set that in the VMA's, and thus gone is your
nice fast g_u_p() that doesn't touch VMAs :-)

> Yes, but unfortunately MPI says apps can allocate memory however they
> damn well please... in any case these issues are all-too-well-known in
> the RDMA world for quite a while.

Yup. What do you think of the idea of pre-COWing pages with an elevated
count at fork time ?

Cheers,
Ben.
