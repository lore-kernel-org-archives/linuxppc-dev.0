Return-Path: <cbouatmailru@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 6596DDE39D
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 19:55:23 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 3so313353ywj.39
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 02:55:10 -0700 (PDT)
Date: Fri, 18 Apr 2008 13:54:59 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/5] [POWERPC] sysdev: implement FSL GTM support
Message-ID: <20080418095459.GA23772@zarina>
References: <20080417192656.GA19107@polina.dev.rtsoft.ru>
	<20080417192832.GA28286@polina.dev.rtsoft.ru>
	<20080417224740.GA25323@zarina>
	<E0A0E0FF-C2D5-432B-86A4-59AF23D3B63F@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <E0A0E0FF-C2D5-432B-86A4-59AF23D3B63F@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 17, 2008 at 11:19:39PM -0500, Kumar Gala wrote:
[...]
>>> + * interval value, and fires the interrupt when the value is  
>>> reached. This
>>> + * function will reduce the precision of the timer as needed in  
>>> order for the
>>> + * requested timeout to fit in a 16-bit register.
>>> + */
>>> +int gtm_reset_timer16(struct gtm_timer *tmr, unsigned long usec,  
>>> bool reload)
>>> +{
>>> +	/* quite obvious, frequency which is enough for ÂµSec precision */
>>> +	int freq = 1000000;
>>> +	unsigned int bit;
>>> +
>>> +	bit = fls_long(usec);
>>> +	if (bit > 15) {
>>> +		freq >>= bit - 15;
>>> +		usec >>= bit - 15;
>>> +	}
>>
>> if (!freq)
>> 	return -EINVAL;
>
> do you want me to fix this up on commit or are you going to respin the  
> patch set based on feedback?

I would better respin the whole thing. Will do this today.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
