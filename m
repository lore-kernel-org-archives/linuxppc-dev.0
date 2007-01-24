Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EED98DDF18
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Jan 2007 04:19:19 +1100 (EST)
Date: Wed, 24 Jan 2007 09:19:17 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Laurent Pinchart <laurent.pinchart@technotrade.biz>
Subject: Re: JTAG emulator for MPC8548E (v2)
Message-ID: <20070124171917.GB31703@gate.ebshome.net>
References: <BD261180E6D35F4D9D32F3E44FD3D901062D1E42@EMPBEDEX.empirix.com>
	<200701240857.19428.laurent.pinchart@technotrade.biz>
	<20070124103548.GA31703@gate.ebshome.net>
	<200701241206.18167.laurent.pinchart@technotrade.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200701241206.18167.laurent.pinchart@technotrade.biz>
Cc: "Morrison, Tom" <tmorrison@empirix.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jan 24, 2007 at 12:06:17PM +0100, Laurent Pinchart wrote:
> Hi Eugene,
> 
> > > The new unit works *mostly* fine. No debugging issue (not that I use it
> > > that much anyway, now that the board boots Linux), but still a flash
> > > programming issue. Programming the target parallel NOR flash works in
> > > slow JTAG mode, but not in faster mode using the internal workspace. I
> > > reported the problem several months ago and still haven't received any
> > > solution.
> >
> > Most likely problem isn't in BDI but in your setup. Depending on
> > the particular chip model, to be able use workspace you must have
> > initialized memory first. In fact, I'm pretty sure you haven't
> > configured chip correctly to make workspace usable. I've been using
> > BDI with various PowerPC and MIPS SoCs for many years. It's an excellent
> > tool, you just have to use it correctly.
> 
> I wish it was that simple.

Sorry, but it is. It's a low level tool which requires deep knowledge 
of the chip.

>  It is probably a target processor configuration 
> issue, as I can use the workspace if
> 
> a) the target flash has already been programmed with U-Boot
> b) the BDI-2000 is misconfigured and fails to stop the target processor at 
> startup.
> 
> I can thus use the workspace when U-Boot initializes the processor.

Wow, so you knew it wasn't BDI but a configuration problem from the 
start. So it all was just a FUD, how low.  

> 
> I had a look at U-Boot code and tried to initialize the processor registers 
> with the same values, without luck. I asked Abatron's French distributor for 
> technical support, and they haven't been able to help me. They made me try 
> lots of different initialization sequences. Several people online sent me 
> their configuration file, and none of them worked for me.
> 
> So, there must be a configuration problem somewhere, but even Abatron's 
> technical support haven't been able to find it. That's why I complained about 
> their support in my e-mail.

In your original e-mail you made it look like BDI has a bug in it, 
which in fact isn't true. Bad support might be a concern, I agree, but 
this doesn't make a tool bad, IMHO.

-- 
Eugene
