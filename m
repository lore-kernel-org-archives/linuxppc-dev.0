Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
 [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CFAE0B6F99
 for <linuxppc-dev@ozlabs.org>; Sat, 21 Jan 2012 07:05:23 +1100 (EST)
Message-ID: <4F19C8F8.1090801@freescale.com>
Date: Fri, 20 Jan 2012 14:05:12 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
Subject: Re: Cannot wake-up from standby with MPC8313
References: <4F047BF8.7090400@aimvalley.nl> <4F04BFEA.1050009@freescale.com>
 <4F05C8C2.9070401@aimvalley.nl> <4F05EA6B.9040902@freescale.com>
 <4F06FCBC.4090302@aimvalley.nl> <4F076187.2080308@freescale.com>
 <4F103C17.3080003@aimvalley.nl> <4F1486F1.7000406@freescale.com>
 <4F15A83C.7020805@aimvalley.nl> <4F15F17C.20202@freescale.com>
 <4F169BE3.30102@aimvalley.nl>
In-Reply-To: <4F169BE3.30102@aimvalley.nl>
Content-Type: text/plain; charset="windows-1252"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/18/2012 04:16 AM, Norbert van Bolhuis wrote:
> Yes this is it!
> You mentioned mpc8313erdb bug before, I guess you had to mention it
> twice before
> I looked at mpc8313erdb bug description.
>=20
> The mpc8313erdb bug is described as follows:
>=20
> 3.5 Power management control (PMC) registers cannot be
> accessed?
> The PMC registers range from IMMR + 0x0B00 to IMMR + 0x0BFF. When this
> area is accessed in u-boot,
> the RDB hangs up. It appears that the PMC block is related to the JTAG
> interface; TRST must not be pulled
> down for normal operation of the PMC block. Possible workarounds are as
> follows:
> =95 Attach a debugger to drive TRST high during normal operation.
> =95 Remove the pull-down resistor (R37) for TRST. Although this tested =
on
> some RDBs without any
> problem, it violates the hardware specification. If it does not work on
> your RDB, use another workaround.
>=20
>=20
> I guess this is an MPC8313 problem rather than an MPC8313E-RDB problem =
?
> and I would expect it to be mentioned in MPC8313E Errata (which isn't t=
he
> case).

It is mentioned in the MPC8313E manual (4.2.2 step #10) that TRST must
not be asserted except when PORESET is asserted.  The mpc8313erdb bug
was that the board was not complying with this.

-Scott
