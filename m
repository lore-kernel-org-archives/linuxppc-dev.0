Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0248.outbound.messaging.microsoft.com [213.199.154.248])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DBBB72C0082
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Sep 2013 07:18:57 +1000 (EST)
Message-ID: <1379366325.2536.178.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/mpc85xx:Add initial device tree support of T104x
From: Scott Wood <scottwood@freescale.com>
To: Kushwaha Prabhakar-B32579 <B32579@freescale.com>
Date: Mon, 16 Sep 2013 16:18:45 -0500
In-Reply-To: <071A08F2C6A57E4E94D980ECA553F874F607C5@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1378882686-19454-1-git-send-email-prabhakar@freescale.com>
 <1378941854.12204.439.camel@snotra.buserror.net>
 <071A08F2C6A57E4E94D980ECA553F874F607C5@039-SN1MPN1-006.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Aggrwal Poonam-B10812 <B10812@freescale.com>,
 Jain Priyanka-B32167 <B32167@freescale.com>,
 Sethi Varun-B16395 <B16395@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-09-13 at 02:30 -0500, Kushwaha Prabhakar-B32579 wrote:
> > I also question the need to define separate t1040 compatible values for
> > all of these, if the only difference is whether the onboard switch is
> > enabled or not.
> > 
> 
> so should I use T104x as compatible field. and in T1040 device tree add extra node for l2 switch. 

No, because we don't know if there will be (e.g) a t1043 that is
different.  Just use t1040 as the canonical name.

> > Please update the clock stuff based on
> > http://patchwork.ozlabs.org/patch/274134/
> > 
> 
> this patch is still under discussion. May I have to wait for the final patch.
> or may I rebase on v4. 

You can wait for the final patch, or you can update based on the current
state of the discussion, and be ready to update again if anything
changes.

> > > +/include/ "qoriq-dma-0.dtsi"
> > > +	dma@100300 {
> > > +		fsl,iommu-parent = <&pamu0>;
> > > +		fsl,liodn-reg = <&guts 0x580>; /* DMA1LIODNR */
> > > +	};
> > > +
> > > +/include/ "qoriq-dma-1.dtsi"
> > > +	dma@101300 {
> > > +		fsl,iommu-parent = <&pamu0>;
> > > +		fsl,liodn-reg = <&guts 0x584>; /* DMA2LIODNR */
> > > +	};
> > 
> > These are elo3:
> > http://patchwork.ozlabs.org/patch/271238/
> 
> This patch is still under discussion. 
> I am not sure, I should wait for final patch or change code as per v9 version. 

I think that patch is pretty well settled at this point.  Just make it a
prerequisite for this patch.

-Scott
