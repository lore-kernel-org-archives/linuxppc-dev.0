Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 564A72C0335
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Oct 2013 09:13:18 +1100 (EST)
Message-ID: <1381788786.7979.643.camel@snotra.buserror.net>
Subject: Re: [PATCH v5] powerpc/mpc85xx: Update the clock nodes in device tree
From: Scott Wood <scottwood@freescale.com>
To: Tang Yuantian-B29983 <B29983@freescale.com>
Date: Mon, 14 Oct 2013 17:13:06 -0500
In-Reply-To: <D07C73A334FF604B95B3CBD2A545D07B150C24BD@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1381300704-4238-1-git-send-email-Yuantian.Tang@freescale.com>
 <20131010100331.GE26954@e106331-lin.cambridge.arm.com>
 <D07C73A334FF604B95B3CBD2A545D07B150BD137@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131011092526.GE3910@e106331-lin.cambridge.arm.com>
 <1381518433.7979.536.camel@snotra.buserror.net>
 <D07C73A334FF604B95B3CBD2A545D07B150C24BD@039-SN2MPN1-013.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Mark Rutland <mark.rutland@arm.com>,
 Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-Leo-R58472 <r58472@freescale.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-10-11 at 21:52 -0500, Tang Yuantian-B29983 wrote:
> Thanks for your review.
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: 2013=E5=B9=B410=E6=9C=8812=E6=97=A5 =E6=98=9F=E6=9C=9F=E5=85=AD=
 3:07
> > To: Mark Rutland
> > Cc: Tang Yuantian-B29983; devicetree@vger.kernel.org; linuxppc-
> > dev@lists.ozlabs.org; Li Yang-Leo-R58472
> > Subject: Re: [PATCH v5] powerpc/mpc85xx: Update the clock nodes in de=
vice
> > tree
> >=20
> > I'm not sure I understand the "_0"/"_1" part, though.  Doesn't each P=
LL
> > just have one output, which the consumer may choose to divide by 2 (o=
r in
> > some cases 4)?  Why does that division need to be exposed in the devi=
ce
> > tree as separate connections to the parent clock?
> >=20
> The device tree makes that quite clear.=20

You chose to model it that way in the device tree; that doesn't make it
clear that the hardware works that way or that it's a good way to model
it.

> Each PLL has several output which MUX node can take from.

Point out where in the hardware documentation it says this.  What I see
is a PLL that has one output, and a MUX register that can choose from
multiple PLL and divider options.

>  It is not a runtime decision.

Hmm?  It's a register you write to.

-Scott
