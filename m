Return-Path: <hzpeterchen@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
 [209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 0FFD4B70FF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2011 14:02:10 +1100 (EST)
Received: by faaa20 with SMTP id a20so1202725faa.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2011 19:02:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAL411-qEgc8T+sdn4VzUXeCd76mQ1wkc9V6oV+CovVV8QrRxYg@mail.gmail.com>
References: <1321015093-13715-1-git-send-email-leoli@freescale.com>
 <20111122093437.GA18543@nchen-desktop>
 <3F607A5180246847A760FD34122A1E052D94DB@039-SN1MPN1-003.039d.mgd.msft.net>
 <CAL411-qEgc8T+sdn4VzUXeCd76mQ1wkc9V6oV+CovVV8QrRxYg@mail.gmail.com>
Date: Wed, 23 Nov 2011 11:02:04 +0800
Message-ID: <CAL411-rXmawefELJCdCgiXT7Ma5Mi7z1zbR_eLZCncTChiR4Mg@mail.gmail.com>
Subject: Re: [PATCH] usb/fsl_udc: fix dequeuing a request in progress
From: Peter Chen <hzpeterchen@gmail.com>
To: Li Yang-R58472 <r58472@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
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

On Tue, Nov 22, 2011 at 7:48 PM, Peter Chen <hzpeterchen@gmail.com> wrote:
>>>It seems to can't get the correct qh pointer, you may still need to use
>>>below code to get it
>>> =A0 =A0 =A0 int i =3D ep_index(ep) * 2 + ep_is_in(ep);
>>> =A0 =A0 =A0 struct ep_queue_head *dQH =3D &ep->udc->ep_qh[i];
>>
>> Thanks for trying. =A0 =A0It will be much easier if we can dereference Q=
H from the ep structure. =A0It is really strange that the ep->qh pointer is=
 not working somehow.
>>
>
> Seems only ep0-out's qh pointer is assigned at ep structure.
> At probe:
> /* setup udc->eps[] for ep0 */
> struct_ep_setup(udc_controller, 0, "ep0", 0);
>
>
>> We have initialized it in struct_ep_setup():
>> =A0 =A0 =A0 =A0ep->qh =3D &udc->ep_qh[index];
>>
>> Can you do me a favor on investigating why it's failing?
>>
Leo, I have debugged this issue at my board just now, the reason of failure
is we only have one ep struct for ep0, so when talking about ep0, it always
pointers to udc->ep[0]. So even we initialize the current qh address for ep=
0in
at probe, it still can't get the ep0in's qh address through ep
structure, as ep0 is
always udc->ep[0].

>> Thanks,
>> Leo
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
>
> --
> BR,
> Peter Chen
>



--=20
BR,
Peter Chen
