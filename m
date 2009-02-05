Return-Path: <rdreier@cisco.com>
Received: from sj-iport-5.cisco.com (sj-iport-5.cisco.com [171.68.10.87])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "sj-iport-5.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0C45FDDF04
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 16:33:37 +1100 (EST)
From: Roland Dreier <rdreier@cisco.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: FW: [PATCH] powerpc/mm: Export HPAGE_SHIFT
References: <20090203164930.GA10101@mtls03> <ada8wonnh3t.fsf@cisco.com>
	<1233712248.16867.131.camel@pasglop>
	<20090203211329.d6190a08.akpm@linux-foundation.org>
	<aday6wmn2vr.fsf@cisco.com>
	<20090203222601.747ca8b7.akpm@linux-foundation.org>
	<adad4dym2zp.fsf@cisco.com> <1233791729.4612.28.camel@pasglop>
	<ada7i45lb9x.fsf@cisco.com> <1233811493.4612.69.camel@pasglop>
Date: Wed, 04 Feb 2009 21:33:34 -0800
In-Reply-To: <1233811493.4612.69.camel@pasglop> (Benjamin Herrenschmidt's
	message of "Thu, 05 Feb 2009 16:24:53 +1100")
Message-ID: <adawsc5jvm9.fsf@cisco.com>
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

 > Right, but then you need to set that in the VMA's, and thus gone is your
 > nice fast g_u_p() that doesn't touch VMAs :-)

Registering memory is a slow path thing in the RDMA world.  Speeding it
up is nice, so we make userspace do the madvise(VM_DONTCOPY) if it cares
but if it doesn't it can leave it out.

 > > Yes, but unfortunately MPI says apps can allocate memory however they
 > > damn well please... in any case these issues are all-too-well-known in
 > > the RDMA world for quite a while.

 > Yup. What do you think of the idea of pre-COWing pages with an elevated
 > count at fork time ?

Super-duper sucks if the first thing the child does is exec() :)
Also if the parent has registered > half the memory in the system then
it's instant OOM.  So not that useful for the RDMA case :)

The one thing that might make sense is to pre-COW any partial pages that
the parent has registered -- ie if half a page can be used by the child,
at least pre-COW that, but leave all the full pages with VM_DONTCOPY.

 - R.
