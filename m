Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xmcq4tybzDqj4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Aug 2018 02:16:43 +1000 (AEST)
Received: from mail-qt0-f172.google.com (mail-qt0-f172.google.com
 [209.85.216.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C777421581
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 16:16:40 +0000 (UTC)
Received: by mail-qt0-f172.google.com with SMTP id m13-v6so10757971qth.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 09:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-6-git-send-email-vabhav.sharma@nxp.com>
 <CAL_JsqKH4haGy2F2_2EP=evC8ip7DmGR8J4wzrO0wWnOLsaZqA@mail.gmail.com>
 <AM6PR04MB478980C90EE825D024D8B977F3370@AM6PR04MB4789.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB478980C90EE825D024D8B977F3370@AM6PR04MB4789.eurprd04.prod.outlook.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 24 Aug 2018 11:16:28 -0500
Message-ID: <CAL_Jsq+QrDR_YyZ+icftUrwOoMZcSCMkmj8cR=bqEJ-q+pdntg@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: add LX2160ARDB board support
To: vabhav.sharma@nxp.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-clk <linux-clk@vger.kernel.org>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 linux-kernel-owner@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Kate Stewart <kstewart@linuxfoundation.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Russell King <linux@armlinux.org.uk>, V.Sethi@nxp.com,
 Udit Kumar <udit.kumar@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Sriram Dash <sriram.dash@nxp.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 23, 2018 at 10:08 AM Vabhav Sharma <vabhav.sharma@nxp.com> wrote:

[...]

> > > +               i2c@3 {
> > > +                       #address-cells = <1>;
> > > +                       #size-cells = <0>;
> > > +                       reg = <0x3>;
> > > +
> > > +                       sa56004@4c {
> >
> > temperature-sensor@4c
> Ok, temperature-sensor-1@4c

No, that's not what I said. You don't need the '-1' because the
unit-address makes the node name unique. Node names are supposed to be
generic based on the class/type of device. See the DT spec.

> >
> > > +                               compatible = "nxp,sa56004";
> > > +                               reg = <0x4c>;
> > > +                       };
> > > +
> > > +                       sa56004@4d {
> Ok,temperature-sensor-2@4d
> > > +                               compatible = "nxp,sa56004";
> > > +                               reg = <0x4d>;
> > > +                       };
> > > +               };
> > > +       };
> > > +};
> > > +
> > > +&i2c4 {
> > > +       status = "okay";
> > > +
> > > +       rtc@51 {
> > > +               compatible = "nxp,pcf2129";
> > > +               reg = <0x51>;
> > > +               // IRQ10_B
> > > +               interrupts = <0 150 0x4>;
> > > +               };
> > > +
> > > +};
> > > +
> > > +&usb0 {
> > > +       status = "okay";
> > > +};
> > > +
> > > +&usb1 {
> > > +       status = "okay";
> > > +};
> > > +
> > > +&crypto {
> > > +       status = "okay";
> > > +};
> > > --
> > > 2.7.4
> > >
