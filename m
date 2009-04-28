Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id AB25FDDDFA
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 15:59:44 +1000 (EST)
Message-ID: <49F68943.3090800@denx.de>
Date: Tue, 28 Apr 2009 06:42:43 +0200
From: Heiko Schocher <hs@denx.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] 83xx: add support for the kmeter1 board.
References: <49F00605.1080605@denx.de>
	<6B76A454-649E-408C-A8DF-AAEEE6011929@kernel.crashing.org>
	<49F544DE.1010307@denx.de>
	<20090427180503.GB10292@ld0162-tx32.am.freescale.net>
In-Reply-To: <20090427180503.GB10292@ld0162-tx32.am.freescale.net>
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

Hello Scott,

Scott Wood wrote:
> On Mon, Apr 27, 2009 at 07:38:38AM +0200, Heiko Schocher wrote:
>> 1) add in the soc node an "errata" node and in this "errata" node
>>    we can add all CPU specific errata as an example the qe_enet10
>>    errata, which above code covers:
> 
> What about errata discovered after the device tree is deployed?

Didn;t know that there are such errata. Ok, this is a problem.

>>         soc8360@e0000000 {
>> 	[...]
>>                 errata {
>>                         device_type = "errata";
> 
> device_type is deprecated except for a couple of legacy uses.  Please do
> not add new ones.

Ok.

>>                         compatible = "fsl,mpc83xx_errata";
> 
> To be bound to by an "errata driver"? :-P

Why not ;-) ?

>>                         #address-cells = <1>;
>>                         #size-cells = <1>;
>>
>>                         qe_enet10@14a8 {
>>                                 device_type = "errata";
>>                                 compatible = "fsl,mpc83xx_errata_qe_enet10";
>>                                 reg = <0x14a8 0x08>;
> 
> But that register is part of the "QE parallel I/O port" block (even if it
> happens to be undocumented within that block), not part of the "QE ENET10
> erratum" block.  The device tree describes the hardware, not what you
> want to do with it.

Hmm.. isn;t this an errata for a buggy hardware? Why not describing this
in the dts?

> The presence of the erratum itself is indicated by the presence of the
> buggy device, possibly in conjunction with SVR if the device tree is not
> specific enough.

Ah, Ok, that was just an idea ... so, where and how to solve the qe_enet10
errata without using get_immrbase() (and I vote not to solve it as it
actuall is in board specific code, maybe as i proposed in an earlier mail
in the ucc_geth.c driver?)?

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
