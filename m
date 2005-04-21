Return-Path: <robin.gilks@tait.co.nz>
Received: from gatekeeper.tait.co.nz (tel096021.tait.co.nz [202.37.96.21])
	by ozlabs.org (Postfix) with ESMTP id 2C12E67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 15:20:20 +1000 (EST)
Received: from gatekeeper.tait.co.nz (merlin.tait.co.nz [127.0.0.1])
	by localhost.tait.co.nz (Postfix) with ESMTP id 825B310BA7C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 17:20:18 +1200 (NZST)
Received: from sunstrike.tait.co.nz (unknown [172.25.40.92])
	by gatekeeper.tait.co.nz (Postfix) with ESMTP id 0085810B919
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 17:20:18 +1200 (NZST)
Received: from conversion-daemon.sunstrike.tait.co.nz by sunstrike.tait.co.nz
	(Sun Java System Messaging Server 6.1 (built Apr 28 2004))
	id <0IFA00F013E4M700@sunstrike.tait.co.nz>
	(original mail from robin.gilks@tait.co.nz) for
	linuxppc-embedded@ozlabs.org; Thu, 21 Apr 2005 17:20:17 +1200 (NZST)
Date: Thu, 21 Apr 2005 17:20:17 +1200
From: Robin Gilks <robin.gilks@tait.co.nz>
In-reply-to: <D8595042F3765A4285B848A78A2C2ED1027750@bsdmsg002.corp.satyam.ad>
To: Atit_Shah <Atit_Shah@satyam.com>
Message-id: <42673811.8030805@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
References: <D8595042F3765A4285B848A78A2C2ED1027750@bsdmsg002.corp.satyam.ad>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux booting problem when initializing flash file system
Reply-To: robin.gilks@tait.co.nz
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Atit_Shah wrote:
> Hi All,
> 
> 	I am using a board which has a ST Micro Electronics Flash
> (M29W640DB) and when booting the Linux Kernel I get the following error:
> 
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000000:
> 0x0020 instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000004:
> 0x22df instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000000c:
> 0x0008 instead
> 
> Further such events for this erase block will not be printed
> JFFS2: Erase block at 0x00000000 is not formatted. It will be erased
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020000:
> 0x0020 instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00020004:
> 0x22df instead
> jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0002000c:
> 0x0008 instead
> 
> And it ends with................
> 
> Cowardly refusing to erase blocks on filesystem with no valid JFFS2
> nodes
> Kernel panic: VFS: Unable to mount root fs on 1f:00
> <0>Rebooting in 180 seconds..
> 
> The reference board using an AMD flash works fine. I selected the ST
> Flash from make xconfig in Linux but the kernel crashes before it even
> calls start_kernel.
> Could somebody suggest wrong....
> 
> Thanks
> Atit

If the M29W640DB has the same problem as the M28W640ECB that I've used, 
then a fixup table entry may be required in drivers/mtd/cfi_cmdset_0001 
to say that buffered write is not supported.

You don't say which kernel or mtd version you are using - I'm assuming 
2.4 and an mtd about a year old!!

-- 
Robin Gilks
Senior Design Engineer          Phone: (+64)(3) 357 1569
Tait Electronics                Fax  :  (+64)(3) 359 4632
PO Box 1645 Christchurch        Email : robin.gilks@tait.co.nz
New Zealand

=======================================================================
This email, including any attachments, is only for the intended
addressee.  It is subject to copyright, is confidential and may be
the subject of legal or other privilege, none of which is waived or
lost by reason of this transmission.
If the receiver is not the intended addressee, please accept our
apologies, notify us by return, delete all copies and perform no
other act on the email.
Unfortunately, we cannot warrant that the email has not been
 altered or corrupted during transmission.
=======================================================================
