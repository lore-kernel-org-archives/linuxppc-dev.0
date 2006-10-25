Return-Path: <luong.ngo@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by ozlabs.org (Postfix) with ESMTP id 6AAC167A3B
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 14:14:29 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id f25so26815pyf
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 21:14:28 -0700 (PDT)
Message-ID: <1b2aacd80610242049j23917f61x1e277b4c6a581f9a@mail.gmail.com>
Date: Tue, 24 Oct 2006 20:49:45 -0700
From: "Luong Ngo" <luong.ngo@gmail.com>
To: "linuxppc-dev list" <linuxppc-dev@ozlabs.org>
Subject: MPC8343: PCI resource allocation questions
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_103324_21783576.1161748185653"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_103324_21783576.1161748185653
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,
I am trying to bring up linux kernel 2.6.14 on a system using MPC 8343E and
am having issues with the PCI resource allocation in the kernel. I saw these
messages:
.............
PCI: Cannot allocate resource region 0 of device 0000:00:00.0
PCI: Cannot allocate resource region 2 of device 0000:00:00.0
PCI: Failed to allocate mem resource #2:80000000@0 for 0000:00:00.0

After digging into the codes, I realize that the PCI subsystem scan the bus
and reading the BARs in the CPU PCI controller, which give the region 1 from
0x0 to 0x000FFFFF and region 2 from 0x0 to 0x7FFFFFFF. And the values I
assign to the bridge resource in calling pci_init_resource during setup hose
is 0x80000000 - 0x9FFFFFFF (I got this values from the mpc834x_sys.h).  So I
just extend the bridge resource to 0x70000000 - 0xFFFFFFFF to cover all 2
regions in the 2 BAR and this seems to get rid of the above messages.
However this would cause other platform devices to fail to claim its
resources,

fsl-gianfar.1: failed to claim resource 0
unable to register device 0
fsl-gianfar.2: failed to claim resource 0
unable to register device 1
fsl-i2c.1: failed to claim resource 0
unable to register device 2

Could anyone tell me how these PCI resource work and how to resolve this
conflict?
And my other questions are  why is the region 2 in the mpc8343E such huge
and what is it used for?
Also Why the kernel looks into the CPU PCI controller? because as I
understand, in the hose setup step in platform initialization, the host
bridge is skipped while other PCI devices would be probed and have their
BARs assigned the address range to use ( in function pciauto_bus_scan in
arch/ppc/syslib/pci_auto.c )

One more question, are these BARs in the PCI controller related with the PCI
inbound and outbound mapping of the PCI interface? Do the regions in BAR
need to match/derive from the inbound/outbound address mapping?

Thank you,

Luong Ngo

------=_Part_103324_21783576.1161748185653
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br>I am trying to bring up linux kernel 2.6.14 on a system using MPC 8343E and am having issues with the PCI resource allocation in the kernel. I saw these messages:<br>.............<br>PCI: Cannot allocate resource region 0 of device 0000:00:
00.0<br>PCI: Cannot allocate resource region 2 of device 0000:00:00.0<br>PCI: Failed to allocate mem resource #2:80000000@0 for 0000:00:00.0<br><br>After digging into the codes, I realize that the PCI subsystem scan the bus and reading the BARs in the CPU PCI controller, which give the region 1 from 0x0 to 0x000FFFFF and region 2 from 0x0 to 0x7FFFFFFF. And the values I assign to the bridge resource in calling pci_init_resource during setup hose is 0x80000000 - 0x9FFFFFFF (I got this values from the mpc834x_sys.h).&nbsp; So I just extend the bridge resource to 0x70000000 - 0xFFFFFFFF to cover all 2 regions in the 2 BAR and this seems to get rid of the above messages. However this would cause other platform devices to fail to claim its resources, 
<br><br>fsl-gianfar.1: failed to claim resource 0<br>unable to register device 0<br>fsl-gianfar.2: failed to claim resource 0<br>unable to register device 1<br>fsl-i2c.1: failed to claim resource 0<br>unable to register device 2
<br><br>Could anyone tell me how these PCI resource work and how to resolve this conflict?<br>And my other questions are&nbsp; why is the region 2 in the mpc8343E such huge and what is it used for? <br>Also Why the kernel looks into the CPU PCI controller? because as I understand, in the hose setup step in platform initialization, the host bridge is skipped while other PCI devices would be probed and have their BARs assigned the address range to use ( in function pciauto_bus_scan in arch/ppc/syslib/pci_auto.c )
<br><br>One more question, are these BARs in the PCI controller related with the PCI inbound and outbound mapping of the PCI interface? Do the regions in BAR need to match/derive from the inbound/outbound address mapping?
<br><br>Thank you,<br><br>Luong Ngo<br>

------=_Part_103324_21783576.1161748185653--
