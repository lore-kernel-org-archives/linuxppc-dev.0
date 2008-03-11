Return-Path: <coreppcdevel@gmail.com>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.181])
	by ozlabs.org (Postfix) with ESMTP id 86D9EDE02B
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 23:54:32 +1100 (EST)
Received: by el-out-1112.google.com with SMTP id v27so1393283ele.16
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Mar 2008 05:54:31 -0700 (PDT)
Message-ID: <543e3890803110554g94d7514sc8aee2031918a705@mail.gmail.com>
Date: Tue, 11 Mar 2008 18:24:30 +0530
From: "Suresh Chandra Mannava" <coreppcdevel@gmail.com>
To: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: Interrupt routing ARCH=ppc
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1364_32625601.1205240070807"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_1364_32625601.1205240070807
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,

I am working on porting Linux 2.6.16.60 on PowerPC based board with Tsi109
system controller.
Our platform support is defined in arch/ppc
Here is our hardware interrupt routing
Tsi109 PCI BUS
    (BUS 0)
        |
        |
       V
     VME controller (BUS 0 IDSEL 16) IRQ 36
      PMC Slot        (BUS 0 IDSEL 17) IRQ 37
     PCI-PCI Bridge (BUS 0 IDSEL 18) No IRQ required
                |
     (BUS 1)|
                 |------->    PMC Slot (BUS 1 IDSEL 19) IRQ 38
                              USB Contr(BUS 1 IDSEL 20) IRQ 39

I faced a problem at map_irq. Due to pci_swizzle, PCI probe is always
returning p2p bridge IDSEL for all device on BUS 1.
In our case, we routed independent interrupt lines for the devices on BUS 1.

I made a quick workaround by assigning IRQ's based on dev->devfn.

Is there any standard way of assigning independent interrupts for the
devices connected below P2P bridge?

I am facing problem with on-board USB controller. Even though
/proc/interrupts shows correct assignment. USB is always returning the
following message

usb 2-1: new low speed USB device using ohci_hcd and address 2
ohci_hcd 0000:01:04.0: Unlink after no-IRQ?  Controller is probably using
the wrong IRQ

If the interrupts are not assigned properly, how the above message pop-up
soon after inserting USB device?

Here is the proc entry
# cat /proc/interrupts
           CPU0
 12:        105  tsi108_pic Level     serial
 38:       4270  tsi108_PCI_int Level     eth0
 39:          1  tsi108_PCI_int Level     ehci_hcd:usb1, ohci_hcd:usb2,
ohci_hcd :usb3

Whereas USB PMC on BUS 0 works fine.

I request you to provide some pointers on the same.

Thanks a lot,
Suresh

------=_Part_1364_32625601.1205240070807
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi All,<br><br>I am working on porting Linux <a href="http://2.6.16.60">2.6.16.60</a> on PowerPC based board with Tsi109 system controller. <br>Our platform support is defined in arch/ppc<br>Here is our hardware interrupt routing<br>
Tsi109 PCI BUS <br>&nbsp;&nbsp;&nbsp; (BUS 0)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; V<br>&nbsp;&nbsp;&nbsp;&nbsp; VME controller (BUS 0 IDSEL 16) IRQ 36 <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; PMC Slot&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (BUS 0 IDSEL 17) IRQ 37<br>&nbsp;&nbsp;&nbsp;&nbsp; PCI-PCI Bridge (BUS 0 IDSEL 18) No IRQ required<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |<br>&nbsp;&nbsp;&nbsp;&nbsp; (BUS 1)|<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp; |-------&gt;&nbsp;&nbsp;&nbsp; PMC Slot (BUS 1 IDSEL 19) IRQ 38<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; USB Contr(BUS 1 IDSEL 20) IRQ 39 <br><br>I faced a problem at map_irq. Due to pci_swizzle, PCI probe is always returning p2p bridge IDSEL for all device on BUS 1.<br>
In our case, we routed independent interrupt lines for the devices on BUS 1.<br><br>I made a quick workaround by assigning IRQ&#39;s based on dev-&gt;devfn. <br><br>Is there any standard way of assigning independent interrupts for the devices connected below P2P bridge?<br>
<br>I am facing problem with on-board USB controller. Even though /proc/interrupts shows correct assignment. USB is always returning the following message<br><br>usb 2-1: new low speed USB device using ohci_hcd and address 2<br>
ohci_hcd 0000:01:04.0: Unlink after no-IRQ?&nbsp; Controller is probably using the wrong IRQ<br><br>If the interrupts are not assigned properly, how the above message pop-up soon after inserting USB device?<br><br>Here is the proc entry<br>
# cat /proc/interrupts<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; CPU0<br>&nbsp;12:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 105&nbsp; tsi108_pic Level&nbsp;&nbsp;&nbsp;&nbsp; serial<br>&nbsp;38:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4270&nbsp; tsi108_PCI_int Level&nbsp;&nbsp;&nbsp;&nbsp; eth0<br>&nbsp;39:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp; tsi108_PCI_int Level&nbsp;&nbsp;&nbsp;&nbsp; ehci_hcd:usb1, ohci_hcd:usb2, ohci_hcd :usb3<br>
<br>Whereas USB PMC on BUS 0 works fine.<br><br>I request you to provide some pointers on the same.<br><br>Thanks a lot,<br>Suresh<br><br><br>

------=_Part_1364_32625601.1205240070807--
