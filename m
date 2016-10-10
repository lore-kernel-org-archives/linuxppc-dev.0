Return-Path: <dja@axtens.net>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ssl6Q5DhDzDrL1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 13:52:46 +1100 (AEDT)
Received: by mail-pa0-x242.google.com with SMTP id rw4so1387047pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Oct 2016 19:52:46 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: PPC: sparse: prototypes for functions called
 from assembler
In-Reply-To: <20161010023415.GA18173@fergus.ozlabs.ibm.com>
References: <1476059480-18145-1-git-send-email-dja@axtens.net>
 <1476059480-18145-2-git-send-email-dja@axtens.net>
 <20161010023415.GA18173@fergus.ozlabs.ibm.com>
Date: Mon, 10 Oct 2016 13:52:41 +1100
Message-ID: <87a8ecykxy.fsf@possimpible.ozlabs.ibm.com>
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

Paul Mackerras <paulus@ozlabs.org> writes:

> On Mon, Oct 10, 2016 at 11:31:20AM +1100, Daniel Axtens wrote:
>> A bunch of KVM functions are only called from assembler.
>> Give them prototypes in asm-prototypes.h
>> This reduces sparse warnings.
>> 
>> Signed-off-by: Daniel Axtens <dja@axtens.net>
>> ---
>>  arch/powerpc/include/asm/asm-prototypes.h | 44 +++++++++++++++++++++++++++++++
>>  arch/powerpc/kvm/book3s_64_vio_hv.c       |  1 +
>>  arch/powerpc/kvm/book3s_hv_builtin.c      |  1 +
>>  arch/powerpc/kvm/book3s_hv_ras.c          |  1 +
>>  arch/powerpc/kvm/book3s_hv_rm_mmu.c       |  1 +
>>  arch/powerpc/kvm/book3s_hv_rm_xics.c      |  1 +
>>  6 files changed, 49 insertions(+)
>> 
>> diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
>> index d1492736d852..6c853bcd11fa 100644
>> --- a/arch/powerpc/include/asm/asm-prototypes.h
>> +++ b/arch/powerpc/include/asm/asm-prototypes.h
>> @@ -14,6 +14,9 @@
>>  
>>  #include <linux/threads.h>
>>  #include <linux/kprobes.h>
>> +#ifdef CONFIG_KVM
>> +#include <linux/kvm_host.h>
>> +#endif
>>  
>>  #include <uapi/asm/ucontext.h>
>>  
>> @@ -109,4 +112,45 @@ void early_setup_secondary(void);
>>  /* time */
>>  void accumulate_stolen_time(void);
>>  
>> +/* kvm */
>> +#ifdef CONFIG_KVM
>
> Why do we need this ifdef?  Does the compilation break without it when
> CONFIG_KVM = n?

Yes it does - the 0day build bot picked it up when I did v1 without the
ifdef.

See: https://lists.01.org/pipermail/kbuild-all/2016-September/024742.html

For example:

   arch/powerpc/include/asm/asm-prototypes.h:82:7: error: 'struct kvm_vcpu' declared inside parameter list [-Werror]
          unsigned long tce_list, unsigned long npages);
          ^
   arch/powerpc/include/asm/asm-prototypes.h:85:7: error: 'struct kvm_vcpu' declared inside parameter list [-Werror]
          unsigned long tce_value, unsigned long npages);
          ^
   arch/powerpc/include/asm/asm-prototypes.h:87:29: error: 'struct kvm_vcpu' declared inside parameter list [-Werror]
                                unsigned int yield_count);
                                ^
   arch/powerpc/include/asm/asm-prototypes.h:88:29: error: 'struct kvm_vcpu' declared inside parameter list [-Werror]
    long kvmppc_h_random(struct kvm_vcpu *vcpu);


Regards,
Daniel
