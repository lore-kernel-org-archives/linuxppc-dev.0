Return-Path: <js084@bucknell.edu>
Received: from ivory.bucknell.edu (ivory.bucknell.edu [134.82.9.79])
	by ozlabs.org (Postfix) with ESMTP id 54876DDF22
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Oct 2008 02:52:13 +1100 (EST)
Received: from [134.82.109.42] (js084.resnet.bucknell.edu [134.82.109.42])
	(authenticated bits=0)
	by ivory.bucknell.edu (8.14.2/8.14.2) with ESMTP id m97FqA6A023514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Tue, 7 Oct 2008 11:52:11 -0400
Message-ID: <48EB85A9.1000302@bucknell.edu>
Date: Tue, 07 Oct 2008 11:52:09 -0400
From: Juliana Su <js084@bucknell.edu>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: SysACE driver and Ethernet support? - mainline Linux 2.6.10 and Xilinx
	ML310
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

I finally got PCI support on my Xilinx ML310 with a mainline Linux 
2.6.10 kernel and gcc-3.4.5-glibc-2.3.6 (with the help of the awesome 
people at UNCC). Now, I'm trying to get Xilinx SystemACE device driver 
support and Ethernet working. Unfortunately, I do not know much about 
adding support for a driver that does not currently exist in the kernel. 
Does anybody know if it would be possible to get SysACE driver support 
in 2.6.10? Downloading an ELF file onto a board using a JTAG cable is 
slow and inconvenient... 

My attempt at adding SysACE driver support involved adding in 
drivers/block/xsysace.c and linux/platform_device.h (files pulled from 
mainline Linux 2.6.24) and editing drivers/block/Kconfig and 
drivers/block/Makefile. The kernel failed to compile, however, and spit 
out these errors:


In file included from drivers/block/xsysace.c:93:
include/linux/platform_device.h:16: error: redefinition of `struct 
platform_device'
include/linux/platform_device.h:39: error: conflicting types for 
'platform_device_register_simple'
include/linux/device.h:387: error: previous declaration of 
'platform_device_register_simple' was here
include/linux/platform_device.h:39: error: conflicting types for 
'platform_device_register_simple'
include/linux/device.h:387: error: previous declaration of 
'platform_device_register_simple' was here
include/linux/platform_device.h:52: error: syntax error before 
"pm_message_t"
include/linux/platform_device.h:52: warning: function declaration isn't 
a prototype
include/linux/platform_device.h:53: error: syntax error before 
"pm_message_t"
include/linux/platform_device.h:53: warning: function declaration isn't 
a prototype
drivers/block/xsysace.c: In function `ace_fsm_yieldirq':
drivers/block/xsysace.c:461: error: `NO_IRQ' undeclared (first use in 
this function)
drivers/block/xsysace.c:461: error: (Each undeclared identifier is 
reported only once
drivers/block/xsysace.c:461: error: for each function it appears in.)
drivers/block/xsysace.c: In function `ace_fsm_dostate':
drivers/block/xsysace.c:723: error: too many arguments to function 
`end_that_request_last'
drivers/block/xsysace.c: At top level:
drivers/block/xsysace.c:931: error: unknown field `getgeo' specified in 
initializer
drivers/block/xsysace.c:931: warning: initialization from incompatible 
pointer type
drivers/block/xsysace.c: In function `ace_setup':
drivers/block/xsysace.c:960: warning: implicit declaration of function 
`setup_timer'
drivers/block/xsysace.c:1009: error: `NO_IRQ' undeclared (first use in 
this function)
drivers/block/xsysace.c:1010: warning: passing arg 2 of `request_irq' 
from incompatible pointer type
drivers/block/xsysace.c: In function `ace_teardown':
drivers/block/xsysace.c:1061: error: `NO_IRQ' undeclared (first use in 
this function)
drivers/block/xsysace.c: In function `ace_alloc':
drivers/block/xsysace.c:1081: warning: implicit declaration of function 
`kzalloc'
drivers/block/xsysace.c:1081: warning: assignment makes pointer from 
integer without a cast
drivers/block/xsysace.c: In function `ace_probe':
drivers/block/xsysace.c:1131: error: `NO_IRQ' undeclared (first use in 
this function)
make[2]: *** [drivers/block/xsysace.o] Error 1
make[1]: *** [drivers/block] Error 2
make: *** [drivers] Error 2


Also, is anybody familiar with the Ethernet drivers? My boot-log 
contains this error concerning Ethernet:


eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin 
<saw@saw.sw.com.sg> and others
eth0: Invalid EEPROM checksum 0xbf8a, check settings before activating 
this device!
eth0: OEM i82557/i82558 10/100 Ethernet, 00:0A:35:00:7C:A0, IRQ 0.
  Board assembly 727095-004, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
Self test failed, status ffffffff:
 Failure to initialize the i82557.
 Verify that the card is a bus-master capable slot.


I also tried another Ethernet driver and got this error instead:


e100: Intel(R) PRO/100 Network Driver, 3.2.3-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
e100: 0000:00:07.0: e100_eeprom_load: EEPROM corrupted
e100: probe of 0000:00:07.0 failed with error -11


I know that newer versions of mainline and Xilinx Linux 2.6 have SysACE 
support, but I would prefer to stick with mainline 2.6.10 because, well, 
it sort of works for me at the moment (I was able to mount an ATA hard 
drive with an ext2 file system). Any help/suggestions would be greatly 
appreciated. Let me know if you need me to provide any additional 
information. Thanks!


-Juliana

 
