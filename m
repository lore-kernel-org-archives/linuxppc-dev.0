Return-Path: <Yanjiang.Jin@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tVLvF39mpzDvs3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2016 15:36:09 +1100 (AEDT)
Message-ID: <5840FA25.3010009@windriver.com>
Date: Fri, 2 Dec 2016 12:35:49 +0800
From: yjin <yanjiang.jin@windriver.com>
MIME-Version: 1.0
To: Balbir Singh <bsingharora@gmail.com>
CC: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, <oss@buserror.net>,
 <jinyanjiang@gmail.com>, "open list:LINUX FOR POWERPC
 (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: cputime: fix a compile warning
References: <1479704219-21403-1-git-send-email-yanjiang.jin@windriver.com>
 <874m2n7yrf.fsf@concordia.ellerman.id.au>
 <CAKTCnzkY_g8Z61K_rQetLGbcGdJ-VUV79MEBkZej=yCM3=KJkw@mail.gmail.com>
In-Reply-To: <CAKTCnzkY_g8Z61K_rQetLGbcGdJ-VUV79MEBkZej=yCM3=KJkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 2016年12月02日 12:22, Balbir Singh wrote:
> On Fri, Dec 2, 2016 at 3:15 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> yanjiang.jin@windriver.com writes:
>>
>>> diff --git a/arch/powerpc/include/asm/cputime.h b/arch/powerpc/include/asm/cputime.h
>>> index 4f60db0..4423e97 100644
>>> --- a/arch/powerpc/include/asm/cputime.h
>>> +++ b/arch/powerpc/include/asm/cputime.h
>>> @@ -228,7 +228,8 @@ static inline cputime_t clock_t_to_cputime(const unsigned long clk)
>>>        return (__force cputime_t) ct;
>>>   }
>>>
>>> -#define cputime64_to_clock_t(ct)     cputime_to_clock_t((cputime_t)(ct))
>>> +#define cputime64_to_clock_t(ct)     \
>>> +     (__force u64)(cputime_to_clock_t((cputime_t)(ct)))
>> Given the name of the function is "cputime64 to clock_t", surely we
>> should be returning a clock_t ?
> Please fix it in cpuacct.c  Also check out git commit
> 527b0a76f41d062381adbb55c8eb61e32cb0bfc9
> sched/cpuacct: Avoid %lld seq_printf warning

Hi Balbir,

Where can I find this commit?

Thanks!
Yanjiang
>
> Balbir
