Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0249E1A01AE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jul 2014 23:25:38 +1000 (EST)
Message-ID: <53D64F4C.80208@suse.de>
Date: Mon, 28 Jul 2014 15:25:32 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH 1/4] KVM: PPC: BOOK3S: PR: Emulate virtual timebase
 register
References: <1401970085-14493-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1401970085-14493-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <53919B83.4070308@suse.de> <874mzyxati.fsf@linux.vnet.ibm.com>
In-Reply-To: <874mzyxati.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 06.06.14 18:27, Aneesh Kumar K.V wrote:
> Alexander Graf <agraf@suse.de> writes:
>
>> On 05.06.14 14:08, Aneesh Kumar K.V wrote:
>>> virtual time base register is a per VM, per cpu register that needs
>>> to be saved and restored on vm exit and entry. Writing to VTB is not
>>> allowed in the privileged mode.
>>>
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> For some reason BUG() doesn't always trigger the "execution stops here"
>> logic in gcc. So I've squashed this patch into yours.
>>
>>
>> Alex
>>
>>
>> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
>> index 3e7085d..99de6ad 100644
>> --- a/arch/powerpc/include/asm/reg.h
>> +++ b/arch/powerpc/include/asm/reg.h
>> @@ -1206,6 +1206,7 @@ static inline unsigned long mfvtb (void)
>>         * capture that.
>>         */
>>        BUG();
>> +    return 0;
>>    }
>>
>>    #ifdef __powerpc64__
> you can then drop the include header change. ie,
>
> #include <asm/bug.h>

Yeah, things are even worse than I thought. I've eventually squashed the 
following in. a NOP'ed mfspr() won't keep the branch from blr'ing, so 
we'd never hit the BUG() anyway.


Alex

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 1f34ef7..c8f3381 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -25,7 +25,6 @@
  #ifdef CONFIG_8xx
  #include <asm/reg_8xx.h>
  #endif /* CONFIG_8xx */
-#include <asm/bug.h>

  #define MSR_SF_LG      63              /* Enable 64 bit mode */
  #define MSR_ISF_LG     61              /* Interrupt 64b mode valid on 
630 */
@@ -1210,12 +1209,6 @@ static inline unsigned long mfvtb (void)
         if (cpu_has_feature(CPU_FTR_ARCH_207S))
                 return mfspr(SPRN_VTB);
  #endif
-       /*
-        * The above mfspr will be a no-op on anything before Power8
-        * That can result in random values returned. We need to
-        * capture that.
-        */
-       BUG();
         return 0;
  }
