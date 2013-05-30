Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C10952C0099
 for <linuxppc-dev@ozlabs.org>; Thu, 30 May 2013 20:42:03 +1000 (EST)
Message-ID: <51A72D04.2090203@windriver.com>
Date: Thu, 30 May 2013 18:42:12 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: wolfking <wolfking2000@msn.com>
Subject: Re: can't access PCIe card under sbc8548
References: <1369885321567-71775.post@n7.nabble.com>
 <51A6EA1D.7080100@windriver.com> <1369899157331-71783.post@n7.nabble.com>
In-Reply-To: <1369899157331-71783.post@n7.nabble.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/30/2013 03:32 PM, wolfking wrote:
> (continued)
>    I traced the 8139too.c when it uses pci_iomap, the pci_iomap called the
> ioport_map. The difference between 8139 and my PCIe card lies in the
> "port" value :
> void __iomem *ioport_map(unsigned long port, unsigned int len)
> {
> 	return (void __iomem *) (port + _IO_BASE);

_IO_BASE is equal to isa_io_base. So if this is not zero, I think there's a isa 
bridge in your platform. So you can access these I/O ports based on that isa 
bridge/bus with ioreadx/iowritex.

> }
>    in 8139too.c, the "port" value is 0x1000; for my PCIe card, the "port"
> value
> is 0xfefff000. And the value is got from pci_resource_start. So you see, the

But this means the port is as memory-mapped so ioremap() should be workable in 
this case. Then out_bex/in_bex should be fine.

Tiejun
