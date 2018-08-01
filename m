Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gGKw05GwzF12N
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 11:43:30 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id k21-v6so6975099pff.11
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 18:43:30 -0700 (PDT)
Date: Wed, 1 Aug 2018 11:43:19 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, vaibhav@linux.ibm.com,
 felix@linux.ibm.com, clombard@linux.ibm.com
Subject: Re: [PATCH] powerpc/64s/radix: Fix missing global invalidations
 when removing copro
Message-ID: <20180801114319.62301bb9@roar.ozlabs.ibm.com>
In-Reply-To: <20180731132452.15994-1-fbarrat@linux.ibm.com>
References: <20180731132452.15994-1-fbarrat@linux.ibm.com>
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

On Tue, 31 Jul 2018 15:24:52 +0200
Frederic Barrat <fbarrat@linux.ibm.com> wrote:

> With the optimizations for TLB invalidation from commit 0cef77c7798a
> ("powerpc/64s/radix: flush remote CPUs out of single-threaded
> mm_cpumask"), the scope of a TLBI (global vs. local) can now be
> influenced by the value of the 'copros' counter of the memory context.
> 
> When calling mm_context_remove_copro(), the 'copros' counter is
> decremented first before flushing. It may have the unintended side
> effect of sending local TLBIs when we explicitly need global
> invalidations in this case. Thus breaking any nMMU user in a bad and
> unpredictable way.
> 
> Fix it by flushing first, before updating the 'copros' counter, so
> that invalidations will be global.
> 
> Fixes: 0cef77c7798a ("powerpc/64s/radix: flush remote CPUs out of single-threaded mm_cpumask")
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>

Thanks for catching this, looks good to me.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
