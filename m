Return-Path: <sebastian.huber@embedded-brains.de>
Received: from dedi548.your-server.de (dedi548.your-server.de [85.10.215.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wthlW70gSzDr6v
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 23:10:31 +1000 (AEST)
To: linuxppc-dev@lists.ozlabs.org
Cc: Madalin Bucur <madalin.bucur@nxp.com>
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
Subject: DPAA: Software Portal selection for network interface
Message-ID: <14d11770-fdbb-4719-559a-924855957568@embedded-brains.de>
Date: Thu, 22 Jun 2017 14:42:08 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

as far as I understand the software portal selection for a network=20
interface is done in

static int dpaa_eth_probe(struct platform_device *pdev)
{
     [...]
     channel =3D dpaa_get_channel();
     if (channel < 0) {
         dev_err(dev, "dpaa_get_channel() failed\n");
         err =3D channel;
         goto get_channel_failed;
     }

     priv->channel =3D (u16)channel;

     /* Start a thread that will walk the CPUs with affine portals
      * and add this pool channel to each's dequeue mask.
      */
     dpaa_eth_add_channel(priv->channel);

with

static int dpaa_get_channel(void)
{
     spin_lock(&rx_pool_channel_init);
     if (!rx_pool_channel) {
         u32 pool;
         int ret;

         ret =3D qman_alloc_pool(&pool);

         if (!ret)
             rx_pool_channel =3D pool;
     }
     spin_unlock(&rx_pool_channel_init);
     if (!rx_pool_channel)
         return -ENOMEM;
     return rx_pool_channel;
}

which always returns the same pool channel (e.g. 0x401) if successful.

This means all the QMan portal_isr() are distributed round-robin to all=20
affine portals. Is there some way to configure the software portal for a=20
specific network interface, e.g. use processors 0, 1, 2, 3 for one=20
interface,and 4, 5, 6, 7 for another?

--=20
Sebastian Huber, embedded brains GmbH

Address : Dornierstr. 4, D-82178 Puchheim, Germany
Phone   : +49 89 189 47 41-16
Fax     : +49 89 189 47 41-09
E-Mail  : sebastian.huber@embedded-brains.de
PGP     : Public key available on request.

Diese Nachricht ist keine gesch=C3=A4ftliche Mitteilung im Sinne des EHUG=
.
