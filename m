Return-Path: <B29397@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe005.messaging.microsoft.com [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B12FA2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 12:10:50 +1000 (EST)
From: Chen Peter-B29397 <B29397@freescale.com>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] usb: gadget: fsl_udc_core: do not immediatly prime
 STATUS for IN xfer
Date: Wed, 5 Sep 2012 02:10:39 +0000
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803C67DA2@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1346777932-3362-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
In-Reply-To: <1346777932-3362-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 Li Yang-R58472 <r58472@freescale.com>, "balbi@ti.com" <balbi@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
>=20
> Because the fsl_udc_core driver shares one 'status_req' object for the
> complete ep0 control transfer, it is not possible to prime the final
> STATUS phase immediately after the IN transaction.  E.g. ch9getstatus()
> executed:
>=20
> | req =3D udc->status_req;
> | ...
> | list_add_tail(&req->queue, &ep->queue);
> | if (ep0_prime_status(udc, EP_DIR_OUT))
> |       ....
> |       struct fsl_req *req =3D udc->status_req;
> |       list_add_tail(&req->queue, &ep->queue);
>=20
> which corrupts the ep->queue list by inserting 'status_req' twice.  This
> causes a kernel oops e.g. when 'lsusb -v' is executed on the host.
>=20
> Patch delays the final 'ep0_prime_status(udc, EP_DIR_OUT))' by moving it
> into the ep0 completion handler.
>=20
Enrico, thanks for pointing this problem.

As "prime STATUS phase immediately after the IN transaction" is followed
USB 2.0 spec, to fix this problem, it is better to add data_req for ep0.
In fact, it is already at FSL i.mx internal code, just still not mainlined.

Peter
=20
