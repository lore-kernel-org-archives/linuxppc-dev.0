Return-Path: <John.Youn@synopsys.com>
Received: from smtprelay.synopsys.com (smtprelay.synopsys.com [198.182.47.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C46E51A1D63
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 06:16:54 +1000 (AEST)
From: John Youn <John.Youn@synopsys.com>
To: "balbi@ti.com" <balbi@ti.com>, Robert Baldyga <r.baldyga@hackerion.com>
CC: Robert Baldyga <r.baldyga@samsung.com>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>, "Peter.Chen@freescale.com"
 <Peter.Chen@freescale.com>, "John.Youn@synopsys.com"
 <John.Youn@synopsys.com>, "dahlmann.thomas@arcor.de"
 <dahlmann.thomas@arcor.de>, "nicolas.ferre@atmel.com"
 <nicolas.ferre@atmel.com>, "cernekee@gmail.com" <cernekee@gmail.com>,
 "leoli@freescale.com" <leoli@freescale.com>, "daniel@zonque.org"
 <daniel@zonque.org>, "haojian.zhuang@gmail.com" <haojian.zhuang@gmail.com>,
 "robert.jarzmik@free.fr" <robert.jarzmik@free.fr>, "michal.simek@xilinx.com"
 <michal.simek@xilinx.com>, "devel@driverdev.osuosl.org"
 <devel@driverdev.osuosl.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org"
 <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org"
 <linux-omap@vger.kernel.org>, "linux-geode@lists.infradead.org"
 <linux-geode@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "andrzej.p@samsung.com"
 <andrzej.p@samsung.com>, "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>, "stern@rowland.harvard.edu"
 <stern@rowland.harvard.edu>, "petr.cvek@tul.cz" <petr.cvek@tul.cz>
Subject: Re: [PATCH v5 01/46] usb: gadget: encapsulate endpoint claiming
 mechanism
Date: Thu, 20 Aug 2015 20:07:35 +0000
Message-ID: <2B3535C5ECE8B5419E3ECBE30077290901DC3380D9@us01wembx1.internal.synopsys.com>
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
 <1438351258-31578-2-git-send-email-r.baldyga@samsung.com>
 <20150820153553.GD1639@saruman.tx.rr.com> <55D6001E.3000504@hackerion.com>
 <20150820164808.GB4938@saruman.tx.rr.com> <55D60B80.7040800@hackerion.com>
 <20150820174409.GB7270@saruman.tx.rr.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 8/20/2015 10:45 AM, Felipe Balbi wrote:=0A=
> Hi,=0A=
> =0A=
> On Thu, Aug 20, 2015 at 07:16:48PM +0200, Robert Baldyga wrote:=0A=
>> On 08/20/2015 06:48 PM, Felipe Balbi wrote:=0A=
>>> On Thu, Aug 20, 2015 at 06:28:14PM +0200, Robert Baldyga wrote:=0A=
>>>> Hi Felipe,=0A=
>>>>=0A=
>>>> On 08/20/2015 05:35 PM, Felipe Balbi wrote:=0A=
>>>> [...]=0A=
>>>>> just letting you know that this regresses all gadget drivers making t=
hem=0A=
>>>>> try to disable previously disabled endpoints and enable previously=0A=
>>>>> enabled endpoints.=0A=
>>>>>=0A=
>>>>> I have a possible fix (see below) but then it shows a problem on the=
=0A=
>>>>> host side when using with g_zero (see further below):=0A=
>>>>>=0A=
>>>>> commit 3b8932100aacb6cfbffe288ca93025d8b8430c00=0A=
>>>>> Author: Felipe Balbi <balbi@ti.com>=0A=
>>>>> Date:   Wed Aug 19 18:05:27 2015 -0500=0A=
>>>>>=0A=
>>>>>     usb: gadget: fix ep->claimed lifetime=0A=
>>>>>=0A=
>>>>>     In order to fix a regression introduced by commit=0A=
>>>>>     cc476b42a39d ("usb: gadget: encapsulate endpoint=0A=
>>>>>     claiming mechanism") we have to introduce a simple=0A=
>>>>>     helper to check if a particular is enabled or not.=0A=
>>>>>=0A=
>>>>>     After that, we need to move ep->claimed lifetime to=0A=
>>>>>     usb_ep_enable() and usb_ep_disable() since those=0A=
>>>>>     are the only functions which actually enable and=0A=
>>>>>     disable endpoints.=0A=
>>>>>=0A=
>>>>>     A follow-up patch will come to drop all driver_data=0A=
>>>>>     checks from function drivers, since those are, now,=0A=
>>>>>     pointless.=0A=
>>>>>=0A=
>>>>>     Fixes: cc476b42a39d ("usb: gadget: encapsulate endpoint=0A=
>>>>>     	claiming mechanism")=0A=
>>>>>     Cc: Robert Baldyga <r.baldyga@samsung.com>=0A=
>>>>>     Signed-off-by: Felipe Balbi <balbi@ti.com>=0A=
>>>>>=0A=
>>>>> diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epa=
utoconf.c=0A=
>>>>> index 978435a51038..ad45070cd76f 100644=0A=
>>>>> --- a/drivers/usb/gadget/epautoconf.c=0A=
>>>>> +++ b/drivers/usb/gadget/epautoconf.c=0A=
>>>>> @@ -126,7 +126,6 @@ found_ep:=0A=
>>>>>  	ep->address =3D desc->bEndpointAddress;=0A=
>>>>>  	ep->desc =3D NULL;=0A=
>>>>>  	ep->comp_desc =3D NULL;=0A=
>>>>> -	ep->claimed =3D true;=0A=
>>>>=0A=
>>>> Removing this line causes autoconfig can return the same endpoint many=
=0A=
>>>> times. This probably causes problems with g_zero.=0A=
>>>>=0A=
>>>> I will try to fix it ASAP.=0A=
>>>=0A=
>>> I was considering the same thing, but the lifetime of ->claimed doesn't=
=0A=
>>> look correct to me either way. Note that once the flag is enabled, it=
=0A=
>>> won't get disabled by most gadget drivers.=0A=
>>=0A=
>> And it should not be. This flag is indicator, that endpoint is used by s=
ome=0A=
>> function. It should be set once by usb_ep_autoconfig() and cleared by=0A=
>> usb_ep_autoconfig_reset().=0A=
=0A=
And the 'claimed' flag should be used for the ep autoconfig=0A=
mechanism alone. We may want to reset it during the autoconfig=0A=
phase for multiple configs and alt-interfaces. So there should be=0A=
separate 'claimed' and 'enabled' flags.=0A=
=0A=
=0A=
> =0A=
> have you considered switching interfaces and/or alternate settings ?=0A=
=0A=
We ran into similar issues before with this very scenario. Handling=0A=
of set_config(0 or N), in both addressed and configured states, and=0A=
set_interface requests.=0A=
=0A=
=0A=
John=0A=
=0A=
