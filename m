Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com", Issuer "Thawte SGC CA - G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 170672C008C
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Nov 2013 23:15:37 +1100 (EST)
Message-ID: <528DCB61.8040807@windriver.com>
Date: Thu, 21 Nov 2013 16:59:13 +0800
From: =?UTF-8?B?IuKAnHRpZWp1bi5jaGVu4oCdIg==?= <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC][PATCH] powerpc/CoreNet64: compile with CONFIG_E{5, 6}500_CPU
 well
References: <1384936551-8494-1-git-send-email-tiejun.chen@windriver.com>
 <1384965671.1403.414.camel@snotra.buserror.net>
In-Reply-To: <1384965671.1403.414.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/21/2013 12:41 AM, Scott Wood wrote:
> On Wed, 2013-11-20 at 16:35 +0800, Tiejun Chen wrote:
>> CONFIG_ALTIVEC is always enabled for CoreNet64.
>
> In the defconfig perhaps, but this isn't a generally true statement.
>

Yes, but I think we should avoid this probable scenario :)

>> And if we select CONFIG_E{5,6}500_CPU this may introduce -mcpu=e500mc64
>> into $CFLAGS. But Altivec and Spe options not allowed with
>> e500mc64, so :
>
> Sigh.
>
>>    CC      arch/powerpc/lib/xor_vmx.o
>> arch/powerpc/lib/xor_vmx.c:1:0: error: AltiVec not supported in this target
>> make[1]: *** [arch/powerpc/lib/xor_vmx.o] Error 1
>> make: *** [arch/powerpc/lib] Error 2
>>
>> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
>> ---
>>   arch/powerpc/lib/Makefile |    3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
>> index 95a20e1..641a77d 100644
>> --- a/arch/powerpc/lib/Makefile
>> +++ b/arch/powerpc/lib/Makefile
>> @@ -40,5 +40,8 @@ obj-y			+= code-patching.o
>>   obj-y			+= feature-fixups.o
>>   obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
>>
>> +# Altivec and Spe options not allowed with e500mc64 in GCC.
>> +ifeq ($(call cc-option-yn,-mcpu=e500mc64),n)
>>   obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o
>>   CFLAGS_xor_vmx.o += -maltivec -mabi=altivec
>> +endif
>
> This does not seem like the right fix.  What if GCC supports both
> -mcpu=e500mc64 and -mcpu=e6500, and we're using the latter?  Or for that

I can understand what you mean, but in current kernel, -mcpu=e500mc64 should be 
excluded from -mcpu=e6500,

arch/powerpc/Makefile:

E5500_CPU := $(call cc-option,-mcpu=e500mc64,-mcpu=powerpc64)
CFLAGS-$(CONFIG_E5500_CPU) += $(E5500_CPU)
CFLAGS-$(CONFIG_E6500_CPU) += $(call cc-option,-mcpu=e6500,$(E5500_CPU))

But unfortunately, another place also use the same option,

lib/raid6/Makefile:

raid6_pq-$(CONFIG_ALTIVEC) += altivec1.o altivec2.o altivec4.o altivec8.o
...
ifeq ($(CONFIG_ALTIVEC),y)
altivec_flags := -maltivec -mabi=altivec
endif

Looks we have to do something in this common Makefile file as well, but it may 
be a bit ugly if still judge some cpu-specific flags...

So what about this version?

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 607acf5..872a85c 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -127,7 +127,12 @@ CFLAGS-$(CONFIG_POWER5_CPU) += $(call cc-option,-mcpu=power5)
  CFLAGS-$(CONFIG_POWER6_CPU) += $(call cc-option,-mcpu=power6)
  CFLAGS-$(CONFIG_POWER7_CPU) += $(call cc-option,-mcpu=power7)

+# Altivec and Spe options not allowed with e500mc64 in GCC.
+ifeq ($(CONFIG_ALTIVEC),)
  E5500_CPU := $(call cc-option,-mcpu=e500mc64,-mcpu=powerpc64)
+else
+E5500_CPU := -mcpu=powerpc64
+endif
  CFLAGS-$(CONFIG_E5500_CPU) += $(E5500_CPU)
  CFLAGS-$(CONFIG_E6500_CPU) += $(call cc-option,-mcpu=e6500,$(E5500_CPU))

Tiejun

> matter, if we're using -mcpu=whatever-ibm-chip-has-this?
>
> Plus, wouldn't you need to do something to prevent code in that file
> from being called?
>
> -Scott
>
>
>
>
