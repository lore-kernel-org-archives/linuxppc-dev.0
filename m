Return-Path: <morten.banzon@axxessit.no>
Received: from pt20-qms-02.ptn.no (pt20-qms-02.ptn.no [64.28.25.139])
	by ozlabs.org (Postfix) with SMTP id C3BCC2BEA0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Nov 2004 03:18:08 +1100 (EST)
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Message-ID: <OFF3BFC73F.53C5A7DE-ONC1256F4D.00564648-C1256F4D.0058DF9F@axxessit.no>
From: morten.banzon@axxessit.no
Date: Mon, 15 Nov 2004 17:10:42 +0100
Content-Type: text/plain; charset="us-ascii"
Subject: MPC82xx -- DPRAM1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I am using 2.6.9 for a mpc8280 project, and am having trouble using dpram1 
from offset zero, which I need for a mcc hdlc driver.

 In the file include/asm-ppc/cpm2.h there is a constant CPM_DATAONLY_BASE
In the same file the code comment say that the first 128 bytes are used 
for SMC1 and SMC2. 

When I examine the smc (cpm_uart) driver i do not find any reference to 
this region of the dpram1.
I have replaced the calls to cpm_dpalloc with cpm_dpalloc_fixed and an 
adress way up in the dpram1 region.

My question is; do you know which code is using the dpram1 addresses below 
CPM_DATAONLY_BASE ?

This region must be used by something (smc ?), because when I clear from 
offset 0x00 to 0x80 the serial port stop responding.
I can ssh to the device and things seems to be normal util I try to reboot 
the system, whereupon everything hangs.

I am stuck, so if you have any suggestions, please advice.


Regards,
Morten
