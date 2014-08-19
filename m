Return-Path: <gokul.g@kalkitech.in>
Received: from blroutbound19.logix.in (blroutbound19.logix.in
 [221.134.197.215])
 by lists.ozlabs.org (Postfix) with ESMTP id 52BEF1A003C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 00:55:32 +1000 (EST)
Received: from vdvmphy31-out.logix.local (127.0.0.1) by blroutbound19.logix.in
 (PowerMTA(TM) v3.5r11) id hudils1oo38j for <linuxppc-dev@lists.ozlabs.org>;
 Tue, 19 Aug 2014 20:14:53 +0530 (envelope-from <gokul.g@kalkitech.in>)
Received: from unknown (HELO delta.logix.in) ([192.168.10.23])
 (envelope-sender <gokul.g@kalkitech.in>)
 by 192.168.10.57 (qmail-ldap-1.03) with SMTP
 for <linuxppc-dev@lists.ozlabs.org>; 19 Aug 2014 14:44:53 -0000
Message-ID: <53F3629A.6060208@kalkitech.in>
Date: Tue, 19 Aug 2014 20:13:38 +0530
From: Gokul C G <gokul.g@kalkitech.in>
MIME-Version: 1.0
To: linux-pci@vger.kernel.org
Subject: PCIe driver not working properly after upgrading to linux 3.8.13
Content-Type: multipart/alternative;
 boundary="------------070907060208000906060904"
Cc: meta-freescale@yoctoproject.org, linuxppc-dev@lists.ozlabs.org,
 djiang@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070907060208000906060904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

HI,

I am facing problem with PCIE driver in new Linux kernel compiled for 
powerpc architecture (Big endian) ,freescales P2040 processor.I was 
using old kernel Linux version 3.0.48 previously and now updated to 
Linux version 3.8.13-rt9.After updating to the new kernel, PCIe device 
drivers not working properly and i am getting some error messages in the 
boot-up .My intention is to use   EXAR PCIe Multiport serial driver and 
add 8 serial ports in addition to 4 built in serial ports provided by 
P2040 processor. The PCIe driver form EXAR is compiled and  loaded as 
kernel module . The same was working with linux kernel 3.0.48 and 
following prints observed while loading kernel module.


linux 3.0.48 ,working insmod log

========================


Exar PCIe (XR17V35x) serial driver Revision: 1.2

0000:01:00.0: ttyXR0 at MMIO 0xc20000000 (irq = 41) is a XR17v35x

0000:01:00.0: ttyXR1 at MMIO 0xc20000400 (irq = 41) is a XR17v35x

0000:01:00.0: ttyXR2 at MMIO 0xc20000800 (irq = 41) is a XR17v35x

0000:01:00.0: ttyXR3 at MMIO 0xc20000c00 (irq = 41) is a XR17v35x

0000:01:00.0: ttyXR4 at MMIO 0xc20001000 (irq = 41) is a XR17v35x

0000:01:00.0: ttyXR5 at MMIO 0xc20001400 (irq = 41) is a XR17v35x

0000:01:00.0: ttyXR6 at MMIO 0xc20001800 (irq = 41) is a XR17v35x

0000:01:00.0: ttyXR7 at MMIO 0xc20001c00 (irq = 41) is a XR17v35x

After that  ttyXR0 to ttyXR7 (7 serial devices) will be displayed 
under*/dev*directory .

And following PCIe driver messages in*dmesg*(linux 3.0.48 ,working )

----------------------------------------------------------------------

EDAC PCI0: Giving out device to module 'MPC85xx_edac' controller 
'mpc85xx_pci_err': DEV 'ffe201000.pcie' (INTERRUPT)

MPC85xx_edac acquired irq 493 for PCI Err

MPC85xx_edac PCI err registered

PCI: Probing PCI hardware

