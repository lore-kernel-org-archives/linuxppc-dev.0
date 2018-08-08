Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lgfH742SzDqp5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 15:57:59 +1000 (AEST)
Message-ID: <aeff83355ee5235cfd6107dba06a5f7957b45c92.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Bharat Bhushan <bharat.bhushan@nxp.com>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "galak@kernel.crashing.org"
 <galak@kernel.crashing.org>,  "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "kstewart@linuxfoundation.org"
 <kstewart@linuxfoundation.org>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Cc: "robh@kernel.org" <robh@kernel.org>, "keescook@chromium.org"
 <keescook@chromium.org>, "tyreld@linux.vnet.ibm.com"
 <tyreld@linux.vnet.ibm.com>,  "joe@perches.com" <joe@perches.com>
Date: Wed, 08 Aug 2018 00:55:37 -0500
In-Reply-To: <AM5PR0401MB254592DC0E917FD292B323BA9A260@AM5PR0401MB2545.eurprd04.prod.outlook.com>
References: <1532684881-19310-1-git-send-email-Bharat.Bhushan@nxp.com>
 <1532684881-19310-6-git-send-email-Bharat.Bhushan@nxp.com>
 <ab2a113620123cb71364b6ae89328ae2fca49821.camel@buserror.net>
 <AM5PR0401MB254592DC0E917FD292B323BA9A260@AM5PR0401MB2545.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [RFC 5/5] powerpc/fsl: Add supported-irq-ranges for P2020
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-08-08 at 03:44 +0000, Bharat Bhushan wrote:
> > -----Original Message-----
> > From: Scott Wood [mailto:oss@buserror.net]
> > Sent: Wednesday, August 8, 2018 2:44 AM
> > To: Bharat Bhushan <bharat.bhushan@nxp.com>;
> > benh@kernel.crashing.org; paulus@samba.org; mpe@ellerman.id.au;
> > galak@kernel.crashing.org; mark.rutland@arm.com;
> > kstewart@linuxfoundation.org; gregkh@linuxfoundation.org;
> > devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; linux-
> > kernel@vger.kernel.org
> > Cc: robh@kernel.org; keescook@chromium.org; tyreld@linux.vnet.ibm.com;
> > joe@perches.com
> > Subject: Re: [RFC 5/5] powerpc/fsl: Add supported-irq-ranges for P2020
> > 
> > On Fri, 2018-07-27 at 15:18 +0530, Bharat Bhushan wrote:
> > > MPIC on NXP (Freescale) P2020 supports following irq
> > > ranges:
> > >   > 0 - 11      (External interrupt)
> > >   > 16 - 79     (Internal interrupt)
> > >   > 176 - 183   (Messaging interrupt)
> > >   > 224 - 231   (Shared message signaled interrupt)
> > 
> > Why don't you convert to the 4-cell interrupt specifiers that make dealing
> > with these ranges less error-prone?
> 
> Ok , will do if we agree to have this series as per comment on other patch.

If you're concerned with errors, this would be a good things to do regardless.
 Actually, it seems that p2020si-post.dtsi already uses 4-cell interrupts.

What is motivating this patchset?  Is there something wrong in the existing
dts files?


> 
> > 
> > > diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> > > b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> > > index 1006950..49ff348 100644
> > > --- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> > > +++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
> > > @@ -57,6 +57,11 @@ void __init mpc85xx_rdb_pic_init(void)
> > >  			MPIC_BIG_ENDIAN |
> > >  			MPIC_SINGLE_DEST_CPU,
> > >  			0, 256, " OpenPIC  ");
> > > +	} else if (of_machine_is_compatible("fsl,P2020RDB-PC")) {
> > > +		mpic = mpic_alloc(NULL, 0,
> > > +		  MPIC_BIG_ENDIAN |
> > > +		  MPIC_SINGLE_DEST_CPU,
> > > +		  0, 0, " OpenPIC  ");
> > >  	} else {
> > >  		mpic = mpic_alloc(NULL, 0,
> > >  		  MPIC_BIG_ENDIAN |
> > 
> > I don't think we want to grow a list of every single revision of every
> > board in
> > these platform files.
> 
> One other confusing observation I have is that "irq_count" from platform
> code is given precedence over "last-interrupt-source" in device-tree.
> Should not device-tree should have precedence otherwise there is no point
> using " last-interrupt-source" if platform code passes "irq_count" in
> mpic_alloc().

Maybe, though I don't think it matters much given that last-interrupt-source
was only added to avoid having to pass irq_count in platform code.

-Scott
