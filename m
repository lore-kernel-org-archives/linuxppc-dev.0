Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by ozlabs.org (Postfix) with ESMTP id 4D5A4DDEEC
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 10:18:58 +1100 (EST)
Date: Thu, 23 Oct 2008 10:18:56 +1100
From: Simon Horman <horms@verge.net.au>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 1/3] powerpc: kexec exit should not use magic numbers
Message-ID: <20081022231854.GB5247@verge.net.au>
References: <f90d4d7306443a720ca31adf513faf25@bga.com> <kexec-kern-1@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <kexec-kern-1@bga.com>
Cc: kexec@lists.infradead.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[ Added Mohan Kumar to CC list ]

On Wed, Oct 22, 2008 at 03:39:18PM -0500, Milton Miller wrote:
> The relocatable kernel kdump patch (54622f10a6aabb8bb2bdacf3dd070046f03dc246)
> added a magic flag value in a register to tell purgatory that it should
> be a panic kernel.  This part is wrong and is reverted by this patch.
> 
> The kernel gets a list of memory blocks and a entry point from user space.
> Its job is to copy the blocks into place and then branch to the designated
> entry point (after turning "off" the mmu).
> 
> The user space tool inserts a trampoline, called purgatory, that runs
> before the user supplied code.   Its job is to establish the entry
> environment for the new kernel or other application based on the contents
> of memory.  The purgatory code is compiled and embedded in the tool,
> where it is later patched using the elf symbol table using elf symbols.
> 
> Since the tool knows it is creating a purgatory that will run after a
> kernel crash, it should just patch purgatory (or the kernel directly)
> if something needs to happen.

Hi Milton,

All of these patches look fine to me.

On the kernel side:
Acked-by: Simon Horman <horms@verge.net.au>

On the kexec-tools side:
I'd rather wait until the kernel changes get merged before merging
the kexec-tools portion. Please ping me at that point.


I'd like to note that these changes really ought to go into the same kernel
(and kexec-tools) release that the relocateable kdump patches as they will
introduce incompatibility. For example, crash-dump kernels with only the
relocatable kdump changes will not be usable if the first-kernel includes
these changes. I think that means that this needs to go into 2.6.28 -
assuming that Linus accepts the pull request than Ben Herrenschmidt sent
recently.

-- 
Simon Horman
  VA Linux Systems Japan K.K., Sydney, Australia Satellite Office
  H: www.vergenet.net/~horms/             W: www.valinux.co.jp/en
