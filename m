Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 61E0CB7B64
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 16:14:38 +1100 (EST)
Subject: Re: [RFC PATCH 10/19] powerpc: gamecube/wii: early debugging using
	usbgecko
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200911222327.37949.arnd@arndb.de>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-11-git-send-email-albert_herranz@yahoo.es>
	<200911222327.37949.arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 26 Nov 2009 16:14:28 +1100
Message-ID: <1259212468.16367.267.camel@pasglop>
Mime-Version: 1.0
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2009-11-22 at 23:27 +0100, Arnd Bergmann wrote:
> 
> This will probably break other platforms if
> CONFIG_PPC_EARLY_DEBUG_USBGECKO
> is set. In general, we try hard to make it possible to build generic
> kernels for multiple systems, so it would be better to also add a
> runtime check here.

No Arnd. The whole point of EARLY_DEBUG is that it is -known- to break
other platforms :-) So that we can use it before we even get to probe
anything.

I am still tempted, one day, to change the kernel early init to setup a
stack in .bss and go straight to C to do that sort of stuff by parsing
the flat DT, this could be done using pretty much completely generic
code :-) But not right now.

Cheers,
Ben.
