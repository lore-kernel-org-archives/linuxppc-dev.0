Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe004.messaging.microsoft.com [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7255110089C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2012 10:37:22 +1000 (EST)
Message-ID: <4FCFF7B4.7070608@freescale.com>
Date: Wed, 6 Jun 2012 19:37:08 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] PPC: PCI: Fix pcibios_io_space_offset() so it works for
 32-bit ptr/64-bit rsrcs
References: <4DC27253-67FC-4A55-8C78-7782D9D0CF53@servergy.com>
 <4FCFC870.40004@freescale.com> <1339021310.7150.181.camel@pasglop>
In-Reply-To: <1339021310.7150.181.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, Ben Collins <ben.c@servergy.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/06/2012 05:21 PM, Benjamin Herrenschmidt wrote:
> Now that means that we can end up with funky arithmetic in a couple of
> cases:
> 
>  - If the bus address of the IO space is larger than the virtual address
> returned by ioremap (it's a bit silly to use large IO addresses but it's
> technically possible, normally IO windows start at 0 bus-side though).
> In fact I wouldn't be surprised if we have various other bugs if IO
> windows don't start at 0 (you may want to double check your dts setup
> here).

The dts does show the I/O beginning at bus address zero:

                 ranges = <0x2000000 0x0 0xc0000000 0xc0000000 0x0
0x20000000
                           0x1000000 0x0 0x0 0xe1000000 0x0 0x10000>;

>  - If the ioremap'ed address of the IO space of another domain is lower
> than the ioremap'ed address of the first domain, in which case the
> calculation:
> 
> 	host->io_base_virt - _IO_BASE
> 
> results in a negative offset.

There should have been only one PCI domain in the QEMU case.

-Scott
