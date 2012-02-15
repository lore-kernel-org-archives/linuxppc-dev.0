Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EE7991007D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2012 11:02:14 +1100 (EST)
Message-ID: <1329264105.3772.12.camel@pasglop>
Subject: Re: [PATCH v3] powerpc: Rework lazy-interrupt handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 15 Feb 2012 11:01:45 +1100
In-Reply-To: <1329201969.3772.7.camel@pasglop>
References: <1329201969.3772.7.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, Stuart Yoder <b08248@gmail.com>,
 Anton Blanchard <anton@au1.ibm.com>,
 Laurentiu Tudor <Laurentiu.Tudor@freescale.com>,
 Paul Mackerras <pmac@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-02-14 at 17:46 +1100, Benjamin Herrenschmidt wrote:
> The current implementation of lazy interrupts handling has some
> issues that this tries to address.
> 
> Except on iSeries, we don't do the various workarounds we need to
> do on re-enable when returning from an interrupt, which can do an
> implicit re-enable, and thus we may still lose or get delayed
> decrementer or doorbell interrupts.

 .../...

So we were still losing doorbells on BookE due to a st00pid thinko on my
part :-) New patch following, hopefully that one's good !

Cheers,
Ben.
