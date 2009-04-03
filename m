Return-Path: <tmarri@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id C7E1FDDDA2
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Apr 2009 03:04:41 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: early kernel debugging
Date: Fri, 3 Apr 2009 09:04:37 -0700
Message-ID: <AC5E1C3367E37D44970B81A6ADD1DA2C071F4F26@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <52907.72158.qm@web38901.mail.mud.yahoo.com>
References: <52907.72158.qm@web38901.mail.mud.yahoo.com>
From: "Tirumala Reddy Marri" <tmarri@amcc.com>
To: "Yigal Goldberger" <yigal_gold@yahoo.com>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am not sure if I understand correctly. But Looks like you are not
passing the device tree along with kernel image and RAMDISK(you may not
need it if  you are using NFS mount). You boot command should some what
look like this "bootm kernel_addr ramdisk_addr devtree_addr" or "bootm
kernel_addr - devtree_addr" . If you are already doing that I would
check my bootargs for correct params.

-----Original Message-----
From: linuxppc-dev-bounces+tmarri=3Damcc.com@ozlabs.org
[mailto:linuxppc-dev-bounces+tmarri=3Damcc.com@ozlabs.org] On Behalf Of
Yigal Goldberger
Sent: Thursday, April 02, 2009 1:06 PM
To: linuxppc-dev@ozlabs.org
Subject: early kernel debugging


Hi All,
I'm using u-boot to boot kernel 2.6.24.2 on a powerpc based board .
I see that after uncompressing the kernel it hangs.
I found a location (System.map) I think corresponds to the __log_buf (my
SDRAM starts at physical address 0 (and u-boot performs -> Load Address:
00000000 Entry Point: 00000000) .
So I just removed the leading C0xxxxxx from the address leaving xxxxxx .
And that's where I looked .=20
I did see 2 error messages (though they were somewhat corrupt) the first
designated a memory fault and the second a kernel oops at some address.
I looked this address up on System.map and it's somewhere inside prom.c
in of_scan_flat_dt( ) .=20

I have a few question at this point :
A)Am I looking at the right memory location for __log_buf ?
B)What is printed to the buffer (printk's of what verbose level ?)
C)In a previous kernel version 2.6.14 I don't remember explicitly using
a flat device tree or pointing at such a tree through the bootm command)
, but I used the ARCH=3Dppc then as opposed to ARCH=3Dpowerpc Now .
I see a lot of stuff regarding the need to provide such a data structure
upon booting via bootm .Do I need to explicitly prepare such a data
structure and provide a pointer to it via bootm ?
Might this be the cause for this early hang ?

Best Regards,
Yigal Goldberger.=20


     =20
_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
