Return-Path: <Alexander.Povolotsky@marconi.com>
Received: from mailgate.pit.comms.marconi.com (mailgate.pit.comms.marconi.com
	[169.144.68.6]) by ozlabs.org (Postfix) with ESMTP id 5630E2BF07
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Dec 2004 09:22:09 +1100 (EST)
Message-ID: <313680C9A886D511A06000204840E1CF0A647400@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: "'Tom Rini'" <trini@kernel.crashing.org>,
	"'dan@embeddededge.com'" <dan@embeddededge.com>
Date: Thu, 23 Dec 2004 17:21:46 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Cc: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: simple bootloader vs 2.6.10-rc3 for 8xx vs I2C based EEPROM !!!
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

Would below (from Dan Malek) explain why on my 8xx board with I2C EEPROM
(which ptobably does not work on 2.6.10-rc3) the simple bootloader fails to
load the kernel ?

If my assumption is correct - does simple bootloader, if/when it fails to
read the data from EEPROM, 
calls "load_kernel()" function or not ?

Does simple bootloader has any debugging print statements, which I could
enable ? (how ?)

If my assumption is correct - then I am probably in a "dead loop":

cannot fix I2C without loading the kernel - can not load the kernel without
working I2C ...

Would greatly appresiate response/advise !

Thks,
Alex
**********************************************
Dan Malek dan at embeddededge.com 
Tue Oct 12 02:38:49 EST 2004 

You need to build a zImage so you get the simple
bootloader that will read the information from the EEPROM
and format the board structure.

Load the zImage file as a binary.  It has a 64K ELF header
on it, so you can either use 'dd' to strip that before the
download or add 64K to the load address to use as the
start address.  The start address is the first instruction of
the image (or +64K if you didn't remove the ELF header).

....the kernel does not understand anything about
the EEPROM format on this board.  This is the
reason this "front end" bootloader was created.
The standard interface to the kernel is the
board descriptor, the board specific data in
the EEPROM or elsewhere is usually quite
varied and isn't appropriate to have in the
kernel when it can be easily represented in
a standard manner.

Thanks.


		-- Dan
