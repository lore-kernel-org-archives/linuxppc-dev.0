Return-Path: <biovore@biovore.net>
Received: from last-exile (unknown [207.114.88.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "biovore", Issuer "biovore" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D7613DDE42
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 10:31:52 +1000 (EST)
Received: from kb3gtn.local (c-69-143-224-204.hsd1.md.comcast.net
	[69.143.224.204])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by last-exile (Postfix) with ESMTP id 9DE4945C179
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 20:31:54 -0400 (EDT)
From: biovore <biovore@biovore.net>
To: linuxppc-dev@ozlabs.org
Subject: New to ML-310
Date: Wed, 13 Jun 2007 20:31:53 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200706132031.53942.biovore@biovore.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello everyone on the list,
	I have managed to get my hands on a ML-310 play around with in my spare time 
at home.  I working on trying to build a linux kernel for the system.  I have 
ISE 9.1i and EDK 9.1i and am using there system generator to patch a 
linux-2.6.22-rc3 kernel I checked out of the montivista kernel git repos.   I 
am familiar with crosscompiling kernels for fix processors of arm and ppc, 
but I am running into problems dealing with the PPC405 in the virtex-II.
The EDK generates a bunch of code and patches the kernel.  I then go into the 
kernel directory and run ./xmake and it seems to go off and do some stuff to 
the .config file and then starts to build the kernel.  I all goes nicely 
until it hits the following error.

  CC      arch/ppc/syslib/xilinx_pic.o
arch/ppc/syslib/xilinx_pic.c:30:5: warning: "XPAR_XINTC_USE_DCR" is not 
defined
arch/ppc/syslib/xilinx_pic.c:121:5: warning: "XPAR_XINTC_USE_DCR" is not 
defined
arch/ppc/syslib/xilinx_pic.c: In function 'ppc4xx_pic_init':
arch/ppc/syslib/xilinx_pic.c:122: error: 'XPAR_INTC_0_BASEADDR' undeclared 
(first use in this function)
arch/ppc/syslib/xilinx_pic.c:122: error: (Each undeclared identifier is 
reported only once
arch/ppc/syslib/xilinx_pic.c:122: error: for each function it appears in.)
arch/ppc/syslib/xilinx_pic.c:148: error: 'XPAR_INTC_0_KIND_OF_INTR' undeclared 
(first use in this function)
make[1]: *** [arch/ppc/syslib/xilinx_pic.o] Error 1
make: *** [arch/ppc/syslib] Error 2

This to me looks like my xparameters.h file is missing something..    Any 
ideas?

Peter Fetterer
--
The force is like duct tape.  It has a dark side, a light side and binds the 
universe together.
