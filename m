Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 424C4B6F9D
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Feb 2012 13:52:22 +1100 (EST)
Message-ID: <4F445845.8030606@windriver.com>
Date: Wed, 22 Feb 2012 10:51:49 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Liu Yu-B13201 <B13201@freescale.com>
Subject: Re: [PATCH v5 3/4] KVM: PPC: epapr: install ev_idle hcall for e500
 guest
References: <1329799573-8820-1-git-send-email-yu.liu@freescale.com>
 <1329799573-8820-2-git-send-email-yu.liu@freescale.com>
 <1329799573-8820-3-git-send-email-yu.liu@freescale.com>
 <4F4377AD.4000501@windriver.com>
 <4CA99838F21AB847ACC344051E23170905749AB6@039-SN2MPN1-022.039d.mgd.msft.net>
In-Reply-To: <4CA99838F21AB847ACC344051E23170905749AB6@039-SN2MPN1-022.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Wood Scott-B07421 <B07421@freescale.com>, "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Liu Yu-B13201 wrote:
> 
>> -----Original Message-----
>> From: tiejun.chen [mailto:tiejun.chen@windriver.com]
>> Sent: Tuesday, February 21, 2012 6:54 PM
>> To: Liu Yu-B13201
>> Cc: agraf@suse.de; kvm-ppc@vger.kernel.org; kvm@vger.kernel.org;
>> linuxppc-dev@ozlabs.org; Wood Scott-B07421
>> Subject: Re: [PATCH v5 3/4] KVM: PPC: epapr: install ev_idle hcall for
>> e500 guest
>>
>> Liu Yu wrote:
>>> If the guest hypervisor node contains "has-idle" property.
>>>
>>> Signed-off-by: Liu Yu <yu.liu@freescale.com>
>>> ---
>>> v5: no change
>>>
>>>  arch/powerpc/kernel/epapr_hcalls.S   |   29
>> +++++++++++++++++++++++++++++
>>>  arch/powerpc/kernel/epapr_paravirt.c |   11 ++++++++++-
>>>  2 files changed, 39 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/epapr_hcalls.S
>>> b/arch/powerpc/kernel/epapr_hcalls.S
>>> index 697b390..72fa234 100644
>>> --- a/arch/powerpc/kernel/epapr_hcalls.S
>>> +++ b/arch/powerpc/kernel/epapr_hcalls.S
>>> @@ -15,6 +15,35 @@
>>>  #include <asm/ppc_asm.h>
>>>  #include <asm/asm-offsets.h>
>>>
>>> +#define HC_VENDOR_EPAPR		(1 << 16)
>>> +#define HC_EV_IDLE		16
>> Why not use 'EV_IDLE' directly?
>>
>>> +
>>> +_GLOBAL(epapr_ev_idle)
>>> +epapr_ev_idle:
>>> +	rlwinm	r3,r1,0,0,31-THREAD_SHIFT	/* current thread_info */
>>> +	lwz	r4,TI_LOCAL_FLAGS(r3)	/* set napping bit */
>>> +	ori	r4,r4,_TLF_NAPPING	/* so when we take an exception */
>>> +	stw	r4,TI_LOCAL_FLAGS(r3)	/* it will return to our caller */
>>> +
>>> +	wrteei	1
>>> +
>>> +idle_loop:
>>> +	LOAD_REG_IMMEDIATE(r11, HC_VENDOR_EPAPR | HC_EV_IDLE)
>> And could this line be simplified as something like this:
>>
>> LOAD_REG_IMMEDIATE(r11, EV_HCALL_TOKEN(EV_IDLE))
>>
>> If so, even we can remove the previous HC_VENDOR_EPAPR definition as well.
>>
> 
> Because the epapr_hcalls.h contains C functions,
> so it cannot be included by assembly code.

These common definitions are already covered in epapr_hcalls.h, but looks you
redefine the same items many times, in kvm_para.h/epapr_hcalls.S. And I think
maybe we'll also reuse these generics elsewhere lately.

So can we limit that with __ASSEMBLY__ in epapr_hcalls.h? Or other way. If so it
makes our life easy in the future.

Tiejun
