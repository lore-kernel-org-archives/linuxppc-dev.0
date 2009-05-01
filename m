Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A4E26DDEDA
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 07:47:18 +1000 (EST)
Message-ID: <49FB6D33.6010905@freescale.com>
Date: Fri, 01 May 2009 16:44:19 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH v6] introduce macro spin_event_timeout()
References: <1240859144-20893-1-git-send-email-timur@freescale.com>
	<20090501173354.64e78def@lappy.seanm.ca>
In-Reply-To: <20090501173354.64e78def@lappy.seanm.ca>
Content-Type: text/plain; charset=ISO-8859-1
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sean MacLennan wrote:

> Would cpu_relax be a good thing to put here?
> 
> Something like:
> 
> while (!(rc = (condition)) && (tb_ticks_since(__start) <= __loops)) \
> 	if (delay) \
> 		udelay(delay); \
> 	else \
> 		cpu_relax(); \
> 

I had that at one point, but then I looked at the code for udelay(), and
it appears that if I do udelay(0), it does something similar to cpu_relax:

	start = get_tbl();
	while (get_tbl() - start < loops)
		HMT_low();
	HMT_medium();

cpu_relax does this:

do { HMT_low(); HMT_medium(); barrier(); } while (0)

Well, now that I look at it, cpu_relax() changes the thread priority to
low and then back to medium, whereas udelay() never sets it to low if
'loops' is 0.

I'm okay with changing my code, but I wonder if udelay() should look
like this:

	start = get_tbl();
	HMT_low();
	while (get_tbl() - start < loops)
		HMT_low();
	HMT_medium();

-- 
Timur Tabi
Linux kernel developer at Freescale
