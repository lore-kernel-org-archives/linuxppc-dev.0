Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8721267BBC
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jul 2005 04:14:53 +1000 (EST)
Date: Tue, 5 Jul 2005 20:14:48 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20050705181448.GA28142@suse.de>
References: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
	<20050703172955.GA25976@suse.de>
	<20050703183237.GC16764@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20050703183237.GC16764@smtp.west.cox.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Set cpu explicitly in kernel compiles
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Sun, Jul 03, Tom Rini wrote:

> cpu-as-y = -Wa,-mcpu=powerpc	# Pure ppc32

That alone should fix it, adding -mcpu=$somecpu may generate bad code
for other cpu types, according to alanm.

> cpu-as-$(CONFIG_6xx) += -Wa,-maltivec
> cpu-as-$(CONFIG_PPC_601) := -Wa,-mcpu=601 # Or whatever the 601 option is

601 doesnt need special cflags handling.

cpu-as-$(CONFIG_6xx) += -Wa,-mcpu=powerpc

may be enough, no idea if -Wa is required.
