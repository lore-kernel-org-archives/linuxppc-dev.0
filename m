Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 514CA2C0296
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 13:49:10 +1000 (EST)
Message-ID: <1373428088.16720.8.camel@pasglop>
Subject: Re: [PATCH 1/2] powerpc/math-emu: remove the dead code in math.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 10 Jul 2013 13:48:08 +1000
In-Reply-To: <20130710032533.GA10374@concordia>
References: <1373420623-24869-1-git-send-email-haokexin@gmail.com>
 <1373420623-24869-2-git-send-email-haokexin@gmail.com>
 <20130710020132.GA7491@concordia>
 <20130710022307.GB361@pek-khao-d1.corp.ad.wrs.com>
 <20130710032533.GA10374@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>, Kevin Hao <haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-07-10 at 13:25 +1000, Michael Ellerman wrote:
> > > Any idea why we have that there? ie. have the config symbols changed
> > > over time or was this always dead code?
> > 
> > No idea. I tried to trace this before submitting the patch. But it has
> > been there since the begin of the git history. So I just assume that it is
> > always dead code. :-)
> 
> Yeah looks like it. Even in the git-huge tree I see it in the initial
> commit.
> 
> You should say that in the commit message though. Otherwise it's not
> clear if you're fixing a recent breakage or not.

This is ancient code that was meant to emulate only load/stores/fmr without
the rest of the emulation. The goal was to be able to boot userspace that
was compiled without -msoft-float to *some* extent (bcs it would potentially
use fp load/stores for things like memcpy) on small CPUs where the kernel
footprint was critical.

It's been obsolete for a while now.

Cheers,
Ben.
