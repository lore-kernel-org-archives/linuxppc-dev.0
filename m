Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415Kmh3kD2zDrph
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 18:34:28 +1000 (AEST)
Date: Wed, 13 Jun 2018 10:34:19 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi.kleen@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>,
 Tony Luck <tony.luck@intel.com>,
 "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Doug Berger <opendmb@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
 iommu@lists.linux-foundation.org
Subject: Re: [RFC PATCH 03/23] genirq: Introduce IRQF_DELIVER_AS_NMI
Message-ID: <20180613083419.GS12258@hirez.programming.kicks-ass.net>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-4-git-send-email-ricardo.neri-calderon@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1528851463-21140-4-git-send-email-ricardo.neri-calderon@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 12, 2018 at 05:57:23PM -0700, Ricardo Neri wrote:
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 5426627..dbc5e02 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -61,6 +61,8 @@
>   *                interrupt handler after suspending interrupts. For system
>   *                wakeup devices users need to implement wakeup detection in
>   *                their interrupt handlers.
> + * IRQF_DELIVER_AS_NMI - Configure interrupt to be delivered as non-maskable, if
> + *                supported by the chip.
>   */

NAK on the first 6 patches. You really _REALLY_ don't want to expose
NMIs to this level.
