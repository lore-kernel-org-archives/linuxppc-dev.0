Return-Path: <jjboor@aimsys.nl>
Received: from smtp08.wanadoo.nl (smtp08.wanadoo.nl [194.134.35.149])
	by ozlabs.org (Postfix) with ESMTP id C54BE67AC7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Apr 2005 17:31:36 +1000 (EST)
In-Reply-To: <4254D1D1.8090000@dgt.com.pl>
References: <4253CB3B.7040009@dgt.com.pl>
	<977733d4c9325dbf4052cea66b10824c@aimsys.nl>
	<4254D1D1.8090000@dgt.com.pl>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b401be5cfa8b051577b461a9ece7950d@aimsys.nl>
From: Jaap-Jan Boor <jjboor@aimsys.nl>
Date: Thu, 7 Apr 2005 09:31:36 +0200
To: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: USB on 8250 PCI
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

What kernel version do you use?
In a 2.4 series kernel, you might check m8260_pcibios_fixup()
and probably set dev->irq ?

I don't know yet if this is the same in 2.6. I recently saw a lot of 
pci setup related changes in this mailing list.

Jaap-Jan

On 7-apr-05, at 8:23, Wojciech Kromer wrote:

> i still can't figure out is it a hardware or configuration problem,
> i can see all registers, drivers seems to work,
> it can detect device insert
> but there is no data transmision
>
> there are also no interrupts,
> i'm not sure what to write in interrupt_line in PCI config space
>
> any hints?
>
> =============================================================
> here is my dmesg part:
>
> ehci_hcd 00:1e.2: PCI device 1033:00e0
> ehci_hcd 00:1e.2: irq -20, pci mem c924b000
> usb.c: new USB bus registered, assigned bus number 1
> ehci_hcd 00:1e.2: ehci_start hcs_params 0x2385 dbg=0 cc=2 pcc=3 !ppc 
> ports=5
> ehci_hcd 00:1e.2: ehci_start portroute 1 0 1 0 0
> ehci_hcd 00:1e.2: ehci_start hcc_params e806 thresh 0 uframes 
> 256/512/1024 park
> ehci_hcd 00:1e.2: capability 0001 at e8
> ehci_hcd 00:1e.2: reset command 080b02 park=3 ithresh=8 period=1024 
> Reset HALT
> PCI: 00:1e.2 PCI cache line size set incorrectly (0 bytes) by BIOS/FW, 
> correcting to 32
> ehci_hcd 00:1e.2: init command 010b09 park=3 ithresh=1 period=256 RUN
> ehci_hcd 00:1e.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Dec-29/2.4
> hcd.c: 00:1e.2 root hub device address 1
> usb.c: kmalloc IF c727f340, numif 1
> usb.c: new device strings: Mfr=3, Product=2, SerialNumber=1
> usb.c: USB device number 1 default language ID 0x0
> Manufacturer: Linux 2.4.19-dgt ehci_hcd
> Product: PCI device 1033:00e0
> SerialNumber: 00:1e.2
> hub.c: USB hub found
> hub.c: 5 ports detected
> hub.c: standalone hub
> hub.c: ganged power switching
> hub.c: individual port over-current protection
> hub.c: Single TT
> hub.c: TT requires at most 8 FS bit times
> hub.c: Port indicators are not supported
> hub.c: power on to power good time: 0ms
> hub.c: hub controller current requirement: 0mA
> hub.c: port removable status: RRRRR
> hub.c: local power source is good
> hub.c: no over-current condition exists
> hub.c: enabling power on all ports
> usb.c: hub driver claimed interface c727f340
> ehci_hcd 00:1e.2: GetStatus port 1 status 001803 POWER sig=j  CSC 
> CONNECT
> hub.c: port 1, portstatus 501, change 1, 480 Mb/s
> hub.c: port 1 connection change
> hub.c: port 1, portstatus 501, change 1, 480 Mb/s
> hub.c: port 1, portstatus 501, change 0, 480 Mb/s
> hub.c: port 1, portstatus 501, change 0, 480 Mb/s
> hub.c: port 1, portstatus 501, change 0, 480 Mb/s
> hub.c: port 1, portstatus 501, change 0, 480 Mb/s
> hub.c: port 1, portstatus 511, change 0, 480 Mb/s
> hub.c: port 1 of hub 1 not reset yet, waiting 10ms
> hub.c: port 1, portstatus 511, change 0, 480 Mb/s
> hub.c: port 1 of hub 1 not reset yet, waiting 10ms
> ehci_hcd 00:1e.2: port 1 full speed --> companion
> ehci_hcd 00:1e.2: GetStatus port 1 status 003801 POWER OWNER sig=j  
> CONNECT
> hub.c: port 1, portstatus 0, change 10, 12 Mb/s
> ehci_hcd 00:1e.2: free_config  devnum 0
> hub.c: port 2, portstatus 100, change 0, 12 Mb/s
> hub.c: port 3, portstatus 100, change 0, 12 Mb/s
> hub.c: port 4, portstatus 100, change 0, 12 Mb/s
> hub.c: port 5, portstatus 100, change 0, 12 Mb/s
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
