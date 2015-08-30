Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E7151A028B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2015 22:50:27 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 30 Aug 2015 18:20:25 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id A85271258017
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2015 18:19:38 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7UCoN0b17825928
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2015 18:20:24 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7UCoN6F023575
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Aug 2015 18:20:23 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 07/10] kasan: Make INLINE KASan support arch selectable
In-Reply-To: <CAPAsAGyG89ABf4WqvhtDqxF18UnmMh+Kn2gFRqH3-x4guGOiVQ@mail.gmail.com>
References: <1440577578-15813-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1440577578-15813-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <CAPAsAGyG89ABf4WqvhtDqxF18UnmMh+Kn2gFRqH3-x4guGOiVQ@mail.gmail.com>
Date: Sun, 30 Aug 2015 18:20:21 +0530
Message-ID: <87613xq6sy.fsf@linux.vnet.ibm.com>
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

Andrey Ryabinin <ryabinin.a.a@gmail.com> writes:

> 2015-08-26 11:26 GMT+03:00 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
>> Some of the archs, may find it difficult to support inline KASan
>> mode. Add HAVE_ARCH_KASAN_INLINE so that we can disable inline
>> support at config time.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/x86/Kconfig       |  1 +
>>  lib/Kconfig.kasan      |  2 ++
>>  scripts/Makefile.kasan | 28 ++++++++++++++--------------
>>  3 files changed, 17 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index b3a1a5d77d92..4416f80580fb 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -78,6 +78,7 @@ config X86
>>         select HAVE_ARCH_HUGE_VMAP              if X86_64 || X86_PAE
>>         select HAVE_ARCH_JUMP_LABEL
>>         select HAVE_ARCH_KASAN                  if X86_64 && SPARSEMEM_VMEMMAP
>> +       select HAVE_ARCH_KASAN_INLINE                   if X86_64 && SPARSEMEM_VMEMMAP
>
> This will not work because config HAVE_ARCH_KASAN_INLINE is not defined.
> Instead of you can just add following in this file:
>
> config HAVE_ARCH_KASAN_INLINE
>           def_bool y
>           depends on KASAN
>

Missed cherry-pick

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index e9d1bb1175b8..5dba03bc3f01 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -1,6 +1,9 @@
 config HAVE_ARCH_KASAN
 	bool
 
+config HAVE_ARCH_KASAN_INLINE
+	bool
+
 if HAVE_ARCH_KASAN
 
 config KASAN

>
>>         select HAVE_ARCH_KGDB
>>         select HAVE_ARCH_KMEMCHECK
>>         select HAVE_ARCH_SECCOMP_FILTER
>> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
>> index 39f24d6721e5..e9d1bb1175b8 100644
>> --- a/lib/Kconfig.kasan
>> +++ b/lib/Kconfig.kasan
>> @@ -32,6 +32,7 @@ config KASAN_OUTLINE
>>           however it doesn't bloat size of kernel's .text section so
>>           much as inline does.
>>
>> +if HAVE_ARCH_KASAN_INLINE
>>  config KASAN_INLINE
>>         bool "Inline instrumentation"
>
>  depends on HAVE_ARCH_KASAN_INLINE
>
>>         help
>> @@ -40,6 +41,7 @@ config KASAN_INLINE
>>           it gives about x2 boost over outline instrumentation), but
>>           make kernel's .text size much bigger.
>>           This requires a gcc version of 5.0 or later.
>> +endif
>>
>>  endchoice
>>
>> diff --git a/scripts/Makefile.kasan b/scripts/Makefile.kasan
>> index 3f874d24234f..c1c06e9e107a 100644
>> --- a/scripts/Makefile.kasan
>> +++ b/scripts/Makefile.kasan
>> @@ -1,29 +1,29 @@
>>  ifdef CONFIG_KASAN
>> -ifdef CONFIG_KASAN_INLINE
>> -       call_threshold := 10000
>> -else
>> -       call_threshold := 0
>> -endif
>> -
>> -CFLAGS_KASAN_MINIMAL := -fsanitize=kernel-address
>>
>>  CFLAGS_KASAN := $(call cc-option, -fsanitize=kernel-address \
>> -               -fasan-shadow-offset=$(CONFIG_KASAN_SHADOW_OFFSET) \
>> -               --param asan-stack=1 --param asan-globals=1 \
>> -               --param asan-instrumentation-with-call-threshold=$(call_threshold))
>> -
>> -ifeq ($(call cc-option, $(CFLAGS_KASAN_MINIMAL) -Werror),)
>> +                   --param asan-instrumentation-with-call-threshold=0)
>> +ifeq ($(CFLAGS_KASAN),)
>>     ifneq ($(CONFIG_COMPILE_TEST),y)
>>          $(warning Cannot use CONFIG_KASAN: \
>>              -fsanitize=kernel-address is not supported by compiler)
>>     endif
>>  else
>> -    ifeq ($(CFLAGS_KASAN),)
>> +
>> +   ifdef CONFIG_KASAN_INLINE
>> +   CFLAGS_KASAN_INLINE := $(call cc-option, -fsanitize=kernel-address \
>> +                        -fasan-shadow-offset=$(CONFIG_KASAN_SHADOW_OFFSET) \
>> +                        --param asan-stack=1 --param asan-globals=1 \
>> +                        --param asan-instrumentation-with-call-threshold=10000)
>> +
>> +    ifeq ($(CFLAGS_KASAN_INLINE),)
>>          ifneq ($(CONFIG_COMPILE_TEST),y)
>>              $(warning CONFIG_KASAN: compiler does not support all options.\
>>                  Trying minimal configuration)
>>          endif
>> -        CFLAGS_KASAN := $(CFLAGS_KASAN_MINIMAL)
>> +    else
>> +        CFLAGS_KASAN := $(CFLAGS_KASAN_INLINE)
>>      endif
>> +    endif
>> +
>
> This removes stack and globals for CONFIG_KASAN_OUTLINE=y. Why?
> Those are completely separate features. So this patch shouldn't touch
> this Makefile at all.
> Depends on HAVE_ARCH_KASAN_INLINE in CONFIG_KASAN_INLINE should be enough.


Correct. I have changes that will make kasan_global and kasan_stack as
config items. I didn't add it as part of this series because I still
haven't got outline global and stack work on ppc64. Right now the split
config only applies to ppc64. Hence didn't want to make the patch more
complicated. 

>
> But you need to disable 'asan-stack' and 'asan-globals' for pcc64.
> I'd suggest to introduce CFLAGS_ARCH_KASAN.
> Define it in ppc64 Makefile:
>
> CFLAGS_ARCH_KASAN := --param asan-globals=0 --param asan-stack=0
>
> and add these flags to CFLAGS_KASAN_MINIMAL and CFLAGS_KASAN in Makefile.kasan.
>
>
>>  endif
>>  endif
>>

-aneesh
