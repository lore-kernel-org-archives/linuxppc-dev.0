Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 08CAFDDE98
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 18:12:24 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 1/2] [POWERPC] Add PPC4xx L2-cache support (440GX &
	460EX/GT)
Date: Thu, 20 Mar 2008 08:12:08 +0100
References: <1205847389-17771-1-git-send-email-sr@denx.de>
	<1205996092.26869.420.camel@pasglop>
In-Reply-To: <1205996092.26869.420.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200803200812.08282.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 20 March 2008, Benjamin Herrenschmidt wrote:
> On Tue, 2008-03-18 at 14:36 +0100, Stefan Roese wrote:
> > This patch adds support for the 256k L2 cache found on some IBM/AMCC
> > 4xx PPC's. It introduces a common 4xx SoC file (sysdev/ppc4xx_soc.c)
> > which currently "only" adds the L2 cache init code. Other common 4xx
> > stuff can be added later here.
> >
> > The L2 cache handling code is just a copy of Eugene's code in arch/ppc
> > with small modifications.
> >
> > Tested on AMCC Taishan 440GX and Canyonlands 460EX.
> >
> > Signed-off-by: Stefan Roese <sr@denx.de>
>
> It's my understanding that on some 44x platforms, the l2 needs to be
> explicitely invalidated on DMAs.

Correct.

> Do we know more about that ? I think it 
> depends on something like the number of masters on the PLB4 or so. I
> don't remember the details.

The L2 cache on the 440GX is cache coherent (via snooping). On the 
440SP/440SPe the L2 cache is partially coherent. The LL (Low Latency) PLB 
segment is coherent and the HB (High Bandwidth) PLB segment is unfortunately 
not. Here an except from the 440SPe users manual:

"
Cache coherency is limited to the Low Latency (LL) PLB bus and is managed by a 
hardware snoop mechanism or software (software that is similar to the 
existing CPU L1 cache)
"

So we will need to add something to handle the L2 cache on those platforms 
correctly. Not needed on 440GX though.

As for 460EX/GT this is currently not clear yet. I'm working on it with AMCC 
right now.

Best regards,
Stefan
