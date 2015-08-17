Return-Path: <Laurentiu.Tudor@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0122.outbound.protection.outlook.com [207.46.100.122])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 22E091A0372
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 00:13:04 +1000 (AEST)
Message-ID: <55D1B970.1020405@freescale.com>
Date: Mon, 17 Aug 2015 13:37:36 +0300
From: Laurentiu Tudor <b10716@freescale.com>
MIME-Version: 1.0
To: <linuxppc-dev@lists.ozlabs.org>, Ran Shalit <ranshalit@gmail.com>
Subject: Re: using general IRQs
References: <CAJ2oMhLX18merCHtge0oOQ2DSQ8BE1Zd=dAuPWzyTRNmr-DLiA@mail.gmail.com>
In-Reply-To: <CAJ2oMhLX18merCHtge0oOQ2DSQ8BE1Zd=dAuPWzyTRNmr-DLiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10/2015 10:48 AM, Ran Shalit wrote:
> Hello,
> 
> MPC8349 has general IRQ numbered 0-7,
> It is required to bind these IRQs with some routine , i.e. they are
> not used with any specific driver.
> 
> - Should they be configured as gpios in device tree so that we can use
> the gpio as irq in linux ? Is there any example ?

If it's a gpio then yes, you need to use it as a gpio. Not familiar with MPC8349,
but newer FSL chips can select between gpio or irq through a RCW field (IRQ_BASE?).

Note that for gpios there's special apis, such as:  of_get_gpio(), gpio_request_one() a.s.o.
Also you'll need to update your device tree node to something like:

  intc2@0{
   compatible = "intc2";
   reg = <0 0x1000>;
   gpios = <&gpio0 4 0>;
  };

See Documentation/gpio.txt for more info.

---
Best Regards, Laurentiu
