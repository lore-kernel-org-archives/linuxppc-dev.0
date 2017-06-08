Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wkGmx4rFKzDqNt
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 06:12:33 +1000 (AEST)
Date: Thu, 8 Jun 2017 22:12:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/4] powerpc/64: context switch an hwsync instruction can
 be avoided
Message-ID: <20170608201226.GD8337@worktop.programming.kicks-ass.net>
References: <20170608153609.19217-1-npiggin@gmail.com>
 <20170608153609.19217-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170608153609.19217-3-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 09, 2017 at 01:36:08AM +1000, Nicholas Piggin wrote:
> The hwsync in the context switch code to prevent MMIO access being
> reordered from the point of view of a single process if it gets
> migrated to a different CPU is not required because there is an hwsync
> performed earlier in the context switch path.
> 
> Comment this so it's clear enough if anything changes on the scheduler
> or the powerpc sides. Remove the hwsync from _switch.
> 
> This improves context switch performance by 2-3% on POWER8.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
