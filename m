Return-Path: <daniel.lezcano@linaro.org>
Received: from mail-wm0-x235.google.com (mail-wm0-x235.google.com
 [IPv6:2a00:1450:400c:c09::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgpsg3N29zDql5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 18:07:02 +1000 (AEST)
Received: by mail-wm0-x235.google.com with SMTP id r201so17754970wme.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jul 2016 01:07:02 -0700 (PDT)
Subject: Re: [PATCH v4] cpuidle: Fix last_residency division
To: Nicolas Pitre <nicolas.pitre@linaro.org>
References: <1467297253-2171-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <5775335E.2040003@linaro.org>
 <alpine.LFD.2.20.1606301132350.12094@knanqh.ubzr>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, rjw@rjwysocki.net,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, anton@samba.org,
 mpe@ellerman.id.au, bsingharora@gmail.com, David.Laight@ACULAB.COM,
 arnd@arndb.de
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <577624A3.2000406@linaro.org>
Date: Fri, 1 Jul 2016 10:06:59 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.20.1606301132350.12094@knanqh.ubzr>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/30/2016 05:37 PM, Nicolas Pitre wrote:
> On Thu, 30 Jun 2016, Daniel Lezcano wrote:

[ ... ]

>>> +	if (likely(nsec < DIV_APPROXIMATION_THRESHOLD)) {
>>> +		u32 usec = nsec;
>>> +
>>> +		usec += usec >> 5;
>>> +		usec = usec >> 10;
>>> +
>>> +		/* Can safely cast to int since usec is < INT_MAX */
>>> +		return usec;
>>> +	} else {
>>> +		u64 usec = div_u64(nsec, 1000);
>>> +
>>> +		if (usec > INT_MAX)
>>> +			usec = INT_MAX;
>>> +
>>> +		/* Can safely cast to int since usec is < INT_MAX */
>>> +		return usec;
>>> +	}
>>> +}
>>
>>
>> What bothers me with this division is the benefit of adding an extra ultra
>> optimized division by 1000 in cpuidle.h while we have already ktime_divns
>> which is optimized in ktime.h.
>
> It is "optimized" but still much heavier than what is presented above as
> it provides maximum precision.
>
> It all depends on how important the performance gain from the original
> shift by 10 was in the first place.

Actually the original shift was there because it was convenient as a 
simple ~div1000 operation. But against all odds, the approximation 
introduced a regression on a very specific use case on PowerPC.

We are not in the hot path and I think we can live with a ktime_divns 
without problem. That would simplify the fix I believe.

Perhaps the div1000 routine could be moved in ktime.h to be used as a 
helper for ktime_divns when we divide by the 1000 constant and submitted 
in a separate patch as an optimization.

-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
