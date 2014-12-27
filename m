Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0112.outbound.protection.outlook.com [157.56.111.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 17CF51A08C2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Dec 2014 13:43:57 +1100 (AEDT)
Message-ID: <1419648220.5581.192.camel@freescale.com>
Subject: Re: [PATCH] i2c-qoriq: modified compatibility for correct prescaler
From: Scott Wood <scottwood@freescale.com>
To: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 26 Dec 2014 20:43:40 -0600
In-Reply-To: <20141223134940.GA1925@katana>
References: <1414537731.23458.120.camel@snotra.buserror.net>
 <5450AC85.40302@keymile.com> <20141113003418.GE2062@katana>
 <5465B285.7070005@keymile.com> <20141114082832.GA2180@katana>
 <1416274083.15957.96.camel@freescale.com> <20141125181347.GC9716@katana>
 <1416966097.15957.171.camel@freescale.com> <54899FB4.9010207@keymile.com>
 <54996CB5.8030808@keymile.com> <20141223134940.GA1925@katana>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Valentin Longchamp <valentin.longchamp@keymile.com>,
 Linux device trees <devicetree@vger.kernel.org>, danielle.costantino@gmail.com,
 "Boschung, Rainer" <Rainer.Boschung@keymile.com>, "Brunck,
 Holger" <Holger.Brunck@keymile.com>, Linux I2C <linux-i2c@vger.kernel.org>,
 Linux PowerPC Kernel <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-12-23 at 14:49 +0100, Wolfram Sang wrote:
> On Tue, Dec 23, 2014 at 02:23:01PM +0100, Valentin Longchamp wrote:
> > Wolfgang, Scott,
> 
> Wolfram, please.
> 
> > > What is then the agreement here ? Add a clock-div to the device trees ? Or do
> > > something similar to  mpc_i2c_get_sec_cfg_8xxx() ?
> > > 
> > > I think the clock-div property is better according to Freescale's AN 2919
> > > section 3.1 Source clock. All the source clocks are fixed (with a clock-div of 2
> > > in case of mpc8536/43/45/47/48/67/68/72, plus p2020) except for the mpc8533/44
> > > where it can be 2 or 3, and that's what mpc_i2c_get_sec_cfg_8xxx() determines.
> > > 
> > > So mpc_i2c_get_sec_cfg_8xxx() should remain the exception and the other
> > > prescaler values should be derived from an additional clock-div that must be
> > > added in the respective device trees (at least for the qoriq devices, because
> > > for instance mpc8543 already has the correct prescaler thanks to
> > > mpc_i2c_data_8543 from i2c-mpc.c).
> > > 
> > 
> > Do you have an opinion on the above ?
> 
> I don't mind. I'll leave it to PowerPC experts to judge if a new binding
> is apropriate or reading SVR is the way to go. If it is going to be a
> new binding, then please look around before if there is already
> something similar around...

I'd rather use SVR so things work with existing device trees.

-Scott
