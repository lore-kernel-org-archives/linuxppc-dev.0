Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id B16BC67A2E
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Dec 2006 23:48:27 +1100 (EST)
Message-ID: <4574197A.2020204@ru.mvista.com>
Date: Mon, 04 Dec 2006 15:50:02 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] mark PCI resource with start 0 as unassigned
References: <20061130165202.GA23205@aepfle.de>	<20061204123854.GA28159@aepfle.de>
	<FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>
In-Reply-To: <FF278F8E-1F65-488D-8821-86A1D9F3B5DA@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-ide@vger.kernel.org, Olaf Hering <olaf@aepfle.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Segher Boessenkool wrote:
>>--- a/arch/powerpc/kernel/pci_64.c
>>+++ b/arch/powerpc/kernel/pci_64.c
>>@@ -1234,6 +1234,14 @@ static void __devinit fixup_resource(str
>> 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
>> 	unsigned long start, end, mask, offset;
>>
>>+	/*
>>+	 * tell the core code that this ressource is unassigned
>>+	 * fixes p630 winbond IDE with libata
>>+	 */
>>+	if (res->start == 0) {
>>+		res->flags = 0;
>>+		return;
>>+	}
>> 	if (res->flags & IORESOURCE_IO) {
>> 		offset = (unsigned long)hose->io_base_virt - pci_io_base;
> 
> 
> Please make this run on pSeries only; on a PowerMac for
> example, it's totally normal that the first PCI legacy I/O
> BAR in the system gets assigned 0.

    What do you mean by legacy I/O BAR? If you mean IDE controller, that would 
drive IDE core mad like this:

W82C105_IDE: inconsistent baseregs (BIOS) for port 0, skipping

> Segher

WBR, Sergei
