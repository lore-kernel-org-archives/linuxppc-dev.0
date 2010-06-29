Return-Path: <R1AAHA@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 78D60B6F19
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 10:19:10 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.14.3/de01egw01-8.14.3) with ESMTP id
	o5TNtjCV009404
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 16:55:45 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o5U0891u017838
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 19:08:09 -0500 (CDT)
Date: Tue, 29 Jun 2010 18:55:44 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: "Tabi Timur-B04825" <B04825@freescale.com>
Subject: Re: [PATCH] powerpc: introduce basic support for the Freescale
	P1022DS reference board
Message-Id: <20100629185544.609a952a.kim.phillips@freescale.com>
In-Reply-To: <5610599F537DD74A8D1F5CC946A7507303478FF9@az33exm25.fsl.freescale.net>
References: <1277847274-24648-1-git-send-email-timur@freescale.com>
	<20100629171904.d6ae6233.kim.phillips@freescale.com>
	<5610599F537DD74A8D1F5CC946A7507303478FF9@az33exm25.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 29 Jun 2010 17:39:17 -0600
"Tabi Timur-B04825" <B04825@freescale.com> wrote:

> Kim Phillips wrote:
> > On Tue, 29 Jun 2010 16:34:34 -0500
> > Timur Tabi<timur@freescale.com>  wrote:
> >
> >> Introduce basic support for the Freescale P1022DS reference board, based on the
> >> Freescale BSP for this board.
> >>
> >> Details: No DIU video or SSI audio support, no MMC/SD card support, 36-bit and
> >> SWIOTLB support enabled, 36-bit DTS only, and CONFIG_NO_HZ disabled because it
> >> causes performance problems on this kernel.
> >
> > what kind of performance problems?
> 
> See my post on linuxppc-dev about CONFIG_NO_HZ.

looks like it should be easily bisected, esp. since
mpc85xx_smp_defconfig has NO_HZ=y.

> >> +			queue-group@0{
> >> +				#address-cells =<1>;
> >> +				#size-cells =<1>;
> >> +				reg =<0xB1000 0x1000>;
> >> +				fsl,rx-err-int-map =<0xAA>;
> >> +				fsl,tx-int-map =<0xAA>;
> >> +				interrupts =<35 2 36 2 40 2>;
> >> +			};
> >> +			queue-group@1{
> >> +				#address-cells =<1>;
> >> +				#size-cells =<1>;
> >> +				reg =<0xB5000 0x1000>;
> >> +				fsl,rx-err-int-map =<0x55>;
> >> +				fsl,tx-int-map =<0x55>;
> >> +				interrupts =<51 2 52 2 67 2>;
> >> +			};
> >
> > these queue-group nodes, fsl,{r,t}x-* properties...
> 
> I just copied this tree from the BSP.  I have no idea what they should ok 
> like.  Can you be more specific?

eh?  you submitted the patch; I'm just calling out the
foreign/undocumented matter in it.

> >> +		crypto@30000 {
> >
> >> +			fsl,multi-host-mode = "dual";
> >> +			fsl,channel-remap =<0x3>;
> >
> > and the above two properties aren't supported by their respective
> > drivers, nor are they listed in the dts bindings documentation.
> 
> Then please tell me what these nodes should look like.

delete them?

Kim
