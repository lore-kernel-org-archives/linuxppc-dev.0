Return-Path: <wfarnsworth@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id C7324DDF1A
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 02:51:25 +1000 (EST)
Subject: Re: [PATCH] Fix the LPC47M192 SuperIO on the MPC8641 HPCN
From: Wade Farnsworth <wfarnsworth@mvista.com>
To: Segher Boessenkool <segher@kernel.crashing.org>,
	Jon Loeliger <jdl@freescale.com>
In-Reply-To: <63ff9dee6b212cc7908c8e1b73920ea6@kernel.crashing.org>
References: <1181147415.5674.108.camel@rhino>
	<200706070039.51541.arnd@arndb.de> <1181232276.5674.146.camel@rhino>
	<63ff9dee6b212cc7908c8e1b73920ea6@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 09:51:24 -0700
Message-Id: <1181235084.5674.190.camel@rhino>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-06-07 at 18:35 +0200, Segher Boessenkool wrote:
> >> Hardcoded I/O port numbers always worry me a little. I know that this 
> >> is
> >> supposed to work in general, but can't you read the I/O port range 
> >> from
> >> a device tree property?
> >
> > I suppose I could create a device node for the Super I/O config
> > registers and use those instead of hardcoding it here.
> 
> I'd just hide it all, do this setup in the firmware,
> where it belongs, and don't expose the superio config
> in the device tree.

That's a valid point.  This probably could (should?) be handled by
U-boot.

Jon, or others do you have any opinions on this?

> 
> > superio_cfg@4e {
> > 	reg = <1 4e 2>;
> > 	compatible = "smsc-lpc47m192-cfg";
> > };
> >
> > I'm not sure if the name and compatible properties are appropriate
> > though.  Any recommendations?
> 
> "superio" and "smsc,lpc47m192" I'd say.  You also
> then should link the logical devices on the superio
> to the device nodes that represent those.  I'm not
> sure this is all worth it, this is low-level setup
> the firmware should do and everything else can treat
> it as a black box.

OK, if we decide to keep this, I'll use those instead.

Thanks.

--Wade
