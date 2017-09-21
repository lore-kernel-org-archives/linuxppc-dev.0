Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyKGW5yhszDqTc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 11:46:43 +1000 (AEST)
In-Reply-To: <1505355228-15039-1-git-send-email-gromero@linux.vnet.ibm.com>
To: Gustavo Romero <gromero@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: stable@vger.kernel.org, mikey@neuling.org, cyrilbur@gmail.com,
 sam.bobroff@au1.ibm.com
Subject: Re: [v2] powerpc/tm: Flush TM only if CPU has TM feature
Message-Id: <3xyKGW31PFz9sPk@ozlabs.org>
Date: Thu, 21 Sep 2017 11:46:43 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-09-14 at 02:13:48 UTC, Gustavo Romero wrote:
> Commit cd63f3c ("powerpc/tm: Fix saving of TM SPRs in core dump")
> added code to access TM SPRs in flush_tmregs_to_thread(). However
> flush_tmregs_to_thread() does not check if TM feature is available on
> CPU before trying to access TM SPRs in order to copy live state to
> thread structures. flush_tmregs_to_thread() is indeed guarded by
> CONFIG_PPC_TRANSACTIONAL_MEM but it might be the case that kernel
> was compiled with CONFIG_PPC_TRANSACTIONAL_MEM enabled and ran on
> a CPU without TM feature available, thus rendering the execution
> of TM instructions that are treated by the CPU as illegal instructions.
> 
> The fix is just to add proper checking in flush_tmregs_to_thread()
> if CPU has the TM feature before accessing any TM-specific resource,
> returning immediately if TM is no available on the CPU. Adding
> that checking in flush_tmregs_to_thread() instead of in places
> where it is called, like in vsr_get() and vsr_set(), is better because
> avoids the same problem cropping up elsewhere.
> 
> Cc: stable@vger.kernel.org # v4.13+
> Fixes: cd63f3c ("powerpc/tm: Fix saving of TM SPRs in core dump")
> Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
> Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/c1fa0768a8713b135848f78fd43ffc

cheers
