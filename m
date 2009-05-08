Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 3DC28DDDA1
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 15:54:27 +1000 (EST)
Message-ID: <4A03C6AC.5080007@denx.de>
Date: Fri, 08 May 2009 07:44:12 +0200
From: Heiko Schocher <hs@denx.de>
MIME-Version: 1.0
To: "Varlese, Christopher" <Christopher.Varlese@keymile.com>
Subject: Re: [PATCH] 83xx: add support for the kmeter1 board.
References: <49F00605.1080605@denx.de><6B76A454-649E-408C-A8DF-AAEEE6011929@kernel.crashing.org>
	<49F544DE.1010307@denx.de>
	<D839955AA28B9A42A61B9181506E27C40182F50E@SRVCHBER1212.ch.keymile.net>
In-Reply-To: <D839955AA28B9A42A61B9181506E27C40182F50E@SRVCHBER1212.ch.keymile.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Christopher,

Varlese, Christopher wrote:
> (FYI I working on the kmeter1)
> 
> kmeter1.c reuses the same QE_ENET10 RGMII errata workaround code from mpc836x_mds.c (MPC8360EMDS eval board).
> 
> In my view errata nodes in the dts is overkill.   Maybe the errata code can go into a reusable function somewhere in 83xx/ or in ucc_geth.c?

To put an errata node in the dts was just an idea ;-)
I also mentioned putting this code in the ucc_geth.c driver ...

> I also think the original errata code needs improving:
> 	- mask some SVR bits so activated for all matching CPU models, e.g. MPC8360 & MPC8360E.

Did a first try in my v2 patch, see:

http://ozlabs.org/pipermail/linuxppc-dev/2009-April/071384.html

but I got no response yet.

> 	- The code in mpc836x_mds.c and kmeter1.c does not do exactly what Freescale errata says!

:-(

> Here the errata document:
> 	http://www.freescale.com/files/32bit/doc/errata/MPC8360ECE.pdf
> 
> Because kmeter1 is using an MPC8360 CPU model the workaround doesn't actually trigger.  So to kill 2 birds with 1 stone we tested a Uboot patch (below) doing what QE_ENET10 says.   It seemed to work fine for us.
>         /* RGMII timing Errata workaround for rev 2.1 silicon
>          * (ref: MPC8360ECE rev.1 12/2007 QE_ENET10 UCC2 option 1)
>          */
>         void *reg = (void *)(CONFIG_SYS_IMMR + 0x14ac);
>         clrsetbits_be32 (reg, 0x000000F0, 0x000000A0);
> 
>>From my point of view:
> 	- The workaround code in kmeter1.c could go for now.
> 	- An improved errata workaround for 836x boards would be nice (..who is motivated? :-))

I can make this errata, if someone gives advice, where to put ...
I vote for putting it into the ucc_geth.c driver, and activating it
maybe through the "phy-connection-type" if it activates the rgmii
mode ... ?

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
