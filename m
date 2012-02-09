Return-Path: <r58472@freescale.com>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
 [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 14728B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2012 21:45:13 +1100 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: RE: [RFC] Multi queue support in ethernet/freescale/ucc_geth.c
Date: Thu, 9 Feb 2012 10:44:54 +0000
Message-ID: <94F013E7935FF44C83EBE7784D62AD3F0571F5FE@039-SN2MPN1-022.039d.mgd.msft.net>
References: <4F2B1138.2090004@windriver.com>
In-Reply-To: <4F2B1138.2090004@windriver.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Paul Gortmaker [mailto:paul.gortmaker@windriver.com]
> Sent: Friday, February 03, 2012 6:42 AM
> To: Li Yang-R58472
> Cc: netdev@vger.kernel.org; linuxppc-dev@lists.ozlabs.org
> Subject: [RFC] Multi queue support in ethernet/freescale/ucc_geth.c
>=20
> Hi Li,

Hi Paul,

Sorry for the late response due to holidays.

>=20
> A while back DaveM mentioned that it would be good to break out the ring
> allocations[1] in this driver.
>=20
> I was looking at it, and in the process noticed this:
>=20
> $ grep 'numQueues.*=3D' drivers/net/ethernet/freescale/ucc_geth.c
>         .numQueuesTx =3D 1,
>         .numQueuesRx =3D 1,
> $
>=20
> My interpretation of the above is that there is no way (aside from a code
> edit) to enable multi queue support.
> They are only ever assigned one time, to a value of one.
>=20
> Assuming I'm not missing something obvious, is the multi queue support
> functional and tested, or just old code that never got tested and
> subsequently enabled?

Previously the device is only used on single core cpu, so we didn't have th=
e incentive to enable multi-queue.  It is not tested on Linux currently.

>=20
> The reason I ask, is that the ring allocation code gets rid of the loop
> wrapping it, if the driver is really only meant to ever have just single
> queues for Rx/Tx. And other areas of the driver can also be simplified
> accordingly as well.

Well.  I would prefer the other way which is to add the multi-queue support=
 as we are using the QE in multi-core SoC and the current driver is having =
almost all the code needed for multi-queue except interface to the protocol=
 layer.

- Leo
