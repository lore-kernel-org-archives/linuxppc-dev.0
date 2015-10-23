Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0119.outbound.protection.outlook.com [207.46.100.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 151081A0AB5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2015 07:56:06 +1100 (AEDT)
Message-ID: <1445633739.701.227.camel@freescale.com>
Subject: Re: [PATCH v12 6/6] QE: Move QE from arch/powerpc to drivers/soc
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "lauraa@codeaurora.org" <lauraa@codeaurora.org>, Xie Xiaobo-R63061
 <X.Xie@freescale.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 Li Yang-Leo-R58472 <LeoLi@freescale.com>, "paulus@samba.org"
 <paulus@samba.org>
Date: Fri, 23 Oct 2015 15:55:39 -0500
In-Reply-To: <SN1PR0301MB155072B05697D15EC990E0229B260@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1444806968-4627-1-git-send-email-qiang.zhao@freescale.com>
 <1444806968-4627-6-git-send-email-qiang.zhao@freescale.com>
 <20151023031952.GA31843@home.buserror.net>
 <SN1PR0301MB155072B05697D15EC990E0229B260@SN1PR0301MB1550.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-10-23 at 02:49 -0500, Zhao Qiang-B45475 wrote:
> On Fri, Oct 23, 2015 at 11:20 AM, Wood Scott-B07421 <scottwood@freescale.com
> > wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, October 23, 2015 11:20 AM
> > To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
> > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > lauraa@codeaurora.org; Xie Xiaobo-R63061 <X.Xie@freescale.com>;
> > benh@kernel.crashing.org; Li Yang-Leo-R58472 <LeoLi@freescale.com>;
> > paulus@samba.org
> > Subject: Re: [PATCH v12 6/6] QE: Move QE from arch/powerpc to drivers/soc
> > 
> > On Wed, Oct 14, 2015 at 03:16:08PM +0800, Zhao Qiang wrote:
> > 
> > 
> > > diff --git a/arch/powerpc/sysdev/qe_lib/Kconfig
> > > b/drivers/soc/fsl/qe/Kconfig similarity index 50% copy from
> > > arch/powerpc/sysdev/qe_lib/Kconfig
> > > copy to drivers/soc/fsl/qe/Kconfig
> > > index 3c25199..283fe0d 100644
> > > --- a/arch/powerpc/sysdev/qe_lib/Kconfig
> > > +++ b/drivers/soc/fsl/qe/Kconfig
> > > @@ -2,6 +2,17 @@
> > >  # QE Communication options
> > >  #
> > > 
> > > +config QUICC_ENGINE
> > > + bool "Freescale QUICC Engine (QE) Support"
> > > + depends on FSL_SOC && PPC32
> > > + select GENERIC_ALLOCATOR
> > > + select CRC32
> > > + help
> > > +   The QUICC Engine (QE) is a new generation of communications
> > > +   coprocessors on Freescale embedded CPUs (akin to CPM in older
> > chips).
> > > +   Selecting this option means that you wish to build a kernel
> > > +   for a machine with a QE coprocessor.
> > > +
> > >  config UCC_SLOW
> > >   bool
> > >   default y if SERIAL_QE
> > > @@ -19,9 +30,3 @@ config UCC_FAST
> > >  config UCC
> > >   bool
> > >   default y if UCC_FAST || UCC_SLOW
> > > -
> > > -config QE_USB
> > > - bool
> > > - default y if USB_FSL_QE
> > > - help
> > > -   QE USB Controller support
> > 
> > Why did some config symbols get moved and others not?
> 
> Because QE_USB should be putted under drivers/usb,
> It is independent of this patchset.

If it's independent of this patchset then don't put it in this patchset.  
Move all the QE stuff to drivers/soc and then later if something belongs 
somewhere else, have a separate patch move it there.

-Scott
