Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0101.outbound.protection.outlook.com [157.56.110.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 305A61A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 02:40:07 +1000 (AEST)
Message-ID: <1442939995.19102.246.camel@freescale.com>
Subject: Re: [PATCH v10 5/5] QE: Move QE from arch/powerpc to drivers/soc
From: Scott Wood <scottwood@freescale.com>
To: Zhao Qiang-B45475 <qiang.zhao@freescale.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "lauraa@codeaurora.org" <lauraa@codeaurora.org>, Xie Xiaobo-R63061
 <X.Xie@freescale.com>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 Li Yang-Leo-R58472 <LeoLi@freescale.com>, "paulus@samba.org"
 <paulus@samba.org>
Date: Tue, 22 Sep 2015 11:39:55 -0500
In-Reply-To: <SN1PR0301MB15505DD2F1230357BD91C15F9B450@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1442560521-19354-1-git-send-email-qiang.zhao@freescale.com>
 <1442560521-19354-5-git-send-email-qiang.zhao@freescale.com>
 <20150921225611.GC12709@home.buserror.net>
 <SN1PR0301MB15505DD2F1230357BD91C15F9B450@SN1PR0301MB1550.namprd03.prod.outlook.com>
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

On Tue, 2015-09-22 at 03:24 -0500, Zhao Qiang-B45475 wrote:
> On Tue, Sep 22, 2015 at 06:56 AM +0800, Wood Scott-B07421 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Tuesday, September 22, 2015 6:56 AM
> > To: Zhao Qiang-B45475
> > Cc: linux-kernel@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> > lauraa@codeaurora.org; Xie Xiaobo-R63061; benh@kernel.crashing.org; Li
> > Yang-Leo-R58472; paulus@samba.org
> > Subject: Re: [PATCH v10 5/5] QE: Move QE from arch/powerpc to drivers/soc
> > 
> > On Fri, Sep 18, 2015 at 03:15:21PM +0800, Zhao Qiang wrote:
> > > diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
> > > new file mode 100644 index 0000000..3012571
> > > --- /dev/null
> > > +++ b/drivers/soc/fsl/qe/Kconfig
> > > @@ -0,0 +1,33 @@ 
> > > + help
> > > +   The QUICC Engine (QE) is a new generation of communications
> > > +   coprocessors on Freescale embedded CPUs (akin to CPM in older
> > chips).
> > > +   Selecting this option means that you wish to build a kernel
> > > +   for a machine with a QE coprocessor.
> > > +
> > > +config UCC_SLOW
> > > + bool
> > > + default y if SERIAL_QE
> > > + help
> > > +   This option provides qe_lib support to UCC slow
> > > +   protocols: UART, BISYNC, QMC
> > > +
> > > +config UCC_FAST
> > > + bool
> > > + default y if UCC_GETH
> > > + help
> > > +   This option provides qe_lib support to UCC fast
> > > +   protocols: HDLC, Ethernet, ATM, transparent
> > 
> > What does "qe_lib" mean to the end user, or to anyone after the code is
> > moved to drivers/soc/fsl/qe?
> 
> Qe_lib has functions configuring ucc, managing muram and so on.
> It is the common functions to end user.

It's not going to be called qe_lib anymore.  s/provides qe_lib support to UCC 
/provides support for QE UCC/

-Scott
