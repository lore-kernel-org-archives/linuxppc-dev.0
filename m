Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Q3RG4ns7zDr0X
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2018 23:47:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>
Cc: linuxppc-dev@ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
 Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 1/2] powerpc: Add ppc32_allmodconfig defconfig target
In-Reply-To: <CA+7wUsz3hADry_O7MCO8pJRmWb84dbQYu8zOyEYQ01P=R8WoDA@mail.gmail.com>
References: <20180709142426.26999-1-mpe@ellerman.id.au>
 <CA+7wUsz3hADry_O7MCO8pJRmWb84dbQYu8zOyEYQ01P=R8WoDA@mail.gmail.com>
Date: Tue, 10 Jul 2018 23:47:20 +1000
Message-ID: <874lh7b3tj.fsf@concordia.ellerman.id.au>
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

Mathieu Malaterre <malat@debian.org> writes:
> On Mon, Jul 9, 2018 at 4:24 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Because the allmodconfig logic just sets every symbol to M or Y, it
>> has the effect of always generating a 64-bit config, because
>> CONFIG_PPC64 becomes Y.
>>
>> So to make it easier for folks to test 32-bit code, provide a phony
>> defconfig target that generates a 32-bit allmodconfig.
>>
>> The 32-bit port has several mutually exclusive CPU types, we choose
>> the Book3S variants as that's what the help text in Kconfig says is
>> most common.
>
> Ok then.

That was just me taking a stab in the dark. You suggested we should
mimic the Debian config, what does that use?

>> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
>> index 2ea575cb3401..2556c2182789 100644
>> --- a/arch/powerpc/Makefile
>> +++ b/arch/powerpc/Makefile
>> @@ -354,6 +354,11 @@ mpc86xx_smp_defconfig:
>>         $(call merge_into_defconfig,mpc86xx_basic_defconfig,\
>>                 86xx-smp 86xx-hw fsl-emb-nonhw)
>>
>> +PHONY += ppc32_allmodconfig
>> +ppc32_allmodconfig:
>> +       $(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/book3s_32.config \
>> +               -f $(srctree)/Makefile allmodconfig
>> +
>
> I this a good time to update line 34 at the same time:
>
> KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
>
> ?

34 or 36?

  ifeq ($(CROSS_COMPILE),)
  KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
  else
  KBUILD_DEFCONFIG := ppc64_defconfig
  endif

Do you mean the else case?

cheers
