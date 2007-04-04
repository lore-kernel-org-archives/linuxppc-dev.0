Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CA7CFDDF6A
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 04:19:35 +1000 (EST)
Message-ID: <4613EC2F.80109@freescale.com>
Date: Wed, 04 Apr 2007 13:19:27 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: change rheap functions to use long integers
	instead of pointers
References: <11756161753280-git-send-email-timur@freescale.com>
	<F4B76190-37C3-453C-B4F0-C1CB7CC0532E@kernel.crashing.org>
	<4613E39A.70606@freescale.com> <4613E7CC.1020001@246tNt.com>
	<20070404181351.GA19855@ld0162-tx32.am.freescale.net>
In-Reply-To: <20070404181351.GA19855@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Sylvain Munaut <tnt@246tNt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:

> ...in which case it's already broken, as IS_ERR() will return true after
> you use up a little over 1/16 of the region.

Scott's right.  rh_attach_region() never supported anything above "(unsigned long) 
-MAXERR".  Perhaps I should add a check for that?

	/* Round start up */
	s = (s + m) & ~m;

+	if (IS_ERR_VALUE(s))
+		return -EINVAL;

	/* Round end down */
	e = e & ~m;

The same patch should be applied to rh_detach_region() and rh_alloc_fixed().

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
