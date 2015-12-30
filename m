Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id B2CA21A02EF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Dec 2015 02:14:48 +1100 (AEDT)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id BED50202FE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Dec 2015 15:14:45 +0000 (UTC)
Received: from mail-yk0-f176.google.com (mail-yk0-f176.google.com
 [209.85.160.176])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 491F6202E9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Dec 2015 15:14:43 +0000 (UTC)
Received: by mail-yk0-f176.google.com with SMTP id a85so80129062ykb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Dec 2015 07:14:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <VI1PR04MB1664E34FC9467506BEC5D815E8FD0@VI1PR04MB1664.eurprd04.prod.outlook.com>
References: <1451274454-26091-1-git-send-email-shh.xie@gmail.com>
 <20151229183436.GB12450@rob-hp-laptop>
 <VI1PR04MB1664E34FC9467506BEC5D815E8FD0@VI1PR04MB1664.eurprd04.prod.outlook.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 30 Dec 2015 09:14:23 -0600
Message-ID: <CAL_JsqLaFj2uC8dZRhvAi=fdr=JySd4+zp62z3FosePOp7Dqjw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: fsl: update fman dt binding for PCS PHY
To: Shaohui Xie <shaohui.xie@nxp.com>
Cc: "shh.xie@gmail.com" <shh.xie@gmail.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Scott Wood <scottwood@freescale.com>,
 Igal Liberman <Igal.Liberman@freescale.com>,
 Shaohui Xie <Shaohui.Xie@freescale.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 29, 2015 at 9:41 PM, Shaohui Xie <shaohui.xie@nxp.com> wrote:
>> Subject: Re: [PATCH] powerpc: fsl: update fman dt binding for PCS PHY
>>
>> On Mon, Dec 28, 2015 at 11:47:34AM +0800, shh.xie@gmail.com wrote:
>> > From: Shaohui Xie <Shaohui.Xie@freescale.com>
>> >
>> > PCS PHY can support backplane (1000BASE-KX and 10GBASE-KR), this needs
>> > to change corresponding serdes lane settings, so a reference is needed
>> > for serdes lane. This patch describes properties needed for PCS PHY to
>> > support backplane.
>> >
>> > Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
>> > ---
>> > based on: http://patchwork.ozlabs.org/patch/560936/
>> >
>> >  Documentation/devicetree/bindings/powerpc/fsl/fman.txt | 14
>> > ++++++++++++++
>> >  1 file changed, 14 insertions(+)
>> >
>> > diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
>> > b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
>> > index 55c2c03..b38e727 100644
>> > --- a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
>> > +++ b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
>> > @@ -432,6 +432,16 @@ example of how to define a PHY (Internal PHY has no
>> interrupt line).
>> >  - For "fsl,fman-mdio" compatible internal mdio bus, the PHY is TBI PHY.
>> >  - For "fsl,fman-memac-mdio" compatible internal mdio bus, the PHY is PCS PHY,
>> >    PCS PHY addr must be '0'.
>> > +  PCS PHY can support backplane (1000BASE-KX and 10GBASE-KR), this
>> > + needs to  change the corresponding serdes lane settings.
>> > +
>> > +  PCS PHY node properties required for backplane:
>> > +
>> > +  - compatible: must be "ethernet-phy-ieee802.3-c45".
>> > +  - phy-mode: string, operation mode of the PHY interface; must be "1000base-
>> kx"
>> > +    for 1000BASE-KX, or "10gbase-kr" for 10GBASE-KR.
>>
>> Seems like these should be in common ethernet phy binding.
> [S.H] 'compatible' and 'phy-mode' are standard properties already in common Ethernet
> phy binding, I can update 'phy-mode' with "1000base-kx" and "10gbase-kr", how
> about I still list the two properties here for the requirement of PCS PHY to support
> backplane?

Yes. The common binding should list all possible values and this
binding should list allowed values.

Rob
