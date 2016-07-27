Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s01cs4vv0zDrMY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 03:07:09 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id h186so2129448pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 10:07:09 -0700 (PDT)
Subject: Re: [v3] UCC_GETH/UCC_FAST: Use IS_ERR_VALUE_U32 API to avoid
 IS_ERR_VALUE abuses.
To: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org
References: <1469297151-9763-1-git-send-email-arvind.yadav.cs@gmail.com>
 <4175803.I7CDUloLxQ@wuerfel>
Cc: zajec5@gmail.com, leoli@freescale.com, qiang.zhao@freescale.com,
 viresh.kumar@linaro.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, scottwood@freescale.com, akpm@linux-foundation.org,
 linux@roeck-us.net
From: arvind Yadav <arvind.yadav.cs@gmail.com>
Message-ID: <5798EA36.70000@gmail.com>
Date: Wed, 27 Jul 2016 22:37:02 +0530
MIME-Version: 1.0
In-Reply-To: <4175803.I7CDUloLxQ@wuerfel>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I am also agree with Arnd Bergmann. We should use 'static inline function'
instead of macro to deal with error check.

On Tuesday 26 July 2016 05:09 PM, Arnd Bergmann wrote:
> On Saturday, July 23, 2016 11:35:51 PM CEST Arvind Yadav wrote:
>> diff --git a/include/linux/err.h b/include/linux/err.h
>> index 1e35588..a42f942 100644
>> --- a/include/linux/err.h
>> +++ b/include/linux/err.h
>> @@ -19,6 +19,7 @@
>>   #ifndef __ASSEMBLY__
>>   
>>   #define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
>> +#define IS_ERR_VALUE_U32(x) unlikely((unsigned int)(x) >= (unsigned int)-MAX_ERRNO)
>>   
>>   static inline void * __must_check ERR_PTR(long error)
>>   {
> This doesn't really look like something we want to have as a generic
> interface. The IS_ERR_VALUE() API is rather awkward already, and your
> use seems specific to the cpu_muram_alloc() function.
>
> How about something like
>
> int cpm_muram_error(unsigned long addr)
> {
> 	if (addr >= (unsigned long)-MAX_ERRNO)
> 		return addr;
> 	else
> 		return 0;
> }
>
> and then use that to check the value returned by the allocation
> that is still an 'unsigned long', before assigning it to a 'u32'.
>
> 	Arnd
