Return-Path: <ioecas@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.185])
	by ozlabs.org (Postfix) with ESMTP id 80B70DDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Sep 2007 17:03:12 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id h3so818452nfh
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Sep 2007 00:03:10 -0700 (PDT)
Message-ID: <5a65c5e70709100003w3d40013eoa2fe189dafa4a977@mail.gmail.com>
Date: Mon, 10 Sep 2007 15:03:09 +0800
From: "yuan tian" <ioecas@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: linux can't read pci bus configure space of a scsi controller
	(lsi53c1020)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7026_3821982.1189407789441"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_7026_3821982.1189407789441
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,
I have a board based on ocotea(ppc440gx) as reference.
Without PCI bus,the linux system can run successfully on
the board. when the PCI bus is used,the system hung.
on the pci bus ,there are two pci devices.one is a scsi
controller,the other is a fpga. i found the system hung at
indirect_pci.c.


 indirect_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
       int len, u32 *val)
{
 struct pci_controller *hose = bus->sysdata;
 volatile void __iomem *cfg_data;
 u8 cfg_type = 0;

 if (ppc_md.pci_exclude_device)
  if (ppc_md.pci_exclude_device(bus->number, devfn))
   return PCIBIOS_DEVICE_NOT_FOUND;

 if (hose->set_cfg_type)
  if (bus->number != hose->first_busno)
   cfg_type = 1;

 PCI_CFG_OUT(hose->cfg_addr,
   (0x80000000 | ((bus->number - hose->bus_offset) << 16)
    | (devfn << 8) | ((offset & 0xfc) | cfg_type)));

 /*
  * Note: the caller has already checked that offset is
  * suitably aligned and that len is 1, 2 or 4.
  */
 cfg_data = hose->cfg_data + (offset & 3);
 switch (len) {
 case 1:
  *val = in_8(cfg_data);
  break;
 case 2:
  *val = in_le16(cfg_data);
  break;
 default:
  *val = in_le32(cfg_data);
  break;
 }
 return PCIBIOS_SUCCESSFUL;
}
 the system run to *val = in_le32(cfg_data) , the board hung.
 when i get out scsi controller,the system can run successfully.

 the vxworks run successfully on the board with these two pci devices.
 so i think the board have no problem on the hardware.

 my question is :
 why can linux read fpga pci configure space and can't read scsi
 controller(lsi 53c1020)?

 any help will be appreciated!

 Regards,
 --
  Tom

------=_Part_7026_3821982.1189407789441
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,</div>
<div>I have a board based on ocotea(ppc440gx) as reference.<br>Without PCI bus,the linux system can run successfully on<br>the board. when the PCI bus is used,the system hung.<br>on the pci bus ,there are two pci devices.one
 is a scsi <br>controller,the other is a fpga. i found the system hung at<br>indirect_pci.c.</div>
<p><br>&nbsp;indirect_read_config(struct pci_bus *bus, unsigned int devfn, int offset,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int len, u32 *val)<br>{<br>&nbsp;struct pci_controller *hose = bus-&gt;sysdata;<br>&nbsp;volatile void __iomem *cfg_data;<br>&nbsp;u8 cfg_type = 0;
</p>
<p>&nbsp;if (ppc_md.pci_exclude_device)<br>&nbsp;&nbsp;if (ppc_md.pci_exclude_device(bus-&gt;number, devfn))<br>&nbsp;&nbsp;&nbsp;return PCIBIOS_DEVICE_NOT_FOUND;<br>&nbsp;<br>&nbsp;if (hose-&gt;set_cfg_type)<br>&nbsp;&nbsp;if (bus-&gt;number != hose-&gt;first_busno)<br>
&nbsp;&nbsp;&nbsp;cfg_type = 1;</p>
<p>&nbsp;PCI_CFG_OUT(hose-&gt;cfg_addr, &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>&nbsp;&nbsp; (0x80000000 | ((bus-&gt;number - hose-&gt;bus_offset) &lt;&lt; 16)<br>&nbsp;&nbsp;&nbsp; | (devfn &lt;&lt; 8) | ((offset &amp; 0xfc) | cfg_type)));</p>
<p>&nbsp;/*<br>&nbsp; * Note: the caller has already checked that offset is<br>&nbsp; * suitably aligned and that len is 1, 2 or 4.<br>&nbsp; */<br>&nbsp;cfg_data = hose-&gt;cfg_data + (offset &amp; 3);<br>&nbsp;switch (len) {<br>&nbsp;case 1:<br>&nbsp;&nbsp;*val = in_8(cfg_data);
<br>&nbsp;&nbsp;break;<br>&nbsp;case 2:<br>&nbsp;&nbsp;*val = in_le16(cfg_data);<br>&nbsp;&nbsp;break;<br>&nbsp;default:<br>&nbsp;&nbsp;*val = in_le32(cfg_data);<br>&nbsp;&nbsp;break;<br>&nbsp;}<br>&nbsp;return PCIBIOS_SUCCESSFUL;<br>}<br>&nbsp;the system run to *val = in_le32(cfg_data) , the board hung.
<br>&nbsp;when i get out scsi controller,the system can run successfully.</p>
<p>&nbsp;the vxworks run successfully on the board with these two pci devices.<br>&nbsp;so i think the board have no problem on the hardware.</p>
<p>&nbsp;my question is :<br>&nbsp;why can linux read fpga pci configure space and can&#39;t read scsi <br>&nbsp;controller(lsi 53c1020)?</p>
<p>&nbsp;any help will be appreciated!<br>&nbsp; <br>&nbsp;Regards,<br>&nbsp;--<br>&nbsp;&nbsp;Tom</p>

------=_Part_7026_3821982.1189407789441--
