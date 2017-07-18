Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBcGg5PDTzDqlC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 20:44:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@ozlabs.org
Cc: abdhalee@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/powernv: Fix boot on Power8 bare metal due to
 opal_configure_cores()
In-Reply-To: <1500292365.8256.15.camel@gmail.com>
References: <1500291060-8133-1-git-send-email-mpe@ellerman.id.au>
 <1500292365.8256.15.camel@gmail.com>
Date: Tue, 18 Jul 2017 20:44:10 +1000
Message-ID: <87shhuhvnp.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:

> On Mon, 2017-07-17 at 21:31 +1000, Michael Ellerman wrote:
>> In commit 1c0eaf0f56d6 ("powerpc/powernv: Tell OPAL about our MMU mode
>> on POWER9"), we added additional flags to the OPAL call to configure
>> CPUs at boot.
>> 
>> These flags only work on Power9 firmwares, and worse can cause boot
>> failures on Power8 machines, so we check for CPU_FTR_ARCH_300 (aka POWER9)
>> before adding the extra flags.
>> 
>> Unfortunately we forgot that opal_configure_cores() is called before
>> the CPU feature checks are dynamically patched, meaning the check
>> always returns true.
>> 
>> We definitely need to do something to make the CPU feature checks less
>> prone to bugs like this, but for now the minimal fix is to use
>> early_cpu_has_feature().
>> 
>> Reported-and-tested-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
>> Fixes: 1c0eaf0f56d6 ("powerpc/powernv: Tell OPAL about our MMU mode on POWER9")
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>  arch/powerpc/platforms/powernv/opal.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
>> index 9b87abb178f0..cad6b57ce494 100644
>> --- a/arch/powerpc/platforms/powernv/opal.c
>> +++ b/arch/powerpc/platforms/powernv/opal.c
>> @@ -78,7 +78,7 @@ void opal_configure_cores(void)
>>  	 *  ie. Host hash  supports  hash guests
>>  	 *      Host radix supports  hash/radix guests
>>  	 */
>> -	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
>> +	if (early_cpu_has_feature(CPU_FTR_ARCH_300)) {
>>  		reinit_flags |= OPAL_REINIT_CPUS_MMU_HASH;
>>  		if (early_radix_enabled())
>>  			reinit_flags |= OPAL_REINIT_CPUS_MMU_RADIX;
>
> We do have CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG,

We do, but in this case that actually hid the bug. I have that enabled,
which means instead of breaking the boot, it just prints a warning and continues.

And because it's not a real oops my CI scripts didn't detect it as a
failure >:E

> but I am not sure if there is an efficient way to enable it till we
> actually get the key enabled. I wonder if a branch hint will help, but
> I still feel its expensive.

No there doesn't seem to be. The obvious option of using a jump label to
avoid the "is it initialised yet" check produces terrible code like:

  +------+ c0000000000f55b4  480000d4      b       c0000000000f5688        # copy_process.isra.5.part.6+0x18a8/0x1960
  |        c0000000000f55b8  39200000      li      r9,0
  |        c0000000000f55bc  69290001      xori    r9,r9,1    <----------+
  |        c0000000000f55c0  2fa90000      cmpdi   cr7,r9,0              |
  |   +--+ c0000000000f55c4  419e0010      beq     cr7,c0000000000f55d4  | # copy_process.isra.5.part.6+0x17f4/0x1960
  |   |    c0000000000f55c8  7ec3b378      mr      r3,r22                |
  |   |    c0000000000f55cc  4bf82bed      bl      c0000000000781b8      | # radix__flush_tlb_mm+0x8/0x390
  |   |    c0000000000f55d0  60000000      nop                           |
  |   +--> c0000000000f55d4  e8610070      ld      r3,112(r1)            |
  |        c0000000000f55d8  48077c61      bl      c00000000016d238      | # up_write+0x8/0xa0
  |        ....                                                          |
  +------> c0000000000f5688  39200001      li      r9,1                  |
	   c0000000000f568c  4bffff30      b       c0000000000f55bc  +---+ # copy_process.isra.5.part.6+0x17dc/0x1960


cheers
