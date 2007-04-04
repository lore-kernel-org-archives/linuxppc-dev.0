Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 51FE5DDF23
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 04:28:05 +1000 (EST)
Message-ID: <4613EE2C.3070104@freescale.com>
Date: Wed, 04 Apr 2007 13:27:56 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc: change rheap functions to use long integers
	instead of pointers
References: <11756161753280-git-send-email-timur@freescale.com>
	<F4B76190-37C3-453C-B4F0-C1CB7CC0532E@kernel.crashing.org>
	<4613E39A.70606@freescale.com> <4613E7CC.1020001@246tNt.com>
	<20070404181351.GA19855@ld0162-tx32.am.freescale.net>
	<4613EC2F.80109@freescale.com> <4613ED4F.2030203@freescale.com>
In-Reply-To: <4613ED4F.2030203@freescale.com>
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

Scott Wood wrote:

>> The same patch should be applied to rh_detach_region() and 
>> rh_alloc_fixed().
> 
> You should check "e" instead, and make sure that s < e.

Now that I look at the code, I think there's a bug in the calculation of 'e'.  'e' is 
rounded down, and it's based on the unaligned value of 'start'.  Instead, 'size' should be 
rounded up, and 'e' should be based on 's' (i.e. the aligned value of 'start').

Otherwise, if you pass an unaligned value of 'start', then the buffer you get back will be 
less than 'size'.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
