Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYfP75zJYzDsTS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 08:24:43 +1000 (AEST)
Message-ID: <1473805463.30217.206.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: "Y.B. Lu" <yangbo.lu@nxp.com>, "linux-mmc@vger.kernel.org"
 <linux-mmc@vger.kernel.org>, "ulf.hansson@linaro.org"
 <ulf.hansson@linaro.org>,  Arnd Bergmann <arnd@arndb.de>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
 <linux-clk@vger.kernel.org>, "linux-i2c@vger.kernel.org"
 <linux-i2c@vger.kernel.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring
 <robh+dt@kernel.org>, Russell King <linux@arm.linux.org.uk>, Jochen
 Friedrich <jochen@scram.de>, Joerg Roedel <joro@8bytes.org>, Claudiu Manoil
 <claudiu.manoil@freescale.com>, Bhupesh Sharma
 <bhupesh.sharma@freescale.com>,  Qiang Zhao <qiang.zhao@nxp.com>, Kumar
 Gala <galak@codeaurora.org>, Santosh Shilimkar <ssantosh@kernel.org>, Leo
 Li <leoyang.li@nxp.com>, "X.B. Xie" <xiaobo.xie@nxp.com>
Date: Tue, 13 Sep 2016 17:24:23 -0500
In-Reply-To: <HE1PR04MB08892E63EB2D579D6F0A7550F8FE0@HE1PR04MB0889.eurprd04.prod.outlook.com>
References: <1473150503-9550-1-git-send-email-yangbo.lu@nxp.com>
 <1473150503-9550-6-git-send-email-yangbo.lu@nxp.com>
 <1473392840.30217.170.camel@buserror.net>
 <HE1PR04MB08892D8354E38EC32F549E98F8FF0@HE1PR04MB0889.eurprd04.prod.outlook.com>
 <1473722714.30217.196.camel@buserror.net>
 <HE1PR04MB08892E63EB2D579D6F0A7550F8FE0@HE1PR04MB0889.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [v11, 5/8] soc: fsl: add GUTS driver for QorIQ platforms
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-09-13 at 07:23 +0000, Y.B. Lu wrote:
> > 


> > 
> > -----Original Message-----
> > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > owner@vger.kernel.org] On Behalf Of Scott Wood
> > Sent: Tuesday, September 13, 2016 7:25 AM
> > To: Y.B. Lu; linux-mmc@vger.kernel.org; ulf.hansson@linaro.org; Arnd
> > Bergmann
> > Cc: linuxppc-dev@lists.ozlabs.org; devicetree@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> > clk@vger.kernel.org; linux-i2c@vger.kernel.org; iommu@lists.linux-
> > foundation.org; netdev@vger.kernel.org; Mark Rutland; Rob Herring;
> > Russell King; Jochen Friedrich; Joerg Roedel; Claudiu Manoil; Bhupesh
> > Sharma; Qiang Zhao; Kumar Gala; Santosh Shilimkar; Leo Li; X.B. Xie
> > Subject: Re: [v11, 5/8] soc: fsl: add GUTS driver for QorIQ platforms
> > 
> > BTW, aren't ls2080a and ls2085a the same die?  And is there no non-E
> > version of LS2080A/LS2040A?
> [Lu Yangbo-B47093] I checked all the svr values in chip errata doc "Revision
> level to part marking cross-reference" table.
> I found ls2080a and ls2085a were in two separate doc. And I didn’t find non-
> E version of LS2080A/LS2040A in chip errata doc.
> Do you know is there any other doc we can confirm this?

No.  Traditionally we've always had E and non-E versions of each chip, but I
have no knowledge of whether that has changed (I do note that the way that E-
status is indicated in SVR has changed).

But please label LS2080A and LS2085A as the same die (or provide strong
evidence that they are not).

> 
> > 
> > 
> > > 
> > > > > 
> > > > > +	do {
> > > > > +		if (!matches->soc_id)
> > > > > +			return NULL;
> > > > > +		if (glob_match(svr_match, matches->soc_id))
> > > > > +			break;
> > > > > +	} while (matches++);
> > > > Are you expecting "matches++" to ever evaluate as false?
> > > [Lu Yangbo-B47093] Yes, this is used to match the soc we use in
> > > qoriq_soc array until getting true.
> > > We need to get the name and die information defined in array.
> > I'm not asking whether the glob_match will ever return true.  I'm saying
> > that "matches++" will never become NULL.
> [Lu Yangbo-B47093] The matches++ will never become NULL while it will return
> NULL after matching for all the members in array.

"matches++" will never "return NULL".  It's just an incrementing address.  It
won't be null until you wrap around the address space, and even if the other
loop terminators never kicked in you'd crash long before that happens.

Please rewrite the loop as something like:

	while (matches->soc_id) {
		if (glob_match(...))
			return matches;

		matches++;
	}

	return NULL;


> > > > > +	/* Register soc device */
> > > > > +	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> > > > > +	if (!soc_dev_attr) {
> > > > > +		ret = -ENOMEM;
> > > > > +		goto out_unmap;
> > > > > +	}
> > > > Couldn't this be statically allocated?
> > > [Lu Yangbo-B47093] Do you mean we define this struct statically ?
> > > 
> > > static struct soc_device_attribute soc_dev_attr;
> > Yes.
> > 
> [Lu Yangbo-B47093] It's ok to define it statically. Is there any need to do
> that?

It's simpler.

-Scott
