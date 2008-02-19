Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E1952DDDF4
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 09:51:55 +1100 (EST)
Message-ID: <47BB5D82.6070806@freescale.com>
Date: Tue, 19 Feb 2008 16:51:46 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, lkml <linux-kernel@vger.kernel.org>
Subject: Difference between vmlinux and vmlinux.bin
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm trying to write an ELF loader for a PowerPC vmlinux, and I've come across 
something I don't understand.

In vmlinux, there are two Program Segments, the first of which is PT_LOAD.  What 
is the difference between the block of data inside this section, and 
vmlinux.bin?  I thought that vmlinux.bin is nothing more than the PT_LOAD 
section of vmlinux.  However, when I do a memcmp, there is a difference at 
offset 3080192 (vmlinux.bin is 4874532 bytes long):

memcmp @ 3080192 125 != 31
32 bytes @ 412f0000:

7d 20 00 28 31 29 ff ff 7d 20 01 2d 40 a2 ff f4
2f 89 00 00 41 9e 01 9c 7f e3 fb 78 4b d7 b0 75
32 bytes @ 42300000:

1f 8b 08 08 b7 e7 7a 44 00 03 62 75 73 79 62 6f
78 2d 31 2e 31 2e 33 2e 69 6d 67 00 ec 5d 7d 74

So when Kbuild creates vmlinux.bin, what does it do besides extract the PT_LOAD 
segment?

-- 
Timur Tabi
Linux kernel developer at Freescale
