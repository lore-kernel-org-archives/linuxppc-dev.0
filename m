Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DDA9EB7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 07:30:35 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4D88DDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Aug 2009 07:30:34 +1000 (EST)
Subject: Re: ARM clock API to PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4A90486C-8BF5-428C-9FD8-830D822C0D40@kernel.crashing.org>
References: <1250063825.15143.43.camel@pasglop>
	<20090812111954.GB31596@zod.rchland.ibm.com>
	<4A90486C-8BF5-428C-9FD8-830D822C0D40@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 13 Aug 2009 07:29:59 +1000
Message-Id: <1250112599.3587.21.camel@pasglop>
Mime-Version: 1.0
Cc: devicetree-discuss@lists.ozlabs.org, John Jacques <john.jacques@lsi.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Torez Smith <torez@us.ibm.com>, Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-08-12 at 08:40 -0500, Kumar Gala wrote:

> I'm in the same boat as you Josh.  I think there is value and utility  
> here but not sure what problem Ben's trying to solve.

Well, there's several things here. 

First, it would be nice to improve clock management on some existing
SoCs. I'm not going to rewrite the powermac clock handling though :-)
But it might allow to cleanup some hacks we have there or add dynamic
clock handling in areas where we could improve power consumption etc...
by doing it but aren't today. Not critical but it's nice to have the
base layout there.

Don't you have parts where you'd like some more dynamic clock
management ? This API is a reasonably simple and nice way to get there.

Now, I know there is at least one person on earth contemplating sharing
some drivers between PPC and ARM. I won't tell much more at this stage,
but it makes sense in the grand scheme of things to see SoC vendors put
similar IO cores into either PPC or ARM and providing that clock API is
a good way to also allow these drivers to work since the drivers in
questions make use of it.

Also, note that the clk API is in include/linux/clk.h, ie, it's not
really ARM specific anymore in that sense, it's also very simple (it
leaves a lot to the implementation which is good) and thus my proposal
resolves in very little support code for us (mostly the clk_get()
implementation that hooks into ppc_md, the wrappers to call the
"methods" of struct clk, and the helper to parse the OF bits).

Cheers,
Ben.
