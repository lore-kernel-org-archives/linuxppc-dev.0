Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BCE49DE01D
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 23:35:58 +1100 (EST)
Message-Id: <A9D24B54-FDB5-44E3-9A20-05CCE12AE0A0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: John Rigby <jrigby@freescale.com>
In-Reply-To: <1223406020-12278-2-git-send-email-jrigby@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 1/3] powerpc: 83xx: pci: Remove need for get_immrbase from
	mpc83xx_add_bridge.
Date: Wed, 8 Oct 2008 07:35:09 -0500
References: <1223406020-12278-1-git-send-email-jrigby@freescale.com>
	<1223406020-12278-2-git-send-email-jrigby@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 7, 2008, at 2:00 PM, John Rigby wrote:

> Modify mpc83xx_add_bridge to get config space register base address  
> from the device
> tree instead of immr + hardcoded offset.
>
> 83xx pci nodes have this change:
>    register properties now contain two address length tuples:
> 	First is the pci bridge register base, this has always been there.
> 	Second is the config base, this is new.
>
> This is documented in Documentation/powerpc/dts-bindings/fsl/ 
> 83xx-512x-pci.txt
>
> The changes accomplish these things:
>    mpc83xx_add_bridge no longer needs to call get_immrbase
>    it uses hard coded addresses if the second register value is  
> missing
>
> Signed-off-by: John Rigby <jrigby@freescale.com>
> ---
> .../powerpc/dts-bindings/fsl/83xx-512x-pci.txt     |   40 +++++++++++ 
> +++
> arch/powerpc/boot/dts/mpc8313erdb.dts              |    3 +-
> arch/powerpc/boot/dts/mpc8315erdb.dts              |    3 +-
> arch/powerpc/boot/dts/mpc832x_mds.dts              |    3 +-
> arch/powerpc/boot/dts/mpc832x_rdb.dts              |    3 +-
> arch/powerpc/boot/dts/mpc8349emitx.dts             |    6 ++-
> arch/powerpc/boot/dts/mpc8349emitxgp.dts           |    3 +-
> arch/powerpc/boot/dts/mpc834x_mds.dts              |    6 ++-
> arch/powerpc/boot/dts/mpc836x_mds.dts              |    3 +-
> arch/powerpc/boot/dts/mpc836x_rdk.dts              |    3 +-
> arch/powerpc/boot/dts/mpc8377_mds.dts              |    3 +-
> arch/powerpc/boot/dts/mpc8377_rdb.dts              |    3 +-
> arch/powerpc/boot/dts/mpc8378_mds.dts              |    3 +-
> arch/powerpc/boot/dts/mpc8378_rdb.dts              |    3 +-
> arch/powerpc/boot/dts/mpc8379_mds.dts              |    3 +-
> arch/powerpc/boot/dts/mpc8379_rdb.dts              |    3 +-
> arch/powerpc/boot/dts/sbc8349.dts                  |    3 +-
> arch/powerpc/sysdev/fsl_pci.c                      |   54 +++++++++++ 
> ++-------
> 18 files changed, 111 insertions(+), 37 deletions(-)
> create mode 100644 Documentation/powerpc/dts-bindings/fsl/83xx-512x- 
> pci.txt

applied

- k
