Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DxZS2TfDzDrDD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 18:52:16 +1000 (AEST)
Subject: Re: [PATCH v4] powerpc: Avoid code patching freed init sections
To: Nicholas Piggin <npiggin@gmail.com>, Michael Neuling <mikey@neuling.org>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 Haren Myneni <haren@linux.vnet.ibm.com>, =?UTF-8?Q?Michal_Such=c3=a1nek?=
 <msuchanek@suse.de>
References: <20180914011411.3184-1-mikey@neuling.org>
 <20180914142201.379b14a4@roar.ozlabs.ibm.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <2d775c16-9dc9-efa4-f3fb-6a0f16297a3a@c-s.fr>
Date: Tue, 18 Sep 2018 10:52:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180914142201.379b14a4@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 14/09/2018 à 06:22, Nicholas Piggin a écrit :
> On Fri, 14 Sep 2018 11:14:11 +1000
> Michael Neuling <mikey@neuling.org> wrote:
> 
>> This stops us from doing code patching in init sections after they've
>> been freed.
>>
>> In this chain:
>>    kvm_guest_init() ->
>>      kvm_use_magic_page() ->
>>        fault_in_pages_readable() ->
>> 	 __get_user() ->
>> 	   __get_user_nocheck() ->
>> 	     barrier_nospec();
>>
>> We have a code patching location at barrier_nospec() and
>> kvm_guest_init() is an init function. This whole chain gets inlined,
>> so when we free the init section (hence kvm_guest_init()), this code
>> goes away and hence should no longer be patched.
>>
>> We seen this as userspace memory corruption when using a memory
>> checker while doing partition migration testing on powervm (this
>> starts the code patching post migration via
>> /sys/kernel/mobility/migration). In theory, it could also happen when
>> using /sys/kernel/debug/powerpc/barrier_nospec.
>>
>> cc: stable@vger.kernel.org # 4.13+
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>>
>> ---
>> For stable I've marked this as v4.13+ since that's when we refactored
>> code-patching.c but it could go back even further than that. In
>> reality though, I think we can only hit this since the first
>> spectre/meltdown changes.
>>
>> v4:
>>   Feedback from Christophe Leroy:
>>     - init_mem_free -> init_mem_is_free
>>     - prlog %lx -> %px
>>
>> v3:
>>   Add init_mem_free flag to avoid potential race.
>>   Feedback from Christophe Leroy:
>>     - use init_section_contains()
>>     - change order of init test for performance
>>     - use pr_debug()
>>     - remove blank line
>>
>> v2:
>>    Print when we skip an address
>> ---
>>   arch/powerpc/include/asm/setup.h | 1 +
>>   arch/powerpc/lib/code-patching.c | 6 ++++++
>>   arch/powerpc/mm/mem.c            | 2 ++
>>   3 files changed, 9 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
>> index 1a951b0046..1fffbba8d6 100644
>> --- a/arch/powerpc/include/asm/setup.h
>> +++ b/arch/powerpc/include/asm/setup.h
>> @@ -9,6 +9,7 @@ extern void ppc_printk_progress(char *s, unsigned short hex);
>>   
>>   extern unsigned int rtas_data;
>>   extern unsigned long long memory_limit;
>> +extern bool init_mem_is_free;
>>   extern unsigned long klimit;
>>   extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
>>   
>> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
>> index 850f3b8f4d..6ae2777c22 100644
>> --- a/arch/powerpc/lib/code-patching.c
>> +++ b/arch/powerpc/lib/code-patching.c
>> @@ -28,6 +28,12 @@ static int __patch_instruction(unsigned int *exec_addr, unsigned int instr,
>>   {
>>   	int err;
>>   
>> +	/* Make sure we aren't patching a freed init section */
>> +	if (init_mem_is_free && init_section_contains(exec_addr, 4)) {
>> +		pr_debug("Skipping init section patching addr: 0x%px\n", exec_addr);
>> +		return 0;
>> +	}
> 
> What we should do is a whitelist, make sure it's only patching the
> sections we want it to.
> 
> That's a bigger job when you consider modules and things too though,
> so this looks good for now. Thanks,

What about using kernel_text_address() for it then ? It also handles 
modules, is it more complicated than that ?

Christophe
