Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C527DB6F62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2012 21:36:27 +1000 (EST)
Message-ID: <1339673724.9220.164.camel@pasglop>
Subject: Re: [PATCH] i2c: let the core register devices from devicetree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfram Sang <w.sang@pengutronix.de>
Date: Thu, 14 Jun 2012 21:35:24 +1000
In-Reply-To: <20120614091434.GB14419@pengutronix.de>
References: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
 <1339623217.9220.119.camel@pasglop> <20120614091434.GB14419@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Viresh Kumar <viresh.kumar@st.com>,
 Mauro Carvalho Chehab <mchehab@redhat.com>, Tony Lindgren <tony@atomide.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-i2c@vger.kernel.org,
 Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@nvidia.com>,
 Barry Song <21cnbao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>,
 Deepak Sikri <deepak.sikri@st.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>,
 Dirk Brandewie <dirk.brandewie@gmail.com>, Pawel Moll <pawel.moll@arm.com>,
 Wolfram Sang <wolfram@the-dreams.de>, Sascha Hauer <s.hauer@pengutronix.de>,
 Rusty Russell <rusty@rustcorp.com.au>, Tang Yuantian <B29983@freescale.com>,
 "Jean Delvare \(PC drivers, core\)" <khali@linux-fr.org>,
 Magnus Damm <damm@opensource.se>, Lars-Peter Clausen <lars@metafoo.de>,
 "Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
 linux-arm-kernel@lists.infradead.org, Jiri Kosina <jkosina@suse.cz>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Karol Lewandowski <k.lewandowsk@samsung.com>, Olof Johansson <olof@lixom.net>,
 Shawn Guo <shawn.guo@linaro.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-06-14 at 11:14 +0200, Wolfram Sang wrote:
> On Thu, Jun 14, 2012 at 07:33:37AM +1000, Benjamin Herrenschmidt wrote:
> > On Wed, 2012-06-13 at 23:12 +0200, Wolfram Sang wrote:
> > > Currently, every driver has to do it on its own, but it should be done
> > > in the core, like we already do with board_info structs.
> > > 
> > > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> > > ---
> > > 
> > > Based on v3.5-rc2. Only build tested, I don't have a OF based device
> > > around at the moment.
> > 
> > Won't that conflict with i2c-powermac doing it its own way ?
> 
> Yup :(
> 
> I assume there is no chance that the powermac devicetree can be
> pre-processed to be compatible with of_i2c_register_devices?

That would be nasty and need a lot of testing on all sort of machines I
don't have direct access to.

Maybe we can set a flag somewhere to indicate to the core not to run the
default probing on that controller ?

Cheers,
Ben.
