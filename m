Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSC0j032czDqZy
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 23:34:13 +1000 (AEST)
In-Reply-To: <1502181795-15477-1-git-send-email-ego@linux.vnet.ibm.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [v2] powerpc/powernv/idle: Disable LOSE_FULL_CONTEXT states when
 stop-api fails
Message-Id: <3xSC0h6Tj7z9sN5@ozlabs.org>
Date: Wed,  9 Aug 2017 23:34:12 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-08-08 at 08:43:15 UTC, "Gautham R. Shenoy" wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Currently, we use the opal call opal_slw_set_reg() to inform the
> Sleep-Winkle Engine (SLW) to restore the contents of some of the
> Hypervisor state on wakeup from deep idle states that lose full
> hypervisor context (characterized by the flag
> OPAL_PM_LOSE_FULL_CONTEXT).
> 
> However, the current code has a bug in that if opal_slw_set_reg()
> fails, we don't disable the use of these deep states (winkle on
> POWER8, stop4 onwards on POWER9).
> 
> This patch fixes this bug by ensuring that if programing the
> sleep-winkle engine to restore the hypervisor states in
> pnv_save_sprs_for_deep_states() fails, then we exclude such states by
> clearing the OPAL_PM_LOSE_FULL_CONTEXT flag from
> supported_cpuidle_states. As a result POWER8 will be prevented from
> using winkle for CPU-Hotplug, and POWER9 will put the offlined CPUs to
> the default stop state when available.
> 
> Further, we ensure in the initialization of the cpuidle-powernv driver
> to only include those states whose flags are present in
> supported_cpuidle_states, thereby skipping OPAL_PM_LOSE_FULL_CONTEXT
> states when they have been disabled due to stop-api failure.
> 
> Fixes: 1e1601b38e6 ("powerpc/powernv/idle: Restore SPRs for deep idle
> states via stop API.")
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/785a12afdb4a52903447fd890633c8

cheers
