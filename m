Return-Path: <rdreier@cisco.com>
Received: from sj-iport-6.cisco.com (sj-iport-6.cisco.com [171.71.176.117])
	by ozlabs.org (Postfix) with ESMTP id 2EF7ADDDF9
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 12:43:57 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Allow drivers to map individual 4k pages to userspace
References: <17938.14674.621036.256587@cargo.ozlabs.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 03 Apr 2007 19:34:13 -0700
In-Reply-To: <17938.14674.621036.256587@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Tue, 3 Apr 2007 21:24:02 +1000")
Message-ID: <adar6r0dg0q.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, Joachim Fenkes <fenkes@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Warning: I am somewhat of a PowerPC ignoramus, so this reply may not
make sense.

 > Some drivers have resources that they want to be able to map into
 > userspace that are 4k in size.  On a kernel configured with 64k pages
 > we currently end up mapping the 4k we want plus another 60k of
 > physical address space, which could contain anything.  This can
 > introduce security problems, for example in the case of an infiniband
 > adaptor where the other 60k could contain registers that some other
 > program is using for its communications.

I assume this is an eHCA-specific problem.  Mellanox adapters (which
I'm much more familiar with) allow the driver to pass in the system
page size at initialization time, and make the register pages of size
equal to the system size.

Another approach is simply not to enable the other 4K pages that are
exposed when mapping a 64K page into userspace - ie only use 1/16th of
the available contexts.  Although perhaps eHCA has such a limited # of
contexts that this is not practical.

 > This patch adds a new function, remap_4k_pfn, which drivers can use to
 > map a single 4k page to userspace regardless of whether the kernel is
 > using a 4k or a 64k page size.  Like remap_pfn_range, it would
 > typically be called in a driver's mmap function.  It only maps a
 > single 4k page, which on a 64k page kernel appears replicated 16 times
 > throughout a 64k page.  On a 4k page kernel it reduces to a call to
 > remap_pfn_range.

The problem with this approach is that remap_4k_pfn is
powerpc-specific, right?  For example, I don't believe that an ia64
kernel running with 16K pages could implement this.  Which means that
any driver that calls remap_4k_pfn is now powerpc-specific (or has an
#ifdef to work around this).

In fact my impression was that the powerpc MMU is not part of the
architecture, in the sense that a new implementation could come along
that supported 64K pages without the ability to do this 4K aliasing
trick.  Which would make multiplatform kernels very painful, since
remap_4k_pfn might work for some platforms the kernel could boot on.
Or is this not a problem?

 - R.
