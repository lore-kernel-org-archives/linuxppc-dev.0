Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyzKc6rpwzDr4S
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 22:21:24 +1000 (AEST)
In-Reply-To: <1498612609-13677-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: ego@linux.vnet.ibm.com, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 npiggin@gmail.com
Subject: Re: powernv:idle: Clear r12 on wakeup from stop lite
Message-Id: <3wyzKc5KLkz9s76@ozlabs.org>
Date: Thu, 29 Jun 2017 22:21:24 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-06-28 at 01:16:49 UTC, Akshay Adiga wrote:
> pnv_wakeup_noloss expects R12 to contain SRR1 value to determine if
> the wakeup reason is an HMI in CHECK_HMI_INTERRUPT.
> 
> When we wakeup with ESL=0, SRR1 will not contain the wakeup reason, so
> there is no point setting R12 to SRR1.
> 
> However, we don't set R12 at all and R12 contains garbage, and still
> being used to check HMI assuming that it had SRR1. causing the
> OPAL msglog to be filled with the following print:
> 	HMI: Received HMI interrupt: HMER = 0x0040000000000000
> 
> This patch clears R12 after waking up from stop with ESL=EC=0, so that
> we don't accidentally enter the HMI handler in pnv_wakeup_noloss if
> the R12[42:45] corresponds to HMI as wakeup reason.
> 
> Bug existed prior to "commit 9d29250136f6 ("powerpc/64s/idle: Avoid SRR
> usage in idle sleep/wake paths")  but was never hit in practice
> 
> Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
> Fixes: 9d29250136f6 ("powerpc/64s/idle: Avoid SRR usage in idle
> sleep/wake paths")
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4d0d7c02df680740da41f5f92a238c

cheers
