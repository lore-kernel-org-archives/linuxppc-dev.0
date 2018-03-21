Return-Path: <aik@ozlabs.ru>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com
 [IPv6:2607:f8b0:4001:c0b::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405dM80HTpzF1d5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 16:16:33 +1100 (AEDT)
Received: by mail-it0-x244.google.com with SMTP id d13-v6so5327806itf.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 22:16:33 -0700 (PDT)
Subject: Re: [PATCH v2 0/9] EEH refactoring 1
To: linuxppc-dev@lists.ozlabs.org
References: <cover.1521427331.git.sam.bobroff@au1.ibm.com>
Cc: Sam Bobroff <sam.bobroff@au1.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <190a5b7e-217b-402b-80a6-8f6a912347d9@ozlabs.ru>
Date: Wed, 21 Mar 2018 16:16:25 +1100
MIME-Version: 1.0
In-Reply-To: <cover.1521427331.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19/3/18 1:45 pm, Sam Bobroff wrote:
> Hello everyone,
> 
> Here is a set of some small, mostly idempotent, changes to improve
> maintainability in some of the EEH code, primarily in eeh_driver.c.
> 
> I've kept them all small to aid review but perhaps they should be squashed down
> before being applied.
> 
> Cheers,
> Sam.
> 
> Patch set changelog follows:
> 
> ====== v1 -> v2: ======
> 
> Patch 1/9: powerpc/eeh: Remove eeh_handle_event()
> 
> Patch 2/9: powerpc/eeh: Manage EEH_PE_RECOVERING inside eeh_handle_normal_event()
> 
> Patch 3/9: powerpc/eeh: Fix misleading comment in __eeh_addr_cache_get_device()
> 
> Patch 4/9: powerpc/eeh: Remove misleading test in eeh_handle_normal_event()
> 
> Patch 5/9: powerpc/eeh: Rename frozen_bus to bus in eeh_handle_normal_event()
> 
> Patch 6/9: powerpc/eeh: Clarify arguments to eeh_reset_device()
> * Re-ordered parameters to eeh_reset_device() to keep pe first.
> * Changed eeh_aware_driver to driver_eeh_aware.
> 
> Patch 7/9: powerpc/eeh: Remove always-true tests in eeh_reset_device()
> 
> Patch 8/9: powerpc/eeh: Factor out common code eeh_reset_device()
> * In one case, added braces to "if" to match "else".
> 
> Patch 9/9: powerpc/eeh: Add eeh_state_active() helper
> 
> ====== v1: ======
> 
> Patch 1/9: powerpc/eeh: Remove eeh_handle_event()
> Patch 2/9: powerpc/eeh: Manage EEH_PE_RECOVERING inside eeh_handle_normal_event()
> Patch 3/9: powerpc/eeh: Fix misleading comment in __eeh_addr_cache_get_device()
> Patch 4/9: powerpc/eeh: Remove misleading test in eeh_handle_normal_event()
> Patch 5/9: powerpc/eeh: Rename frozen_bus to bus in eeh_handle_normal_event()
> Patch 6/9: powerpc/eeh: Clarify arguments to eeh_reset_device()
> Patch 7/9: powerpc/eeh: Remove always-true tests in eeh_reset_device()
> Patch 8/9: powerpc/eeh: Factor out common code eeh_reset_device()
> Patch 9/9: powerpc/eeh: Add eeh_state_active() helper
> 
> Sam Bobroff (9):
>   powerpc/eeh: Remove eeh_handle_event()
>   powerpc/eeh: Manage EEH_PE_RECOVERING inside eeh_handle_normal_event()
>   powerpc/eeh: Fix misleading comment in __eeh_addr_cache_get_device()
>   powerpc/eeh: Remove misleading test in eeh_handle_normal_event()
>   powerpc/eeh: Rename frozen_bus to bus in eeh_handle_normal_event()
>   powerpc/eeh: Clarify arguments to eeh_reset_device()
>   powerpc/eeh: Remove always-true tests in eeh_reset_device()
>   powerpc/eeh: Factor out common code eeh_reset_device()
>   powerpc/eeh: Add eeh_state_active() helper
> 
>  arch/powerpc/include/asm/eeh.h               |   6 ++
>  arch/powerpc/include/asm/eeh_event.h         |   3 +-
>  arch/powerpc/kernel/eeh.c                    |  19 ++--
>  arch/powerpc/kernel/eeh_cache.c              |   3 +-
>  arch/powerpc/kernel/eeh_driver.c             | 137 +++++++++++----------------
>  arch/powerpc/kernel/eeh_event.c              |   6 +-
>  arch/powerpc/platforms/powernv/eeh-powernv.c |   9 +-
>  7 files changed, 72 insertions(+), 111 deletions(-)
> 

Nice cleanup,

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


-- 
Alexey
