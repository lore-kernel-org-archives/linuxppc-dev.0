Return-Path: <leon.woestenberg@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 378F6B71B5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 21:07:27 +1000 (EST)
Received: from mail-gx0-f210.google.com (mail-gx0-f210.google.com
	[209.85.217.210]) by ozlabs.org (Postfix) with ESMTP id 84898DDD1C
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 21:07:25 +1000 (EST)
Received: by gxk6 with SMTP id 6so324586gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 04:07:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c384c5ea0906170309j6fdf28f5qc38129e82649ef28@mail.gmail.com>
References: <c384c5ea0906160852l4845760cp8594463a866683dc@mail.gmail.com>
	<4A38AADD.3070801@aimvalley.nl>
	<c384c5ea0906170309j6fdf28f5qc38129e82649ef28@mail.gmail.com>
Date: Wed, 17 Jun 2009 13:07:23 +0200
Message-ID: <c384c5ea0906170407w5dfb891n2d4e4c41bf06b66d@mail.gmail.com>
Subject: Re: MPC83xx watchdog reset board dead lock
From: Leon Woestenberg <leon.woestenberg@gmail.com>
To: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Wed, Jun 17, 2009 at 12:09 PM, Leon
Woestenberg<leon.woestenberg@gmail.com> wrote:
> Quoting David Hawkins, who gave a very clear explanation:
> <...>
> If you have the Flash BUSY# signal, then this scheme works
> great, since using HRESET# low and BUSY# low to create a
> PORESET# source is only active until the Flash RESET#
> is asserted long enough for it to get out of the BUSY#
> state and back into read-array mode.
>

I just found out from a Spansion datasheet that the RY/BUSY# of a
typical Flash NOR is enabled by CE#, and tri-state otherwise.
CE# in turn is driven by the LCS# from the PowerPC.

So basically, the first configuration access cycle while the NOR is in
write mode, will pull CE# low, which results in RY/BUSY#
being driven.

I have measured this pulse is ~1.9 us. So the reset circuitry needs a
maximum minimum pulse duration of 1.9 us.

Our reset controller (DS1818) fulfills this requirement, with a T,PB of 1 us.

A reset controller will extend the reset pulse. This is needed because:

for Flash NOR: I have seen a mininum of 35 us reset pulse.
(for the PowerPC: PORESET# should be asserted externally for at least
32 input clock cycles)


Regards,
-- 
Leon
