Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0131.outbound.protection.outlook.com [157.56.110.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EA5BB1A0727
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 06:38:47 +1000 (AEST)
Message-ID: <1437079112.2993.127.camel@freescale.com>
Subject: Re: [PATCH v2] powerpc/dts: Add and fix 1588 timer node for eTSEC
From: Scott Wood <scottwood@freescale.com>
To: Lu Yangbo-B47093 <yangbo.lu@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Thu, 16 Jul 2015 15:38:32 -0500
In-Reply-To: <BY1PR0301MB11921FFFBC88E7ABD81D2E27F2990@BY1PR0301MB1192.namprd03.prod.outlook.com>
References: <1430969347-13869-1-git-send-email-yangbo.lu@freescale.com>
 <BY1PR0301MB11921FFFBC88E7ABD81D2E27F2990@BY1PR0301MB1192.namprd03.prod.outlook.com>
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

On Wed, 2015-07-15 at 21:37 -0500, Lu Yangbo-B47093 wrote:
> Any comments?
> Thanks.

Sorry, I must have missed this on my last time through the patch queue.  I 
see you've decimalized the fiper and max-adj properties, which is good... but 
does it really make sense for tmr-add?  I'm not familiar with what this value 
represents, but the numbers look more natural as hex (e.g. 0xaaaaaaab versus 
2863311531).

> > diff --git a/arch/powerpc/boot/dts/p2020rdb-pc.dtsi
> > b/arch/powerpc/boot/dts/p2020rdb-pc.dtsi
> > index c21d1c7..363172d 100644
> > --- a/arch/powerpc/boot/dts/p2020rdb-pc.dtsi
> > +++ b/arch/powerpc/boot/dts/p2020rdb-pc.dtsi
> > @@ -215,12 +215,12 @@
> >     };
> > 
> >      ptp_clock@24e00{
> > -           fsl,tclk-period = <5>;
> > -           fsl,tmr-prsc = <200>;
> > -           fsl,tmr-add = <0xCCCCCCCD>;
> > -           fsl,tmr-fiper1 = <0x3B9AC9FB>;
> > -           fsl,tmr-fiper2 = <0x0001869B>;
> > -           fsl,max-adj = <249999999>;
> > +           fsl,tclk-period = <5>;
> > +           fsl,tmr-prsc    = <2>;
> > +           fsl,tmr-add     = <2863311531>;
> > +           fsl,tmr-fiper1  = <999999995>;
> > +           fsl,tmr-fiper2  = <99990>;
> > +           fsl,max-adj     = <299999999>;
> >     };

And here, you're changing the value of fsl,tmr-add and fsl,max-adj.  Why?

-Scott
