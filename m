Return-Path: <jwboyer@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2077AB70EB
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Feb 2011 06:32:09 +1100 (EST)
Received: by wyi11 with SMTP id 11so5809050wyi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Jan 2011 11:32:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTimnKthzUg79qQcEF4K6dkyuYwE22Hzp-U=yZmK9@mail.gmail.com>
References: <20110131191109.5727.87742.sendpatchset@squad5-lp1.lab.bos.redhat.com>
	<AANLkTimnKthzUg79qQcEF4K6dkyuYwE22Hzp-U=yZmK9@mail.gmail.com>
Date: Mon, 31 Jan 2011 14:32:03 -0500
Message-ID: <AANLkTikTFPtOpY14Tb-qxEEpM4YkOUyDOHbKNsDNK4oE@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mm: add devmem_is_allowed() for STRICT_DEVMEM
	checking
From: Josh Boyer <jwboyer@gmail.com>
To: Steve Best <sfbest@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 31, 2011 at 2:25 PM, Josh Boyer <jwboyer@gmail.com> wrote:
> On Mon, Jan 31, 2011 at 2:16 PM, Steve Best <sfbest@us.ibm.com> wrote:
>> =A0 =A0Provide devmem_is_allowed() routine to restrict access to kernel
>> =A0 =A0memory from userspace.
>> =A0 =A0Set CONFIG_STRICT_DEVMEM config option to switch on checking.
>>
>> Signed-off-by: Steve Best <sfbest@us.ibm.com>
>>
>> diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
>> index 2d38a50..6805d5d 100644
>> --- a/arch/powerpc/Kconfig.debug
>> +++ b/arch/powerpc/Kconfig.debug
>> @@ -299,4 +299,16 @@ config PPC_EARLY_DEBUG_CPM_ADDR
>> =A0 =A0 =A0 =A0 =A0platform probing is done, all platforms selected must
>> =A0 =A0 =A0 =A0 =A0share the same address.
>>
>> +config STRICT_DEVMEM
>> + =A0 =A0 =A0 =A0def_bool y
>> + =A0 =A0 =A0 =A0prompt "Filter access to /dev/mem"
>> + =A0 =A0 =A0 =A0---help---
>> + =A0 =A0 =A0 =A0 =A0This option restricts access to /dev/mem. =A0If thi=
s option is
>> + =A0 =A0 =A0 =A0 =A0disabled, you allow userspace access to all memory,=
 including
>> + =A0 =A0 =A0 =A0 =A0kernel and userspace memory. Accidental memory acce=
ss is likely
>> + =A0 =A0 =A0 =A0 =A0to be disastrous.
>> + =A0 =A0 =A0 =A0 =A0Memory access is required for experts who want to d=
ebug the kernel.
>> +
>> + =A0 =A0 =A0 =A0 =A0If you are unsure, say Y.
>> +
>> =A0endmenu
>> diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/=
page.h
>> index 53b64be..f225032 100644
>> --- a/arch/powerpc/include/asm/page.h
>> +++ b/arch/powerpc/include/asm/page.h
>> @@ -262,6 +262,11 @@ extern void copy_user_page(void *to, void *from, un=
signed long vaddr,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct page *p);
>> =A0extern int page_is_ram(unsigned long pfn);
>>
>> +static inline int devmem_is_allowed(unsigned long pfn)
>> +{
>> + =A0 =A0 =A0 =A0return 0;
>> +}
>> +
>
> Er, should this be toggled via CONFIG_STRICT_DEVMEM somehow? =A0Or I
> guess I'm missing why the config option had to be added if not.

Nevermind.  I see that it's done in the drivers/char/mem.c file.
Should have looked more first.

josh
