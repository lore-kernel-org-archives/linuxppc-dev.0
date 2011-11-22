Return-Path: <r58472@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
 [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 69D24B70B7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 20:49:40 +1100 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: Chen Peter-B29397 <B29397@freescale.com>
Subject: RE: [PATCH] usb/fsl_udc: fix dequeuing a request in progress
Date: Tue, 22 Nov 2011 09:49:25 +0000
Message-ID: <3F607A5180246847A760FD34122A1E052D94DB@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1321015093-13715-1-git-send-email-leoli@freescale.com>
 <20111122093437.GA18543@nchen-desktop>
In-Reply-To: <20111122093437.GA18543@nchen-desktop>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: "gregkh@suse.de" <gregkh@suse.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "balbi@ti.com" <balbi@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>Subject: Re: [PATCH] usb/fsl_udc: fix dequeuing a request in progress
>
>On Fri, Nov 11, 2011 at 08:38:13PM +0800, Li Yang wrote:
>> The original implementation of dequeuing a request in progress is not
>> correct.  Change to use a correct process and also clean up the
>> related functions a little bit.
>>
>> Signed-off-by: Li Yang <leoli@freescale.com>
>> ---
>>  drivers/usb/gadget/fsl_udc_core.c |   62 +++++++++++++++++-------------
>------
>>  1 files changed, 29 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/fsl_udc_core.c
>> b/drivers/usb/gadget/fsl_udc_core.c
>> index b2c44e1..beef9b7 100644
>> --- a/drivers/usb/gadget/fsl_udc_core.c
>> +++ b/drivers/usb/gadget/fsl_udc_core.c
>> @@ -696,12 +696,31 @@ static void fsl_free_request(struct usb_ep *_ep,
>struct usb_request *_req)
>>  		kfree(req);
>>  }
>>
>> -/*-------------------------------------------------------------------
>> ------*/
>> +/* Actually add a dTD chain to an empty dQH and let go */ static void
>> +fsl_prime_ep(struct fsl_ep *ep, struct ep_td_struct *td) {
>> +	struct ep_queue_head *qh =3D ep->qh;
>It seems to can't get the correct qh pointer, you may still need to use
>below code to get it
> 	int i =3D ep_index(ep) * 2 + ep_is_in(ep);
> 	struct ep_queue_head *dQH =3D &ep->udc->ep_qh[i];

Thanks for trying.    It will be much easier if we can dereference QH from =
the ep structure.  It is really strange that the ep->qh pointer is not work=
ing somehow.

We have initialized it in struct_ep_setup():
	ep->qh =3D &udc->ep_qh[index];

Can you do me a favor on investigating why it's failing?

Thanks,
Leo
