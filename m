Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 37C32DDEBC
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 05:20:31 +1000 (EST)
Message-ID: <4613FA75.206@freescale.com>
Date: Wed, 04 Apr 2007 14:20:21 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: [PATCH] powerpc: change rheap functions to use long integers
	instead of pointers
References: <11756161753280-git-send-email-timur@freescale.com>
	<F4B76190-37C3-453C-B4F0-C1CB7CC0532E@kernel.crashing.org>
	<4613E39A.70606@freescale.com> <4613E7CC.1020001@246tNt.com>
	<4613EAC6.5000203@freescale.com>
	<5BBB288E-3E8D-4513-B75A-101CC8950F86@embeddedalley.com>
In-Reply-To: <5BBB288E-3E8D-4513-B75A-101CC8950F86@embeddedalley.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dan Malek wrote:

> How about just leaving it alone?  

Panto said a while back that using unsigned long instead of void * is better.

 > A void * is
> perfectly valid as rheap could be used to manage
> any address space. 

And therefore, it shouldn't be a pointer, because that implies that it can be 
dereferenced.  An unsigned long is a better type to use for a generic value than a void 
pointer.

> you are reducing
> it's capability (by taking it's object management
> outside of the kernel virtual space), 

Sorry, I don't understand that.

> and you are
> introducing concerns for error conditions of
> current users.

I'm fixing those by changing the type from long to ulong and using IS_ERR_VALUE().

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
