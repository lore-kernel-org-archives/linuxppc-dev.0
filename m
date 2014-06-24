Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205])
 by lists.ozlabs.org (Postfix) with ESMTP id 6DFAA1A0221
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 16:01:57 +1000 (EST)
Message-ID: <53A91449.6010701@roeck-us.net>
Date: Mon, 23 Jun 2014 23:01:45 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix build warning
References: <1402677499-28289-1-git-send-email-linux@roeck-us.net>	
 <1403584501.4587.153.camel@pasglop> <53A90718.4050401@roeck-us.net>
 <1403588053.4587.160.camel@pasglop>
In-Reply-To: <1403588053.4587.160.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/23/2014 10:34 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2014-06-23 at 22:05 -0700, Guenter Roeck wrote:
>> On 06/23/2014 09:35 PM, Benjamin Herrenschmidt wrote:
>>> On Fri, 2014-06-13 at 09:38 -0700, Guenter Roeck wrote:
>>>> If compiled with W=1, the following warning is seen in powerpc builds.
>>>>
>>>> arch/powerpc/kernel/smp.c:750:18: warning:
>>>> 	type qualifiers ignored on function return type
>>>> static const int powerpc_smt_flags(void)
>>>>                    ^
>>>>
>>>> This is caused by a function returning 'const int', which doesn't
>>>> make sense to gcc. Drop 'const' to fix the problem.
>>>
>>> This breaks the 64-bit build:
>>>
>>> arch/powerpc/kernel/smp.c:764:2: error: initialization from incompatible pointer type [-Werror]
>>> arch/powerpc/kernel/smp.c:764:2: error: (near initialization for 'powerpc_topology[0].sd_flags') [-Werror]
>>>
>>> It appears that the generic definition in sched.h has this function
>>> defined as const int, so that needs to be fixed too along with all
>>> instances in all archs.
>>>
>>
>> https://lkml.org/lkml/2014/6/12/743
>
> Won't the patch above break powerpc then ? IE. The functions signature
> won't match anymore ... /me thinks you probably need to fix them all
> at once.
>

I thought that only happens if a const is dropped, but maybe not.

Sigh. Much easier to break something than to fix it. That would mean to get approval
from at least three maintainers, and all that to get rid of a warning. I don't
really have time for that. Let's just forget about it and live with the warning.

Guenter
