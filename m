Return-Path: <akostop@inaccessnetworks.com>
Received: from inaccessnetworks.com (node3.inaccessnetworks.com
	[212.205.200.118]) by ozlabs.org (Postfix) with ESMTP id D714067B6D
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Sep 2006 23:30:53 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by inaccessnetworks.com (8.13.6/8.13.5) with ESMTP id k8EDUoQm000724
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Sep 2006 16:30:50 +0300
Received: from inaccessnetworks.com ([127.0.0.1])
	by localhost (host11.inaccessnetworks.com [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP id 00391-07 for <linuxppc-dev@ozlabs.org>;
	Thu, 14 Sep 2006 16:30:50 +0300 (EEST)
Received: from priv.inaccessnetworks.com (orion.priv.inaccessnetworks.com
	[192.168.1.2])
	by inaccessnetworks.com (8.13.6/8.13.5) with ESMTP id k8EDUi4j000712
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Sep 2006 16:30:44 +0300
Received: from draco (draco.priv.inaccessnetworks.com [192.168.1.3])
	by priv.inaccessnetworks.com (8.12.1/8.12.1) with ESMTP id
	k8EDUi6p019979
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Sep 2006 16:30:44 +0300
Date: Thu, 14 Sep 2006 16:30:44 +0300
To: linuxppc-dev@ozlabs.org
Subject: cpm_uart non-console problem with write on 2nd open..
From: "Alexandros Kostopoulos" <akostop@inaccessnetworks.com>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-7
MIME-Version: 1.0
Message-ID: <op.tfvehinanhx3hy@draco>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm experiencing a problem with the 2.6.13 cpm_uart driver. When opening=
  =

the device for the second time after the driver was inserted, if only a =
 =

few bytes are sent for transmission and the device is then closed, the  =

tx_empty routine called by shutdown returns 0 and the latter hangs in th=
e  =

while loop with the call to cpm_uart_tx_empty. No bytes are actually  =

transmitted from the uart.

I found out that the difference between the first and subsequent open  =

calls is that during the first time (and until the first shutdown) the  =

transmitter is enabled in GSMRL. From this point on, the transmitter is =
 =

initially disabled on startup. Thus, if only a few bytes are queued for =
 =

transmission before shutdown and a TX interrupt is not triggered, the  =

bytes are never sent, and thus the shutdown function hangs on the  =

cpm_uart_tx_empty loop.

The fix that works for me is the following:

Index: drivers/serial/cpm_uart/cpm_uart_core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/serial/cpm_uart/cpm_uart_core.c     (revision 106)
+++ drivers/serial/cpm_uart/cpm_uart_core.c     (working copy)

@@ -394,7 +394,7 @@ static int cpm_uart_startup(struct uart_
                 pinfo->smcp->smc_smcmr |=3D SMCMR_REN;
         } else {
                 pinfo->sccp->scc_sccm |=3D UART_SCCM_RX;
-        pinfo->sccp->scc_gsmrl |=3D (SCC_GSMRL_ENR);
+        pinfo->sccp->scc_gsmrl |=3D (SCC_GSMRL_ENR | SCC_GSMRL_ENT);

         }

Any comments would be greatly appreciated

thank you

Alex
