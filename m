Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-wg0-x234.google.com (mail-wg0-x234.google.com
 [IPv6:2a00:1450:400c:c00::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 84E832C0327
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Mar 2014 01:29:02 +1100 (EST)
Received: by mail-wg0-f52.google.com with SMTP id k14so3224845wgh.23
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Mar 2014 06:28:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1393247295.28803.10.camel@smile.fi.intel.com>
References: <1393240172-18769-1-git-send-email-a13xp0p0v88@gmail.com>
 <1393240172-18769-6-git-send-email-a13xp0p0v88@gmail.com>
 <1393247295.28803.10.camel@smile.fi.intel.com>
Date: Thu, 6 Mar 2014 18:28:57 +0400
Message-ID: <CAF0T0X5XAd=qW_4F2fmz_nmLDifjeicO23i_BThph2gsQiKgRg@mail.gmail.com>
Subject: Re: [PATCH RFC v8 5/5] dma: mpc512x: register for device tree channel
 lookup
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>,
 Gerhard Sittig <gsi@denx.de>, Alexander Popov <a13xp0p0v88@gmail.com>,
 dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Andy.

2014-02-24 17:08 GMT+04:00 Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> On Mon, 2014-02-24 at 15:09 +0400, Alexander Popov wrote:
>> @@ -1018,11 +1019,23 @@ static int mpc_dma_probe(struct platform_device *op)
>>       /* Register DMA engine */
>>       dev_set_drvdata(dev, mdma);
>>       retval = dma_async_device_register(dma);
>> -     if (retval) {
>> -             devm_free_irq(dev, mdma->irq, mdma);
>> -             irq_dispose_mapping(mdma->irq);
>> +     if (retval)
>> +             goto out_irq;
>> +
>> +     /* register with OF helpers for DMA lookups (nonfatal) */
>> +     if (dev->of_node) {
>> +             retval = of_dma_controller_register(dev->of_node,
>> +                                                 of_dma_xlate_by_chan_id,
>> +                                                 mdma);
>> +             if (retval)
>> +                     dev_warn(dev, "could not register for OF lookup\n");
>>       }
>>
>> +     return 0;
>> +
>> +out_irq:
>> +     devm_free_irq(dev, mdma->irq, mdma);
>
> Something wrong either with devm_request_irq() or you don't need to call
> devm_free_irq() explicitly. Once we already try to discuss this earlier
> in this mailing list with Lars-Peter(?), though there were no solution
> how to keep devm_*_irq usability.

Thanks, I've read this discussion. It seems that the current code doesn't do
anything bad, though devm_request_irq() and devm_free_irq() can be changed
to request_irq() and free_irq() accordingly. Do you think it's worth being done
in a separate patch in this series?

>> +     irq_dispose_mapping(mdma->irq);
>>       return retval;
>>  }
>>
>> @@ -1031,6 +1044,8 @@ static int mpc_dma_remove(struct platform_device *op)
>>       struct device *dev = &op->dev;
>>       struct mpc_dma *mdma = dev_get_drvdata(dev);
>>
>> +     if (dev->of_node)
>> +             of_dma_controller_free(dev->of_node);
>>       dma_async_device_unregister(&mdma->dma);
>>       devm_free_irq(dev, mdma->irq, mdma);
>>       irq_dispose_mapping(mdma->irq);

Best regards,
Alexander
