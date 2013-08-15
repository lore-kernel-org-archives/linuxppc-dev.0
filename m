Return-Path: <sergei.shtylyov@cogentembedded.com>
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
 [209.85.215.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5A9312C00D2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Aug 2013 08:51:48 +1000 (EST)
Received: by mail-la0-f53.google.com with SMTP id el20so965781lab.40
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 15:51:44 -0700 (PDT)
Message-ID: <520D5B88.7080304@cogentembedded.com>
Date: Fri, 16 Aug 2013 02:51:52 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>, clbchenlibo.chen@huawei.com
Subject: Re: [PATCH v3 0/7] net: use platform_{get,set}_drvdata()
References: <520CD11D.8010202@huawei.com>
 <20130815.152359.920302339053249583.davem@davemloft.net>
 <20130815.153903.859166500375208182.davem@davemloft.net>
In-Reply-To: <20130815.153903.859166500375208182.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-7; format=flowed
Cc: gregkh@linuxfoundation.org, netdev@vger.kernel.org, jg1.han@samsung.com,
 lizefan@huawei.com, vbordug@ru.mvista.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 08/16/2013 02:39 AM, David Miller wrote:

>> From: Libo Chen <clbchenlibo.chen@huawei.com>
>> Date: Thu, 15 Aug 2013 21:01:17 +0800

>>> Use the wrapper functions for getting and setting the driver data using
>>> platform_device instead of using dev_{get,set}_drvdata() with &pdev->dev,
>>> so we can directly pass a struct platform_device.

>>> changelog v3:
>>> 	remove modify about dev_set_drvdata()
>>> changelog v2:
>>> 	this version add modify record about dev_set_drvdata().

>> Series applied.

> Actually, I had to revert, these patches break the build.

> drivers/net/ethernet/sun/sunhme.c: In function ¡happy_meal_pci_probe¢:
> drivers/net/ethernet/sun/sunhme.c:3114:2: error: implicit declaration of function ¡platform_set_drvdata¢ [-Werror=implicit-function-declaration]
> drivers/net/ethernet/sun/sunhme.c: In function ¡happy_meal_pci_remove¢:
> drivers/net/ethernet/sun/sunhme.c:3162:9: error: implicit declaration of function ¡platform_get_drvdata¢ [-Werror=implicit-function-declaration]
> drivers/net/ethernet/sun/sunhme.c:3162:26: warning: initialization makes pointer from integer without a cast [enabled by default]

    Hm, patch #5 was clearly defective as it tried to call 
platform_{get|set}_drvdata() on PCI devices -- I've read the patch but 
overlooked that. And the driver lacks #include <linux/platform_device.h>, so 
I'm not sure it always compiled flawlessly.

WBR, Sergei
