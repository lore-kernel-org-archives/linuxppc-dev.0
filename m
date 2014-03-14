Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0186.outbound.protection.outlook.com [207.46.163.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 959BA2C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Mar 2014 09:34:41 +1100 (EST)
Message-ID: <1394836465.12479.123.camel@snotra.buserror.net>
Subject: Re: [PATCH 3/9] powerpc/rcpm: add RCPM driver
From: Scott Wood <scottwood@freescale.com>
To: Chenhui Zhao <chenhui.zhao@freescale.com>
Date: Fri, 14 Mar 2014 17:34:25 -0500
In-Reply-To: <20140312035954.GB4706@localhost.localdomain>
References: <1394168285-32275-1-git-send-email-chenhui.zhao@freescale.com>
 <1394168285-32275-3-git-send-email-chenhui.zhao@freescale.com>
 <1394581371.13761.62.camel@snotra.buserror.net>
 <20140312035954.GB4706@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Jason.Jin@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-03-12 at 11:59 +0800, Chenhui Zhao wrote:
> On Tue, Mar 11, 2014 at 06:42:51PM -0500, Scott Wood wrote:
> > On Fri, 2014-03-07 at 12:57 +0800, Chenhui Zhao wrote:
> > > +int fsl_rcpm_init(void)
> > > +{
> > > +	struct device_node *np;
> > > +
> > > +	np = of_find_compatible_node(NULL, NULL, "fsl,qoriq-rcpm-2.0");
> > > +	if (np) {
> > > +		rcpm_v2_regs = of_iomap(np, 0);
> > > +		of_node_put(np);
> > > +		if (!rcpm_v2_regs)
> > > +			return -ENOMEM;
> > > +
> > > +		qoriq_pm_ops = &qoriq_rcpm_v2_ops;
> > > +
> > > +	} else {
> > > +		np = of_find_compatible_node(NULL, NULL, "fsl,qoriq-rcpm-1.0");
> > > +		if (np) {
> > > +			rcpm_v1_regs = of_iomap(np, 0);
> > > +			of_node_put(np);
> > > +			if (!rcpm_v1_regs)
> > > +				return -ENOMEM;
> > > +
> > > +			qoriq_pm_ops = &qoriq_rcpm_v1_ops;
> > > +
> > > +		} else {
> > > +			pr_err("%s: can't find the rcpm node.\n", __func__);
> > > +			return -EINVAL;
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > 
> > Why isn't this a proper platform driver?
> > 
> > -Scott
> 
> The RCPM is not a single function IP block, instead it is a collection
> of device run control and power management. It would be called by other
> drivers and functions. For example, the callback .freeze_time_base()
> need to be called at early stage of kernel init. Therefore, it would be
> better to init it at early stage.

OK, but consider using of_find_matching_node_and_match().

-Scott
