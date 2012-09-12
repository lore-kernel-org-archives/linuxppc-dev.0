Return-Path: <r58472@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 673012C009C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 21:17:22 +1000 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: "balbi@ti.com" <balbi@ti.com>, Enrico Scholz
 <enrico.scholz@sigma-chemnitz.de>
Subject: RE: [PATCH] usb: gadget: fsl_udc_core: do not immediatly prime
 STATUS for IN xfer
Date: Wed, 12 Sep 2012 11:17:14 +0000
Message-ID: <94F013E7935FF44C83EBE7784D62AD3F09418B8A@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1346777932-3362-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
 <F281D0F91ED19E4D8E63A7504E8A649803C67DA2@039-SN2MPN1-023.039d.mgd.msft.net>
 <20120906131708.GJ29202@arwen.pp.htv.fi>
 <lyehmf1b27.fsf@ensc-virt.intern.sigma-chemnitz.de>
 <20120906142739.GV29202@arwen.pp.htv.fi>
In-Reply-To: <20120906142739.GV29202@arwen.pp.htv.fi>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Chen Peter-B29397 <B29397@freescale.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Felipe Balbi [mailto:balbi@ti.com]
> Sent: Thursday, September 06, 2012 10:28 PM
> To: Enrico Scholz
> Cc: balbi@ti.com; Chen Peter-B29397; linux-usb@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; Li Yang-R58472; gregkh@linuxfoundation.org
> Subject: Re: [PATCH] usb: gadget: fsl_udc_core: do not immediatly prime
> STATUS for IN xfer
>=20
> Hi,
>=20
> On Thu, Sep 06, 2012 at 04:27:12PM +0200, Enrico Scholz wrote:
> > Felipe Balbi <balbi@ti.com> writes:
> >
> > >> > Because the fsl_udc_core driver shares one 'status_req' object
> > >> > for the complete ep0 control transfer, it is not possible to
> > >> > prime the final STATUS phase immediately after the IN
> > >> > transaction.  E.g. ch9getstatus()
> > >> > executed:
> > >> >
> > >> > | req =3D udc->status_req;
> > >> > | ...
> > >> > | list_add_tail(&req->queue, &ep->queue); if
> > >> > | (ep0_prime_status(udc, EP_DIR_OUT))
> > >> > |       ....
> > >> > |       struct fsl_req *req =3D udc->status_req;
> > >> > |       list_add_tail(&req->queue, &ep->queue);
> > >> >
> > >> > which corrupts the ep->queue list by inserting 'status_req'
> > >> > twice.  This causes a kernel oops e.g. when 'lsusb -v' is executed
> on the host.
> > >> >
> > >> > Patch delays the final 'ep0_prime_status(udc, EP_DIR_OUT))' by
> > >> > moving it into the ep0 completion handler.
> > >> >
> > >> Enrico, thanks for pointing this problem.
> > >>
> > >> As "prime STATUS phase immediately after the IN transaction" is
> > >> followed USB 2.0 spec, to fix this problem, it is better to add
> data_req for ep0.
> > >> In fact, it is already at FSL i.mx internal code, just still not
> mainlined.
> > >
> > > so, do I get an Acked-by to this patch ? Does it need to go on
> > > v3.6-rc or can it wait until v3.7 merge window ?
> >
> > Without this (or the mentioned data_req patch), I can crash a g_multi
> > gadget by executing 'lsusb -v' as root on the host.  Should not be
> > exploitable (only a BUG_ON() is triggered) but issue should be fixed
> > asap.
>=20
> cool, so I'll apply to my fixes branch as soon as I get Acked-by or
> Tested-by from someone.

This seems to revert the error handling for USB2.0 spec 8.5.3.3.  But the p=
roblem is a serious one to be fixed right away.  So

Acked-by: Li Yang <leoli@freescale.com>

We need to revisit the error handling issue later and find a proper way to =
address it.

Regards,
Leo
