Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 505C6B6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Jul 2010 19:29:06 +1000 (EST)
Subject: Re: Where are logical memory block regions setup?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rick Ramstetter <rick.ramstetter@gmail.com>
In-Reply-To: <AANLkTi=mAZOuyC4GmSUnk8d5gHs3N0NC2dhUH0K3jwUM@mail.gmail.com>
References: <AANLkTi=mAZOuyC4GmSUnk8d5gHs3N0NC2dhUH0K3jwUM@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Jul 2010 19:28:58 +1000
Message-ID: <1280222938.1970.200.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-07-26 at 22:52 -0400, Rick Ramstetter wrote:
> Hi all,
> 
> Where can I find the code that sets values in lmb.reserved.region[i]? 
> This is in reference to 2.6.27's arch/powerpc/mm/mem.c and
> include/linux/lmb.h
> 
> I'm looking specifically for code that sets lmb_region's region.size
> and region.base.

They come from the reserve map in the device-tree, plus possible
additional calls to lmb_reserve. Do a grep -r lmb_reserve arch/powerpc
and you should find it all.

Cheers,
Ben.
