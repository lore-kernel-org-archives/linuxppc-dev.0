Return-Path: <r.baldyga@hackerion.com>
Received: from sender163-mail.zoho.com (sender163-mail.zoho.com
 [74.201.84.163])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A66B1A1BEE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 19:50:38 +1000 (AEST)
Message-ID: <55B35825.7010607@hackerion.com>
Date: Sat, 25 Jul 2015 11:34:29 +0200
From: Robert Baldyga <r.baldyga@hackerion.com>
MIME-Version: 1.0
To: Krzysztof Opasiak <k.opasiak@samsung.com>,
 Robert Baldyga <r.baldyga@samsung.com>,
 gregkh@linuxfoundation.org, balbi@ti.com
CC: Peter.Chen@freescale.com, johnyoun@synopsys.com,
 dahlmann.thomas@arcor.de, nicolas.ferre@atmel.com, cernekee@gmail.com,
 leoli@freescale.com, daniel@zonque.org, haojian.zhuang@gmail.com,
 robert.jarzmik@free.fr, michal.simek@xilinx.com,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-geode@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, andrzej.p@samsung.com,
 m.szyprowski@samsung.com
Subject: Re: [PATCH v3 26/46] usb: gadget: pch_ud: add ep capabilities support
References: <1436941953-1327-1-git-send-email-r.baldyga@samsung.com>
 <1436941953-1327-27-git-send-email-r.baldyga@samsung.com>
 <55AD0EDD.70201@samsung.com>
In-Reply-To: <55AD0EDD.70201@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 07/20/2015 05:08 PM, Krzysztof Opasiak wrote:
>
>
> On 07/15/2015 08:32 AM, Robert Baldyga wrote:
>> Convert endpoint configuration to new capabilities model.
>>
>> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
>> ---
>>   drivers/usb/gadget/udc/pch_udc.c | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/udc/pch_udc.c
>> b/drivers/usb/gadget/udc/pch_udc.c
>> index 613547f..cc8fb3c 100644
>> --- a/drivers/usb/gadget/udc/pch_udc.c
>> +++ b/drivers/usb/gadget/udc/pch_udc.c
>> @@ -2895,11 +2895,21 @@ static void pch_udc_pcd_reinit(struct
>> pch_udc_dev *dev)
>>           ep->in = ~i & 1;
>>           ep->ep.name = ep_string[i];
>>           ep->ep.ops = &pch_udc_ep_ops;
>> -        if (ep->in)
>> +        if (ep->in) {
>>               ep->offset_addr = ep->num * UDC_EP_REG_SHIFT;
>> -        else
>> +            ep->ep.caps.dir_in = true;
>> +        } else {
>>               ep->offset_addr = (UDC_EPINT_OUT_SHIFT + ep->num) *
>>                         UDC_EP_REG_SHIFT;
>> +            ep->ep.caps.dir_out = true;
>> +        }
>> +        if (i == UDC_EP0IN_IDX || i == UDC_EP0OUT_IDX) {
>> +            ep->ep.caps.type_control = true;
>
> In all previous patches you set both dir_in and dir_out to true for ep0
> but in this patch you don't do this. Is there some reason for this or
> it's just a mistake?
>

Most of UDC drivers we have single instance of ep0 for both directions, 
but this one has two separate unidirectional ep0in and ep0out.

>> +        } else {
>> +            ep->ep.caps.type_iso = true;
>> +            ep->ep.caps.type_bulk = true;
>> +            ep->ep.caps.type_int = true;
>> +        }
>>           /* need to set ep->ep.maxpacket and set Default
>> Configuration?*/
>>           usb_ep_set_maxpacket_limit(&ep->ep, UDC_BULK_MAX_PKT_SIZE);
>>           list_add_tail(&ep->ep.ep_list, &dev->gadget.ep_list);
>>
>

Thanks,
Robert Baldyga
