Return-Path: <nicolas.pitre@linaro.org>
Received: from mail-qk0-x236.google.com (mail-qk0-x236.google.com
 [IPv6:2607:f8b0:400d:c09::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgxQR5ZNzzDqpF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 23:02:23 +1000 (AEST)
Received: by mail-qk0-x236.google.com with SMTP id a125so200901973qkc.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jul 2016 06:02:23 -0700 (PDT)
Date: Fri, 1 Jul 2016 09:02:18 -0400 (EDT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Balbir Singh <bsingharora@gmail.com>
cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>, rjw@rjwysocki.net,
 linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, anton@samba.org,
 mpe@ellerman.id.au, David.Laight@ACULAB.COM, arnd@arndb.de
Subject: Re: [PATCH v4] cpuidle: Fix last_residency division
In-Reply-To: <1467376873.12509.1.camel@gmail.com>
Message-ID: <alpine.LFD.2.20.1607010901140.12094@knanqh.ubzr>
References: <1467297253-2171-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <5775335E.2040003@linaro.org>
 <alpine.LFD.2.20.1606301132350.12094@knanqh.ubzr>
 <577624A3.2000406@linaro.org> <1467376873.12509.1.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2140905334-1467378140=:12094"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--8323328-2140905334-1467378140=:12094
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 1 Jul 2016, Balbir Singh wrote:

> On Fri, 2016-07-01 at 10:06 +0200, Daniel Lezcano wrote:
> > On 06/30/2016 05:37 PM, Nicolas Pitre wrote:
> > > 
> > > On Thu, 30 Jun 2016, Daniel Lezcano wrote:
> > [ ... ]
> > 
> > > 
> > > > 
> > > > > 
> > > > > +	if (likely(nsec < DIV_APPROXIMATION_THRESHOLD)) {
> > > > > +		u32 usec = nsec;
> > > > > +
> > > > > +		usec += usec >> 5;
> > > > > +		usec = usec >> 10;
> > > > > +
> > > > > +		/* Can safely cast to int since usec is < INT_MAX */
> > > > > +		return usec;
> > > > > +	} else {
> > > > > +		u64 usec = div_u64(nsec, 1000);
> > > > > +
> > > > > +		if (usec > INT_MAX)
> > > > > +			usec = INT_MAX;
> > > > > +
> > > > > +		/* Can safely cast to int since usec is < INT_MAX */
> > > > > +		return usec;
> > > > > +	}
> > > > > +}
> > > > 
> > > > What bothers me with this division is the benefit of adding an extra ultra
> > > > optimized division by 1000 in cpuidle.h while we have already ktime_divns
> > > > which is optimized in ktime.h.
> > > It is "optimized" but still much heavier than what is presented above as
> > > it provides maximum precision.
> > > 
> > > It all depends on how important the performance gain from the original
> > > shift by 10 was in the first place.
> > Actually the original shift was there because it was convenient as a 
> > simple ~div1000 operation. But against all odds, the approximation 
> > introduced a regression on a very specific use case on PowerPC.
> > 
> > We are not in the hot path and I think we can live with a ktime_divns 
> > without problem. That would simplify the fix I believe.
> > 
> 
> I would tend to agree with this and there are better ways to do
> multiplicative inverses if we care

ktime_divns already does it automatically when applicable.


Nicolas
--8323328-2140905334-1467378140=:12094--
