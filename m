Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6CA46DDF21
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 04:13:34 +1000 (EST)
Message-ID: <4613EAC6.5000203@freescale.com>
Date: Wed, 04 Apr 2007 13:13:26 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH] powerpc: change rheap functions to use long integers
	instead of pointers
References: <11756161753280-git-send-email-timur@freescale.com>
	<F4B76190-37C3-453C-B4F0-C1CB7CC0532E@kernel.crashing.org>
	<4613E39A.70606@freescale.com> <4613E7CC.1020001@246tNt.com>
In-Reply-To: <4613E7CC.1020001@246tNt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sylvain Munaut wrote:

> But you're right, your not changing the actual values returned,
> ERR_PTR(x) == x ....
> So if someone wants to use it with addresses, he still can. He should
> just do cast to (void *). And to detect errors on alloc he should he
> IS_ERR(...)

How about I change rh_alloc() to return unsigned long, instead of just long, and then the 
callers can use IS_ERR_VALUE() to check for error?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
