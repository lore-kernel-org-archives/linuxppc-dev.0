Return-Path: <B08782@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 934172C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Oct 2013 18:10:32 +1100 (EST)
Message-ID: <525E3BD7.1020208@freescale.com>
Date: Wed, 16 Oct 2013 10:10:15 +0300
From: Claudiu Manoil <claudiu.manoil@freescale.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Thomas_H=FChn?= <thomas@net.t-labs.tu-berlin.de>
Subject: Re: Fwd: Gianfar driver crashes in Kernel v3.10
References: <90BE8C5D-E23B-41B5-BB52-8A0C0758931D@net.t-labs.tu-berlin.de>
 <760FFC38-597B-46CB-BA4C-620A1D663C8A@net.t-labs.tu-berlin.de>
In-Reply-To: <760FFC38-597B-46CB-BA4C-620A1D663C8A@net.t-labs.tu-berlin.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/11/2013 11:59 AM, Thomas H=FChn wrote:
> Hi Claudiu,
>
>> Does this show up on a half duplex (100Mb/s) link?
>
> In my testsetup I always used 1GBit Ethernet connections, so no 100MBit=
 tested yet.
> Should I do so ?
>
>> Could you provide following for the gianfar interface, on your setup:
>
> sure:
>> # ethtool ethX
> root@Bluse-home:~# ethtool eth0
> Settings for eth0:
>         Supported ports: [ ]
>         Supported link modes:   1000baseT/Full
>         Supported pause frame use: No
>         Supports auto-negotiation: No
>         Advertised link modes:  1000baseT/Full
>         Advertised pause frame use: No
>         Advertised auto-negotiation: No
>         Speed: 1000Mb/s
>         Duplex: Full
>         Port: MII
>         PHYAD: 0
>         Transceiver: external
>         Auto-negotiation: on
>         Current message level: 0x0000003f (63)
>                                drv probe link timer ifdown ifup
>         Link detected: yes
>
>> and
>> # ethtool -d ethX | grep 500
>>
> root@Bluse-home:~# ethtool -d eth0 | grep 500
> 0x0500:         00 00 00 3f 00 00 72 05 40 60 50 60 00 a1 f0 37
>
>
>> Is there any other indication before this Oops? Like a tx timeout WARN=
?
>>
>
> Nothing there about any timeout.
>

Please try the following patch:
http://patchwork.ozlabs.org/patch/283235/

It should help with your issue.

claudiu
