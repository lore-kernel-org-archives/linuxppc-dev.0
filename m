Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7B76CDDF32
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 05:33:27 +1000 (EST)
In-Reply-To: <461BE0EC.8090204@freescale.com>
References: <11757244213581-git-send-email-timur@freescale.com>	<461AAF2F.2020608@freescale.com>
	<DEB47A44-7FBF-40AD-B409-12A9BFA35976@kernel.crashing.org>
	<461BDB69.4050405@freescale.com>
	<EB6E9F47-C92F-48E0-BC98-13AA3B9C0027@kernel.crashing.org>
	<461BE0EC.8090204@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DF53284F-75DF-4077-BAC2-41F69093F755@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: change rheap functions to use ulongs instead
	of pointers
Date: Tue, 10 Apr 2007 14:32:56 -0500
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 10, 2007, at 2:09 PM, Timur Tabi wrote:

> Kumar Gala wrote:
>
>> What's the specific problem you are fixing?  Its not obvious that  
>> this patch is addressing a bug.
>
> problem != bug
>
> The problem is that a pointer implies something you can  
> dereference.  But the return value from rh_alloc() is only a  
> pointer in a specific circumstance which is not actually used in  
> any current code.  So *all* of the callers of rh_alloc() cast the  
> return value to an integer type anyway.
>
> In other words, it's wrong to use a pointer.  The value is a  
> generic number, and so the type needs to match that.  The code is  
> just better using ulongs.  Also, two redundant macros  
> (IS_MURAM_ERR, etc) have been removed and replaced with their  
> generic counterpart (IS_ERR_VALUE).

I consider this all code cleanup at this point since the code is  
functional at this point.  I don't disagree with any of your points,  
but this is cleanup.  We should take this all the way if we are going  
to do it.

- k