pci 0000:00:00.0: ignoring class b20 (doesn't match header type 01)

PCIE error(s) detected

pci 0000:00:00.0: PCI bridge to [bus 01-ff]

PCIE ERR_DR register: 0x80020000

PCIE ERR_CAP_STAT register: 0x80000001

PCIE ERR_CAP_R0 register: 0x00000800

PCIE ERR_CAP_R1 register: 0x00000000

PCIE ERR_CAP_R2 register: 0x00000000

PCIE ERR_CAP_R3 register: 0x00000000

pci 0000:00:00.0: PCI bridge to [bus 01-01]

pci 0000:00:00.0:   bridge window [io 0xfdfea000-0xfdff9fff]

pci 0000:00:00.0:   bridge window [mem 0xc20000000-0xc3fffffff]

pci 0000:00:00.0:   bridge window [mem pref disabled]

bio: create slab <bio-0> at 0

But after upgrading kernel to 3.8.13 while inserting kernel module only 
following messages displayed and no ttyXR devices displayed under /dev 
directory .

Exar PCIe (XR17V35x) serial driver Revision: 1.2

no other messages

And following PCIe driver messages in*dmesg*(linux 3.8.13 ,not working )

----------------------------------------------------------------------

EDAC PCI0: Giving out device to module 'MPC85xx_edac' controller 
'mpc85xx_pci_err': DEV 'ffe201000.pcie' (INTERRUPT)

MPC85xx_edac acquired irq 481 for PCI Err

MPC85xx_edac PCI err registered

PCI: Probing PCI hardware

fsl-pci ffe201000.pcie: PCI host bridge to bus 0000:00

pci_bus 0000:00: root bus resource [io  0x0000-0xffff]

pci_bus 0000:00: root bus resource [mem 0xc20000000-0xc3fffffff] (bus 
address [0xe0000000-0xffffffff])

pci_bus 0000:00: root bus resource [bus 00-ff]

PCIE error(s) detected

PCIE ERR_DR register: 0x80020000

PCIE ERR_CAP_STAT register: 0x80000001

PCIE ERR_CAP_R0 register: 0x00000800

pci 0000:00:00.0: PCI bridge to [bus 01-ff]

PCIE ERR_CAP_R1 register: 0x00000000

PCIE ERR_CAP_R2 register: 0x00000000

PCIE ERR_CAP_R3 register: 0x00000000

PCI: Cannot allocate resource region 0 of device 0000:00:00.0, will remap

pci 0000:00:00.0: BAR 0: can't assign mem (size 0x1000000)

pci 0000:00:00.0: BAR 9: can't assign mem pref (size 0x200000)

pci 0000:00:00.0: PCI bridge to [bus 01]

pci 0000:00:00.0:   bridge window [io  0x0000-0xffff]

pci 0000:00:00.0:   bridge window [mem 0xc20000000-0xc3fffffff]



=========================



-----------

following lines are there in dts related to pci

   pcie@ffe200000 {

   reg = <0xf 0xfe200000 0x0 0x1000>;

   ranges = <0x2000000 0x0 0xe0000000 0xc 0x0 0x0 0x20000000 0x1000000 
0x0 0x0 0xf 0xf8000000 0x0 0x10000>;

   compatible = "fsl,p2041-pcie", "fsl,qoriq-pcie-v2.2";

   device_type = "pci";

   #size-cells = <0x2>;

   #address-cells = <0x3>;

   bus-range = <0x0 0xff>;

   clock-frequency = <0x1fca055>;

   interrupts = <0x10 0x2 0x1 0xf>;

          pcie@0 {

          ranges = <0x2000000 0x0 0xe0000000 0x2000000 0x0 0xe0000000 
0x0 0x20000000 0x1000000 0x0 0x0 0x1000000 0x0 0x0 0x0 0x10000>;

          reg = <0x0 0x0 0x0 0x0 0x0>;

          #interrupt-cells = <0x1>;

          #size-cells = <0x2>;

          #address-cells = <0x3>;

          device_type = "pci";

          interrupts = <0x10 0x2 0x1 0xf>;

          interrupt-map-mask = <0xf800 0x0 0x0 0x7>;

          interrupt-map = <0x0 0x0 0x0 0x1 0x1 0x28 0x1 0x0 0x0 0x0 0x0 
0x0 0x2 0x1 0x1 0x1 0x0 0x0 0x0 0x0 0x0 0x3 0x1 0x2 0x1 0x0 0x0 0x0 0x0 
0x0 0x4 0x1 0x3 0x1 0x0 0x0>;

          };

   };

   pcie@ffe201000 {

   reg = <0xf 0xfe201000 0x0 0x1000>;

   ranges = <0x2000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000 
0x1000000 0x0 0x0 0xf 0xf8010000 0x0 0x10000>;

   compatible = "fsl,p2041-pcie", "fsl,qoriq-pcie-v2.2";

   device_type = "pci";

   #size-cells = <0x2>;

   #address-cells = <0x3>;

   bus-range = <0x0 0xff>;

   clock-frequency = <0x1fca055>;

   interrupts = <0x10 0x2 0x1 0xe>;

       pcie@0 {

       ranges = <0x2000000 0x0 0xe0000000 0x2000000 0x0 0xe0000000 0x0 
0x20000000 0x1000000 0x0 0x0 0x1000000 0x0 0x0 0x0 0x10000>;

       reg = <0x0 0x0 0x0 0x0 0x0>;

       #interrupt-cells = <0x1>;

       #size-cells = <0x2>;

      #address-cells = <0x3>;

      device_type = "pci";

      interrupts = <0x10 0x2 0x1 0xe>;

      interrupt-map-mask = <0xf800 0x0 0x0 0x7>;

      interrupt-map = <0x0 0x0 0x0 0x1 0x1 0x29 0x1 0x0 0x0 0x0 0x0 0x0 
0x2 0x1 0x5 0x1 0x0 0x0 0x0 0x0 0x0 0x3 0x1 0x6 0x1 0x0 0x0 0x0 0x0 0x0 
0x4 0x1 0x7 0x1 0x0 0x0>;

      };

   };

   pcie@ffe202000 {

   reg = <0xf 0xfe202000 0x0 0x1000>;

   ranges = <0x2000000 0x0 0xe0000000 0xc 0x40000000 0x0 0x20000000 
0x1000000 0x0 0x0 0xf 0xf8020000 0x0 0x10000>;

   compatible = "fsl,p2041-pcie", "fsl,qoriq-pcie-v2.2";

   device_type = "pci";

   #size-cells = <0x2>;

   #address-cells = <0x3>;

   bus-range = <0x0 0xff>;

   clock-frequency = <0x1fca055>;

   interrupts = <0x10 0x2 0x1 0xd>;

      pcie@0 {

      ranges = <0x2000000 0x0 0xe0000000 0x2000000 0x0 0xe0000000 0x0 
0x20000000 0x1000000 0x0 0x0 0x1000000 0x0 0x0 0x0 0x10000>;

      reg = <0x0 0x0 0x0 0x0 0x0>;

      #interrupt-cells = <0x1>;

      #size-cells = <0x2>;

      #address-cells = <0x3>;

      device_type = "pci";

      interrupts = <0x10 0x2 0x1 0xd>;

      interrupt-map-mask = <0xf800 0x0 0x0 0x7>;

      interrupt-map = <0x0 0x0 0x0 0x1 0x1 0x2a 0x1 0x0 0x0 0x0 0x0 0x0 
0x2 0x1 0x9 0x1 0x0 0x0 0x0 0x0 0x0 0x3 0x1 0xa 0x1 0x0 0x0 0x0 0x0 0x0 
0x4 0x1 0xb 0x1 0x0 0x0>;

      };

   };

*
*

only address ffe201000 have PCIe card connected.


====================

here is the lspci output

---------------------------------

root@root:~#  lspci -vvv

00:00.0 Class 0604: 1957:0411

01:00.0 Class 0700: 13a8:0358

root@root:~#

make menuconfig compile time options for linux  :

---------------------------------------------------------------------

-*- Freescale Local Bus support

   ? ?                                           [ ] Enable stashing of 
FMAN write transactions for ethernet ports

   ? ?                                           -*- Datapath 
Acceleration Queue and Buffer management

   ? ?                                           [*] PCI support

   ? ?                                           [*] PCI Express support

   ? ?                                           < > PCI Express Hotplug 
driver

   ? ?                                           [*]   Root Port 
Advanced Error Reporting support

   ? ?                                           [ ]     PCI Express 
ECRC settings control

   ? ?                                           < >     PCIe AER error 
injector support

   ? ?                                           [ ]   PCI Express ASPM 
control

   ? ?                                           [*] Message Signaled 
Interrupts (MSI and MSI-X)

   ? ?                                           [*] PCI Debugging

   ? ?                                           [ ] Enable PCI resource 
re-allocation detection

   ? ?                                           < > PCI Stub driver

   ? ?                                           [ ] PCI IOV support

   ? ?                                           [ ] PCI PRI support

   ? ?                                           [ ] PCI PASID support

   ? ?                                           < > PCCard 
(PCMCIA/CardBus) support --->

   ? ?                                           <*> Support for PCI 
Hotplug --->

   ? ?                                           [ ] RapidIO support





I am using same device tree that i used with linux 3.0.48 .

I doubt there is basic problem with PCie driver provided with linux 3.8.x .

When I searched in this Google, I Could find that some people 
experienced some problem with PCIe driver in linux 3.8 after 
up-gradation of kernel.

Can anyone help me to get out this issue ?

Did any one faced same issue before?

-- 
Thanks & Regards
*Gokul C G *
Engineer Product Development

Phone 	 : +91-484 2861900
Mobile 	 :
Fax 	 : +91-484 2861900
Email 	 : gokul.g@kalkitech.in <mailto:gokul.g@kalkitech.in>
Web 	 : www.kalkitech.com <http://www.kalkitech.com>


<http://www.kalkitech.com>


"Disclaimer: This message is being sent from Kalki Communication Technologies
Pvt Ltd (KALKITECH). and may contain information which is confidential or 

privileged. If you are not the intended recipient, please advise the sender
immediately by reply e-mail and delete this message and any attachments 

without retaining a copy. Any unauthorized use of the content of this message
can expose the responsible party to civil and/or criminal penalties, 

and may constitute a more serious offense. Further the company does not accept
liability for any errors, omissions, viruses or computer problems 

experienced as a result of this transmission. If you have received this
message in error, notice is hereby given that no representation, contract or 

other binding obligation shall be created by this e-mail." 

--------------070907060208000906060904
Content-Type: multipart/related;
 boundary="------------050200020204040802090303"


--------------050200020204040802090303
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">HI,</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);">&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">I am facing problem with PCIE driver in new Linux kernel
      compiled for powerpc architecture (Big endian) ,freescales P2040
      processor.I was using old kernel Linux version 3.0.48 previously
      and now updated to Linux version 3.8.13-rt9.After updating to the
      new kernel, PCIe device drivers not working properly and i am
      getting some error messages in the boot-up .My intention is to
      use&nbsp;&nbsp; EXAR PCIe Multiport serial driver and add 8 serial ports in
      addition to 4 built in serial ports provided by P2040 processor.
      The PCIe driver form EXAR is compiled and&nbsp; loaded as kernel module
      . The same was working with linux kernel 3.0.48 and following
      prints observed while loading kernel module.</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);"><br>
      linux 3.0.48 ,working insmod log<br>
    </p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);">========================<br>
      &nbsp;<br>
      <br>
    </p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">Exar PCIe (XR17V35x) serial driver Revision: 1.2</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">0000:01:00.0: ttyXR0 at MMIO 0xc20000000 (irq = 41) is a
      XR17v35x</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">0000:01:00.0: ttyXR1 at MMIO 0xc20000400 (irq = 41) is a
      XR17v35x</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">0000:01:00.0: ttyXR2 at MMIO 0xc20000800 (irq = 41) is a
      XR17v35x</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">0000:01:00.0: ttyXR3 at MMIO 0xc20000c00 (irq = 41) is a
      XR17v35x</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">0000:01:00.0: ttyXR4 at MMIO 0xc20001000 (irq = 41) is a
      XR17v35x</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">0000:01:00.0: ttyXR5 at MMIO 0xc20001400 (irq = 41) is a
      XR17v35x</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">0000:01:00.0: ttyXR6 at MMIO 0xc20001800 (irq = 41) is a
      XR17v35x</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">0000:01:00.0: ttyXR7 at MMIO 0xc20001c00 (irq = 41) is a
      XR17v35x</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);">&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">After that&nbsp; ttyXR0 to ttyXR7 (7 serial devices) will be
      displayed under<span class="Apple-converted-space">&nbsp;</span><strong
        style="margin: 0px; padding: 0px; border: 0px; font-weight:
        bold; font-style: inherit; font-size: 13px; font-family:
        inherit; vertical-align: baseline;">/dev</strong><span
        class="Apple-converted-space">&nbsp;</span>directory .</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);">&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">And following PCIe driver messages in<span
        class="Apple-converted-space">&nbsp;</span><strong style="margin:
        0px; padding: 0px; border: 0px; font-weight: bold; font-style:
        inherit; font-size: 13px; font-family: inherit; vertical-align:
        baseline;">dmesg</strong><span class="Apple-converted-space">&nbsp;</span>(linux
      3.0.48 ,working )</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">----------------------------------------------------------------------</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">EDAC PCI0: Giving out device to module 'MPC85xx_edac'
      controller 'mpc85xx_pci_err': DEV 'ffe201000.pcie' (INTERRUPT)</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">MPC85xx_edac acquired irq 493 for PCI Err</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">MPC85xx_edac PCI err registered</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">PCI: Probing PCI hardware</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">pci 0000:00:00.0: ignoring class b20 (doesn't match header
      type 01)</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">PCIE error(s) detected</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">pci 0000:00:00.0: PCI bridge to [bus 01-ff]</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">PCIE ERR_DR register: 0x80020000</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">PCIE ERR_CAP_STAT register: 0x80000001</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">PCIE ERR_CAP_R0 register: 0x00000800</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">PCIE ERR_CAP_R1 register: 0x00000000</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">PCIE ERR_CAP_R2 register: 0x00000000</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">PCIE ERR_CAP_R3 register: 0x00000000</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">pci 0000:00:00.0: PCI bridge to [bus 01-01]</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">pci 0000:00:00.0:&nbsp;&nbsp; bridge window [io&nbsp;
      0xfdfea000-0xfdff9fff]</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">pci 0000:00:00.0:&nbsp;&nbsp; bridge window [mem
      0xc20000000-0xc3fffffff]</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">pci 0000:00:00.0:&nbsp;&nbsp; bridge window [mem pref disabled]</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">bio: create slab &lt;bio-0&gt; at 0</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);">&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);">&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">But after upgrading kernel to 3.8.13 while inserting kernel
      module only following messages displayed and no ttyXR devices
      displayed under /dev directory .</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);">&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">Exar PCIe (XR17V35x) serial driver Revision: 1.2</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">no other messages</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);">&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">And following PCIe driver messages in<span
        class="Apple-converted-space">&nbsp;</span><strong style="margin:
        0px; padding: 0px; border: 0px; font-weight: bold; font-style:
        inherit; font-size: 13px; font-family: inherit; vertical-align:
        baseline;">dmesg</strong><span class="Apple-converted-space">&nbsp;</span>(linux
      3.8.13 ,not working )</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">----------------------------------------------------------------------</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">EDAC PCI0: Giving out device to module 'MPC85xx_edac'
      controller 'mpc85xx_pci_err': DEV 'ffe201000.pcie' (INTERRUPT)</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">MPC85xx_edac acquired irq 481 for PCI Err</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">MPC85xx_edac PCI err registered</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">PCI: Probing PCI hardware</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">fsl-pci ffe201000.pcie: PCI host bridge to bus 0000:00</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">pci_bus 0000:00: root bus resource [io&nbsp; 0x0000-0xffff]</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">pci_bus 0000:00: root bus resource [mem
      0xc20000000-0xc3fffffff] (bus address [0xe0000000-0xffffffff])</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">pci_bus 0000:00: root bus resource [bus 00-ff]</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">PCIE error(s) detected</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">PCIE ERR_DR register: 0x80020000</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">PCIE ERR_CAP_STAT register: 0x80000001</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">PCIE ERR_CAP_R0 register: 0x00000800</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">pci 0000:00:00.0: PCI bridge to [bus 01-ff]</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">PCIE ERR_CAP_R1 register: 0x00000000</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">PCIE ERR_CAP_R2 register: 0x00000000</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">PCIE ERR_CAP_R3 register: 0x00000000</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">PCI: Cannot allocate resource region 0 of device
      0000:00:00.0, will remap</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">pci 0000:00:00.0: BAR 0: can't assign mem (size 0x1000000)</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">pci 0000:00:00.0: BAR 9: can't assign mem pref (size
      0x200000)</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">pci 0000:00:00.0: PCI bridge to [bus 01]</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">pci 0000:00:00.0:&nbsp;&nbsp; bridge window [io&nbsp; 0x0000-0xffff]</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">pci 0000:00:00.0:&nbsp;&nbsp; bridge window [mem
      0xc20000000-0xc3fffffff]</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);">&nbsp;<br>
    </p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);"><br>
      =========================<br>
    </p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);"><br>
    </p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);"><br>
    </p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">-----------</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">following lines are there in dts related to pci</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);">&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; pcie@ffe200000 {</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; reg = &lt;0xf 0xfe200000 0x0 0x1000&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; ranges = &lt;0x2000000 0x0 0xe0000000 0xc 0x0 0x0
      0x20000000 0x1000000 0x0 0x0 0xf 0xf8000000 0x0 0x10000&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; compatible = "fsl,p2041-pcie", "fsl,qoriq-pcie-v2.2";</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; device_type = "pci";</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; #size-cells = &lt;0x2&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; #address-cells = &lt;0x3&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; bus-range = &lt;0x0 0xff&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; clock-frequency = &lt;0x1fca055&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; interrupts = &lt;0x10 0x2 0x1 0xf&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcie@0 {</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges = &lt;0x2000000 0x0 0xe0000000 0x2000000
      0x0 0xe0000000 0x0 0x20000000 0x1000000 0x0 0x0 0x1000000 0x0 0x0
      0x0 0x10000&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg = &lt;0x0 0x0 0x0 0x0 0x0&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #interrupt-cells = &lt;0x1&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells = &lt;0x2&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #address-cells = &lt;0x3&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device_type = "pci";</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupts = &lt;0x10 0x2 0x1 0xf&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-map-mask = &lt;0xf800 0x0 0x0 0x7&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; interrupt-map = &lt;0x0 0x0 0x0 0x1 0x1 0x28 0x1
      0x0 0x0 0x0 0x0 0x0 0x2 0x1 0x1 0x1 0x0 0x0 0x0 0x0 0x0 0x3 0x1
      0x2 0x1 0x0 0x0 0x0 0x0 0x0 0x4 0x1 0x3 0x1 0x0 0x0&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; };</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);">&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; pcie@ffe201000 {</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; reg = &lt;0xf 0xfe201000 0x0 0x1000&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; ranges = &lt;0x2000000 0x0 0xe0000000 0xc 0x20000000 0x0
      0x20000000 0x1000000 0x0 0x0 0xf 0xf8010000 0x0 0x10000&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; compatible = "fsl,p2041-pcie", "fsl,qoriq-pcie-v2.2";</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; device_type = "pci";</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; #size-cells = &lt;0x2&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; #address-cells = &lt;0x3&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; bus-range = &lt;0x0 0xff&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; clock-frequency = &lt;0x1fca055&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; interrupts = &lt;0x10 0x2 0x1 0xe&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);">&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pcie@0 {</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ranges = &lt;0x2000000 0x0 0xe0000000 0x2000000 0x0
      0xe0000000 0x0 0x20000000 0x1000000 0x0 0x0 0x1000000 0x0 0x0 0x0
      0x10000&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg = &lt;0x0 0x0 0x0 0x0 0x0&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #interrupt-cells = &lt;0x1&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #size-cells = &lt;0x2&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp; #address-cells = &lt;0x3&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp; device_type = "pci";</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp; interrupts = &lt;0x10 0x2 0x1 0xe&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp; interrupt-map-mask = &lt;0xf800 0x0 0x0 0x7&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp; interrupt-map = &lt;0x0 0x0 0x0 0x1 0x1 0x29 0x1 0x0
      0x0 0x0 0x0 0x0 0x2 0x1 0x5 0x1 0x0 0x0 0x0 0x0 0x0 0x3 0x1 0x6
      0x1 0x0 0x0 0x0 0x0 0x0 0x4 0x1 0x7 0x1 0x0 0x0&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp; };</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; };</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);">&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; pcie@ffe202000 {</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; reg = &lt;0xf 0xfe202000 0x0 0x1000&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; ranges = &lt;0x2000000 0x0 0xe0000000 0xc 0x40000000 0x0
      0x20000000 0x1000000 0x0 0x0 0xf 0xf8020000 0x0 0x10000&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; compatible = "fsl,p2041-pcie", "fsl,qoriq-pcie-v2.2";</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; device_type = "pci";</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; #size-cells = &lt;0x2&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; #address-cells = &lt;0x3&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; bus-range = &lt;0x0 0xff&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; clock-frequency = &lt;0x1fca055&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; interrupts = &lt;0x10 0x2 0x1 0xd&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);">&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp; pcie@0 {</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp; ranges = &lt;0x2000000 0x0 0xe0000000 0x2000000 0x0
      0xe0000000 0x0 0x20000000 0x1000000 0x0 0x0 0x1000000 0x0 0x0 0x0
      0x10000&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp; reg = &lt;0x0 0x0 0x0 0x0 0x0&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp; #interrupt-cells = &lt;0x1&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp; #size-cells = &lt;0x2&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp; #address-cells = &lt;0x3&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp; device_type = "pci";</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp; interrupts = &lt;0x10 0x2 0x1 0xd&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp; interrupt-map-mask = &lt;0xf800 0x0 0x0 0x7&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp; interrupt-map = &lt;0x0 0x0 0x0 0x1 0x1 0x2a 0x1 0x0
      0x0 0x0 0x0 0x0 0x2 0x1 0x9 0x1 0x0 0x0 0x0 0x0 0x0 0x3 0x1 0xa
      0x1 0x0 0x0 0x0 0x0 0x0 0x4 0x1 0xb 0x1 0x0 0x0&gt;;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp;&nbsp;&nbsp;&nbsp; };</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; };</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);"><span style="margin: 0px; padding: 0px; border: 0px;
        font-weight: inherit; font-style: inherit; font-size: 13px;
        font-family: inherit; vertical-align: baseline; color: rgb(24,
        24, 24);"><strong style="margin: 0px; padding: 0px; border: 0px;
          font-weight: bold; font-style: inherit; font-size: 13px;
          font-family: inherit; vertical-align: baseline;"><br>
        </strong></span></p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);">&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">only address ffe201000 have PCIe card connected.</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);"><br>
    </p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);">====================<br>
    </p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">here is the lspci output</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">---------------------------------</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">root@root:~#&nbsp; lspci -vvv</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">00:00.0 Class 0604: 1957:0411</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">01:00.0 Class 0700: 13a8:0358</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">root@root:~#</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);">&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);">&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">make menuconfig compile time options for linux&nbsp; :</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">---------------------------------------------------------------------</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">-*- Freescale Local Bus support&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; &#9474; &#9474;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [ ] Enable
      stashing of FMAN write transactions for ethernet ports&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; &#9474; &#9474;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -*-
      Datapath Acceleration Queue and Buffer management&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; &#9474; &#9474;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [*] PCI
      support&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; &#9474; &#9474;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [*] PCI
      Express support&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; &#9474; &#9474;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &gt;&nbsp;&nbsp;
      PCI Express Hotplug driver&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; &#9474; &#9474;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [*]&nbsp;&nbsp; Root
      Port Advanced Error Reporting support&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; &#9474; &#9474;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [ ]&nbsp;&nbsp;&nbsp;&nbsp; PCI
      Express ECRC settings control&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; &#9474; &#9474;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;
      &gt;&nbsp;&nbsp;&nbsp;&nbsp; PCIe AER error injector
      support&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; &#9474; &#9474;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [ ]&nbsp;&nbsp; PCI
      Express ASPM
