Return-Path: <jan.kiszka@siemens.com>
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F1A3A1A0015
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2015 04:26:23 +1000 (AEST)
Message-ID: <555630E0.8060305@siemens.com>
Date: Fri, 15 May 2015 19:46:08 +0200
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
To: David Hildenbrand <dahi@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 02/12] KVM: define common KVM_GUESTDBG_USE_SW/HW_BP bits
References: <1431700035-23479-1-git-send-email-alex.bennee@linaro.org>	<1431700035-23479-3-git-send-email-alex.bennee@linaro.org>	<555613F2.9060204@de.ibm.com>
 <20150515193315.6d3e82d2@thinkpad-w530>
In-Reply-To: <20150515193315.6d3e82d2@thinkpad-w530>
Content-Type: text/plain; charset=utf-8
Cc: peter.maydell@linaro.org, Tony Krowiak <akrowiak@linux.vnet.ibm.com>,
 kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Bharat Bhushan <Bharat.Bhushan@freescale.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 kvmarm@lists.cs.columbia.edu, S390 <linux-s390@vger.kernel.org>,
 Michael Mueller <mimu@linux.vnet.ibm.com>,
 Nadav Amit <namit@cs.technion.ac.il>,
 "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>, agraf@suse.de,
 Gleb Natapov <gleb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 zhichao.huang@linaro.org, r65777@freescale.com,
 Mihai Caraman <mihai.caraman@freescale.com>, bp@suse.de, drjones@redhat.com,
 "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, marc.zyngier@arm.com,
 pbonzini@redhat.com, Cornelia Huck <cornelia.huck@de.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Eric Farman <farman@linux.vnet.ibm.com>, ABI/API <linux-api@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Dominik Dingel <dingel@linux.vnet.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, S390 <linux390@de.ibm.com>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>,
 christoffer.dall@linaro.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015-05-15 19:33, David Hildenbrand wrote:
>> Am 15.05.2015 um 16:27 schrieb Alex Bennée:
>>> +++ b/arch/s390/include/uapi/asm/kvm.h
>>> @@ -114,8 +114,6 @@ struct kvm_fpu {
>>>  	__u64 fprs[16];
>>>  };
>>>
>>> -#define KVM_GUESTDBG_USE_HW_BP		0x00010000
>> [...]
>>> +++ b/include/uapi/linux/kvm.h
>> [...]
>>> +#define KVM_GUESTDBG_USE_SW_BP		(1 << 16)
>>> +#define KVM_GUESTDBG_USE_HW_BP		(1 << 17)
>>
>> This is an ABI break for s390, no?
>>
>> David, do you remember why we do not use KVM_GUESTDBG_USE_SW_BP?
>>
> 
> We never had to tell the kernel about software breakpoints as this is all
> handled via 4 byte DIAG instructions until now. We don't have to turn this
> mechanism on. QEMU can directly insert the desired DIAG instructions and gets
> notified when they are about to get executed.
> 
> (But we still have 2 byte breakpoint support todo - still tbd how exactly this
> will be realized - could be turned on via such a mechanism)
> 
> The problem is, that these bits are arch specific, now Alex wants to unify
> them for all archs.
> 
> So yes, this is an ABI break for us and breaks hardware breakpoints.(I think
> the first version of this patch didn't contain this ABI break when I had a look)
> 
> I wonder if it wouldn't make more sense to
> 
> - introduce new bits in the arch-unspecific section
> - rework the existing implementers to accept both bits
> 
> Or to simply leave stuff as it is and handle it via arch specific bits.

With one arch proving the "all need this" theory wrong, just drop this
patch. Even quicker when it breaks an ABI.

Jan

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux
