Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id AABFFB7C18
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 07:03:55 +1100 (EST)
Message-ID: <4B1819AB.1030002@ovro.caltech.edu>
Date: Thu, 03 Dec 2009 12:03:55 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: PCI interrupt question
References: <1259821316.12651.26.camel@qu102.quarc.com>	<4B17F14A.1060001@ovro.caltech.edu>	<1259869140.18190.52.camel@qu102.quarc.com>	<4B1816F9.1020601@ovro.caltech.edu>
	<20091203195908.GA17100@ovro.caltech.edu>
In-Reply-To: <20091203195908.GA17100@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Jeff Hane <jeff.hane@maxim-ic.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ira,

> When Linux is assigning BARs and IRQs, it writes the BAR addresses to
> the PCI cards, but does not write the IRQ. This was my experience with
> PCI hotplug.

Ooh, subtle.

>> Bottom line is; if the IRQ field of lspci is 0, then you
>> need to figure out that problem first :)
>>
> 
> In the PCI hotplug case mentioned above, lspci would show the IRQ as 0
> until I called request_irq() in the kernel. Afterwards, the correct IRQ
> showed up in the lspci output.
> 
> Try request_irq(pdev->irq, ....) and see if it works.

You can also try lscpi -xxx, and setpci for writing the
registers. So try cheating and writing to the IRQ register
in the PCI interface.

Another possible problem, you may have your FPGA PCI core
configured in host mode (which can still be a master or target),
and then the IRQ register can not be written.

Cheers,
Dave
