Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BF1C9DE094
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 00:26:10 +1000 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m6SEQ3kQ001565
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 16:26:04 +0200
Message-ID: <106201c8f0bd$dda4f640$ad289e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: Changing Mac address
Date: Mon, 28 Jul 2008 16:25:54 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello all,
there's something I miss here. I'd like to setup a MAC address in software 
at the start of the boot process. I'm trying to figure out where this is 
done in the kernel code.
I'm on a custom variant of a Xilinx ML405 card, still in PPC arch.
So it appears to be going in the arch/ppc/boot/simple/embed_config.c piece 
of code, but since I don't have I2C, the only 'relevant' code is this one:

#if (!defined(CONFIG_XILINX_MLxxx) || !defined(XPAR_IIC_0_BASEADDR) || 
!defined(XPAR_PERSISTENT_0_IIC_0_BASEADDR))
int get_cfg_data(unsigned char **cfg_data) {
#warning I2C needed for obtaining the Ethernet MAC address. Using hard-coded 
MAC address
 return 0; /* no cfg data found */
}

Nonetheless, ifconfig (from busybox) gives me a proper MAC address 
(00:0A:35:01:02:03) and can even change it:
ifconfig eth0 down hw ether 00:0A:35:01:02:10 up
But I want to do that before the network is up.

What is the relevant kernel section to change in order to set the MAC 
address ?
Thanks.
-- 
Guillaume Dargaud
http://www.gdargaud.net/
