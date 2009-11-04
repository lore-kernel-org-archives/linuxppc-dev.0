Return-Path: <max@hinterhof.net>
Received: from mail.nusquama.org (mail.nusquama.org [85.131.211.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.nusquama.org", Issuer "Max Vozeler" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 42E9EB7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  6 Nov 2009 01:36:11 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.nusquama.org (Postfix) with ESMTP id 40B9C3C10F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Nov 2009 15:06:28 +0100 (CET)
Received: from quark.vpn.nusquama.org (ip-92-50-90-221.unitymediagroup.de
	[92.50.90.221])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "quark.vpn.nusquama.org", Issuer "Max Vozeler" (verified OK))
	by mail.nusquama.org (Postfix) with ESMTP id 010BE3C10E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Nov 2009 15:06:28 +0100 (CET)
Resent-Message-ID: <20091105140559.GA11157@quark.vpn.nusquama.org>
Date: Wed, 4 Nov 2009 13:23:55 +0100
From: Max Vozeler <max@hinterhof.net>
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: term_adt746x: Invert bit required on this Powerbook G4
Message-ID: <20091104122355.GA7269@quark.vpn.nusquama.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlab.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I installed Ubuntu 8.10 on this Powerbook G4 ("alu" I think) 
for a friend of mine. As soon as therm_adt746x got loaded, the 
fan turned into a noise steam engine. 

This was on Ubuntu's 2.6.31 kernel (2.6.31-14-powerpc) which 
includes 0512a9a8e277a9de2. I could reproduce it with latest
mainline as well.

The effect was just as Michel described in the changelog; The
fan was running while temps were well below any of the limits,
and it stopped only when I set ridiculously low limits.

[ 1087.141482] adt746x: version 1 (supported)
[ 1087.141495] adt746x: Thermostat bus: 1, address: 0x2e, limit_adjust: 0, fan_speed: -1
[ 1087.141503] sensor 0: HDD BOTTOMSIDE
[ 1087.141507] sensor 1: CPU TOPSIDE
[ 1087.141512] sensor 2: GPU ON DIE
[ 1087.161365] adt746x: ADT7460 initializing
[ 1087.165245] adt746x: Lowering max temperatures from 73, 80, 109 to 70, 50, 70
[ 1087.165261] adt746x: Setting speed to 0 for CPU TOPSIDE fan.
[ 1087.166302] adt746x: Setting speed to 0 for GPU ON DIE fan.

(What "worked" was limit_adjust=-30, fan did turn off, but so did
the Powerbook shortly after, despite being cold.)

After some poking around, in which everything seemed to be
according to plan including write of 0 to both FAN_SPD_SET regs,
I noticed that explicitly *setting* the invert bit as in 

 -		write_reg(th, MANUAL_MODE[fan],
 -			(manual|MANUAL_MASK) & (~INVERT_MASK));
 +		write_reg(th, MANUAL_MODE[fan],
 +			(manual|MANUAL_MASK|INVERT_MASK));

seems to cure it. The fan appears to behave normally now, it
turns on slowly when the temp limits are reached, otherwise it
stays off. The temperature is reasonable (ie, no too hot).

So, puzzeled, I checked the spec, and it appears very clear on
the question of invert: It should be off by default.

I'm about to give the laptop back to my friend, but I suppose I 
could borrow it for further tests if anyone could guide me how 
to dig further into this.

Any hw/openfirmware details interesting?

	Max
