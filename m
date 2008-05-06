Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C3CF1DDE1E
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 20:13:58 +1000 (EST)
Subject: Re: [PATCH] Sam440ep support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20080506091622.269180@gmx.net>
References: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>
	<6DA6B1DA-11B5-4B89-88AD-561B4D17B33B@kernel.crashing.org>
	<20080505195054.172000@gmx.net> <1210031058.21644.120.camel@pasglop>
	<20080506075115.269150@gmx.net> <1210063719.21644.162.camel@pasglop>
	<20080506091622.269180@gmx.net>
Content-Type: text/plain
Date: Tue, 06 May 2008 20:12:27 +1000
Message-Id: <1210068747.21644.164.camel@pasglop>
Mime-Version: 1.0
Cc: tiwai@suse.de, linuxppc-dev@ozlabs.org, cjg@cruxppc.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-05-06 at 11:16 +0200, Gerhard Pircher wrote:
> I can't answer this question. *ducked* :-) Takashi?
> 
> FYI: I posted the results of the test with Takashi's dma_mmap_coherent
> patch here:
> http://ozlabs.org/pipermail/linuxppc-dev/2006-June/024078.html
> 
> On the other side it looks like this problem does not only affect
> ALSA.
> As far as I can tell also some V4L(2) drivers have a problem with
> mmaping
> non coherent DMA allocations, but I'm not sure (it's a long time since
> I
> did some tests with video cards on my AmigaOne).
> 
> Naturally I can do some tests, if you or Takashi come up with a new
> patch.

Time that we sort that stuff out once for all..

sg allocations are usually lists of page, so virt_to_page shouldn't be a
problem in the first place, though we still need some way to get the
right prot attributes.

Ben.
