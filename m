Return-Path: <sven@powerlinux.fr>
Received: from archon.plz.fr (archon.plz.fr [194.50.78.210])
	by ozlabs.org (Postfix) with ESMTP id 2796CDDE0F
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Oct 2007 21:51:32 +1000 (EST)
Date: Sun, 14 Oct 2007 13:33:36 +0200
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 4/7] bestcomm: core bestcomm support for Freescale
	MPC5200
Message-ID: <20071014113336.GA23286@powerlinux.fr>
References: <20071014044041.23438.14070.stgit@trillian.cg.shawcable.net>
	<20071014044205.23438.36036.stgit@trillian.cg.shawcable.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071014044205.23438.36036.stgit@trillian.cg.shawcable.net>
From: Sven Luther <sven@powerlinux.fr>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Oct 13, 2007 at 10:42:05PM -0600, Grant Likely wrote:
> From: Sylvain Munaut <tnt@246tNt.com>
> 
> This patch adds support for the core of the BestComm API
> for the Freescale MPC5200(b). The BestComm engine is a
> microcode-controlled / tasks-based DMA used by several
> of the onchip devices.
> 
> Setting up the tasks / memory allocation and all common
> low level functions are handled by this patch.
> The specifics details of each tasks and their microcode
> are split-out in separate patches.
> 
> This is not the official API, but a much cleaner one.
> (hopefully)
> 
> Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Hi Grant, ...

I am unsure if this is a regression with regard to Sylvain's patch, or
somethign else, but it is no more possible to build bestcomm modular :

ERROR: "bcom_enable" [drivers/net/fec_mpc52xx/fec_mpc52xx.ko] undefined!
ERROR: "bcom_disable" [drivers/net/fec_mpc52xx/fec_mpc52xx.ko] undefined!
ERROR: "bcom_task_alloc" [arch/powerpc/sysdev/bestcomm/bestcomm-gen-bd.ko] undefined!
ERROR: "bcom_sram" [arch/powerpc/sysdev/bestcomm/bestcomm-gen-bd.ko] undefined!
ERROR: "bcom_load_image" [arch/powerpc/sysdev/bestcomm/bestcomm-gen-bd.ko] undefined!
ERROR: "bcom_task_free" [arch/powerpc/sysdev/bestcomm/bestcomm-gen-bd.ko] undefined!
ERROR: "bcom_eng" [arch/powerpc/sysdev/bestcomm/bestcomm-gen-bd.ko] undefined!
ERROR: "bcom_set_initiator" [arch/powerpc/sysdev/bestcomm/bestcomm-gen-bd.ko] undefined!
ERROR: "bcom_task_alloc" [arch/powerpc/sysdev/bestcomm/bestcomm-fec.ko] undefined!
ERROR: "bcom_sram" [arch/powerpc/sysdev/bestcomm/bestcomm-fec.ko] undefined!
ERROR: "bcom_load_image" [arch/powerpc/sysdev/bestcomm/bestcomm-fec.ko] undefined!
ERROR: "bcom_task_free" [arch/powerpc/sysdev/bestcomm/bestcomm-fec.ko] undefined!
ERROR: "bcom_eng" [arch/powerpc/sysdev/bestcomm/bestcomm-fec.ko] undefined!
ERROR: "bcom_task_alloc" [arch/powerpc/sysdev/bestcomm/bestcomm-ata.ko] undefined!
ERROR: "bcom_sram" [arch/powerpc/sysdev/bestcomm/bestcomm-ata.ko] undefined!
ERROR: "bcom_load_image" [arch/powerpc/sysdev/bestcomm/bestcomm-ata.ko] undefined!
ERROR: "bcom_task_free" [arch/powerpc/sysdev/bestcomm/bestcomm-ata.ko] undefined!
ERROR: "bcom_eng" [arch/powerpc/sysdev/bestcomm/bestcomm-ata.ko] undefined!
ERROR: "bcom_set_initiator" [arch/powerpc/sysdev/bestcomm/bestcomm-ata.ko] undefined!

.config snipplet leading to this : 

CONFIG_PPC_BESTCOMM=m
CONFIG_PPC_BESTCOMM_ATA=m
CONFIG_PPC_BESTCOMM_FEC=m
CONFIG_PPC_BESTCOMM_GEN_BD=m
CONFIG_FEC_MPC52xx=m
CONFIG_FEC_MPC52xx_MDIO=m

This is building against the 2.6.23 tree, with assorted debian patches
applied, and the latest version of this and domen's patches.

Friendly,

Sven Luther
