Return-Path: <julien.thierry@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 415LKf2qrRzF07t
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 18:59:26 +1000 (AEST)
Subject: Re: [RFC PATCH 03/23] genirq: Introduce IRQF_DELIVER_AS_NMI
To: Peter Zijlstra <peterz@infradead.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi.kleen@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@suse.de>,
 Tony Luck <tony.luck@intel.com>, "Ravi V. Shankar"
 <ravi.v.shankar@intel.com>, x86@kernel.org, sparclinux@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Jacob Pan <jacob.jun.pan@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Levin, Alexander (Sasha Levin)" <alexander.levin@verizon.com>,
 Randy Dunlap <rdunlap@infradead.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Doug Berger <opendmb@gmail.com>,
 Palmer Dabbelt <palmer@sifive.com>, iommu@lists.linux-foundation.org
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <1528851463-21140-4-git-send-email-ricardo.neri-calderon@linux.intel.com>
 <20180613083419.GS12258@hirez.programming.kicks-ass.net>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <26687332-ab8f-7f6d-909a-f0918dbfea86@arm.com>
Date: Wed, 13 Jun 2018 09:59:16 +0100
MIME-Version: 1.0
In-Reply-To: <20180613083419.GS12258@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Peter, Ricardo,

On 13/06/18 09:34, Peter Zijlstra wrote:
> On Tue, Jun 12, 2018 at 05:57:23PM -0700, Ricardo Neri wrote:
>> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
>> index 5426627..dbc5e02 100644
>> --- a/include/linux/interrupt.h
>> +++ b/include/linux/interrupt.h
>> @@ -61,6 +61,8 @@
>>    *                interrupt handler after suspending interrupts. For system
>>    *                wakeup devices users need to implement wakeup detection in
>>    *                their interrupt handlers.
>> + * IRQF_DELIVER_AS_NMI - Configure interrupt to be delivered as non-maskable, if
>> + *                supported by the chip.
>>    */
> 
> NAK on the first 6 patches. You really _REALLY_ don't want to expose
> NMIs to this level.
> 

I've been working on something similar on arm64 side, and effectively 
the one thing that might be common to arm64 and intel is the interface 
to set an interrupt as NMI. So I guess it would be nice to agree on the 
right approach for this.

The way I did it was by introducing a new irq_state and let the irqchip 
driver handle most of the work (if it supports that state):

https://lkml.org/lkml/2018/5/25/181

This has not been ACKed nor NAKed. So I am just asking whether this is a 
more suitable approach, and if not, is there any suggestions on how to 
do this?

Thanks,

-- 
Julien Thierry
