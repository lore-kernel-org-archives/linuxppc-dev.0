Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 80A91DDDEF
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 00:54:35 +1100 (EST)
Subject: Re: [PATCH] ppc: Add support for bigger page sizes than 4KB on PPC44x
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20070313093754.4DE90353A9E@atlas.denx.de>
References: <20070313093754.4DE90353A9E@atlas.denx.de>
Content-Type: text/plain
Date: Tue, 13 Mar 2007 14:54:27 +0100
Message-Id: <1173794067.24454.78.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-03-13 at 10:37 +0100, Wolfgang Denk wrote:
> Dear Ben,
> 
> in message <1173769934.24454.67.camel@localhost.localdomain> you wrote:
> >
> >  - It's arch/ppc. We shouldn't do new major features on this codebase.
> > You are welcome however in helping moving over 4xx to arch/powerpc :-)
> 
> Will do that as soon as we have an arch/powerpc port for the 440SP /
> 440SPe

Ah great. I was thinking about working on 440GX after I'm back from the
ski. (I have a Taishan board)

We'll need to look into the MSI problem for SPe I suppose too...
hopefully Michael should have a proper MSI core merged upstream soom
(/me crosses fingers).

> >  - Have you tried other page sizes ? How hard would it be to support 16K
> > and what kind of performance numbers do you get with 16K ? It's a better
> 
> 16 kB should work, but was not tested so far. From our RAID oriented
> calculations it's not interesting.

Fair enough. I still think it would be useful for other workloads to
have that choice though :-)

> We tried 256 kB, but kernel linking fails with a "Not enough room for
> program headers" error message. We will investigate this ASAP, but at
> the moment we have other priorities. [Any hints what might  go  wrong
> are welcome.]

256K will not be doable without serious hacking afaik. Anything above
64K. You won't be able to run most userland apps for example as the
sections are generally 64K aligned.

> Agreed, but this obviously depends  on  the  sort  of  application(s)
> you're running.

Definitely.

Cheers,
Ben.
