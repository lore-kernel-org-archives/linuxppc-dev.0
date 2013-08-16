Return-Path: <libo.chen@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
 (Client CN "myname.my.domain", Issuer "www.mirapoint.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DBBFF2C0237
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 12:16:10 +1000 (EST)
Message-ID: <520D8B4C.8010509@huawei.com>
Date: Fri, 16 Aug 2013 10:15:40 +0800
From: Libo Chen <clbchenlibo.chen@huawei.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v3 0/7] net: use platform_{get,set}_drvdata()
References: <520CD11D.8010202@huawei.com>
 <20130815.152359.920302339053249583.davem@davemloft.net>
 <20130815.153903.859166500375208182.davem@davemloft.net>
In-Reply-To: <20130815.153903.859166500375208182.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-7"
Cc: sergei.shtylyov@cogentembedded.com, gregkh@linuxfoundation.org,
 netdev@vger.kernel.org, jg1.han@samsung.com, lizefan@huawei.com,
 vbordug@ru.mvista.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2013/8/16 6:39, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Thu, 15 Aug 2013 15:23:59 -0700 (PDT)
> 
>> From: Libo Chen <clbchenlibo.chen@huawei.com>
>> Date: Thu, 15 Aug 2013 21:01:17 +0800
>>
>>> Use the wrapper functions for getting and setting the driver data using
>>> platform_device instead of using dev_{get,set}_drvdata() with &pdev->dev,
>>> so we can directly pass a struct platform_device.
>>>
>>> changelog v3:
>>> 	remove modify about dev_set_drvdata()
>>> changelog v2:
>>> 	this version add modify record about dev_set_drvdata().
>>
>> Series applied.
> 
> Actually, I had to revert, these patches break the build.
> 
> drivers/net/ethernet/sun/sunhme.c: In function ¡happy_meal_pci_probe¢:
> drivers/net/ethernet/sun/sunhme.c:3114:2: error: implicit declaration of function ¡platform_set_drvdata¢ [-Werror=implicit-function-declaration]
> drivers/net/ethernet/sun/sunhme.c: In function ¡happy_meal_pci_remove¢:
> drivers/net/ethernet/sun/sunhme.c:3162:9: error: implicit declaration of function ¡platform_get_drvdata¢ [-Werror=implicit-function-declaration]
> drivers/net/ethernet/sun/sunhme.c:3162:26: warning: initialization makes pointer from integer without a cast [enabled by default]
> 


oh, it is my fault, I will update!
