Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx026.isp.belgacom.be (outmx026.isp.belgacom.be
	[195.238.4.91])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BAE4167B1E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Jun 2006 22:36:38 +1000 (EST)
Received: from outmx026.isp.belgacom.be (localhost [127.0.0.1])
	by outmx026.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k57CaNU7001690
	for <linuxppc-embedded@ozlabs.org>; Wed, 7 Jun 2006 14:36:27 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: CPM_UART should allocate DPRAM for SMCx parameter RAM on MPC82xx
Date: Wed, 7 Jun 2006 14:34:08 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200606071434.08905.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everybody,

the move to platform devices introduced a bug in the CPM_UART SMC driver.

Unlike SCC and FCC, the SMC parameter ram is not at a fixed location. A 
pointer to the parameter ram is instead stored at PROFF_SMCx_BASE.

The SMC platform device resources (in arch/ppc/syslib/pq2_devices.c) reserves 
the memory resource PROFF_SMCx_BASE - PROFF_SMCx_BASE+1. The CPM UART driver 
considers that value as the SMC parameter ram offset. It should instead 
allocate 64 bytes (on a 64 bytes boundary) of DPRAM for its parameter ram, 
and store the offset at PROFF_SMCx_BASE. 

I'm not sure how to fix the problem as it seems that the platform device 
support is not complete yet (cpm_uart_init_portdesc is still used to 
initialize the console). A possible workaround is to set the pram resource to 
0x0000-0x003f and 0x0040-0x007f instead of 0x87fc-0x87fd and 0x88fc-0x88fd 
for SMC1 and SMC2. This will not work if cpm_uart_init_portdesc is not 
called.

Laurent Pinchart
