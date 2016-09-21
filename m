Return-Path: <peda@axentia.se>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00104.outbound.protection.outlook.com [40.107.0.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfCNz4L30zDt3l
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Sep 2016 18:25:22 +1000 (AEST)
Subject: Re: [v12, 7/8] base: soc: introduce soc_device_match() interface
To: Alexander Shiyan <shc_work@mail.ru>, Yangbo Lu <yangbo.lu@nxp.com>
References: <1474441040-11946-1-git-send-email-yangbo.lu@nxp.com>
 <1474441040-11946-8-git-send-email-yangbo.lu@nxp.com>
 <1474444574.270880035@f136.i.mail.ru>
CC: Mark Rutland <mark.rutland@arm.com>, Xiaobo Xie <xiaobo.xie@nxp.com>,
 Minghuan Lian <minghuan.lian@nxp.com>, <linux-i2c@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, Qiang Zhao <qiang.zhao@nxp.com>, Russell King
 <linux@arm.linux.org.uk>, Bhupesh Sharma <bhupesh.sharma@freescale.com>,
 Joerg Roedel <joro@8bytes.org>, Jochen Friedrich <jochen@scram.de>, Claudiu
 Manoil <claudiu.manoil@freescale.com>, <devicetree@vger.kernel.org>, Kumar
 Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Santosh
 Shilimkar <ssantosh@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Leo Li
 <leoyang.li@nxp.com>, <iommu@lists.linux-foundation.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-mmc@vger.kernel.org>,
 <ulf.hansson@linaro.org>, Scott Wood <oss@buserror.net>, Arnd Bergmann
 <arnd@arndb.de>
From: Peter Rosin <peda@axentia.se>
Message-ID: <aa53da4f-205d-cfa1-c85c-00e82e928bbc@axentia.se>
Date: Wed, 21 Sep 2016 10:25:08 +0200
MIME-Version: 1.0
In-Reply-To: <1474444574.270880035@f136.i.mail.ru>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016-09-21 09:56, Alexander Shiyan wrote:
>> Среда, 21 сентября 2016, 9:57 +03:00 от Yangbo Lu <yangbo.lu@nxp.com>:
>>
>> From: Arnd Bergmann < arnd@arndb.de >
>>
>> We keep running into cases where device drivers want to know the exact
>> version of the a SoC they are currently running on. In the past, this has
>> usually been done through a vendor specific API that can be called by a
>> driver, or by directly accessing some kind of version register that is
>> not part of the device itself but that belongs to a global register area
>> of the chip.
> ...
>> +const struct soc_device_attribute *soc_device_match(
>> +const struct soc_device_attribute *matches)
>> +{
>> +int ret = 0;
>> +
>> +if (!matches)
>> +return NULL;
>> +
>> +while (!ret) {
>> +if (!(matches->machine || matches->family ||
>> +      matches->revision || matches->soc_id))
>> +break;
>> +ret = bus_for_each_dev(&soc_bus_type, NULL, (void *)matches,
>> +       soc_device_match_one);
>> +if (!ret)
>> +matches++;
> 
> So, what happen if next "matches" (after increment) will be NULL?

A crash?

> I think you should use while(matches) at the start of this procedure.

*arrgh*

*If* matches wrap, you indeed have *big* problems. *Elsewhere*

Hint: Please read the review comments on the previous version of this
series [1] before commenting further.

Cheers,
Peter

[1] https://www.mail-archive.com/netdev@vger.kernel.org/msg126617.html
