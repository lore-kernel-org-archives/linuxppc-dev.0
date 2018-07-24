Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Zg3743lkzDqCG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 23:59:47 +1000 (AEST)
In-Reply-To: <20180425051759.9474-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v2] powerpc: NMI IPI make NMI IPIs fully sychronous
Message-Id: <41Zg372DMxz9s29@ozlabs.org>
Date: Tue, 24 Jul 2018 23:59:47 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-04-25 at 05:17:59 UTC, Nicholas Piggin wrote:
> There is an asynchronous aspect to smp_send_nmi_ipi. The caller waits
> for all CPUs to call in to the handler, but it does not wait for
> completion of the handler. This is a needless complication, so remove
> it and always wait synchronously.
> 
> The synchronous wait allows the caller to easily time out and clear
> the wait for completion (zero nmi_ipi_busy_count) in the case of badly
> behaved handlers. This would have prevented the recent smp_send_stop
> NMI IPI bug from causing the system to hang.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5b73151fff63fb019db8171cb81c6c

cheers
