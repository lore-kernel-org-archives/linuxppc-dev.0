Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42G3Sc3r44zF39H
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 14:21:04 +1000 (AEST)
In-Reply-To: <1536784265-19806-1-git-send-email-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Breno Leitao <leitao@debian.org>, gromero@linux.vnet.ibm.com
Subject: Re: [v2] selftests/powerpc: Do not fail with reschedule
Message-Id: <42G3Sc2C0jz9sCD@ozlabs.org>
Date: Thu, 20 Sep 2018 14:21:02 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-09-12 at 20:31:05 UTC, Breno Leitao wrote:
> There are cases where the test is not expecting to have the transaction
> aborted, but, the test process might have been rescheduled, either in the
> OS level or by KVM (if it is running on a KVM guest machine). The process
> reschedule will cause a treclaim/recheckpoint which will cause the
> transaction to doom, aborting the transaction as soon as the process is
> rescheduled back to the CPU. This might cause the test to fail, but this is
> not a failure in essence.
> 
> If that is the case, TEXASR[FC] is indicated with either
> TM_CAUSE_RESCHEDULE or TM_CAUSE_KVM_RESCHEDULE for KVM interruptions.
> 
> In this scenario, ignore these two failures and avoid the whole test to
> return failure.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Gustavo Romero <gromero@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/44d947eff19d64384efc06069509db

cheers
