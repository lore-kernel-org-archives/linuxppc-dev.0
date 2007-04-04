Return-Path: <tnt@246tNt.com>
Received: from outmx034.isp.belgacom.be (outmx034.isp.belgacom.be
	[195.238.6.171])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A09F2DDE2C
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 05:32:27 +1000 (EST)
Received: from outmx034.isp.belgacom.be (localhost.localdomain [127.0.0.1])
	by outmx034.isp.belgacom.be (8.13.4/8.13.4/Debian-3sarge3) with ESMTP
	id l34JWLol024175
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Apr 2007 21:32:22 +0200
Message-ID: <4613FD29.6050908@246tNt.com>
Date: Wed, 04 Apr 2007 21:31:53 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: change rheap functions to use long integers
	instead of pointers
References: <11756161753280-git-send-email-timur@freescale.com>
	<F4B76190-37C3-453C-B4F0-C1CB7CC0532E@kernel.crashing.org>
	<4613E39A.70606@freescale.com> <4613E7CC.1020001@246tNt.com>
	<4613EAC6.5000203@freescale.com>
	<5BBB288E-3E8D-4513-B75A-101CC8950F86@embeddedalley.com>
	<4613FA75.206@freescale.com>
In-Reply-To: <4613FA75.206@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Dan Malek wrote:
>
>> How about just leaving it alone?  
>
> Panto said a while back that using unsigned long instead of void * is
> better.
>
> > A void * is
>> perfectly valid as rheap could be used to manage
>> any address space. 
>
> And therefore, it shouldn't be a pointer, because that implies that it
> can be dereferenced.  An unsigned long is a better type to use for a
> generic value than a void pointer.
FWIW, I agree that unsigned long is better. If it can hold anything, it
shouldn't be a pointer. And since currently _all_ users use it to store
offset, that removes a lot of un-necessary casts.

>> you are reducing
>> it's capability (by taking it's object management
>> outside of the kernel virtual space), 
>
> Sorry, I don't understand that.
Actually the returned value don't change so all it does is to shed some
light on some previously present but unseen issues ...
>
>> and you are
>> introducing concerns for error conditions of
>> current users.
>
> I'm fixing those by changing the type from long to ulong and using
> IS_ERR_VALUE().
That looks good to me ...


    Sylvain
