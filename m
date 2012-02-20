Return-Path: <B08248@freescale.com>
Received: from AM1EHSOBE006.bigfish.com (am1ehsobe001.messaging.microsoft.com
 [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4966BB6FA2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2012 01:00:35 +1100 (EST)
From: Yoder Stuart-B08248 <B08248@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [linuxppc-release] [PATCH 1/2] powerpc: document the FSL MPIC
 message register binding
Date: Mon, 20 Feb 2012 14:00:20 +0000
Message-ID: <9F6FE96B71CF29479FF1CDC8046E15032F656B@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1329446943-9732-1-git-send-email-B38951@freescale.com>
 <9F6FE96B71CF29479FF1CDC8046E15032F516B@039-SN1MPN1-002.039d.mgd.msft.net>
 <4F3EF533.90409@freescale.com>
In-Reply-To: <4F3EF533.90409@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "meador_inge@mentor.com" <meador_inge@mentor.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>,
 Jia Hongtao-B38951 <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Friday, February 17, 2012 6:48 PM
> To: Yoder Stuart-B08248
> Cc: Jia Hongtao-B38951; linuxppc-dev@lists.ozlabs.org; meador_inge@mentor=
.com; Li Yang-R58472
> Subject: Re: [linuxppc-release] [PATCH 1/2] powerpc: document the FSL MPI=
C message register
> binding
>=20
> On 02/17/2012 09:50 AM, Yoder Stuart-B08248 wrote:
> >
> >
> >> -----Original Message-----
> >> From: linuxppc-release-bounces@linux.freescale.net
> >> [mailto:linuxppc-release- bounces@linux.freescale.net] On Behalf Of
> >> Jia Hongtao-B38951
> >> Sent: Thursday, February 16, 2012 8:49 PM
> >> To: linuxppc-dev@lists.ozlabs.org
> >> Cc: meador_inge@mentor.com; Li Yang-R58472; Jia Hongtao-B38951
> >> Subject: [linuxppc-release] [PATCH 1/2] powerpc: document the FSL
> >> MPIC message register binding
> >>
> >> This binding documents how the message register blocks found in some
> >> FSL MPIC implementations shall be represented in a device tree.
> >>
> >> Signed-off-by: Meador Inge <meador_inge@mentor.com>
> >> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> >> Signed-off-by: Li Yang <leoli@freescale.com>
> >> ---
> >>  .../devicetree/bindings/powerpc/fsl/mpic-msgr.txt  |   62 +++++++++++=
+++++++++
> >>  1 files changed, 62 insertions(+), 0 deletions(-)  create mode
> >> 100644 Documentation/devicetree/bindings/powerpc/fsl/mpic-msgr.txt
> >>
> >> diff --git
> >> a/Documentation/devicetree/bindings/powerpc/fsl/mpic-msgr.txt
> >> b/Documentation/devicetree/bindings/powerpc/fsl/mpic-msgr.txt
> >> new file mode 100644
> >> index 0000000..b4ae70e
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/powerpc/fsl/mpic-msgr.txt
> >> @@ -0,0 +1,62 @@
> >> +* FSL MPIC Message Registers
> >> +
> >> +This binding specifies what properties must be available in the
> >> +device tree representation of the message register blocks found in
> >> +some FSL MPIC implementations.
> >> +
> >> +Required properties:
> >> +
> >> +    - compatible: Specifies the compatibility list for the message re=
gister
> >> +      block.  The type shall be <string> and the value shall be of th=
e form
> >> +      "fsl,mpic-v<version>-msgr", where <version> is the version numb=
er of
> >> +      the MPIC containing the message registers.
> >
> > The type for compatibles is a <string-list>.
> >
> >> +    - reg: Specifies the base physical address(s) and size(s) of the
> >> +      message register block's addressable register space.  The type =
shall be
> >> +      <prop-encoded-array>.
> >> +
> >> +    - interrupts: Specifies a list of interrupt source and level-sens=
e pairs.
> >> +      The type shall be <prop-encoded-array>.  The length shall be eq=
ual to
> >> +      the number of registers that are available for receiving interr=
upts.
> >
> > How many interrupts are there?   If more than 1,  this is where
> > you need to specify what each interrupt is for.
>=20
> They aren't "for" anything in particular -- each interrupt is associated =
with a message
> register.  The binding does say that the number of interrupts corresponds=
 to the bits set in
> the receive mask.

Then make that clear, it also should use the term 'interrupt-specifier'
not 'interrupt source and level-sense pairs', which implies a particular
parent interrupt controller configuration.

Stuart
