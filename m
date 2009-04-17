Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 831A8DE0DF
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 05:05:01 +1000 (EST)
Subject: Re: Question about DBCR0 initialization for 440
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <200904171307.47734.hollisb@us.ibm.com>
References: <20090414203313.8D8F11BE8056@mail209-sin.bigfish.com>
	<20090417154628.43F859D0055@mail178-wa4.bigfish.com>
	<625fc13d0904171022u4d7d5d8cve0ccfb74cc31f554@mail.gmail.com>
	<200904171307.47734.hollisb@us.ibm.com>
Content-Type: text/plain
Date: Fri, 17 Apr 2009 21:04:47 +0200
Message-Id: <1239995087.7210.19.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, John Linn <John.Linn@xilinx.com>,
	Tirumala Reddy Marri <tmarri@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-04-17 at 13:07 -0500, Hollis Blanchard wrote:
> On Friday 17 April 2009 12:22:37 Josh Boyer wrote:
> > On Fri, Apr 17, 2009 at 11:46 AM, John Linn <John.Linn@xilinx.com> wrote:
> > > Josh, any thoughts on putting this into head_44x.S?
> > 
> > The code in the fsl file looks like the right solution.  I do have an
> > odd question though, in that it's hard for the
> > kernel to really know if something like a BDI is running.  Namely,
> > that config option doesn't cover RiscWatch in an obvious manner.
> 
> Yeah, setting DBCR0 would interfere with all JTAG probes. The ifdef meands you 
> can't support both a JTAG debugger and hardware breakpoints in the same 
> binary? Now that's an annoying restriction.

Might be worth checking if external debug is enabled, and override it
only if it's not.


Ben.
