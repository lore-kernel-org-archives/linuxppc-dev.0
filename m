Return-Path: <nicolas.pitre@linaro.org>
Received: from mail-qk0-x22c.google.com (mail-qk0-x22c.google.com
 [IPv6:2607:f8b0:400d:c09::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfm9S1zKLzDqwC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 01:02:04 +1000 (AEST)
Received: by mail-qk0-x22c.google.com with SMTP id t127so91702254qkf.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 08:02:04 -0700 (PDT)
Date: Wed, 29 Jun 2016 11:01:58 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, rjw@rjwysocki.net,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, anton@samba.org,
 mpe@ellerman.id.au, bsingharora@gmail.com, David.Laight@ACULAB.COM,
 Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] cpuidle: Fix last_residency division
In-Reply-To: <57737AA1.7050201@linaro.org>
Message-ID: <alpine.LFD.2.20.1606290944400.24439@knanqh.ubzr>
References: <1467183971-12327-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <57737AA1.7050201@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-438052120-1467210361=:24439"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--8323328-438052120-1467210361=:24439
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LFD.2.20.1606291045411.24439@knanqh.ubzr>

On Wed, 29 Jun 2016, Daniel Lezcano wrote:

> On 06/29/2016 09:06 AM, Shreyas B. Prabhu wrote:
> > diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
> > index f87f399..c8ea5ad 100644
> > --- a/drivers/cpuidle/cpuidle.h
> > +++ b/drivers/cpuidle/cpuidle.h
> > @@ -68,4 +68,27 @@ static inline void
> > cpuidle_coupled_unregister_device(struct cpuidle_device *dev)
> >   }
> >   #endif
> >
> > +/*
> > + * Used for calculating last_residency in usec. Optimized for case
> > + * where last_residency in nsecs is < INT_MAX/2 by using faster
> > + * approximation. Approximated value has less than 1% error.
> > + */
> > +static inline int convert_nsec_to_usec(u64 nsec)
> > +{
> > +	if (likely(nsec < INT_MAX / 2)) {
> 
> UINT_MAX ?

Actually this can be better than that.

> > +		int usec = (int)nsec;

First, you'll want an unsigned type. Given the provided argument is u64, 
we can assume there won't be any negative values here.

Then it would be wise to use a type with an explicit width, like U32.

> > +		usec += usec >> 5;
> > +		usec = usec >> 10;
> > +		return usec;

And now you want to maximize the available range. So not to overflow the 
first addition, we must respect:

	usec + (usec >> 5) <= 0xffffffff 
	usec + usec/32 <= 0xffffffff
	usec <= (0xffffffff * 32) / 33

Therefore:

	nsec <= 0xf83e0f82

This is much better than INT_MAX/2.

> > +	} else {
> > +		u64 usec = div_u64(nsec, 1000);
> > +
> > +		if (usec > INT_MAX)
> > +			usec = INT_MAX;
> > +		return (int)usec;
> > +	}
> > +}
> 
> 
> 
> -- 
>  <http://www.linaro.org/> Linaro.org  Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
> 
--8323328-438052120-1467210361=:24439--
