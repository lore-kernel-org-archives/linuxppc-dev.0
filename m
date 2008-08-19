Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F37CEDE9DB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Aug 2008 02:13:59 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m7JGDrS2013880 for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Aug 2008 09:13:53 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m7JGDqJZ008014
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Aug 2008 11:13:52 -0500 (CDT)
Date: Tue, 19 Aug 2008 11:13:52 -0500
From: Scott Wood <scottwood@freescale.com>
To: Matvejchikov Ilya <matvejchikov@gmail.com>
Subject: Re: No output from SMC1 console with the 2.6.26 kernel (8xx based
	board)
Message-ID: <20080819161352.GA1735@ld0162-tx32.am.freescale.net>
References: <8496f91a0807281243y2193dad5hc758444fe0a10258@mail.gmail.com>
	<488E2510.7070209@freescale.com>
	<8496f91a0807282310r5e70fe01v85b2ff2da7a80416@mail.gmail.com>
	<488F385B.9030504@nanometrics.ca>
	<8496f91a0807291136v172b3b16t170088faf3f30b5b@mail.gmail.com>
	<20080729193901.GC8051@ld0162-tx32.am.freescale.net>
	<8496f91a0807300237q302cafd3ga21ddb7bbc0bd513@mail.gmail.com>
	<20080730154545.GB25428@ld0162-tx32.am.freescale.net>
	<8496f91a0808190413y69817434v2e340454941f97a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8496f91a0808190413y69817434v2e340454941f97a0@mail.gmail.com>
Cc: Ben Gardiner <BenGardiner@nanometrics.ca>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Aug 19, 2008 at 03:13:54PM +0400, Matvejchikov Ilya wrote:
> Hi all,
> 
> The problem was in incorrect (not full) brg-node definition. Instead of
> brg@119f0 {
>     compatible = "fsl,cpm-brg", "fsl,cpm2-brg";
>     reg = <119f0 10 115f0 10>;
>  };
> there must be:
> brg@119f0 {
>     compatible = "fsl,cpm-brg", "fsl,cpm2-brg";
>     reg = <119f0 10 115f0 10>;
>     clock-frequency = <my_clock_frequency>;
>  };
> 
> The PQ2 (and some others) DTS files needs to be updated.

No, the DTS files don't need to be updated -- u-boot (or whatever
firmware you use, or the bootwrapper) needs to fill in the frequency.

-Scott
