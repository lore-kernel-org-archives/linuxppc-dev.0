Return-Path: <sudeep.holla@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 38F621A084B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2015 04:35:49 +1100 (AEDT)
Subject: Re: [PATCH 04/17] powerpc: mpic: use IRQCHIP_SKIP_SET_WAKE instead of
 redundant mpic_irq_set_wake
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-5-git-send-email-sudeep.holla@arm.com>
 <1442981170.19102.322.camel@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, Sudeep Holla
 <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Hongtao Jia <hongtao.jia@freescale.com>, Marc Zyngier
 <Marc.Zyngier@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Wang Dongsheng-B40534 <Dongsheng.Wang@freescale.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Message-ID: <562529EF.7050404@arm.com>
Date: Mon, 19 Oct 2015 18:35:43 +0100
MIME-Version: 1.0
In-Reply-To: <1442981170.19102.322.camel@freescale.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

On 23/09/15 05:06, Scott Wood wrote:
> On Mon, 2015-09-21 at 16:47 +0100, Sudeep Holla wrote:
>> mpic_irq_set_wake return -ENXIO for non FSL MPIC and sets IRQF_NO_SUSPEND
>> flag for FSL ones. enable_irq_wake already returns -ENXIO if irq_set_wak
>> is not implemented. Also there's no need to set the IRQF_NO_SUSPEND flag
>> as it doesn't guarantee wakeup for that interrupt.
>>
>> This patch removes the redundant mpic_irq_set_wake and sets the
>> IRQCHIP_SKIP_SET_WAKE for only FSL MPIC.
>>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Scott Wood <scottwood@freescale.com>
>> Cc: Hongtao Jia <hongtao.jia@freescale.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   arch/powerpc/sysdev/mpic.c | 23 ++++-------------------
>>   1 file changed, 4 insertions(+), 19 deletions(-)
>
> Acked-by: Scott Wood <scottwood@freescale.com>
>

Can you pick this up via your tree ?

-- 
Regards,
Sudeep
