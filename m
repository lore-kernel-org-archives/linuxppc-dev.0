Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0761C1A19DE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 17:53:57 +1000 (AEST)
Message-ID: <1436428426.3948.117.camel@kernel.crashing.org>
Subject: Re: PASEMI: PA6T board doesn't boot with the RC1 of kernel 4.2 anymore
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 09 Jul 2015 17:53:46 +1000
In-Reply-To: <1436406135.18682.3.camel@ellerman.id.au>
References: <559BB716.6040001@xenosoft.de> <559BC99D.20608@xenosoft.de>
 <559D653F.2060307@xenosoft.de>
 <1436394990.3948.113.camel@kernel.crashing.org>
 <1436406135.18682.3.camel@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-07-09 at 11:42 +1000, Michael Ellerman wrote:
> > 
> > There is no way that commit affects anything on that platform, it
> only
> > changes a file in arch/x86 that isn't compiled on a powerpc build.
> You
> > must have made a mistake in your bisection, possibly the one
> "sometimes
> > boots" should be considered good, but I can't say for sure.
> > 
> > Michael has a PA6T board at work, so I assume he will see if he can
> > reproduce.
> 
> Yeah I can't reproduce here.
> 
> I think you need to bisect again and look for the particular crash you
> reported. If you see that crash then mark it bad, else mark it good.

Michael, the crash looks like a neat NULL dereference, any chance you
can spot something in the code that might explain it ?

The strange thing is that the crash is in sb600_8259_cascade(), however
that function doesn't seem to exist in a current kernel tree, or if it
does it's somewhat hidden behind grep-defeating macros.

All I can find that relates to something called "sb600" is some quirks
in AHCI and x86 fixups that seem ATI related.

Christian, do you have some out of tree driver in that kernel ?

Ben.
 
