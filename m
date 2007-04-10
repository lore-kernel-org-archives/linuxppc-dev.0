Return-Path: <tnt@246tNt.com>
Received: from outmx015.isp.belgacom.be (outmx015.isp.belgacom.be
	[195.238.4.87])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 179E2DDF42
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 05:43:16 +1000 (EST)
Received: from outmx015.isp.belgacom.be (localhost [127.0.0.1])
	by outmx015.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l3AJh5s1008661
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 21:43:07 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <461BE8B5.7000903@246tNt.com>
Date: Tue, 10 Apr 2007 21:42:45 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: change rheap functions to use ulongs instead
	of pointers
References: <11757244213581-git-send-email-timur@freescale.com>	<461AAF2F.2020608@freescale.com>
	<DEB47A44-7FBF-40AD-B409-12A9BFA35976@kernel.crashing.org>
	<461BDB69.4050405@freescale.com>
	<EB6E9F47-C92F-48E0-BC98-13AA3B9C0027@kernel.crashing.org>
	<461BE0EC.8090204@freescale.com>
	<DF53284F-75DF-4077-BAC2-41F69093F755@kernel.crashing.org>
In-Reply-To: <DF53284F-75DF-4077-BAC2-41F69093F755@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>
> On Apr 10, 2007, at 2:09 PM, Timur Tabi wrote:
>
>> Kumar Gala wrote:
>>
>>> What's the specific problem you are fixing?  Its not obvious that
>>> this patch is addressing a bug.
>>
>> problem != bug
>>
>> The problem is that a pointer implies something you can dereference. 
>> But the return value from rh_alloc() is only a pointer in a specific
>> circumstance which is not actually used in any current code.  So
>> *all* of the callers of rh_alloc() cast the return value to an
>> integer type anyway.
>>
>> In other words, it's wrong to use a pointer.  The value is a generic
>> number, and so the type needs to match that.  The code is just better
>> using ulongs.  Also, two redundant macros (IS_MURAM_ERR, etc) have
>> been removed and replaced with their generic counterpart (IS_ERR_VALUE).
>
> I consider this all code cleanup at this point since the code is
> functional at this point.  I don't disagree with any of your points,
> but this is cleanup.  We should take this all the way if we are going
> to do it.
I like this patch, I think the conversion to ulong does make sense (a
whole lot more than void * ...).

And I don't really agree that we need to "take it all the way" at once
... Even if later it's interesting to make it more global, the work that
is done here won't be lost so I'm in favor of merging that now.
Moving it to /lib is most likely going to take quite some time and that
should not prevent local cleaning of arch/powerpc

Removing all those cast make the core more readable imho. And writing
new code that use rheap is a whole lot more clear without having to
bother casting to/from void* each time you use a rh_ function ...


    Sylvain
