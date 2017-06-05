Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wh9pj3kG2zDqKr
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 20:21:49 +1000 (AEST)
In-Reply-To: <22c2ebcfe72f4f17be6d284d922895cec34e23fc.1492606297.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [1/5] powerpc/mm: only call store_updates_sp() on stores in
 do_page_fault()
Message-Id: <3wh9ph70pfz9s8Y@ozlabs.org>
Date: Mon,  5 Jun 2017 20:21:48 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-19 at 12:56:24 UTC, Christophe Leroy wrote:
> Function store_updates_sp() checks whether the faulting
> instruction is a store updating r1. Therefore we can limit its calls
> to stores exceptions.
> 
> This patch is an improvement of commit a7a9dcd882a67 ("powerpc: Avoid
> taking a data miss on every userspace instruction miss")
> 
> With the same microbenchmark app, run with 500 as argument, on an
> MPC885 we get:
> 
> Before this patch: 152000 DTLB misses
> After this patch:  147000 DTLB misses
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Patches 1, 3, 4 and 5 applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e8de85ca32f572f5dee00733022d8a

cheers
