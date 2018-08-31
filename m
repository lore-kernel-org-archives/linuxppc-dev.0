Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4229x86LdZzF38G
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Sep 2018 06:31:07 +1000 (AEST)
Message-ID: <f6707cb54c3e6da1b50f45f915c996dfccfeacda.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Andy Tang <andy.tang@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>,
 "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "mturquette@baylibre.com"
 <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
 "rjw@rjwysocki.net"
 <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
 "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "linux-kernel-owner@vger.kernel.org"
 <linux-kernel-owner@vger.kernel.org>, "catalin.marinas@arm.com"
 <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>,
 "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>,
 "kstewart@linuxfoundation.org"
 <kstewart@linuxfoundation.org>, "yamada.masahiro@socionext.com"
 <yamada.masahiro@socionext.com>
Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, Varun Sethi
 <V.Sethi@nxp.com>, Udit Kumar <udit.kumar@nxp.com>
Date: Fri, 31 Aug 2018 15:28:44 -0500
In-Reply-To: <DB5PR0401MB22130C025AA4CCAD0221781DF30F0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
References: <1534747636-20064-1-git-send-email-vabhav.sharma@nxp.com>
 <1534747636-20064-4-git-send-email-vabhav.sharma@nxp.com>
 <4a9ea6b451683ec98c92e86a5ae6b91213a6afcf.camel@buserror.net>
 <VI1PR04MB4800E8B1E8541FCA9221A1CFF3080@VI1PR04MB4800.eurprd04.prod.outlook.com>
 <d2cfd49eb33a3ce74f0e78f2b53d3954d2cb3e76.camel@buserror.net>
 <b31ae8e788fb93971167faa9b55b497e838532c4.camel@buserror.net>
 <DB5PR0401MB22130C025AA4CCAD0221781DF30F0@DB5PR0401MB2213.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for lx2160a
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-08-31 at 06:12 +0000, Andy Tang wrote:
> Hi Scott,
> 
> Please see my replay inline.
> 
> > -----Original Message-----
> > From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org>
> > On Behalf Of Scott Wood
> > Sent: 2018年8月31日 1:43
> > To: Vabhav Sharma <vabhav.sharma@nxp.com>;
> > linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > robh+dt@kernel.org; mark.rutland@arm.com;
> > linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
> > mturquette@baylibre.com; sboyd@kernel.org; rjw@rjwysocki.net;
> > viresh.kumar@linaro.org; linux-clk@vger.kernel.org;
> > linux-pm@vger.kernel.org; linux-kernel-owner@vger.kernel.org;
> > catalin.marinas@arm.com; will.deacon@arm.com;
> > gregkh@linuxfoundation.org; arnd@arndb.de;
> > kstewart@linuxfoundation.org; yamada.masahiro@socionext.com
> > Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; Andy Tang
> > <andy.tang@nxp.com>; linux@armlinux.org.uk; Varun Sethi
> > <V.Sethi@nxp.com>; Udit Kumar <udit.kumar@nxp.com>
> > Subject: Re: [PATCH 3/5] drivers: clk-qoriq: Add clockgen support for
> > lx2160a
> > 
> > On Thu, 2018-08-30 at 12:39 -0500, Scott Wood wrote:
> > > On Thu, 2018-08-30 at 07:36 +0000, Vabhav Sharma wrote:
> > > > > 
> > > > > Why are you increasing NUM_CMUX beyond 8 for a chip that only
> > 
> > has
> > > > > 8 entries in cmux_to_group?
> > > > 
> > > > Configuration is 16 cores,8 cluster with 2 cores in each cluster
> > > 
> > > So?  This is about cmuxes, not cores.  You're increasing the array
> > > without ever using the new size.
> > 
> > Oh, and you also broke p4080 which has 8 cmuxes but no -1 terminator,
> > because the array was of length 8.  Probably the array should be changed
> > to NUM_CMUX+1 so every array can be -1 terminated.
> > 
> 
> [Andy] How about we add -1 terminator to p4080 and increase NUM_CMUX to 16?

Why 16?  What does such a change have to do with this chip, which according to
the rest of the patch has 8 cmuxes?

> We don't want to increase NUM_CMUX each time new soc with more cmuxes added.

You don't want to have to make a trivial change each time you exceed a limit
that has yet to be exceeded once since NUM_CMUX was added?  This isn't ABI or
in any other way hard to change.  It's right in the same file as the chip
description you'd be adding.

And even if a chip did come along with 16 cmuxes, you'd then need to increase
the array to 17 to hold the -1 if you don't want to leave a situation like the
p4080 is in now, where a chip's cmux array could be broken by increasing
NUM_CMUX further.

-Scott
