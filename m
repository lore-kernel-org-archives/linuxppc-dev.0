Return-Path: <max@hinterhof.net>
Received: from mail.nusquama.org (mail.nusquama.org [85.131.211.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.nusquama.org", Issuer "Max Vozeler" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 4EE93B7B9A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  6 Nov 2009 01:36:11 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.nusquama.org (Postfix) with ESMTP id 5E6243C110
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Nov 2009 15:06:31 +0100 (CET)
Received: from quark.vpn.nusquama.org (ip-92-50-90-221.unitymediagroup.de
	[92.50.90.221])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "quark.vpn.nusquama.org", Issuer "Max Vozeler" (verified OK))
	by mail.nusquama.org (Postfix) with ESMTP id 1E9EE3C10E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Nov 2009 15:06:31 +0100 (CET)
Resent-Message-ID: <20091105140603.GB11157@quark.vpn.nusquama.org>
Date: Wed, 4 Nov 2009 13:39:49 +0100
From: Max Vozeler <max@hinterhof.net>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: term_adt746x: Invert bit required on this Powerbook G4
Message-ID: <20091104123949.GA9104@quark.vpn.nusquama.org>
References: <20091104122355.GA7269@quark.vpn.nusquama.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20091104122355.GA7269@quark.vpn.nusquama.org>
Cc: linuxppc-dev@lists.ozlab.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 04, 2009 at 01:23:55PM +0100, Max Vozeler wrote:
> After some poking around, in which everything seemed to be
> according to plan including write of 0 to both FAN_SPD_SET regs,
> I noticed that explicitly *setting* the invert bit as in 
> 
>  -		write_reg(th, MANUAL_MODE[fan],
>  -			(manual|MANUAL_MASK) & (~INVERT_MASK));
>  +		write_reg(th, MANUAL_MODE[fan],
>  +			(manual|MANUAL_MASK|INVERT_MASK));
> 
> seems to cure it. The fan appears to behave normally now, it
> turns on slowly when the temp limits are reached, otherwise it
> stays off. The temperature is reasonable (ie, no too hot).
> 
> So, puzzeled, I checked the spec, and it appears very clear on
> the question of invert: It should be off by default.

Another datapoint: 

The PRAM battery in this Powerbook is old, so it forgets e.g.
clock state completely when not connected to the power supply.

These are the PWM1/PWM2 registers during probe_thermostat() 
after such a complete poweroff:

[   28.332700] adt746x: ADT7460 initializing
[   28.385266] ZZZ MANUAL_MODE[0] 0xd2
[   28.385832] ZZZ MANUAL_MODE[1] 0x82

So if I'm reading this correctly, PWM1 starts off with the 
invert bit (0x10) set, for some reason.

	Max
