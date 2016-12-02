Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x243.google.com (mail-ua0-x243.google.com
 [IPv6:2607:f8b0:400c:c08::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tVLbk0kvLzDvqs
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 15:22:42 +1100 (AEDT)
Received: by mail-ua0-x243.google.com with SMTP id b35so23429074uaa.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Dec 2016 20:22:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <874m2n7yrf.fsf@concordia.ellerman.id.au>
References: <1479704219-21403-1-git-send-email-yanjiang.jin@windriver.com>
 <874m2n7yrf.fsf@concordia.ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Date: Fri, 2 Dec 2016 15:22:39 +1100
Message-ID: <CAKTCnzkY_g8Z61K_rQetLGbcGdJ-VUV79MEBkZej=yCM3=KJkw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: cputime: fix a compile warning
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: yanjiang.jin@windriver.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, oss@buserror.net,
 jinyanjiang@gmail.com, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 2, 2016 at 3:15 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> yanjiang.jin@windriver.com writes:
>
>> diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
>> index 4f60db0..4423e97 100644
>> --- a/arch/powerpc/include/asm/cputime.h
>> +++ b/arch/powerpc/include/asm/cputime.h
>> @@ -228,7 +228,8 @@ static inline cputime_t clock_t_to_cputime(const unsigned long clk)
>>       return (__force cputime_t) ct;
>>  }
>>
>> -#define cputime64_to_clock_t(ct)     cputime_to_clock_t((cputime_t)(ct))
>> +#define cputime64_to_clock_t(ct)     \
>> +     (__force u64)(cputime_to_clock_t((cputime_t)(ct)))
>
> Given the name of the function is "cputime64 to clock_t", surely we
> should be returning a clock_t ?

Please fix it in cpuacct.c  Also check out git commit
527b0a76f41d062381adbb55c8eb61e32cb0bfc9
sched/cpuacct: Avoid %lld seq_printf warning

Balbir
