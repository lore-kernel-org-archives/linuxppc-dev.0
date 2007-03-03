Return-Path: <ed.swarthout@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 64E39DDF82
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Mar 2007 18:44:55 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l237ipFe009846
	for <linuxppc-embedded@ozlabs.org>; Sat, 3 Mar 2007 00:44:51 -0700 (MST)
Received: from az33exm20.fsl.freescale.net (az33exm20.am.freescale.net
	[10.64.32.6])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l237ionY005494
	for <linuxppc-embedded@ozlabs.org>; Sat, 3 Mar 2007 01:44:50 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: DMA take 3
Date: Sat, 3 Mar 2007 00:44:45 -0700
Message-ID: <B52955765C54604CB1A62A9967F22C7301EAE69E@az33exm20.fsl.freescale.net>
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C069B08@MERCURY.inside.istor.com>
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A181@MERCURY.inside.istor.com>
	<B52955765C54604CB1A62A9967F22C7301EAE573@az33exm20.fsl.freescale.net>
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C069B02@MERCURY.inside.istor.com>
	<B52955765C54604CB1A62A9967F22C7301EAE5F8@az33exm20.fsl.freescale.net>
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C069B08@MERCURY.inside.istor.com>
From: "Swarthout Edward L-SWARTHOU" <ed.swarthout@freescale.com>
To: "Charles Krinke" <ckrinke@istor.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

From: Charles Krinke:
> Your uboot script works fine with the DMA engine. I can=20
> transfer a few bytes from 0xfff8_0000 to 0x1_0000 with no=20
> difficulty. However, I have not yet gotten to an=20
> understanding when DMA'ing through an address translation=20
> window, but at least I know how to make it work in local=20
> memory (LM) space.

>From the dma viewpoint there is no difference.

...
> we can write & read=20
> single memory locations in both RM & SM space from LM space=20
> using these settings.

So from uboot, you can do a "md" or "cp" to/from these areas?

> Next is the burst mode of the PCI for which, I believe, the=20
> only recourse is to use the DMA engine. Here things get a bit=20
> trickier.
> =20
> I am DMA'ing to the window at 0x8800_0000 plus the=20
> destination offset within that window and the issue is that=20
> although LM->LM DMA is now working, LM->SM is not working.
> =20
> So, her are the questions:
> =20
> Is there any special consideration in trying to DMA from a=20
> 32bit PCI to a 64bit address using DAC (Dual Address Cycles)=20
> in the 8541?

No.

> Are there any special considerations relating to using an=20
> outbound address translation window to do this?

No.

> Where else might things be going awry?

Based on your descriptions, I don't see anything.

Send me (off list) your uboot console showing md/cp working and the dma
failing.
You can use the following commands to dump the pertinent register data.

I'd say this discussion has strayed from linuxppc-embedded.
Where is embedded-ppc-hwdebug when you need it?

-Ed

setenv lawregs 'echo law;md ${c}00c08 3b'
setenv dmaregs 'echo dma;md ${c}21100 81'
setenv pciregs 'echo pcio;md ${c}08c00 25; echo pcii; md ${c}08da0 15;
echo pcierr;md ${c}08e00 9'
setenv c e00 # or your ccsr bar prefix

savenv # optional!

run lawregs; run dmaregs; run pciregs
