Return-Path: <roland@redhat.com>
Received: from QMTA02.emeryville.ca.mail.comcast.net
	(qmta02.emeryville.ca.mail.comcast.net [76.96.30.24])
	by ozlabs.org (Postfix) with ESMTP id 208C4DDE24
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 16:18:47 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 1/2] elf loader support for auxvec base platform string
In-Reply-To: Benjamin Herrenschmidt's message of  Monday,
	7 July 2008 15:48:13 +1000 <1215409693.8970.79.camel@pasglop>
References: <20080703234140.GC9594@localdomain>
	<20080704021929.5E9EF1541F5@magilla.localdomain>
	<1215409693.8970.79.camel@pasglop>
Message-Id: <20080707061811.19989154246@magilla.localdomain>
Date: Sun,  6 Jul 2008 23:18:11 -0700 (PDT)
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Well, we use strings to represent the platforms already (ie, the actual
> CPU microarchitecture). Fitting those into bits would be annoying, it

Then use dsocaps.

> makes sense to have AT_BASE_PLATFORM to be the "base" variant of
> AT_PLATFORM.

I understand why you think so.  But let's not be too abstract.  The
purpose of the addition is to drive ld.so's selection of libraries, yes?

AT_PLATFORM is a lousy model.  Handling it is clunky in glibc, because
we have to compare against all the known strings to turn it back into a
bit for the ld.so.cache bitmasks.  We're not going to do the same for
AT_BASE_PLATFORM too, because it just sucks.

Using dsocaps gives you the best of both worlds.  You can freely choose
new strings in the kernel without the ld.so code having to know about
them (which is not true of AT_PLATFORM, but may be true of how you are
thinking about "strings are nice").  You do have to map all the
possibilities that a single kernel build can produce into distinct bits.
But, there are 32 unallocated bits to start with.  Moreover, those bit
assignments are not part of any permanent ABI like bits in AT_* values.
They just have to match up between this kernel build and the ld.conf.d
file installed along with it--kernel hackers and kernel packagers have
to coordinate, not kernel hackers and userland hackers.


Thanks,
Roland
