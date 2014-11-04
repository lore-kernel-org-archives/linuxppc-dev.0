Return-Path: <bigeasy@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 007881A04B5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Nov 2014 19:35:42 +1100 (AEDT)
Message-ID: <54588FD7.5030009@linutronix.de>
Date: Tue, 04 Nov 2014 09:35:35 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>,
 Johannes Thumshirn <johannes.thumshirn@men.de>
Subject: Re: [PATCH 1/2] irqdomain: add support for creating a continous
 mapping
References: <1415031514-27284-1-git-send-email-johannes.thumshirn@men.de>	
 <1415031514-27284-2-git-send-email-johannes.thumshirn@men.de>
 <1415053131.23458.287.camel@snotra.buserror.net>
In-Reply-To: <1415053131.23458.287.camel@snotra.buserror.net>
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/03/2014 11:18 PM, Scott Wood wrote:
> Is it really necessary for the virqs to be contiguous?  How is the
> availability of multiple MSIs communicated to the driver?  Is there an
> example of a driver that currently uses multiple MSIs?

I used this in PCI and after enabling 2^x, I allocated an continuous
block starting at virq. There is no way of communicating this in any
other way. The first irq number is saved in pci_dev->irq and the
remaining have to follow.

Take a look at  drivers/ata/ahci.c and you will see:
- pci_msi_vec_count() for number of irqs
- pci_enable_msi_block() to allocate the number of irqs
- pci_enable_msi() (no X)
- ahci_host_activate() does request_threaded_irq() for pdev->irq and
  loops "number of ports" times which matches number of number of irqs
  (or is less then).

Sebastian
