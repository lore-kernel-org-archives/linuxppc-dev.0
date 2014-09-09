Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0114.outbound.protection.outlook.com [207.46.100.114])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9ACA31A0021
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 11:01:21 +1000 (EST)
Message-ID: <1410305198.24184.336.camel@snotra.buserror.net>
Subject: Re: [PATCH v2] QE: move qe code from arch/powerpc to drivers/soc
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
Date: Tue, 9 Sep 2014 18:26:38 -0500
In-Reply-To: <88ded7369c0546aabeececed5f1a4c06@BLUPR03MB341.namprd03.prod.outlook.com>
References: <1409807186-45816-1-git-send-email-B45475@freescale.com>
 <1409870809.24184.163.camel@snotra.buserror.net>
 <88ded7369c0546aabeececed5f1a4c06@BLUPR03MB341.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Xie Xiaobo-R63061 <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-09-09 at 04:27 -0500, Zhao Qiang-B45475 wrote:
> On Fri, 2014-09-05 at 06:47 AM, Wood Scott wrote:
> 
> 
> 
> > Subject: Re: [PATCH v2] QE: move qe code from arch/powerpc to drivers/soc
> > 
> > On Thu, 2014-09-04 at 13:06 +0800, Zhao Qiang wrote:
> > > LS1 is arm cpu and it has qe ip block.
> > > move qe code from platform directory to public directory.
> > >
> > > QE is an IP block integrates several comunications peripheral
> > > controllers. It can implement a variety of applications, such as uart,
> > > usb and tdm and so on.
> > >
> > > Signed-off-by: Zhao Qiang <B45475@freescale.com>
> > > ---
> > > Changes for v2:
> > > 	- mv code to drivers/soc
> > 
> > Who will be the maintainer of this code once it lives in drivers/soc,
> > especially once it is no longer used only by PPC?
> 
> I have no idea about that, can you explain why you want to know who will be the maintainer.

Currently it falls within "Freescale PPC" which I maintain.  This moves
it out of arch/powerpc and is the first step towards making it not be
PPC-specific.  Whose tree are you expecting patches to
drivers/soc/fsl-qe to go through?

> > > diff --git a/drivers/soc/qe/Kconfig b/drivers/soc/qe/Kconfig new file
> > > mode 100644 index 0000000..8b03ca2
> > > --- /dev/null
> > > +++ b/drivers/soc/qe/Kconfig
> > > @@ -0,0 +1,45 @@
> > > +#
> > > +# QE Communication options
> > > +#
> > > +config QUICC_ENGINE
> > > +	bool "Freescale QUICC Engine (QE) Support"
> > > +	depends on FSL_SOC && PPC32
> > > +	select PPC_LIB_RHEAP
> > > +	select CRC32
> > > +	help
> > > +	  The QUICC Engine (QE) is a new generation of communications
> > > +	  coprocessors on Freescale embedded CPUs (akin to CPM in older
> > chips).
> > > +	  Selecting this option means that you wish to build a kernel
> > > +	  for a machine with a QE coprocessor.
> > > +
> > > +config QE_GPIO
> > > +	bool "QE GPIO support"
> > > +	depends on QUICC_ENGINE
> > > +	select ARCH_REQUIRE_GPIOLIB
> > > +	help
> > > +	  Say Y here if you're going to use hardware that connects to the
> > > +	  QE GPIOs.
> > > +
> > > +config UCC_SLOW
> > > +	bool
> > > +	default y if SERIAL_QE
> > > +	help
> > > +	  This option provides qe_lib support to UCC slow
> > > +	  protocols: UART, BISYNC, QMC
> > > +
> > > +config UCC_FAST
> > > +	bool
> > > +	default y if UCC_GETH
> > > +	help
> > > +	  This option provides qe_lib support to UCC fast
> > > +	  protocols: HDLC, Ethernet, ATM, transparent
> > > +
> > > +config UCC
> > > +	bool
> > > +	default y if UCC_FAST || UCC_SLOW
> > > +
> > > +config QE_USB
> > > +	bool
> > > +	default y if USB_FSL_QE
> > > +	help
> > > +	  QE USB Controller support
> > 
> > First could we give these names better namespacing?
> 
> Add FSL as prefix?

Yes.

-Scott
