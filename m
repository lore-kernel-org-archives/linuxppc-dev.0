Return-Path: <laurent.pinchart@technotrade.biz>
Received: from outmx017.isp.belgacom.be (outmx017.isp.belgacom.be
	[195.238.4.116])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C58C8DE2E9
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Jan 2007 20:24:58 +1100 (EST)
Received: from outmx017.isp.belgacom.be (localhost [127.0.0.1])
	by outmx017.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l0P9OodR008584
	for <linuxppc-embedded@ozlabs.org>; Thu, 25 Jan 2007 10:24:50 +0100
	(envelope-from <laurent.pinchart@technotrade.biz>)
From: Laurent Pinchart <laurent.pinchart@technotrade.biz>
To: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: JTAG emulator for MPC8548E (v2)
Date: Thu, 25 Jan 2007 10:24:41 +0100
References: <BD261180E6D35F4D9D32F3E44FD3D901062D1E42@EMPBEDEX.empirix.com>
	<200701241206.18167.laurent.pinchart@technotrade.biz>
	<20070124171917.GB31703@gate.ebshome.net>
In-Reply-To: <20070124171917.GB31703@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701251024.41936.laurent.pinchart@technotrade.biz>
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

Hi Eugene,

> > > > The new unit works *mostly* fine. No debugging issue (not that I use
> > > > it that much anyway, now that the board boots Linux), but still a
> > > > flash programming issue. Programming the target parallel NOR flash
> > > > works in slow JTAG mode, but not in faster mode using the internal
> > > > workspace. I reported the problem several months ago and still
> > > > haven't received any solution.
> > >
> > > Most likely problem isn't in BDI but in your setup. Depending on
> > > the particular chip model, to be able use workspace you must have
> > > initialized memory first. In fact, I'm pretty sure you haven't
> > > configured chip correctly to make workspace usable. I've been using
> > > BDI with various PowerPC and MIPS SoCs for many years. It's an
> > > excellent tool, you just have to use it correctly.
> >
> > I wish it was that simple.
>
> Sorry, but it is. It's a low level tool which requires deep knowledge
> of the chip.
>
> >  It is probably a target processor configuration
> > issue, as I can use the workspace if
> >
> > a) the target flash has already been programmed with U-Boot
> > b) the BDI-2000 is misconfigured and fails to stop the target processor
> > at startup.
> >
> > I can thus use the workspace when U-Boot initializes the processor.
>
> Wow, so you knew it wasn't BDI but a configuration problem from the
> start. So it all was just a FUD, how low.

I don't agree with you there. It is a configuration issue related to the BDI. 
For all I know, it could be a bug in the BDI that only occurs when 
initialising given registers in a given sequence. Or it might be an issue 
with the BDI-2000 unit I got, which might have a hardware problem. I blamed 
my configuration file first, but even the tech support people haven't been 
able to locate the issue.

All I know is that U-Boot is able to initialise the processor correctly, but 
the BDI isn't, even when fed with a configuration file that performs the same 
initialisation sequence as U-Boot. There are two possible causes : either I 
got the configuration file wrong and forgot a setting, or the BDI fails to 
perform one of the steps correctly.

> > I had a look at U-Boot code and tried to initialize the processor
> > registers with the same values, without luck. I asked Abatron's French
> > distributor for technical support, and they haven't been able to help me.
> > They made me try lots of different initialization sequences. Several
> > people online sent me their configuration file, and none of them worked
> > for me.
> >
> > So, there must be a configuration problem somewhere, but even Abatron's
> > technical support haven't been able to find it. That's why I complained
> > about their support in my e-mail.
>
> In your original e-mail you made it look like BDI has a bug in it,
> which in fact isn't true. Bad support might be a concern, I agree, but
> this doesn't make a tool bad, IMHO.

I don't know where the bug is, unfortunately. As I stated, the BDI-2000 is a 
nice tool, which helped me a lot. I just wish I hadn't suffered such a bad 
technical support experience. That's probably the French distributor's fault, 
and it seems I have been very unlucky when contacting Abatron directly.

Laurent Pinchart
