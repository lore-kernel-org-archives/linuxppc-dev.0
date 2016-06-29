Return-Path: <nicolas.pitre@linaro.org>
Received: from mail-qt0-x235.google.com (mail-qt0-x235.google.com
 [IPv6:2607:f8b0:400d:c0d::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfnHm1sqSzDqsp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 01:52:35 +1000 (AEST)
Received: by mail-qt0-x235.google.com with SMTP id w59so27717007qtd.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 08:52:35 -0700 (PDT)
Date: Wed, 29 Jun 2016 11:52:31 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, rjw@rjwysocki.net,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, anton@samba.org,
 mpe@ellerman.id.au, bsingharora@gmail.com, David.Laight@ACULAB.COM,
 Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] cpuidle: Fix last_residency division
In-Reply-To: <alpine.LFD.2.20.1606290944400.24439@knanqh.ubzr>
Message-ID: <alpine.LFD.2.20.1606291151060.24439@knanqh.ubzr>
References: <1467183971-12327-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <57737AA1.7050201@linaro.org>
 <alpine.LFD.2.20.1606290944400.24439@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 29 Jun 2016, Nicolas Pitre wrote:

> On Wed, 29 Jun 2016, Daniel Lezcano wrote:
> 
> > On 06/29/2016 09:06 AM, Shreyas B. Prabhu wrote:
> > > diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
> > > index f87f399..c8ea5ad 100644
> > > --- a/drivers/cpuidle/cpuidle.h
> > > +++ b/drivers/cpuidle/cpuidle.h
> > > @@ -68,4 +68,27 @@ static inline void
> > > cpuidle_coupled_unregister_device(struct cpuidle_device *dev)
> > >   }
> > >   #endif
> > >
> > > +/*
> > > + * Used for calculating last_residency in usec. Optimized for case
> > > + * where last_residency in nsecs is < INT_MAX/2 by using faster
> > > + * approximation. Approximated value has less than 1% error.
> > > + */
> > > +static inline int convert_nsec_to_usec(u64 nsec)
> > > +{
> > > +	if (likely(nsec < INT_MAX / 2)) {
> > 
> > UINT_MAX ?
> 
> Actually this can be better than that.
> 
> > > +		int usec = (int)nsec;
> 
> First, you'll want an unsigned type. Given the provided argument is u64, 
> we can assume there won't be any negative values here.
> 
> Then it would be wise to use a type with an explicit width, like U32.
> 
> > > +		usec += usec >> 5;
> > > +		usec = usec >> 10;
> > > +		return usec;
> 
> And now you want to maximize the available range. So not to overflow the 
> first addition, we must respect:
> 
> 	usec + (usec >> 5) <= 0xffffffff 
> 	usec + usec/32 <= 0xffffffff
> 	usec <= (0xffffffff * 32) / 33
> 
> Therefore:
> 
> 	nsec <= 0xf83e0f82

And to be sure, you should use 0xf83e0f82UL to avoid any potential sign 
extension.


Nicolas
