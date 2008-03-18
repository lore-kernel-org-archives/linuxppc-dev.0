Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id BC7CDDDE1B
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 18:56:31 +1100 (EST)
Message-ID: <47DF777E.2030103@denx.de>
Date: Tue, 18 Mar 2008 09:04:14 +0100
From: Heiko Schocher <hs@denx.de>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2] 8xx: Add support for the MPC852 based board from
	keymile.
References: <47DA444E.9050507@denx.de>	<20080315102508.bc698a90.sfr@canb.auug.org.au>	<47DF6B82.4030404@denx.de>
	<20080318183320.49c98183.sfr@canb.auug.org.au>
In-Reply-To: <20080318183320.49c98183.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-dev@ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Stephen,

Stephen Rothwell wrote:
> On Tue, 18 Mar 2008 08:13:06 +0100 Heiko Schocher <hs@denx.de> wrote:
>> Stephen Rothwell wrote:
>>> On Fri, 14 Mar 2008 10:24:30 +0100 Heiko Schocher <hs@denx.de> wrote:
>> [...]
>>>> +struct cpm_pin {
>>>> +		int port, pin, flags;
>>>> +};
>>> I wish someone would consolidate all these definitions of cpm_pin.
>> Hmm... do you mean something like, moving this struct
>> in cpm1.h and ...
> 
> Yes or somewhere else appropriate.
> 
>>>> +	for (i = 0; i < ARRAY_SIZE(mgsuvd_pins); i++) {
>>>> +		struct cpm_pin *pin = &mgsuvd_pins[i];
>>>> +		cpm1_set_pin(pin->port, pin->pin, pin->flags);
>>>> +	}
>>> And the code that uses them ...
>> making in arch/powerpc/sysdev/cpm1.c a function
>> cpm1_setup_pins (struct cpm_pin *pins) ?
> 
> Yes.
> 
> This is not necessary for your patch, but would be a nice cleanup later.
> N.B. this struct is alos used by users of cpm2_set_pin().

OK. Another thought about this. Shouldnt this table go in the dts?
A device node like

cpm_pin {
	pins = <port pin flags>;
};

would be nice, or?

bye,
Heiko

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