control&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; &#9474; &#9474;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [*] Message
      Signaled Interrupts (MSI and
      MSI-X)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; &#9474; &#9474;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [*] PCI
Debugging&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; &#9474; &#9474;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [ ] Enable
      PCI resource re-allocation
detection&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; &#9474; &#9474;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &gt;
      PCI Stub
driver&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; &#9474; &#9474;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [ ] PCI IOV
support&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; &#9474; &#9474;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [ ] PCI PRI
support&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; &#9474; &#9474;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [ ] PCI
      PASID
support&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; &#9474; &#9474;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; &gt;
      PCCard (PCMCIA/CardBus) support&nbsp;
---&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; &#9474; &#9474;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;*&gt;
      Support for PCI Hotplug&nbsp;
---&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">&nbsp; &#9474; &#9474;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [ ] RapidIO
      support&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>
    </p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);"><br>
    </p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);"><br>
    </p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);"><br>
    </p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; min-height: 8pt; height: 8pt;
      background-color: rgb(255, 255, 255);"><br>
    </p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">I am using same device tree that i used with linux 3.0.48&nbsp;
      .</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">I doubt there is basic problem with PCie driver provided
      with linux 3.8.x .</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">When I searched in this Google, I Could find that some
      people experienced some problem with PCIe driver in linux 3.8
      after up-gradation of kernel.</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">Can anyone help me to get out this issue ?</p>
    <p style="margin: 0px; padding: 0px; border: 0px; font-weight:
      normal; font-style: normal; font-size: 13px; font-family:
      'Helvetica Neue', Helvetica, Arial, 'Lucida Grande', sans-serif;
      vertical-align: baseline; color: rgb(61, 61, 61); font-variant:
      normal; letter-spacing: normal; line-height: 19.5px; orphans:
      auto; text-align: left; text-indent: 0px; text-transform: none;
      white-space: normal; widows: auto; word-spacing: 0px;
      -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
      255);">Did any one faced same issue before?</p>
    <div class="moz-signature">-- <br>
      <font color="#181818">
        Thanks &amp; Regards
      </font><br>
      <font color="#181818"><b>
          Gokul C G
        </b></font><br>
      <font color="black">
        Engineer Product Development
        <br>
      </font><br>
      <table cellpadding="0" cellspacing="0" border="0">
        <tbody>
          <tr>
            <td width="70">
              Phone </td>
            <td>&nbsp;:
              +91-484 2861900
            </td>
          </tr>
          <tr>
            <td width="70">
              Mobile </td>
            <td>&nbsp;:
            </td>
          </tr>
          <tr>
            <td width="70">
              Fax </td>
            <td>&nbsp;:
              +91-484 2861900
            </td>
          </tr>
          <tr>
            <td width="70">
              Email</td>
            <td>&nbsp;:
              <a href="mailto:gokul.g@kalkitech.in">gokul.g@kalkitech.in</a>
            </td>
          </tr>
          <tr>
            <td width="70">
              Web</td>
            <td>&nbsp;:&nbsp;<a href="http://www.kalkitech.com" align="left">www.kalkitech.com
              </a>
            </td>
          </tr>
        </tbody>
      </table>
      <br>
      <table cellpadding="0" cellspacing="0" border="0">
        <tbody>
          <tr>
            <td>
              <a href="http://www.kalkitech.com">
                <img src="cid:part3.01020603.05070301@kalkitech.in"
                  align="left" border="0" height="70" width="253">
              </a>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  
