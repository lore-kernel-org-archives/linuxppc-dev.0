Return-Path: <srs0=gs+6=4j=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wHn3B6WSSzDqBH
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 May 2017 15:36:54 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wHn3B5mR6z8tBY
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 May 2017 15:36:54 +1000 (AEST)
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wHn395s7Hz9s7j
 for <linuxppc-dev@ozlabs.org>; Wed,  3 May 2017 15:36:53 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id v14so2648093pfd.3
 for <linuxppc-dev@ozlabs.org>; Tue, 02 May 2017 22:36:53 -0700 (PDT)
Date: Wed, 3 May 2017 15:36:35 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, aneesh.kumar@linux.vnet.ibm.com, anton@samba.org
Subject: Re: [PATCH] powerpc/mm/radix: Drop support for CPUs without
 lockless tlbie
Message-ID: <20170503153635.707ea5b6@roar.ozlabs.ibm.com>
In-Reply-To: <1493786699-14850-1-git-send-email-mpe@ellerman.id.au>
References: <1493786699-14850-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed,  3 May 2017 14:44:59 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Currently the radix TLB code includes support for CPUs that do *not*
> have MMU_FTR_LOCKLESS_TLBIE. On those CPUs we are required to take a
> global spinlock before issuing a tlbie.
> 
> Radix can only be built for 64-bit Book3s CPUs, and of those, only
> POWER4, 970, Cell and PA6T do not have MMU_FTR_LOCKLESS_TLBIE. Although
> it's possible to build a kernel with Radix support that can also boot on
> those CPUs, we happen to know that in reality none of those CPUs support
> the Radix MMU, so the code can never actually run on those CPUs.
> 
> So remove the native_tlbie_lock in the Radix TLB code.
> 
> Note that there is another lock of the same name in the hash code, which
> is unaffected by this patch.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Good idea.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
