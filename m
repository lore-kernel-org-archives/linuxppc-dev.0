Return-Path: <sebastian.huber@embedded-brains.de>
Received: from dedi548.your-server.de (dedi548.your-server.de [85.10.215.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wv8515R8VzDql5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 16:42:13 +1000 (AEST)
Subject: Re: DPAA: Software Portal selection for network interface
To: Madalin-cristian Bucur <madalin.bucur@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <14d11770-fdbb-4719-559a-924855957568@embedded-brains.de>
 <AM5PR0402MB26913CAEE7420F66309623D9ECDB0@AM5PR0402MB2691.eurprd04.prod.outlook.com>
From: Sebastian Huber <sebastian.huber@embedded-brains.de>
Message-ID: <a5c3c67e-6533-e5d7-c381-d3655398b8f9@embedded-brains.de>
Date: Fri, 23 Jun 2017 08:42:06 +0200
MIME-Version: 1.0
In-Reply-To: <AM5PR0402MB26913CAEE7420F66309623D9ECDB0@AM5PR0402MB2691.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22/06/17 16:48, Madalin-cristian Bucur wrote:

>> This means all the QMan portal_isr() are distributed round-robin to al=
l
>> affine portals. Is there some way to configure the software portal for=
 a
>> specific network interface, e.g. use processors 0, 1, 2, 3 for one
>> interface,and 4, 5, 6, 7 for another?
> We've stripped all configurability and advanced features from the initi=
al
> DPAA submission. We don't have options to configure this. On the other =
hand,
> the ingress queues are held active in the portal, resulting in one CPU =
doing
> dequeues while there are frames available. This is done to avoid frame
> reordering, improving termination performance (and forwarded TCP perfor=
mance).
>
> The downside is that we're not saturating all CPUs with traffic. We're
> currently working on adding Rx hashing, to be able to maintain intra-fl=
ow
> frame order while spreading processing on all CPUs.
>
> Meanwhile, would RPS (Receive Packet Steering) be a solution for you?
>

We receive UDP packets with an MTU of 1500 on one of the 10G interfaces=20
at wire speed. So, I guess I have to add this configure myself somehow=20
and use a dedicated software portal for this interface.

--=20
Sebastian Huber, embedded brains GmbH

Address : Dornierstr. 4, D-82178 Puchheim, Germany
Phone   : +49 89 189 47 41-16
Fax     : +49 89 189 47 41-09
E-Mail  : sebastian.huber@embedded-brains.de
PGP     : Public key available on request.

Diese Nachricht ist keine gesch=C3=A4ftliche Mitteilung im Sinne des EHUG=
.
