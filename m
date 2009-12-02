Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AABFDB7BDC
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Dec 2009 07:58:01 +1100 (EST)
Subject: Re: Recommended functions for accessing internal registers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Fortini Matteo <matteo.fortini@mta.it>
In-Reply-To: <4B1547E5.6050301@mta.it>
References: <4B1547E5.6050301@mta.it>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 03 Dec 2009 07:57:55 +1100
Message-ID: <1259787475.2076.1160.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-12-01 at 17:44 +0100, Fortini Matteo wrote:
> I see that throughout the kernel source, internal PPC registers are 
> accessed through [in|out]_be[32|16|8]() functions. However, they are 
> translated into 3 inline assembly instructions, one of which is an 
> isync, which has a huge performance hit.
> I tried using readl_be() which seems to be the right function according 
> to the Documentation/ dir, but it is translated directly to in_be32(), 
> so no luck.
> 
> Is it really necessary to use all those instructions? I know I could use 
> a (volatile u32 *) variable to avoid subsequent read/writes to be 
> optimized out, but it seems to be a deprecated use.

There are good reasons why the accessors contain those barriers. What
are you doing that would be performance critical enough for those to be
a problem ?

Cheers,
Ben.
