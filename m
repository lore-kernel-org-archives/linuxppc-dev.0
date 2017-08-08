Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRWWn0M3mzDqpD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 20:55:17 +1000 (AEST)
In-Reply-To: <20170808063724.B755C653E1@po15668-vm-win7.idsi0.si.c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/32: Fix boot failure on non 6xx platforms
Message-Id: <3xRWWm4LtHz9s83@ozlabs.org>
Date: Tue,  8 Aug 2017 20:55:16 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-08-08 at 06:37:24 UTC, Christophe Leroy wrote:
> commit d300627c6a536 ("powerpc/6xx: Handle DABR match before
> calling do_page_fault") breaks non 6xx platforms.
> 
> [    6.029556] Failed to execute /init (error -14)
> [    6.034623] Starting init: /bin/sh exists but couldn't execute it
> (error -14)
> [    6.041489] Kernel panic - not syncing: No working init found.  Try
> passing init= option to kernel. See Linux
> Documentation/admin-guide/init.rst for guidance.
> [    6.055518] CPU: 0 PID: 1 Comm: init Not tainted
> 4.13.0-rc3-s3k-dev-00143-g7aa62e972a56 #56
> [    6.063745] Call Trace:
> [    6.066224] [c60f1ed0] [c001a624] panic+0x108/0x250 (unreliable)
> [    6.072140] [c60f1f30] [c0002640] rootfs_mount+0x0/0x58
> [    6.077311] [c60f1f40] [c000cb80] ret_from_kernel_thread+0x5c/0x64
> [    6.083405] Rebooting in 180 seconds..
> 
> This is because in handle_page_fault(), the call to do_page_fault()
> has been mistakenly enclosed inside an #ifdef CONFIG_6xx
> 
> Fixes: d300627c6a536 ("powerpc/6xx: Handle DABR match before
> calling do_page_fault")
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/64d0a506fbdd64906f168539bee32a

cheers
