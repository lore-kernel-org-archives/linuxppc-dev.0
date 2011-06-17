Return-Path: <mlcreech@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C9DCEB6FBB
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jun 2011 06:54:32 +1000 (EST)
Received: by vxi40 with SMTP id 40so2546229vxi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jun 2011 13:54:28 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 17 Jun 2011 16:54:27 -0400
Message-ID: <BANLkTikyKObukzVw+c10HyDz+Q=PH4jozA@mail.gmail.com>
Subject: NAND BBT corruption on MPC83xx
From: "Matthew L. Creech" <mlcreech@gmail.com>
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

Hi, I posted this on the Linux-MTD list but haven't gotten any hits.
Since it looks like it could be MPC83xx-specific, I'm reposting here.
Rick Johnson noted a problem in fsl_elbc_nand.c back in May which
might be related:

http://lists.infradead.org/pipermail/linux-mtd/2011-May/035372.html


We've gotten some devices back from the field which all suffer from
this same problem on bootup when attaching UBI (these messages are
from U-Boot):

...
Bad block table found at page 524224, version 0x01
Bad block table found at page 524160, version 0x01
nand_bbt: ECC error while reading bad block table
...(long stream of bogus bad blocks)...
UBI: attaching mtd1 to ubi0
UBI: physical eraseblock size:   131072 bytes (128 KiB)
UBI: logical eraseblock size:    129024 bytes
UBI: smallest flash I/O unit:    2048
UBI: sub-page size:              512
UBI: VID header offset:          512 (aligned 512)
UBI: data offset:                2048
UBI error: vtbl_check: volume table check failed: record 0, error 9
UBI error: ubi_init: cannot attach mtd1
UBI error: ubi_init: UBI error: cannot initialize UBI, error -22
UBI init error -22

Full console dumps from 2 devices are here:

http://mcreech.com/work/bbt-ecc-error.txt
http://mcreech.com/work/bbt-ecc-error2.txt

Another device encountered a slightly different error, but which I
assume is due to the same underlying problem:

UBI error: init_volumes: not enough PEBs, required 8061, available 8059
UBI error: ubi_wl_init_scan: no enough physical eraseblocks (-2, need 1)

A full dump from that one is here:

http://mcreech.com/work/bbt-ecc-error3.txt

Are there any known issues that could cause the BBT to
become corrupt like this?

I noticed that the reported bad blocks were all aligned at multiples
of 0x80000 (with one exception).  Dump #1 shows:
 - one BBT with lots of bytes that have their lower 1 or 2 bits
un-set (e.g. 0xfe instead of 0xff): this explains all the
each-4th-block alignment.
 - the other BBT shows only one factory-marked bad block at
0x062e0000, which is presumably correct.  This is preserved in the
bogus BBT, and is the only non-0x80000-aligned bad block in the table.
 - Only the first 1024 bytes of the BBT contain bogus info - the
latter half of the BBT is all correct

It seems like the original BBT somehow had 0-2 bits corrupted at the
low end of each of its bytes, either while in memory or when the BBT
was written to NAND.  Any ideas on what I can do to isolate the
problem?  Thanks in advance!

More info on this board:
- MPC 8313 SoC
- 1GB Samsung NAND flash (K9K8G08U0B)
- Linux 2.6.31
- U-Boot 2009.06

-- 
Matthew L. Creech
