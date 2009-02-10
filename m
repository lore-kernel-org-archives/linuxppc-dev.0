Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 06980DDDA7
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 02:30:57 +1100 (EST)
Message-Id: <6413661A-2719-46F5-AC06-C83C088DCCA1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090210151047.GA25086@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc/83xx: Revive Marvell PHY option on MPC8313E-RDB
	rev. C boards
Date: Tue, 10 Feb 2009 09:30:49 -0600
References: <20090205201040.GB3425@oksana.dev.rtsoft.ru>
	<2a27d3730902082347n7f0eb48dq8c4ecccda290f9c8@mail.gmail.com>
	<ED186496-3882-4E87-9BEC-B56FE09C5827@kernel.crashing.org>
	<20090210151047.GA25086@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 10, 2009, at 9:10 AM, Anton Vorontsov wrote:

> commit e85477f516c2de7ed515fcf94ceab5282eba7fa4 ("powerpc/83xx: Fix
> TSEC0 workability on MPC8313E-RDB boards") fixed TSEC0 workability for
> rev. A and rev. B boards by using fixed-link property for VSC 7385
> 5-port switch. But rev. C boards have an option where TSEC0 connected
> to a Marvell PHY, which is a normal PHY on MDIO bus.
>
> So far U-Boot does not fix up TSEC0 nodes for MPC8313E-RDB boards, so
> we'd better include two device-tree files: one that specify Vitesse
> PHY and another for boards with Marvell PHY option.
>
> Reported-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>
> Li, thanks for heads-up!
>
> One thing though: documentation says that Marvell PHY address is
> 0x3, while old device tree and this patch:
>
> http://www.bitshrine.org/gpp/linux-fsl-2.6.23-MPC8313ERDB-add-default-dts.patch
>
> says "0x1"... I don't have any rev. C boards, so it would
> be great if somebody could confirm that 0x1 is the actual address.
>
> arch/powerpc/boot/dts/mpc8313erdb_marvell_phy.dts |  401 ++++++++++++ 
> +++++++++
> arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   |    2 +-
> 2 files changed, 402 insertions(+), 1 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/mpc8313erdb_marvell_phy.dts

did we decide that we don't have any bcsr or something that convey  
board rev or this setting?

- k
