Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0181.outbound.protection.outlook.com [207.46.163.181])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 997D71A039D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jun 2014 02:16:27 +1000 (EST)
Message-ID: <1403280967.12851.183.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 2/2] flexcan: add err interrupt for p1010rdb
From: Scott Wood <scottwood@freescale.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 20 Jun 2014 11:16:07 -0500
In-Reply-To: <53A3F660.4040807@pengutronix.de>
References: <1403229664-33912-1-git-send-email-B45475@freescale.com>
 <1403229664-33912-2-git-send-email-B45475@freescale.com>
 <53A3F660.4040807@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Zhao Qiang <B45475@freescale.com>, B07421@freescale.com,
 linuxppc-dev@lists.ozlabs.org, wg@grandegger.com, linux-can@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-06-20 at 10:52 +0200, Marc Kleine-Budde wrote:
> On 06/20/2014 04:01 AM, Zhao Qiang wrote:
> > add err interrupt for p1010rdb into dts.
> > 
> > Signed-off-by: Zhao Qiang <B45475@freescale.com>
> > ---
> > Changes for v2:
> > 	- add binding documentation update
> > 
> >  Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 7 +++++--
> >  arch/powerpc/boot/dts/fsl/p1010si-post.dtsi               | 6 ++++--
> >  2 files changed, 9 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> > index 56d6cc3..81929e5 100644
> > --- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> > +++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> > @@ -10,7 +10,9 @@ Required properties:
> >    - fsl,p1010-flexcan
> >  
> >  - reg : Offset and length of the register set for this device
> > -- interrupts : Interrupt tuple for this device
> > +- interrupts : Interrupt tuple for this device.
> > +	The first interrupt is for FlexCAN(Message Buffer and Wake Up)
> > +	The second is for error(Shared with IFC, PEX1 and some other device)
> 
> The second interrupt is optional, at least on ARM we don't need it,
> please reflect this in the documentation update.

The binding also shouldn't specify that the interrupt is shared, much
less with specific things.  It's not relevant, and may not be
universally true.

-Scott
