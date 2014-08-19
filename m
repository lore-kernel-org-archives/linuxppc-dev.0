Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (dns-bn1lp0143.outbound.protection.outlook.com [207.46.163.143])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AEDC71A03EF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 09:46:43 +1000 (EST)
Message-ID: <1408491984.4058.48.camel@snotra.buserror.net>
Subject: Re: PCIe driver not working properly after upgrading to linux 3.8.13
From: Scott Wood <scottwood@freescale.com>
To: Gokul C G <gokul.g@kalkitech.in>
Date: Tue, 19 Aug 2014 18:46:24 -0500
In-Reply-To: <53F3629A.6060208@kalkitech.in>
References: <53F3629A.6060208@kalkitech.in>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: meta-freescale@yoctoproject.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, djiang@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-08-19 at 20:13 +0530, Gokul C G wrote:
> HI,
> 
>  
> 
> I am facing problem with PCIE driver in new Linux kernel compiled for
> powerpc architecture (Big endian) ,freescales P2040 processor.I was
> using old kernel Linux version 3.0.48 previously and now updated to
> Linux version 3.8.13-rt9.After updating to the new kernel, 

3.8.13-rt9 is also an old kernel. :-)

It is also presumably a Freescale SDK kernel (not even the most recent
one), so it would be best to stick with community.freescale.com (you
didn't follow up to my response there) or, in the case of problems with
third party code you've added on to the SDK kernel, the support channels
of whoever provided you with the software.

> PCIe device drivers not working properly and i am getting some error
> messages in the boot-up .My intention is to use   EXAR PCIe Multiport
> serial driver and add 8 serial ports in addition to 4 built in serial
> ports provided by P2040 processor. The PCIe driver form EXAR is
> compiled and  loaded as kernel module . The same was working with
> linux kernel 3.0.48 and following prints observed while loading kernel
> module.
> 
> 
> linux 3.0.48 ,working insmod log
> 
> 
> ========================
>  
> 
> 
> 
> Exar PCIe (XR17V35x) serial driver Revision: 1.2

I don't see this driver in the kernel tree.  We can't help you with code
we can't see.  Are you sure that the driver is expected to work with
3.8?  Have you tried debugging it and/or contacting Exar for support
with their driver?


> PCI: Probing PCI hardware
> 
> fsl-pci ffe201000.pcie: PCI host bridge to bus 0000:00
> 
> pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
> 
> pci_bus 0000:00: root bus resource [mem 0xc20000000-0xc3fffffff] (bus
> address [0xe0000000-0xffffffff])
> 
> pci_bus 0000:00: root bus resource [bus 00-ff]
> 
> PCIE error(s) detected
> 
> PCIE ERR_DR register: 0x80020000
> 
> PCIE ERR_CAP_STAT register: 0x80000001
> 
> PCIE ERR_CAP_R0 register: 0x00000800
> 
> pci 0000:00:00.0: PCI bridge to [bus 01-ff]
> 
> PCIE ERR_CAP_R1 register: 0x00000000
> 
> PCIE ERR_CAP_R2 register: 0x00000000
> 
> PCIE ERR_CAP_R3 register: 0x00000000
> 
> PCI: Cannot allocate resource region 0 of device 0000:00:00.0, will
> remap
> 
> pci 0000:00:00.0: BAR 0: can't assign mem (size 0x1000000)
> 
> pci 0000:00:00.0: BAR 9: can't assign mem pref (size 0x200000)
> 
> pci 0000:00:00.0: PCI bridge to [bus 01]
> 
> pci 0000:00:00.0:   bridge window [io  0x0000-0xffff]
> 
> pci 0000:00:00.0:   bridge window [mem 0xc20000000-0xc3fffffff]
> 
>  
> 
I get very similar errors on Freescale's SDK 1.5 kernel (based on
v3.8.13-rt9), and it doesn't stop a PCIe network card from working.  So
I wouldn't focus too much on these errors.

-Scott
