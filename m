Return-Path: <mr.scada@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DF0B6B6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Apr 2011 09:35:15 +1000 (EST)
Received: by bwz10 with SMTP id 10so764330bwz.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 05 Apr 2011 16:35:10 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 5 Apr 2011 16:35:10 -0700
Message-ID: <BANLkTim=oxHcW-HV5Z062r2p2D1nTL8mcQ@mail.gmail.com>
Subject: Combining multiple NAND MTDs
From: Barry G <mr.scada@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

I have an 8308 using the fsl_elbc_nand NAND controller.  I have
chip selects 2 & 3 hooked up to a single die multiple chip select NAND
chip.  I have programmed u-boot and the kernel correctly and the
NAND "chips" are found:
NAND device: Manufacturer ID: 0xec, Chip ID: 0xd3 (Samsung NAND 1GiB
3,3V 8-bit)
eLBC NAND device at 0xe0600000, bank 1
NAND device: Manufacturer ID: 0xec, Chip ID: 0xd3 (Samsung NAND 1GiB
3,3V 8-bit)
eLBC NAND device at 0xe0608000, bank 2

The nand chips are correctly show up:
# cat /proc/mtd
dev:    size   erasesize  name
mtd0: 02000000 00020000 "fe000000.flash"
mtd1: 40000000 00020000 "e0600000.flash"
mtd2: 40000000 00020000 "e0608000.flash"

(mtd0 is unrelated NOR part).

I want to run UBIFS on the combined 2 gigs of flash.  Whats the best
way to do this?

I tried using the mtdconcat stuff and wrote a small driver
but I am not sure how to populate the mtd_info structure since do_probe_map
doesn't work with NAND AFAIK.

I see that fsl_elbc_select_chip says "hardware does not seem to support this".
Not sure if this is related.

I see some comments in mtd-physmap.txt about using multiple reg ranges?
Does this work with NAND?

Thanks for any pointers,

Barry
