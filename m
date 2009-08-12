Return-Path: <thirumalai.p@datapatterns.co.in>
Received: from ns0.datapatterns.co.in (ns0.datapatterns.co.in [121.242.18.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1AE72B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Aug 2009 00:13:39 +1000 (EST)
Received: from itd210 (itd210.datapatterns [10.5.4.110]) (authenticated bits=0)
	by ns0.datapatterns.co.in (8.14.2/8.14.2) with ESMTP id n7CE1580026499
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2009 19:31:05 +0530
Message-ID: <04CE892647C64383B7CB93BDBF365654@itd210>
From: "Thirumalai" <thirumalai.p@datapatterns.co.in>
To: <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 12 Aug 2009 19:27:50 +0530
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
Subject: Regarding initial PCI configuration
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,
    I need some clarification on powerpc linux-2.6.30 kernels PCI 
enumeration. Please correct me if i am wrong on this. I am having mpc7448 
based custom board on which i am trying to port linux 2.6.30(Note : Earlier 
i have ported linux2.6.23 kernel for this board and its successfully 
booted). So i have choosen mpc7448hpc2 as my model BSP. . On this the first 
call to pci related thing was called. (i.e from 
linux/arch/powerpc/platform/mpc7448hpc2.c/setup_arch() ) which will again 
call my sysdev/tsi108_pci.c/setup_pci() function. At the end of this 
function we use to call the pci_OF_process() function for assigning MEM/IO 
addresses to my kernel. again this function was defined on 
kernel/pci-common.c function. So here the mess starts. On this function the 
code is getting pci_addr and pci_size from ranges property that i used to 
pass on my device tree. But the cpu_addr whatever used will get the 
translated address from prom_parse.c file. This one is always returning 
0xFFFFFFFF. When we just dig into the internals i came to know that the 
implementation is totally different from the previos kernel means from 
linux-2.6.23 this change has come. Now the latest kernel is exhibiting the 
64 bit PCI implementation. But the prom_parse.c code is designed in that 
manner i think. because whenever the of_translate_addr() function is called 
the function will get the parent node for getting the system bus address 
information which we used to have 0xc0000000 and size 0x10000 on the device 
tree. This will do for all the devices but when try to use these function 
PCI mapping. This will create mess. I don't know how to go further.
    Kindly let me know any changes is required on device tree or kernel 
itself to get out this problem.

Regards,
T. 


**************** CAUTION - Disclaimer *****************This email may contain confidential and privileged material for the
sole use of the intended recipient(s). Any review, use, retention, distribution or disclosure by others is strictly prohibited. If you are not the intended recipient (or authorized to receive for the recipient), please contact the sender by reply email and delete all copies of this message. Also, email is susceptible to data corruption, interception, tampering, unauthorized amendment and viruses. We only send and receive emails on the basis that we are not liable for any such corruption, interception, tampering, amendment or viruses or any consequence thereof. 
*********** End of Disclaimer ***********DataPatterns ITS Group**********
