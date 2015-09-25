Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0119.outbound.protection.outlook.com [157.56.110.119])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 382721A0145
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 15:12:28 +1000 (AEST)
Message-ID: <1443157928.32298.108.camel@freescale.com>
Subject: Re: [PATCH V3] thermal: qoriq: Add thermal management support
From: Scott Wood <scottwood@freescale.com>
To: Jia Hongtao-B38951 <hongtao.jia@freescale.com>
CC: "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 25 Sep 2015 00:12:08 -0500
In-Reply-To: <BLUPR03MB14997B46CC6AFC247EDC340E1420@BLUPR03MB149.namprd03.prod.outlook.com>
References: <1442996938-47147-1-git-send-email-hongtao.jia@freescale.com>
 <1443132592.32298.56.camel@freescale.com>
 <BLUPR03MB14997B46CC6AFC247EDC340E1420@BLUPR03MB149.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-09-24 at 22:09 -0500, Jia Hongtao-B38951 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, September 25, 2015 6:10 AM
> > To: Jia Hongtao-B38951
> > Cc: edubezval@gmail.com; linux-pm@vger.kernel.org; linuxppc-
> > dev@lists.ozlabs.org
> > Subject: Re: [PATCH V3] thermal: qoriq: Add thermal management support
> > 
> > On Wed, 2015-09-23 at 16:28 +0800, Jia Hongtao wrote:
> > > This driver add thermal management support by enabling TMU (Thermal
> > > Monitoring Unit) on QorIQ platform.
> > > 
> > > It's based on thermal of framework:
> > > - Trip points defined in device tree.
> > > - Cpufreq as cooling device registered in qoriq cpufreq driver.
> > 
> > I don't see any cooling device registered in the qoriq cpufreq driver.
> > Is this dependent on some other patch?
> 
> It's not depend on any patch. But I saw your patch below:
> [PATCH v3 5/5] cpufreq: qoriq: Don't look at clock implementation details
> So I hold my patch waiting for your patch merged or there will be conflict.
> 
> I could send it out too if you are fine with it.

Yes, rebase it on that patch and send it.  Mention below the --- that you're 
depending on that patch, and provide a patchwork/archive link.

> > > +static int tmu_get_temp(void *p, int *temp) {
> > > +     u8 val;
> > > +     struct qoriq_tmu_data *data = p;
> > > +
> > > +     val = ioread32be(&data->regs->site[0].tritsr);
> > > +     *temp = (int)val * 1000;
> > 
> > Why don't you declare val as int in the first place?
> 
> It's a 32bit register.
> Only the least significant 8 bits represent the temperature.
> The most significant bit shows the validness of the value.
> I use u8 type to remove the rest 24bits influence.

That's even worse.  Use an explicit & operation to extract the field you're 
interested in.

> > > +     ret = qoriq_tmu_calibration(pdev);      /* TMU calibration */
> > > +     if (ret < 0) {
> > > +             dev_err(&pdev->dev, "TMU calibration failed.\n");
> > > +             ret = -ENODEV;
> > > +             goto err_iomap;
> > > +     }
> > 
> > That function returns negative when device tree properties are missing,
> > not when a calibration procedure fails.
> 
> What's your suggestion here to return then?

Remove this message and add a message in qoriq_tmu_calibration for each error 
condition.  Also have qoriq_tmu_calibration pass back a proper error code, 
not -1.

> > > +static const struct of_device_id qoriq_tmu_match[] = {
> > > +     { .compatible = "fsl,qoriq-tmu", },
> > > +     {},
> > > +};
> > 
> > Binding?
> 
> Not send out yet.

The binding needs to come before the driver that uses it.

-Scott
