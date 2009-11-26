Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EF005B7BC5
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 09:37:43 +1100 (EST)
Subject: Re: [RFC PATCH 04/19] powerpc: wii: device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <4B0EF54C.6020101@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<49436.84.105.60.153.1259171377.squirrel@gate.crashing.org>
	<1259211061.16367.260.camel@pasglop>  <4B0E9C5F.50304@yahoo.es>
	<1259269265.18084.14.camel@pasglop>  <4B0EF54C.6020101@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 27 Nov 2009 09:37:37 +1100
Message-ID: <1259275057.2659.3.camel@pasglop>
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

On Thu, 2009-11-26 at 22:38 +0100, Albert Herranz wrote:

> Yup. The idea is to map the first 16MB of MEM1 with a BAT.
> Mapping the whole 24MB with BATs may not be possible because we want the framebuffer
> in MEM1 for performance reasons.

How big is the fb ? We have plenty of BATs on these things... so one 16M
for the low mem and one 64M for the "high" mem, that leaves something
like 6 to manage as much as possible up to the fb :-)

Let's keep 1 or 2 for debug and maybe even BAT map the fb itself, we
still are quite comfortable :-)

That reminds me we still need to re-introduce a clean version of
io_block_mapping (or ioremap flag that does the same) so the platform
code can establish a BAT mapping for a whole bunch of IOs and ioremap
transparenty picks addresses in there. We used to do it, dropped it
mostly because it was done badly (virtual address was hard coded which
caused all sorts of issues) but it shouldn't be hard to do it right and
it would improve perfs a little bit more.

Cheers,
Ben.