<br><pre>
"Disclaimer: This message is being sent from Kalki Communication Technologies
Pvt Ltd (KALKITECH). and may contain information which is confidential or 

privileged. If you are not the intended recipient, please advise the sender
immediately by reply e-mail and delete this message and any attachments 

without retaining a copy. Any unauthorized use of the content of this message
can expose the responsible party to civil and/or criminal penalties, 

and may constitute a more serious offense. Further the company does not accept
liability for any errors, omissions, viruses or computer problems 

experienced as a result of this transmission. If you have received this
message in error, notice is hereby given that no representation, contract or 

other binding obligation shall be created by this e-mail." 
</pre><br>
</body>
</html>

--------------050200020204040802090303
Content-Type: image/jpeg;
 name="Kalkitech_Logo_200.jpg"
Content-Transfer-Encoding: base64
Content-ID: <part3.01020603.05070301@kalkitech.in>
Content-Disposition: inline;
 filename="Kalkitech_Logo_200.jpg"

/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB
AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/2wBDAQEBAQEBAQEBAQEBAQEB
AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQH/wAAR
CABDAMgDASIAAhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAA
AgEDAwIEAwUFBAQAAAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkK
FhcYGRolJicoKSo0NTY3ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWG
h4iJipKTlJWWl5iZmqKjpKWmp6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl
5ufo6erx8vP09fb3+Pn6/8QAHwEAAwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREA
AgECBAQDBAcFBAQAAQJ3AAECAxEEBSExBhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYk
NOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElKU1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOE
hYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk
5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD+/iisHxV4p8OeB/DHiPxr4x1vTPDPhHwh
oOr+KPFPiTWryHT9G8P+HPD+n3Gra3rer39y6W9jpmk6ZaXV/f3k7pDa2lvLPK6xozCl4E8d
eDPif4L8K/Eb4deKND8beAvHGgaX4q8HeL/DOo22r+HvE3hvXLOLUNH1zRNVs5JbTUdL1Oxn
hu7K8tpZILi3lSWN2RgSAdXRRX8737SP7f37TH7UX7ZXhz9i/wD4JseMbHw7beDdRvx8ZPju
nh7w94t8P2/9m3CWHii9hk1/S9Y0xPBPgJpHsDfWUcd/478ez2vh3QLpbC1W91T6PhvhjMOJ
8TiqODqYXCYXL8HWzDM80zCpUoZbluDoxbdbF16VKvOPtJJU6NKlSq1qs37lNwhUnDys2zjC
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
--------------050200020204040802090303--

--------------070907060208000906060904--
