Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7F6CBDDF29
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Mar 2008 21:42:20 +1100 (EST)
Subject: Re: [PATCH 2/11] cell: generalize io-workarounds code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <20080314.212034.-1625856941.kouish@swc.toshiba.co.jp>
References: <20080314.212034.-1625856941.kouish@swc.toshiba.co.jp>
Content-Type: text/plain
Date: Mon, 24 Mar 2008 21:41:49 +1100
Message-Id: <1206355309.7197.32.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-03-14 at 21:20 +0900, Ishizaki Kou wrote:
> This patch splits cell io-workaround code into spider-pci dependent
> code and a generic part, and also adds interfaces to the generic
> io-workaround mechanism.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> ---

Hi !

I noticed that you add a second level of indirection. We already have
one going to the workarounds in the first place, so that looks a bit too
much to my taste.

I may have missed something in your patch but if the workarounds are
specific to a given bridge, they may as well set the top level
indirections once straight to the right workarounds.

Also, my understanding is that we are pretty much using the same bridge
on the cell blades, so is there any way that can be consolidated rather
than having function pointers ?

I'll try to have a closer look next week, but I'm a bit worried by
having all IO go through 2 level of function pointers, the PPE isn't
very good at it and this will slow things down more than they already
are.

Cheers,
Ben.
