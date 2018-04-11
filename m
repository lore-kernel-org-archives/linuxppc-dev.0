Return-Path: <rashmica.g@gmail.com>
Received: from mail-pl0-x22e.google.com (mail-pl0-x22e.google.com
 [IPv6:2607:f8b0:400e:c01::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40LVgK0DwWzDqyW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 14:00:09 +1000 (AEST)
Received: by mail-pl0-x22e.google.com with SMTP id e22-v6so389628plj.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 21:00:09 -0700 (PDT)
Subject: Re: [PATCH 1/2] powerpc/mm: Flush cache on memory hot(un)plug
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, rashmica.g@gmail.com, benh@kernel.crashing.org
References: <20180406052424.29841-1-bsingharora@gmail.com>
From: rashmica <rashmica.g@gmail.com>
Message-ID: <2ce3da2a-e714-8dc7-bb54-faadbfcb06f9@gmail.com>
Date: Wed, 11 Apr 2018 14:00:03 +1000
MIME-Version: 1.0
In-Reply-To: <20180406052424.29841-1-bsingharora@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 06/04/18 15:24, Balbir Singh wrote:
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

Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>
