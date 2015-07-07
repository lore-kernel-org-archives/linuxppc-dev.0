Return-Path: <gustavold@linux.vnet.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B087F1A1061
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 06:54:42 +1000 (AEST)
Received: from /spool/local
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gustavold@linux.vnet.ibm.com>;
 Tue, 7 Jul 2015 17:54:36 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 44CD91DC0060
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jul 2015 16:53:33 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t67Kr6FB3277282
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Jul 2015 17:53:06 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t67KsWsq007767
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Jul 2015 17:54:32 -0300
Message-ID: <559C3C87.9010601@linux.vnet.ibm.com>
Date: Tue, 07 Jul 2015 17:54:31 -0300
From: Gustavo Luiz Duarte <gustavold@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
CC: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/perf/24x7: Fix lockdep warning
References: <20150707193725.GA12395@us.ibm.com>
In-Reply-To: <20150707193725.GA12395@us.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 07/07/2015 04:37 PM, Sukadev Bhattiprolu wrote:
>  From 370152d9427e57cd9632b00189f71099f8e85544 Mon Sep 17 00:00:00 2001
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date: Tue, 7 Jul 2015 12:21:10 -0400
> Subject: [PATCH 1/1] powerpc/perf/24x7: Fix lockdep warning
>
> The sysfs attributes for the 24x7 counters are dynamically allocated.
> Initialize the attributes using sysfs_attr_init() to fix following
> warning which occurs when CONFIG_DEBUG_LOCK_VMALLOC=y.
>
> [    0.346249] audit: initializing netlink subsys (disabled)
> [    0.346284] audit: type=2000 audit(1436295254.340:1): initialized
> [    0.346489] BUG: key c0000000efe90198 not in .data!
> [    0.346491] DEBUG_LOCKS_WARN_ON(1)
> [    0.346502] ------------[ cut here ]------------
> [    0.346504] WARNING: at ../kernel/locking/lockdep.c:3002
> [    0.346506] Modules linked in:
>
> Reported-by: Gustavo Luiz Duarte <gustavold@linux.vnet.ibm.com>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Tested-by: Gustavo Luiz Duarte <gustavold@linux.vnet.ibm.com>

I verified that it fixes a BUG splat on PowerVM (tested on little endian).

[]'s
Gustavo
