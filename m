Return-Path: <julien.thierry@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 415NDl70zNzDr9J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 20:25:25 +1000 (AEST)
Subject: Re: [RFC PATCH 03/23] genirq: Introduce IRQF_DELIVER_AS_NMI
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
 "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Jacob Pan <jacob.jun.pan@intel.com>,
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
 <26687332-ab8f-7f6d-909a-f0918dbfea86@arm.com>
 <alpine.DEB.2.21.1806131104570.2280@nanos.tec.linutronix.de>
 <344b838e-81e3-97d8-f90d-315fed7879c1@arm.com>
 <alpine.DEB.2.21.1806131149410.2280@nanos.tec.linutronix.de>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <5c52d916-e405-e689-8fa1-d2dfb28ab3fd@arm.com>
Date: Wed, 13 Jun 2018 11:25:18 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1806131149410.2280@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 13/06/18 10:57, Thomas Gleixner wrote:
> On Wed, 13 Jun 2018, Julien Thierry wrote:
>> On 13/06/18 10:20, Thomas Gleixner wrote:
>>> Adding NMI delivery support at low level architecture irq chip level is
>>> perfectly fine, but the exposure of that needs to be restricted very
>>> much. Adding it to the generic interrupt control interfaces is not going to
>>> happen. That's doomed to begin with and a complete abuse of the interface
>>> as the handler can not ever be used for that.
>>>
>>
>> Understood, however the need would be to provide a way for a driver to request
>> an interrupt to be delivered as an NMI (if irqchip supports it).
> 
> s/driver/specialized code written by people who know what they are doing/
> 
>> But from your response this would be out of the question (in the
>> interrupt/irq/irqchip definitions).
> 
> Adding some magic to the irq chip is fine, because that's where the low
> level integration needs to be done, but exposing it through the generic
> interrupt subsystem is a NONO for obvious reasons.
> 
>> Or somehow the concerned irqchip informs the arch it supports NMI delivery and
>> it is up to the interested drivers to query the arch whether NMI delivery is
>> supported by the system?
> 
> Yes, we need some infrastructure for that, but that needs to be separate
> and with very limited exposure.
> 

Right, makes sense. I'll check with Marc how such an infrastructure 
should be introduced.

Thanks,

-- 
Julien Thierry
