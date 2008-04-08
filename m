Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id C75F5DDEED
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 22:39:13 +1000 (EST)
Message-ID: <47FB6747.2050301@ru.mvista.com>
Date: Tue, 08 Apr 2008 16:38:31 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] ide: make ide_pci_check_iomem() actually work
References: <200804072027.17520.sshtylyov@ru.mvista.com>
	<200804072246.40223.bzolnier@gmail.com>
	<47FB5ADF.20608@ru.mvista.com>
In-Reply-To: <47FB5ADF.20608@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, I just wrote:

>>> This function didn't actually check if a given BAR is in I/O space 
>>> because of
>>> using the bogus PCI_BASE_ADDRESS_IO_MASK (which equals ~3) to test 
>>> the resource
>>> flags instead of IORESOURCE_IO -- fix this, make ide_hwif_configure() 
>>> check the
>>> results failing if necessary, and move the printk() call to the 
>>> failure path.

>> This change is OK in itself but I worry that ide_pci_check_iomem() may 
>> now
>> return "false" errors (bogus PCI_BASE_ADDRESS_IO_MASK check resulted 
>> in MEM
>> resources always surviving ide_pci_check_iomem() calls before the fix) 
>> for
>> some host drivers (siimage, scc_pata...) resulting in failed 
>> initialization.

>    The SiI chips do have normal I/O resources at BAR0..BAR3. As for 
> scc_pata, the control should not even get there because BAR0..BAR3 are 
> *not* IDE command/control block bases on this chip (BAR0/1 are 
> control/DMA bases if you look into setup_mmio_scc()) but they are 
> treated as such by the code immediately following ide_pci_check_iomem() 
> calls in ide_hwif_configure(), i.e. we might have an error here. The 
> same can be said about the PowerMAC driver which has all its MMIO 
> registers at BAR0.

>> How's about removing this dead/broken function instead for now?

>    If we indeed have a MMIO problem here, it's not in this function but 
> in its callers.

     Looks like we actually have this problem with scc_pata -- it calls 
ide_setup_pci_device() which should lead to calling ide_hwif_configure(). But 
this is broken since this call chain expects a normal PCI IDE controller with 
BAR0..BAR3 either non-existant or being primary/secondary port bases in I/O space.

>> Thanks,
>> Bart

>>> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

WBR, Sergei
