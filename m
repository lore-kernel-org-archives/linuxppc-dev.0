Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgwy04dGPzDqhC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 22:41:12 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id c74so10019217pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jul 2016 05:41:12 -0700 (PDT)
Message-ID: <1467376873.12509.1.camel@gmail.com>
Subject: Re: [PATCH v4] cpuidle: Fix last_residency division
From: Balbir Singh <bsingharora@gmail.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Nicolas Pitre
 <nicolas.pitre@linaro.org>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, rjw@rjwysocki.net,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, anton@samba.org,
 mpe@ellerman.id.au, David.Laight@ACULAB.COM, arnd@arndb.de
Date: Fri, 01 Jul 2016 22:41:13 +1000
In-Reply-To: <577624A3.2000406@linaro.org>
References: <1467297253-2171-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <5775335E.2040003@linaro.org>
 <alpine.LFD.2.20.1606301132350.12094@knanqh.ubzr>
 <577624A3.2000406@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-07-01 at 10:06 +0200, Daniel Lezcano wrote:
> On 06/30/2016 05:37 PM, Nicolas Pitre wrote:
> > 
> > On Thu, 30 Jun 2016, Daniel Lezcano wrote:
> [ ... ]
> 
> > 
> > > 
> > > > 
> > > > +	if (likely(nsec < DIV_APPROXIMATION_THRESHOLD)) {
> > > > +		u32 usec = nsec;
> > > > +
> > > > +		usec += usec >> 5;
> > > > +		usec = usec >> 10;
> > > > +
> > > > +		/* Can safely cast to int since usec is < INT_MAX */
> > > > +		return usec;
> > > > +	} else {
> > > > +		u64 usec = div_u64(nsec, 1000);
> > > > +
> > > > +		if (usec > INT_MAX)
> > > > +			usec = INT_MAX;
> > > > +
> > > > +		/* Can safely cast to int since usec is < INT_MAX */
> > > > +		return usec;
> > > > +	}
> > > > +}
> > > 
> > > What bothers me with this division is the benefit of adding an extra ultra
> > > optimized division by 1000 in cpuidle.h while we have already ktime_divns
> > > which is optimized in ktime.h.
> > It is "optimized" but still much heavier than what is presented above as
> > it provides maximum precision.
> > 
> > It all depends on how important the performance gain from the original
> > shift by 10 was in the first place.
> Actually the original shift was there because it was convenient as a 
> simple ~div1000 operation. But against all odds, the approximation 
> introduced a regression on a very specific use case on PowerPC.
> 
> We are not in the hot path and I think we can live with a ktime_divns 
> without problem. That would simplify the fix I believe.
> 

I would tend to agree with this and there are better ways to do
multiplicative inverses if we care

Balbir Singh.
