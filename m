Return-Path: <B07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0B54CB7D6A
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Feb 2010 03:57:05 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o1BGv2BR007749
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2010 09:57:02 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o1BH3v64017332
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2010 11:03:57 -0600 (CST)
Message-ID: <4B7436BC.10406@freescale.com>
Date: Thu, 11 Feb 2010 10:56:28 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] perf_event: e500 support
References: <20100115214351.GA2869@loki.buserror.net>
	<20100210222932.GA9844@brick.ozlabs.ibm.com>
	<4B7349F2.8030802@freescale.com>
	<20100211030143.GA11245@brick.ozlabs.ibm.com>
In-Reply-To: <20100211030143.GA11245@brick.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> On Wed, Feb 10, 2010 at 06:06:10PM -0600, Scott Wood wrote:
> 
>> Paul Mackerras wrote:
>>>> Some limitations:
>>>> - No threshold support -- need to figure out how to represent it in
>>>>  the event struct from userspace.
>>> What does "threshold support" mean in this context?  Does it mean
>>> something different from getting an interrupt after N events have been
>>> counted?  Or does it mean counting instances where something takes
>>> longer than a specific number of cycles?
>> The latter.
> 
> OK.  I handled that on classic by using some extra high bits in the
> event config for the threshold value. 

OK.

> If you have a single threshold
> value in hardware but more than one event that uses that threshold
> value, then you will need to add a constraint that all threshold
> events have to specify the same threshold.

There's a separate threshold for each counter.

> So, it sounds like you have a class of events which are the
> thresholding events, and two constraints:
> 
> * at most two events in the thresholding event class
> * at most four events in total
> 
> Are there other constraints?  Apart from the thresholding events, can
> any event go on any counter, or can some events only be counted on one
> particular counter?

No, those are the only constraints.

> If your constraints are just the two listed above (<= 2 threshold
> events, <= 4 events total), then doing it the obvious straightforward
> way is fine.  If there are other constraints as well, such as certain
> events only being available on one specific PMC, then you should
> consider reusing the constraint checking machinery from ppc64.

I'll stick with the straightforward approach then.  If future chips have 
more complicated constraints we can revisit using the more general scheme.

-Scott
