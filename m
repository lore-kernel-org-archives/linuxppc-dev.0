Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJCHN0ThrzDqFL
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 08:18:56 +1000 (AEST)
In-Reply-To: <149253349689.12722.1516352063236500616.stgit@jupiter.in.ibm.com>
To: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Daniel Axtens <dja@axtens.net>
Subject: Re: [v2] powerpc/book3s: mce: Move add_taint() later in virtual mode.
Message-Id: <3wJCHM3zf7z9s03@ozlabs.org>
Date: Thu,  4 May 2017 08:18:55 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-04-18 at 16:38:17 UTC, Mahesh Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> machine_check_early() gets called in real mode. The very first time when
> add_taint() is called, it prints a warning which ends up calling opal
> call (that uses OPAL_CALL wrapper) for writing it to console. If we get a
> very first machine check while we are in opal we are doomed. OPAL_CALL
> overwrites the PACASAVEDMSR in r13 and in this case when we are done with
> MCE handling the original opal call will use this new MSR on it's way
> back to opal_return. This usually leads unexpected behaviour or kernel
> to panic. Instead move the add_taint() call later in the virtual mode
> where it is safe to call.
> 
> This is broken with current FW level. We got lucky so far for not getting
> very first MCE hit while in OPAL. But easily reproducible on Mambo.
> This should go to stable.
> 
> Fixes: 27ea2c420cad powerpc: Set the correct kernel taint on machine check errors.
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d93b0ac01a9ce276ec39644be47001

cheers
