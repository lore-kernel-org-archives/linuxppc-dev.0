Return-Path: <alex.bennee@linaro.org>
Received: from socrates.bennee.com
 (static.88-198-71-155.clients.your-server.de [88.198.71.155])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8376E1A01A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 00:51:35 +1000 (AEST)
References: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
 <1427814488-28467-3-git-send-email-alex.bennee@linaro.org>
 <20150413115535.GM6186@cbox>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Christoffer Dall <christoffer.dall@linaro.org>
Subject: Re: [PATCH v2 02/10] KVM: define common __KVM_GUESTDBG_USE_SW/HW_BP
 values
In-reply-to: <20150413115535.GM6186@cbox>
Date: Mon, 13 Apr 2015 15:51:33 +0100
Message-ID: <871tjokrnu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: peter.maydell@linaro.org, kvm@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 Bharat Bhushan <Bharat.Bhushan@freescale.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 kvmarm@lists.cs.columbia.edu, Nadav Amit <namit@cs.technion.ac.il>,
 "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>, agraf@suse.de,
 Gleb Natapov <gleb@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 zhichao.huang@linaro.org, jan.kiszka@siemens.com,
 Mihai Caraman <mihai.caraman@freescale.com>, bp@suse.de, drjones@redhat.com,
 marc.zyngier@arm.com, r65777@freescale.com,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 "open list:ABI/API" <linux-api@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, dahi@linux.vnet.ibm.com,
 pbonzini@redhat.com,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Christoffer Dall <christoffer.dall@linaro.org> writes:

> On Tue, Mar 31, 2015 at 04:08:00PM +0100, Alex Bennée wrote:
>> Currently x86, powerpc and soon arm64 use the same two architecture
>> specific bits for guest debug support for software and hardware
>> breakpoints. This makes the shared values explicit while leaving the
>> gate open for another architecture to use some other value if they
>> really really want to.
>> 
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> 
>> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
>> index ab4d473..1731569 100644
>> --- a/arch/powerpc/include/uapi/asm/kvm.h
>> +++ b/arch/powerpc/include/uapi/asm/kvm.h
>> @@ -310,8 +310,8 @@ struct kvm_guest_debug_arch {
>>   * and upper 16 bits are architecture specific. Architecture specific defines
>>   * that ioctl is for setting hardware breakpoint or software breakpoint.
>>   */
>> -#define KVM_GUESTDBG_USE_SW_BP		0x00010000
>> -#define KVM_GUESTDBG_USE_HW_BP		0x00020000
>> +#define KVM_GUESTDBG_USE_SW_BP		__KVM_GUESTDBG_USE_SW_BP
>> +#define KVM_GUESTDBG_USE_HW_BP		__KVM_GUESTDBG_USE_HW_BP
>>  
>>  /* definition of registers in kvm_run */
>>  struct kvm_sync_regs {
>> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
>> index d7dcef5..1438202 100644
>> --- a/arch/x86/include/uapi/asm/kvm.h
>> +++ b/arch/x86/include/uapi/asm/kvm.h
>> @@ -250,8 +250,8 @@ struct kvm_debug_exit_arch {
>>  	__u64 dr7;
>>  };
>>  
>> -#define KVM_GUESTDBG_USE_SW_BP		0x00010000
>> -#define KVM_GUESTDBG_USE_HW_BP		0x00020000
>> +#define KVM_GUESTDBG_USE_SW_BP		__KVM_GUESTDBG_USE_SW_BP
>> +#define KVM_GUESTDBG_USE_HW_BP		__KVM_GUESTDBG_USE_HW_BP
>>  #define KVM_GUESTDBG_INJECT_DB		0x00040000
>>  #define KVM_GUESTDBG_INJECT_BP		0x00080000
>>  
>> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
>> index 5eedf84..ce2db14 100644
>> --- a/include/uapi/linux/kvm.h
>> +++ b/include/uapi/linux/kvm.h
>> @@ -525,8 +525,16 @@ struct kvm_s390_irq {
>>  
>>  /* for KVM_SET_GUEST_DEBUG */
>>  
>> -#define KVM_GUESTDBG_ENABLE		0x00000001
>> -#define KVM_GUESTDBG_SINGLESTEP		0x00000002
>> +#define KVM_GUESTDBG_ENABLE		(1 << 0)
>> +#define KVM_GUESTDBG_SINGLESTEP	(1 << 1)
>> +
>> +/*
>> + * Architecture specific stuff uses the top 16 bits of the field,
>
> can you be more specific than 'stuff' here?  features?
>
>> + * however there is some shared commonality for the common cases
>
> I don't like this sentence; shared commonality is a pleonasm and the use
> of however makes it sounds like there's some caveat here.

OK I can see that - after I looked it up ;-)

> If the top 16 bits are indeed arhictecture specific, then I think they
> should just be defined in their architecture specific headers.  Unless
> the idea here is that there's a fixed set of of flags that architectures
> can choose to support, in which case it should simply be defined in the
> common header.

Well an architecture might not support some features and want to use
those bits for something else? I didn't want to force the bottom two
of the architecture specific bits to wasted if the features don't exist.

>
>
>> + */
>> +#define __KVM_GUESTDBG_USE_SW_BP	(1 << 16)
>> +#define __KVM_GUESTDBG_USE_HW_BP	(1 << 17)
>> +
>>  
>>  struct kvm_guest_debug {
>>  	__u32 control;
>> -- 
>> 2.3.4
>> 

-- 
Alex Bennée
