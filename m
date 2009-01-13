Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 234B9DE2BE
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 16:01:53 +1100 (EST)
Subject: Re: [PATCH 2/5] powerpc: Generic device tree for all AmigaOne boards
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20090112233904.221050@gmx.net>
References: <20090112233904.221050@gmx.net>
Content-Type: text/plain
Date: Tue, 13 Jan 2009 16:01:42 +1100
Message-Id: <1231822902.22571.37.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I think I throw away the IDE controller node for now, as libata just reads
> the PCI register settings (progif) and I guess the IDE subsystem will do
> the same in the future.

Well... if all AmigaOne use a 8259, they probably use the same interrupt
routing except for PCI slots. In which case, I would -still- prefer if
you had a proper interrupt tree, and at runtime or boot-wrapper time,
fixed up the PCI host "interrupt-map" property to contain the right
values for a given board.

I'm not going to include the new platform in .29, it's way too late
anyway (it should have been published a couple of weeks before the merge
window at least I'd say) so we have some time til .30 to polish things a
bit.

Another area to look at is to cleanup the non-coherent DMA thingy. The
config option should just enable a set of non-coherent backend ops, but
we should still be able to decide which ones to use (coherent vs.
non-coherent) at runtime.

Cheers,
Ben.
