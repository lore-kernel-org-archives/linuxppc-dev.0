Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6MMF13cZzDqb4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 22:48:25 +1000 (AEST)
In-Reply-To: <20170629115726.11060-1-bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2] powerpc/kexec: Fix radix to hash kexec
Message-Id: <3x6MMF0J7cz9s8J@ozlabs.org>
Date: Tue, 11 Jul 2017 22:48:24 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-06-29 at 11:57:26 UTC, Balbir Singh wrote:
> This patch fixes a crash seen while doing a kexec from
> radix mode to hash mode. Key 0 is special in hash and
> used in the RPN by default, we set the key values to 0
> today. In radix mode key 0 is used to control
> supervisor<->user access. In hash key 0 is used by default,
> so the first instruction after the switch causes a crash on
> kexec.
> 
> This patch fixes
> (3b10d00 powerpc/mm/radix: Prevent kernel execution of user space)
> The commit above introduced setting of IAMR and AMOR values to
> prevent execution of user mode instructions from supervisor mode.
> We need to clean up these SPR's on kexec.
> 
> Reported-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/1e2a516e89fc412a754327522ab271

cheers
