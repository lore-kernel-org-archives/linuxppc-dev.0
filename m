Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18436.35348.316368.332336@cargo.ozlabs.ibm.com>
Date: Tue, 15 Apr 2008 20:57:24 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 12/12] [POWERPC] 85xx: Add support for relocatble kernel
	(and booting at non-zero)
In-Reply-To: <1207824531-27168-13-git-send-email-galak@kernel.crashing.org>
References: <1207824531-27168-1-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-2-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-3-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-4-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-5-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-6-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-7-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-8-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-9-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-10-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-11-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-12-git-send-email-galak@kernel.crashing.org>
	<1207824531-27168-13-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> Added support to allow an 85xx kernel to be run from a non-zero physical
> address (useful for cooperative asymmetric multiprocessing situations) and
> kdump.  The support can either be at compile time or runtime
> (CONFIG_RELOCATABLE).
> 
> Currently we are limited to running at a physical address that is module
> 256M.  This is due to how we map TLBs to cover lowmem and should be fixed
> up to allow 64M or maybe even 16M alignment in the future.

The first 11 patches look pretty reasonable, but I think I want a bit
more time to digest this one.  At the least it needs a bit more
description, saying for instance why you remove USER_PGD_PTRS and
KERNEL_PGD_PTRS (yes they are unused now but why does this patch need
to remove them?).  Also, given that we changed from using a
PPC_MEMSTART #define to a memstart_addr variable earlier in the patch
series, why do we need to change back to a #define (MEMORY_START) now?

I take it that with CONFIG_RELOCATABLE set, the kernel won't touch any
RAM below the point where it's loaded?  Is CONFIG_PHYSICAL_START used
at all if CONFIG_RELOCATABLE is set, and if so what does it mean?
What happens if CONFIG_KERNEL_START != CONFIG_PAGE_OFFSET and the
kernel is loaded at some address != CONFIG_PHYSICAL_START?

Are we sure that ARCH_PFN_OFFSET only gets applied to normal memory
pages, not any I/O?  What happens to /dev/mem when ARCH_PFN_OFFSET !=
0?

Also, since you're changing pmd_page(), it would be better to make it
use pfn_to_page or something similar rather than using mem_map + xxx.

Paul.
