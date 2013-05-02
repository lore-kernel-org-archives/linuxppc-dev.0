Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 525E22C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 03:14:08 +1000 (EST)
Date: Thu, 2 May 2013 12:13:59 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: pci overmapping
To: Yoder Stuart-B08248 <B08248@freescale.com>
References: <9F6FE96B71CF29479FF1CDC8046E15035C8E18@039-SN1MPN1-002.039d.mgd.msft.net>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E15035C8E18@039-SN1MPN1-002.039d.mgd.msft.net>
 (from B08248@freescale.com on Thu May  2 12:05:42 2013)
Message-ID: <1367514839.24411.12@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Sethi Varun-B16395 <B16395@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/02/2013 12:05:42 PM, Yoder Stuart-B08248 wrote:
> Kumar,
>=20
> In fsl_pci.c there is a change you made a while back:
>   "powerpc/fsl: Setup PCI inbound window based on actual amount of =20
> memory"
>=20
> ...and there is this comment in the code:
>=20
>     /* PCIe can overmap inbound & outbound since RX & TX are =20
> separated */
>     if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
>=20
> You are implying that PCIe can overmap and PCI can't.  Why is
> that?   (I'm assuming that 'overmap' means that inbound window
> can extend beyond the end of ram.)

Shouldn't the concern be whether we're overlapping outbound, not merely =20
whether we go beyond the end of RAM?

And couldn't inbound/outbound overlap be an issue even on PCIe, if =20
there's a PCI bridge underneath it?

-Scott=
