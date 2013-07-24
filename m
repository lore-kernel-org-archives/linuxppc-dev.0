Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 137BD2C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 10:39:21 +1000 (EST)
Message-ID: <51EF21FD.9020509@asianux.com>
Date: Wed, 24 Jul 2013 08:38:21 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [Suggestion] powerpc: xmon: about 'longjmp' related warning.
References: <51ECD91D.7090903@asianux.com> <20130723135809.GG31944@concordia>
In-Reply-To: <20130723135809.GG31944@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: Michael Neuling <mikey@neuling.org>, "paulus@samba.org" <paulus@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 jovi.zhangwei@huawei.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/23/2013 09:58 PM, Michael Ellerman wrote:
> On Mon, Jul 22, 2013 at 03:02:53PM +0800, Chen Gang wrote:
>> Hello Maintainers:
>>
>> With allmodconfig and EXTRA_CFLAGS=-W", it reports warnings below:
> 
>>
>> arch/powerpc/xmon/xmon.c:3027:6: warning: variable ‘i’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Wclobbered]
>> arch/powerpc/xmon/xmon.c:3068:6: warning: variable ‘i’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Wclobbered]
> 
> In both these cases we are inside the body of a for loop and we do a
> if (setjmp) / else block. Although looking at the source the value of i
> is not modified by the setjmp, I guess it's possible that the compiler
> might reorder the increment of i inside the setjmp and loose the value
> when we longjmp.
> 

I should continue to confirm the details based on your valuable
information, thanks.


>> arch/powerpc/xmon/xmon.c:352:48: warning: argument ‘fromipi’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Wclobbered]
> 
> This one I can't see, but I assume it's a similar case.
> 

OK, I should continue for it.


>> Excuse me, I am not quite sure about it whether can cause issue or not.
> 
> I've never seen it get stuck in those loops or anything, but I guess
> it's possible.
> 

OK, I should make the confirmation.

> The first thing to do would be to analyse the generated assembler code
> to determine if there really is any possiblity of the value being
> clobbered, or if it's just a theoretical bug.
>

Thank you for your valuable information again.

Excuse me, I have to do another things within this month, so I should
provide the confirmation within next month (2013-08-31), is it OK (no
reply means OK).

Welcome any suggestions or completions.


Thanks.
-- 
Chen Gang
