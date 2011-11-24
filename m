Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 054DA1007D7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2011 03:28:39 +1100 (EST)
Received: from lpsc0174x.localnet (lpsc0174x.in2p3.fr [134.158.40.174])
 by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id pAOFfG2C029530
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 16:41:16 +0100
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
To: linuxppc-dev@lists.ozlabs.org
Subject: Telling the kernel about a Flash SPI...
Date: Thu, 24 Nov 2011 16:41:15 +0100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201111241641.15470.dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello all,
I have a flash memory in a custom device and I'd like to place a standard filesystem on it, so I guess there must be a way 
to tell the kernel to use it.
Here's the DTS definition:

		Flash_Serie: gpio@81460000 {
			compatible = "xlnx,xps-gpio-2.00.a", "xlnx,xps-gpio-1.00.a";
			reg = < 0x81460000 0x10000 >;
			xlnx,all-inputs = <0x0>;
			xlnx,all-inputs-2 = <0x0>;
			xlnx,dout-default = <0x0>;
			xlnx,dout-default-2 = <0x0>;
			xlnx,family = "virtex4";
			xlnx,gpio-width = <0xa>;
			xlnx,gpio2-width = <0x20>;
			xlnx,interrupt-present = <0x1>;
			xlnx,is-dual = <0x0>;
			xlnx,tri-default = <0xffffffff>;
			xlnx,tri-default-2 = <0xffffffff>;
		} ;

The bits are addressed as such:
// Flash memory control
#define FLASH_SCK  		(1<<4)		// Serial Clock
#define FLASH_SI   		(1<<3)		// Data Out _to_ the flash (DO)
#define FLASH_RSTN 		(1<<2)		// Reset
#define FLASH_WPN  		(1<<1)		// Write Protect
#define FLASH_SO   		(1<<0)		// Data In _from_ the flash (DI)

So how can I tell the kernel that there's a FAT32 or ext2 filesystem on it (note, I don't need it as a root/boot 
filesystem) ?

Thanks.
-- 
Guillaume Dargaud
http://www.gdargaud.net/
