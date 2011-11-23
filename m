Return-Path: <r58472@freescale.com>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
 [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id DB0EA1007D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2011 19:21:03 +1100 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: Peter Chen <hzpeterchen@gmail.com>
Subject: RE: [PATCH] usb/fsl_udc: fix dequeuing a request in progress
Date: Wed, 23 Nov 2011 08:20:54 +0000
Message-ID: <3F607A5180246847A760FD34122A1E052DB395@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1321015093-13715-1-git-send-email-leoli@freescale.com>
 <20111122093437.GA18543@nchen-desktop>
 <3F607A5180246847A760FD34122A1E052D94DB@039-SN1MPN1-003.039d.mgd.msft.net>
 <CAL411-qEgc8T+sdn4VzUXeCd76mQ1wkc9V6oV+CovVV8QrRxYg@mail.gmail.com>
 <CAL411-rXmawefELJCdCgiXT7Ma5Mi7z1zbR_eLZCncTChiR4Mg@mail.gmail.com>
In-Reply-To: <CAL411-rXmawefELJCdCgiXT7Ma5Mi7z1zbR_eLZCncTChiR4Mg@mail.gmail.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Cc: Chen Peter-B29397 <B29397@freescale.com>, "gregkh@suse.de" <gregkh@suse.de>,
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



>-----Original Message-----
>From: Peter Chen [mailto:hzpeterchen@gmail.com]
>Sent: Wednesday, November 23, 2011 11:02 AM
>To: Li Yang-R58472
>Cc: Chen Peter-B29397; balbi@ti.com; gregkh@suse.de; linux-
>usb@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
>Subject: Re: [PATCH] usb/fsl_udc: fix dequeuing a request in progress
>
>On Tue, Nov 22, 2011 at 7:48 PM, Peter Chen <hzpeterchen@gmail.com> wrote:
>>>>It seems to can't get the correct qh pointer, you may still need to
>>>>use below code to get it
>>>> =A0 =A0 =A0 int i =3D ep_index(ep) * 2 + ep_is_in(ep);
>>>> =A0 =A0 =A0 struct ep_queue_head *dQH =3D &ep->udc->ep_qh[i];
>>>
>>> Thanks for trying. =A0 =A0It will be much easier if we can dereference =
QH
>from the ep structure. =A0It is really strange that the ep->qh pointer is
>not working somehow.
>>>
>>
>> Seems only ep0-out's qh pointer is assigned at ep structure.
>> At probe:
>> /* setup udc->eps[] for ep0 */
>> struct_ep_setup(udc_controller, 0, "ep0", 0);
>>
>>
>>> We have initialized it in struct_ep_setup():
>>> =A0 =A0 =A0 =A0ep->qh =3D &udc->ep_qh[index];
>>>
>>> Can you do me a favor on investigating why it's failing?
>>>
>Leo, I have debugged this issue at my board just now, the reason of
>failure is we only have one ep struct for ep0, so when talking about ep0,
>it always pointers to udc->ep[0]. So even we initialize the current qh
>address for ep0in at probe, it still can't get the ep0in's qh address
>through ep structure, as ep0 is always udc->ep[0].

Oops.  I forgot the fact that we used a single ep structure to handle both =
IN and OUT ep0 because the gadget layer only knows about one ep0 structure.

I guess currently we have no other way out unless the gadget layer do honor=
 ep0 with direction.  IMHO, it is a limitation to current gadget APIs that =
each udc driver need to take too much care of the protocol related stuff on=
 ep0.

Thanks,
Leo
