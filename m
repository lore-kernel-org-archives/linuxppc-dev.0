Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 2365EDE081
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 16:09:46 +1000 (EST)
Message-ID: <4A0D03AB.2040602@denx.de>
Date: Fri, 15 May 2009 07:54:51 +0200
From: Heiko Schocher <hs@denx.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] [PowerPC] MPC8272ADS: fix device tree for 8 MB flash, size
References: <mailman.7754.1242158509.26545.linuxppc-dev@ozlabs.org>
	<4A0A683B.5010209@denx.de>
	<20090514214819.GA15549@b07421-ec1.am.freescale.net>
In-Reply-To: <20090514214819.GA15549@b07421-ec1.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>,
	linux-kernel@vger.kernel.org
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
> On Wed, May 13, 2009 at 08:27:07AM +0200, Heiko Schocher wrote:
>> Hello Wolfgang,
>>
>>> The current device tree for the MPC8272ADS assumes a mapping of 32 MB
>>> of NOR flash at 0xFE00.0000, while there are actually only 8 MB on
>>> the boards, mapped at 0xFF80.0000. When booting an uImage with such a
>>> device tree, the kernel crashes because 0xFE00.0000 is not mapped.
>> Wouldn;t it be better, if u-boot fixes the device tree entries?
> 
> We should proabbly leave out the ranges altogether, and have u-boot
> populate it from the mappings it establishes.

No, I vote for manipulating just the entries, which u-boot dynamically
detect, and let the other entries untouched. It is possible that
there is a device which u-boot didn;t use/know, and there is in the DTS
an ranges entry for it (Maybe not on the MPC8727ADS, but we should
define a rule, how a bootloader has to manipulate entries). So if
u-boot build the complete ranges entry, it maybe miss something.

>> I think, u-boot should know, where the flash begins and ends, and
>> because this is maybe a dynamic variable for this board, it should
>> be better, if u-boot fixes this, so no need for adding a device tree
>> for every board variant.
> 
> Flash is on a SIMM on this board, and the board manual says it's
> expandable to 32 MiB.  However, I suspect that the current DTS was just
> an error as I based it on a board that had not had its flash SIMM
> modified.  That specific flash SIMM is no longer working (or perhaps just
> got its contents corrupted -- one of these days I may hook up a BDI and
> try to reflash), so I can't go back and check.
> 
> I don't see how current u-boot would accomodate more than 8MiB flash on
> this board (there's some detection in board/freescale/mpc8260ads/flash.c,

Didn;t this board uses the CFI driver? :-(

> but I don't see any setting of BR0 besides the preliminary value at
> 0xff800000).

OK, then the patch from Wolfgang should be sufficient.

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
