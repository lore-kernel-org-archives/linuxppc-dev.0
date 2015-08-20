Return-Path: <r.baldyga@hackerion.com>
Received: from sender163-mail.zoho.com (sender163-mail.zoho.com
 [74.201.84.163])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB2981A0103
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 03:17:03 +1000 (AEST)
Message-ID: <55D60B80.7040800@hackerion.com>
Date: Thu, 20 Aug 2015 19:16:48 +0200
From: Robert Baldyga <r.baldyga@hackerion.com>
MIME-Version: 1.0
To: balbi@ti.com
CC: Robert Baldyga <r.baldyga@samsung.com>, gregkh@linuxfoundation.org,
 Peter.Chen@freescale.com, johnyoun@synopsys.com,
 dahlmann.thomas@arcor.de, nicolas.ferre@atmel.com, cernekee@gmail.com,
 leoli@freescale.com, daniel@zonque.org, haojian.zhuang@gmail.com,
 robert.jarzmik@free.fr, michal.simek@xilinx.com,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-geode@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, andrzej.p@samsung.com,
 m.szyprowski@samsung.com, stern@rowland.harvard.edu, petr.cvek@tul.cz
Subject: Re: [PATCH v5 01/46] usb: gadget: encapsulate endpoint claiming
 mechanism
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
 <1438351258-31578-2-git-send-email-r.baldyga@samsung.com>
 <20150820153553.GD1639@saruman.tx.rr.com> <55D6001E.3000504@hackerion.com>
 <20150820164808.GB4938@saruman.tx.rr.com>
In-Reply-To: <20150820164808.GB4938@saruman.tx.rr.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/20/2015 06:48 PM, Felipe Balbi wrote:
> On Thu, Aug 20, 2015 at 06:28:14PM +0200, Robert Baldyga wrote:
>> Hi Felipe,
>>
>> On 08/20/2015 05:35 PM, Felipe Balbi wrote:
>> [...]
>>> just letting you know that this regresses all gadget drivers making them
>>> try to disable previously disabled endpoints and enable previously
>>> enabled endpoints.
>>>
>>> I have a possible fix (see below) but then it shows a problem on the
>>> host side when using with g_zero (see further below):
>>>
>>> commit 3b8932100aacb6cfbffe288ca93025d8b8430c00
>>> Author: Felipe Balbi <balbi@ti.com>
>>> Date:   Wed Aug 19 18:05:27 2015 -0500
>>>
>>>      usb: gadget: fix ep->claimed lifetime
>>>
>>>      In order to fix a regression introduced by commit
>>>      cc476b42a39d ("usb: gadget: encapsulate endpoint
>>>      claiming mechanism") we have to introduce a simple
>>>      helper to check if a particular is enabled or not.
>>>
>>>      After that, we need to move ep->claimed lifetime to
>>>      usb_ep_enable() and usb_ep_disable() since those
>>>      are the only functions which actually enable and
>>>      disable endpoints.
>>>
>>>      A follow-up patch will come to drop all driver_data
>>>      checks from function drivers, since those are, now,
>>>      pointless.
>>>
>>>      Fixes: cc476b42a39d ("usb: gadget: encapsulate endpoint
>>>      	claiming mechanism")
>>>      Cc: Robert Baldyga <r.baldyga@samsung.com>
>>>      Signed-off-by: Felipe Balbi <balbi@ti.com>
>>>
>>> diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
>>> index 978435a51038..ad45070cd76f 100644
>>> --- a/drivers/usb/gadget/epautoconf.c
>>> +++ b/drivers/usb/gadget/epautoconf.c
>>> @@ -126,7 +126,6 @@ found_ep:
>>>   	ep->address = desc->bEndpointAddress;
>>>   	ep->desc = NULL;
>>>   	ep->comp_desc = NULL;
>>> -	ep->claimed = true;
>>
>> Removing this line causes autoconfig can return the same endpoint many
>> times. This probably causes problems with g_zero.
>>
>> I will try to fix it ASAP.
>
> I was considering the same thing, but the lifetime of ->claimed doesn't
> look correct to me either way. Note that once the flag is enabled, it
> won't get disabled by most gadget drivers.

And it should not be. This flag is indicator, that endpoint is used by 
some function. It should be set once by usb_ep_autoconfig() and cleared 
by usb_ep_autoconfig_reset().

I wonder what is reason of this enable/disable regression. Maybe the 
problem is that we don't set ep->driver_data to NULL in 
usb_ep_autoconfig_reset() (so far it was done). Does this problem occur 
while gadget is binded to UDC for the first time, or at any next time? 
Unfortunately at this moment I don't have access to my hardware, so it 
will take a moment before I will setup some testing environment.

Thanks,
Robert
