Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYNvS3VjQzDsT4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 22:16:36 +1000 (AEST)
In-Reply-To: <1473601453-9660-1-git-send-email-wei.guo.simon@gmail.com>
To: Simon Guo <wei.guo.simon@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>, Daniel Axtens <dja@axtens.net>
Subject: Re: [v2] powerpc/ptrace: Fix cppcheck issue in
 gpr32_set_common/gpr32_get_common()
Message-Id: <3sYNvS2K8Gz9t1L@ozlabs.org>
Date: Tue, 13 Sep 2016 22:16:36 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-11-09 at 13:44:13 UTC, Simon Guo wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> The ckpt_regs usage in gpr32_set_common/gpr32_get_common() will lead to
> following cppcheck error at ifndef CONFIG_PPC_TRANSACTIONAL_MEM case:
> 
> [arch/powerpc/kernel/ptrace.c:2062]:
> (error) Uninitialized variable: ckpt_regs
> [arch/powerpc/kernel/ptrace.c:2130]:
> (error) Uninitialized variable: ckpt_regs
> 
> The problem is due to gpr32_set_common() used ckpt_regs variable which
> only makes sense at #ifdef CONFIG_PPC_TRANSACTIONAL_MEM.
> 
> This patch fix this issue by passing in "regs" parameter instead.
> 
> Reported-by: Daniel Axtens <dja@axtens.net>
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/261831160d4df6bafe2f0e12e6

cheers
