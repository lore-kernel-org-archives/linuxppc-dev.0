Return-Path: <akostop@inaccessnetworks.com>
Received: from inaccessnetworks.com (node3.inaccessnetworks.com
	[212.205.200.118]) by ozlabs.org (Postfix) with ESMTP id D5A88679FC
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 00:24:34 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by inaccessnetworks.com (8.13.6/8.13.5) with ESMTP id k7SE55jD030540
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2006 17:05:05 +0300
Received: from inaccessnetworks.com ([127.0.0.1])
	by localhost (host11.inaccessnetworks.com [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP id 30187-03 for <linuxppc-dev@ozlabs.org>;
	Mon, 28 Aug 2006 17:05:04 +0300 (EEST)
Received: from priv.inaccessnetworks.com (orion.priv.inaccessnetworks.com
	[192.168.1.2])
	by inaccessnetworks.com (8.13.6/8.13.5) with ESMTP id k7SE4GXI030518
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2006 17:04:16 +0300
Received: from draco (draco.priv.inaccessnetworks.com [192.168.1.3])
	by priv.inaccessnetworks.com (8.12.1/8.12.1) with ESMTP id
	k7SE4G6p012955
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2006 17:04:16 +0300
Date: Mon, 28 Aug 2006 17:04:16 +0300
To: linuxppc-dev@ozlabs.org
Subject: uart_cpm scc Rx problem after second open of the device
From: "Alexandros Kostopoulos" <akostop@inaccessnetworks.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-7
MIME-Version: 1.0
Message-ID: <op.tezypejhnhx3hy@draco>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I experienced a problem with the cpm_uart scc driver (kernel version  =

2.6.13) while running the driver for a serial port NOT configured as a  =

console.
The problem is as follows:
The first time the device (/dev/ttyCPM0) is opened, everything works ok.=
  =

The second time, however, the device is opened, receive does not work. T=
he  =

device can only transmit, but doesn't receive anything.

Well, by looking into the code, I found out that the ENR (Receiver enabl=
e)  =

bit of the GSMR-L register is only set in cpm_uart_init_scc and NOT in
cpm_uart_startup, as I think it should. Then, the bit is cleared on  =

cpm_uart_shutdown. Thus, the first time the device is opened, the bit is=
  =

set (and so, the device normally receives data), but the second time the=
  =

device is opened, the bit is NOT set and the device cannot receive  =

anything from the serial port.

The diff of my code against the original 2.6.13 code follows (although i=
  =

saw that the 2.6.17 code is exactly the same as far as the ENR bit is
concerned):

Index: cpm_uart_core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- cpm_uart_core.c     (revision 79)
+++ cpm_uart_core.c     (revision 105)
@@ -393,6 +393,7 @@
                 pinfo->smcp->smc_smcm |=3D SMCM_RX;
                 pinfo->smcp->smc_smcmr |=3D SMCMR_REN;
         } else {
+        pinfo->sccp->scc_gsmrl |=3D (SCC_GSMRL_ENR);
                 pinfo->sccp->scc_sccm |=3D UART_SCCM_RX;
         }


Am I missing something here?

Thanks for any comments,
Alex.
