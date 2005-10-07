Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 5134C684DF
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Oct 2005 00:38:47 +1000 (EST)
In-Reply-To: <1128645230.17365.5.camel@gaston>
References: <Pine.LNX.4.61.0509221450190.30738@nylon.am.freescale.net>
	<1127599811.27674.47.camel@gaston>
	<AFEB186E-99B9-4BE8-9AE3-315C74277483@freescale.com>
	<1128644808.17365.2.camel@gaston> <1128645230.17365.5.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FCCCED05-6243-44CE-B610-5BA7EB3A92AB@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 7 Oct 2005 09:39:13 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc32: make sure we have an L3 before touch its control
	register
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 6, 2005, at 7:33 PM, Benjamin Herrenschmidt wrote:

> On Fri, 2005-10-07 at 10:26 +1000, Benjamin Herrenschmidt wrote:
>
>>> Dope, you're right.  I notice that we apparent do this for BTIC and
>>>
>
>
>>> DPM in this function though?
>>>
>>
>> Yes, those bits are buggy. Good catch
>>
>
> And no, in fact, my brain is buggy... On ppc32 we identify first, then
> fixup, then only do the call_setup_cpu ! That's why the Idle NAP code
> actually goes test the feature bit.
>
> I think ppc64 does it the other way around. ppc64 certainly _requires_
> taht the fixup has not yet been applied while running early_setup() as
> it may change some CPU features according to firmware properties.
>
> So in the merged kernel, we need to be extra careful here. I think we
> should go the ppc64 way actually and apply the fixups later. But that
> means fixing the code in cpu_setup_6xx.S indeed.

Well, since we do this early on ppc32, my patch should be ok than.  
(And is need on 7448, do to some crazyness in how L3CR works on  
various versions of 7448).

I'd like to see we push this now and worry about "fixing" all of  
cpu_setup_6xx.S when we move it over to arch/powerpc

- kumar
