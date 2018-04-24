Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40VTnj2rRfzF1RV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 13:48:25 +1000 (AEST)
In-Reply-To: <20180406052424.29841-1-bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: rashmica.g@gmail.com
Subject: Re: [1/2] powerpc/mm: Flush cache on memory hot(un)plug
Message-Id: <40VTnj1yHyz9s02@ozlabs.org>
Date: Tue, 24 Apr 2018 13:48:25 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-04-06 at 05:24:23 UTC, Balbir Singh wrote:
> This patch adds support for flushing potentially dirty
> cache lines when memory is hot-plugged/hot-un-plugged.
> The support is currently limited to 64 bit systems.
> 
> The bug was exposed when mappings for a device were
> actually hot-unplugged and plugged in back later.
> A similar issue was observed during the development
> of memtrace, but memtrace does it's own flushing of
> region via a custom routine.
> 
> These patches do a flush both on hotplug/unplug to
> clear any stale data in the cache w.r.t mappings,
> there is a small race window where a clean cache
> line may be created again just prior to tearing
> down the mapping.
> 
> The patches were tested by disabling the flush
> routines in memtrace and doing I/O on the trace
> file. The system immediately checkstops (quite
> reliablly if prior to the hot-unplug of the memtrace
> region, we memset the regions we are about to
> hot unplug). After these patches no custom flushing
> is needed in the memtrace code.
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> Acked-by: Reza Arbab <arbab@linux.ibm.com>
> Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>

Series applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/fb5924fddf9ee31db04da7ad4e8c34

cheers
