Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zt2m3FfSzF0dT
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2018 21:27:44 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpuidle:powernv: Make the snooze timeout dynamic.
In-Reply-To: <1527768909-32637-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1527768909-32637-1-git-send-email-ego@linux.vnet.ibm.com>
Date: Mon, 04 Jun 2018 21:27:40 +1000
Message-ID: <87fu22bxlf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>
> The commit 78eaa10f027c ("cpuidle: powernv/pseries: Auto-promotion of
> snooze to deeper idle state") introduced a timeout for the snooze idle
> state so that it could be eventually be promoted to a deeper idle
> state. The snooze timeout value is static and set to the target
> residency of the next idle state, which would train the cpuidle
> governor to pick the next idle state eventually.
>
> The unfortunate side-effect of this is that if the next idle state(s)
> is disabled, the CPU will forever remain in snooze, despite the fact
> that the system is completely idle, and other deeper idle states are
> available.

That sounds like a bug, I'll add?

Fixes: 78eaa10f027c ("cpuidle: powernv/pseries: Auto-promotion of snooze to deeper idle state")
Cc: stable@vger.kernel.org # v4.2+

cheers
