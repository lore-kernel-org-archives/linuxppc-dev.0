Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBhLc35TyzDqBS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 08:47:36 +1000 (AEST)
In-Reply-To: <20170419063826.1678-1-david@gibson.dropbear.id.au>
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: jasowang@redhat.com, linuxppc-dev@lists.ozlabs.org, thuth@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [RFC] arch/powerpc: Turn off irqs in switch_mm()
Message-Id: <3wBhLc21L4z9s8Y@ozlabs.org>
Date: Tue, 25 Apr 2017 08:47:35 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-19 at 06:38:26 UTC, David Gibson wrote:
> There seems to be a mismatch in expectations between the powerpc arch code
> and the generic (and x86) code in terms of the irq state when switch_mm()
> is called.
> 
> powerpc expects irqs to already be (soft) disabled when switch_mm() is
> called, as made clear in the commit message of 9c1e105 "powerpc: Allow
> perf_counters to access user memory at interrupt time".
> 
> That seems to be true when it's called from the schedule, but not for
> use_mm().  This becomes clear when looking at the x86 code paths for
> switch_mm().  There, switch_mm() itself disable irqs, with a
> switch_mm_irqs_off() variant which expects that to be already done.
> 
> This patch addresses the problem, making the powerpc code mirror the x86
> code.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9765ad134a00a01cbcc69c78ff6def

cheers
