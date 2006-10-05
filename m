Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3FCA367DB6
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Oct 2006 10:08:55 +1000 (EST)
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17700.19414.724178.711359@cargo.ozlabs.ibm.com>
References: <20060927155626.4d5ca19c@vitb.ru.mvista.com>
	<4879B0C6C249214CBE7AB04453F84E4D19D865@zch01exm20.fsl.freescale.net>
	<20060927165556.04c8d5d7@vitb.ru.mvista.com>
	<CE624A83-809E-4180-800E-660A578FFCFC@embeddedalley.com>
	<20060927112201.293fef44@localhost.localdomain>
	<EBD0615C-4F22-430F-BD23-1283DF98F1B3@embeddedalley.com>
	<1159942128.13323.21.camel@localhost.localdomain>
	<7BD0D5CE-7BA3-43DC-B972-B75672F6A31E@embeddedalley.com>
	<1160005019.5887.30.camel@localhost.localdomain>
	<17700.19414.724178.711359@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 10:08:40 +1000
Message-Id: <1160006920.5887.40.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-10-05 at 10:03 +1000, Paul Mackerras wrote:
> Benjamin Herrenschmidt writes:
> 
> > > It's the 'or not' part that I am worried about.  Things like
> > > you mention above make sense.  I'm starting to worry about
> > > some of this other stuff, and the bscr example is what
> > > woke me up :-)  I think that's an example of things that
> > > should be considered not necessary.
> > 
> > I haven't looked at this specific example. I'll try to have a look
> > later. I jumped into the discussion pointed by somebody else :)
> 
> That one was interesting - the bcsr was being referenced from an
> ethernet driver that looked to me like it would be useful on any board
> based on an 836x chip (I think).  Yet it was claimed that the bcsr was
> so specific and unique to each board that there was no point putting
> it in the device tree - which implies that we would have to have a
> separate lump of code in the tree to drive it for every single
> board. :P  I asked why the ethernet driver was accessing it directly
> if that was the case, but didn't get an answer (well, only an indirect
> answer in that the bcsr access code got removed from the ethernet
> driver).

Well, feature calls might be the answer there... at least to move the
problem out of the driver to the platform code. They are after all just
a way to do random calls into the BSP from drivers, though they have
some issues too (you gotta hope you are running the right platform code
that understands your calls, in which case, why not just call an
exported function ...)

Ben.
