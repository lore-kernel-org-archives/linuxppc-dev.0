Return-Path: <jack_liu@usish.com>
Received: from ms.usish.com (ms.usish.com [61.152.132.204])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CECE72BDB3
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Oct 2004 11:01:26 +1000 (EST)
Received: from usish000029-1 ([222.64.160.209])
	by ms.usish.com (8.12.8/8.12.8) with SMTP id i9511FEW029063
	for <linuxppc-embedded@ozlabs.org>; Tue, 5 Oct 2004 09:01:16 +0800
Message-Id: <200410050101.i9511FEW029063@ms.usish.com>
From: "Jack Liu" <jack_liu@usish.com>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Date: Tue, 5 Oct 2004 9:1:12 +0800
Subject: Resend:MPC8272 PCI bridge problem?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi,all
	I have a problem using MPC8272 PCI bridge. Currently I am debugging our own board with a MPC8272 and PCI IDE chip (VIA VT6410). However I can not visit the memory of PCI space. In u-boot, When I type "md F40001F0", there is always a program check. 
	My configuration is as follows:

	 *	0x00000000-0x07FFFFFF	128MB	SDRAM
	 *	0x80000000-0x9FFFFFFF	512MB	outbound prefetchable PCI memory window
 	 *	0xA0000000-0xBFFFFFFF	512MB	outbound non-prefetchable PCI memory window
 	 *	0xF0000000-0xF001FFFF	128KB	MPC8272 internal memory
 	 *	0xF4000000-0xF7FFFFFF	 64MB   outbound PCI I/O window
 	 *	0xFE000000-0xFFFFFFFF	 32MB	flash
    /* PCIBR0 */
	#define CFG_PCI_MSTR0_LOCAL		0x80000000		/* Local base */
	#define CFG_PCIMSK0_MASK		PCIMSK_1GB		/* Size of window */
	/* PCIBR1 */
	#define CFG_PCI_MSTR1_LOCAL		0xF4000000		/* Local base */
	#define CFG_PCIMSK1_MASK		PCIMSK_64MB		/* Size of window */
	
    #define CFG_PCI_MSTR_IO_LOCAL       0xF4000000          /* Local base */
	#define CFG_PCI_MSTR_IO_BUS         0xF4000000          /* PCI base   */
	#define CFG_CPU_PCI_IO_START        PCI_MSTR_IO_LOCAL
	#define CFG_PCI_MSTR_IO_SIZE        0x04000000          /* 64MB */
	#define CFG_POCMR2_MASK_ATTRIB      (POCMR_MASK_64MB | POCMR_ENABLE | POCMR_PCI_IO)
  
	So, I am wondering why the configured PCI space can not be accessed since I have configured the outbound window and PCIBR? In MPC8241, I can access PCI space by "md FE0001F0".
    Any kind help will be greatly appreciated.
 
Best regard
Jack liu
