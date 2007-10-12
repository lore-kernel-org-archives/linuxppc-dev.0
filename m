Return-Path: <dgibson@ozlabs.org>
Date: Fri, 12 Oct 2007 13:30:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Use PAGE_OFFSET to tell if an address is
	user/kernel in SW TLB handlers
Message-ID: <20071012033032.GH21056@localhost.localdomain>
References: <Pine.LNX.4.64.0710111341140.27045@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0710111341140.27045@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 11, 2007 at 01:42:30PM -0500, Kumar Gala wrote:
> Move to using PAGE_OFFSET instead of TASK_SIZE or KERNELBASE value on
> 6xx/40x/44x/fsl-booke to determine if the faulting address is a kernel or
> user space address.  This mimics how the macro is_kernel_addr()
> works.

Actually it's ambiguous whether TASK_SIZE or PAGE_OFFSET is correct in
most of these cases (KERNELBASE is certainly wrong, though).

TASK_SIZE is the top of the userspace mapped area, PAGE_OFFSET is the
bottom of the linear mapping.  So, strictly speaking there are 3 paths
for the miss handlers: < TASK_SIZE => user mapping, >= PAGE_OFFSET =>
kernel mapping, between the two => immediate fault.

We get away with a two way comparison on 32-bit because, a) they have
the same value and b) none of the pagetables, user or kernel, should
have any entries in the in between region so we'll end up in
do_page_fault in the end, anyway.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
