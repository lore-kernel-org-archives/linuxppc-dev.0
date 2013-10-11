Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 91F102C0330
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Oct 2013 04:36:06 +1100 (EST)
Message-ID: <1381512940.7979.497.camel@snotra.buserror.net>
Subject: Re: Elbc device driver
From: Scott Wood <scottwood@freescale.com>
To: Mercier Ivan <ivan.mercier@gmail.com>
Date: Fri, 11 Oct 2013 12:35:40 -0500
In-Reply-To: <CAMc2ieqO5eKiXdGh0qraJy3FKPMbzkpTGgWrSwwGHh7sn2iCFw@mail.gmail.com>
References: <CAMc2ieqYDBE8HYzmEvfKxw8o7AdYVGN_ew6tvsn_TsRcpEgL8g@mail.gmail.com>
 <1381271655.7979.290.camel@snotra.buserror.net>
 <CAMc2ieqXg1C6twTaqL9irJoLceSw-fFyTseifW5dmCmnXHWLCw@mail.gmail.com>
 <1381418079.7979.396.camel@snotra.buserror.net>
 <CAMc2ieqO5eKiXdGh0qraJy3FKPMbzkpTGgWrSwwGHh7sn2iCFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-10-11 at 17:03 +0200, Mercier Ivan wrote:
> Hi,
> this should be correct (I'm using chip select 3 for this device)
>         lbc: localbus@ffe124000 {
>                 reg = <0xf 0xfe124000 0 0x1000>;
>                 ranges = <3 0 0xf 0xe0000000 0x08000000>;
> 
>                 a3p400{
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>                         compatible = "my_a3p_driver";
>                         reg = <0x0 0x0 0x800000>;
>                 };
>         };

Compatible describes the device, not the driver.  It takes the format
"vendor,device".  The node name, OTOH, is normally a generic description
of the device's functionality ("flash", "ethernet", "board-control",
etc).

You don't need #address-cells/#size-cells on the a3p400 node unless it
has child nodes with reg or ranges.

-Scott
