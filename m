Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0107.outbound.protection.outlook.com [207.46.100.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A20131A0743
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 01:07:55 +1000 (AEST)
Message-ID: <1437750459.2993.224.camel@freescale.com>
Subject: Re: [PATCH v2] powerpc/dts: Add and fix 1588 timer node for eTSEC
From: Scott Wood <scottwood@freescale.com>
To: Lu Yangbo-B47093 <yangbo.lu@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Fri, 24 Jul 2015 10:07:39 -0500
In-Reply-To: <BY1PR0301MB1192CF8FD2B38A36A2A9BFD5F2850@BY1PR0301MB1192.namprd03.prod.outlook.com>
References: <1430969347-13869-1-git-send-email-yangbo.lu@freescale.com>
 <BY1PR0301MB11921FFFBC88E7ABD81D2E27F2990@BY1PR0301MB1192.namprd03.prod.outlook.com>
 <1437079112.2993.127.camel@freescale.com>
 <BY1PR0301MB1192CF8FD2B38A36A2A9BFD5F2850@BY1PR0301MB1192.namprd03.prod.outlook.com>
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

On Mon, 2015-07-20 at 01:33 -0500, Lu Yangbo-B47093 wrote:
> > On Wed, 2015-07-15 at 21:37 -0500, Lu Yangbo-B47093 wrote:
> > > Any comments?
> > > Thanks.
> > 
> > Sorry, I must have missed this on my last time through the patch queue.
> > I see you've decimalized the fiper and max-adj properties, which is
> > good... but does it really make sense for tmr-add?  I'm not familiar with
> > what this value represents, but the numbers look more natural as hex (e.g.
> > 0xaaaaaaab versus 2863311531).
> 
> Yes, the fiper value would be writed into fiper registers. And max-adj 
> value would be used in ptp driver in driver/ptp/.
> But you insisted that values should be in decimalism in the v1 patch... :)
> 
> See the history :)

I didn't insist on decimals for *everything*, just where it makes sense, and 
that "it goes in a register" doesn't *automatically* mean that it doesn't 
make sense.

################# history ##################
> > > +  ptp_clock@b0e00{
> > > +         compatible = "fsl,etsec-ptp";
> > > +         reg = <0xb0e00 0xb0>;
> > > +         interrupts = <68 2 0 0 69 2 0 0>;
> > > +         fsl,tclk-period = <5>;
> > > +         fsl,tmr-prsc    = <2>;
> > > +         fsl,tmr-add     = <0xcccccccd>;
> > > +         fsl,tmr-fiper1  = <0x3b9ac9fb>;
> > > +         fsl,tmr-fiper2  = <0x00018696>;
> > > +         fsl,max-adj     = <249999999>;
> > 
> > Please don't use hex for numbers that make more sense as decimal.
> > [Lu Yangbo-B47093] The hex value is register value, I think it's better 
> > to use hex.
> 
> Whether it goes into a register doesn't matter.  Hex values are useful for 
> values which are subdivided into various bitfields, or whose hex 
> representation is simpler than decimal.  I'm not familiar with the details 
> of this hardware, but I doubt the former is the case for 0x3b9ac9fb == 
> 9999999995 or 0x18696 == 99990.
> 
> -Scott
> ######################################
> 
> 
> > 
> > > > diff --git a/arch/powerpc/boot/dts/p2020rdb-pc.dtsi
> > > > b/arch/powerpc/boot/dts/p2020rdb-pc.dtsi
> > > > index c21d1c7..363172d 100644
> > > > --- a/arch/powerpc/boot/dts/p2020rdb-pc.dtsi
> > > > +++ b/arch/powerpc/boot/dts/p2020rdb-pc.dtsi
> > > > @@ -215,12 +215,12 @@
> > > >     };
> > > > 
> > > >      ptp_clock@24e00{
> > > > -           fsl,tclk-period = <5>;
> > > > -           fsl,tmr-prsc = <200>;
> > > > -           fsl,tmr-add = <0xCCCCCCCD>;
> > > > -           fsl,tmr-fiper1 = <0x3B9AC9FB>;
> > > > -           fsl,tmr-fiper2 = <0x0001869B>;
> > > > -           fsl,max-adj = <249999999>;
> > > > +           fsl,tclk-period = <5>;
> > > > +           fsl,tmr-prsc    = <2>;
> > > > +           fsl,tmr-add     = <2863311531>;
> > > > +           fsl,tmr-fiper1  = <999999995>;
> > > > +           fsl,tmr-fiper2  = <99990>;
> > > > +           fsl,max-adj     = <299999999>;
> > > >     };
> > 
> > And here, you're changing the value of fsl,tmr-add and fsl,max-adj.  Why?
> 
> The old values maybe not calculated base on the default eTSEC system clock 
> value.
> 1588 timer couldn’t be adjusted correctly by old values.

Explain in the changelog what was wrong with the old values (don't just say 
"Fix 1588 timer node in file").

-Scott
