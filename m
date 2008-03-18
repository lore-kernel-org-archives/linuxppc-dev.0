Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6FECDDE010
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 03:19:41 +1100 (EST)
Date: Tue, 18 Mar 2008 19:19:18 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: hs@denx.de
Subject: Re: [PATCH v2] 8xx: Add support for the MPC852 based board from
	keymile.
Message-ID: <20080318191918.6505ba41@kernel.crashing.org>
In-Reply-To: <47DF777E.2030103@denx.de>
References: <47DA444E.9050507@denx.de>
	<20080315102508.bc698a90.sfr@canb.auug.org.au>
	<47DF6B82.4030404@denx.de>
	<20080318183320.49c98183.sfr@canb.auug.org.au>
	<47DF777E.2030103@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 18 Mar 2008 09:04:14 +0100
Heiko Schocher wrote:

> Hello Stephen,
> 
> Stephen Rothwell wrote:
> > On Tue, 18 Mar 2008 08:13:06 +0100 Heiko Schocher <hs@denx.de>
> > wrote:
> >> Stephen Rothwell wrote:
> >>> On Fri, 14 Mar 2008 10:24:30 +0100 Heiko Schocher <hs@denx.de>
> >>> wrote:
> >> [...]
> >>>> +struct cpm_pin {
> >>>> +		int port, pin, flags;
> >>>> +};
> >>> I wish someone would consolidate all these definitions of cpm_pin.
> >> Hmm... do you mean something like, moving this struct
> >> in cpm1.h and ...
> > 
> > Yes or somewhere else appropriate.
> > 
> >>>> +	for (i = 0; i < ARRAY_SIZE(mgsuvd_pins); i++) {
> >>>> +		struct cpm_pin *pin = &mgsuvd_pins[i];
> >>>> +		cpm1_set_pin(pin->port, pin->pin, pin->flags);
> >>>> +	}
> >>> And the code that uses them ...
> >> making in arch/powerpc/sysdev/cpm1.c a function
> >> cpm1_setup_pins (struct cpm_pin *pins) ?
> > 
> > Yes.
> > 
> > This is not necessary for your patch, but would be a nice cleanup
> > later. N.B. this struct is alos used by users of cpm2_set_pin().
> 
> OK. Another thought about this. Shouldnt this table go in the dts?
> A device node like
> 
> cpm_pin {
> 	pins = <port pin flags>;
> };
> 
> would be nice, or?
> 
This has been a disputable question some time ago, and decided (or it looks like decided) that devtree describes hardware, and not the way it is configured at the moment. Therefor, best way for pin stuff is considered, as Scott mentioned, to set up stuff inside the firmware.

-Vitaly

> bye,
> Heiko
> 
