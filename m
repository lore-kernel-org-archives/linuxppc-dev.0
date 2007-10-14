Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 3287CDDE1D
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 06:22:18 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1841131wag
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Oct 2007 13:22:17 -0700 (PDT)
Message-ID: <fa686aa40710141322h308db79ey921fd9d4cea5d1d5@mail.gmail.com>
Date: Sun, 14 Oct 2007 14:22:16 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sven Luther" <sven@powerlinux.fr>
Subject: Re: [PATCH v2 4/7] bestcomm: core bestcomm support for Freescale
	MPC5200
In-Reply-To: <20071014113336.GA23286@powerlinux.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071014044041.23438.14070.stgit@trillian.cg.shawcable.net>
	<20071014044205.23438.36036.stgit@trillian.cg.shawcable.net>
	<20071014113336.GA23286@powerlinux.fr>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/14/07, Sven Luther <sven@powerlinux.fr> wrote:
> On Sat, Oct 13, 2007 at 10:42:05PM -0600, Grant Likely wrote:
> > From: Sylvain Munaut <tnt@246tNt.com>
> >
> > This patch adds support for the core of the BestComm API
> > for the Freescale MPC5200(b). The BestComm engine is a
> > microcode-controlled / tasks-based DMA used by several
> > of the onchip devices.
> >
> > Setting up the tasks / memory allocation and all common
> > low level functions are handled by this patch.
> > The specifics details of each tasks and their microcode
> > are split-out in separate patches.
> >
> > This is not the official API, but a much cleaner one.
> > (hopefully)
> >
> > Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
> > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>
> Hi Grant, ...
>
> I am unsure if this is a regression with regard to Sylvain's patch, or
> somethign else, but it is no more possible to build bestcomm modular :

Hmmm, interesting.  I'll try that out here this afternoon.

g.

>
> ERROR: "bcom_enable" [drivers/net/fec_mpc52xx/fec_mpc52xx.ko] undefined!
> ERROR: "bcom_disable" [drivers/net/fec_mpc52xx/fec_mpc52xx.ko] undefined!
> ERROR: "bcom_task_alloc" [arch/powerpc/sysdev/bestcomm/bestcomm-gen-bd.ko] undefined!
> ERROR: "bcom_sram" [arch/powerpc/sysdev/bestcomm/bestcomm-gen-bd.ko] undefined!
> ERROR: "bcom_load_image" [arch/powerpc/sysdev/bestcomm/bestcomm-gen-bd.ko] undefined!
> ERROR: "bcom_task_free" [arch/powerpc/sysdev/bestcomm/bestcomm-gen-bd.ko] undefined!
> ERROR: "bcom_eng" [arch/powerpc/sysdev/bestcomm/bestcomm-gen-bd.ko] undefined!
> ERROR: "bcom_set_initiator" [arch/powerpc/sysdev/bestcomm/bestcomm-gen-bd.ko] undefined!
> ERROR: "bcom_task_alloc" [arch/powerpc/sysdev/bestcomm/bestcomm-fec.ko] undefined!
> ERROR: "bcom_sram" [arch/powerpc/sysdev/bestcomm/bestcomm-fec.ko] undefined!
> ERROR: "bcom_load_image" [arch/powerpc/sysdev/bestcomm/bestcomm-fec.ko] undefined!
> ERROR: "bcom_task_free" [arch/powerpc/sysdev/bestcomm/bestcomm-fec.ko] undefined!
> ERROR: "bcom_eng" [arch/powerpc/sysdev/bestcomm/bestcomm-fec.ko] undefined!
> ERROR: "bcom_task_alloc" [arch/powerpc/sysdev/bestcomm/bestcomm-ata.ko] undefined!
> ERROR: "bcom_sram" [arch/powerpc/sysdev/bestcomm/bestcomm-ata.ko] undefined!
> ERROR: "bcom_load_image" [arch/powerpc/sysdev/bestcomm/bestcomm-ata.ko] undefined!
> ERROR: "bcom_task_free" [arch/powerpc/sysdev/bestcomm/bestcomm-ata.ko] undefined!
> ERROR: "bcom_eng" [arch/powerpc/sysdev/bestcomm/bestcomm-ata.ko] undefined!
> ERROR: "bcom_set_initiator" [arch/powerpc/sysdev/bestcomm/bestcomm-ata.ko] undefined!
>
> .config snipplet leading to this :
>
> CONFIG_PPC_BESTCOMM=m
> CONFIG_PPC_BESTCOMM_ATA=m
> CONFIG_PPC_BESTCOMM_FEC=m
> CONFIG_PPC_BESTCOMM_GEN_BD=m
> CONFIG_FEC_MPC52xx=m
> CONFIG_FEC_MPC52xx_MDIO=m
>
> This is building against the 2.6.23 tree, with assorted debian patches
> applied, and the latest version of this and domen's patches.
>
> Friendly,
>
> Sven Luther
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
