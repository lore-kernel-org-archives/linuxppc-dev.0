Return-Path: <cclo@astri.org>
Received: from asiwss02.astri.org (mail2.astri.org [203.198.202.21])
	by ozlabs.org (Postfix) with ESMTP id 6A4D567C33
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 16:11:42 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Subject: RE: Problems with uaccsess.h
Date: Fri, 25 Aug 2006 13:43:05 +0800
Message-ID: <A7B1E4DD46AA7046A4398F745240F29402737D53@ASPROEXG.astri.local>
From: "Chun Chung Lo" <cclo@astri.org>
To: "Keinen Namen" <GSM909@gmx.de>
Cc: linuxppc-embedded@ozlabs.org
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

Seems your makefile does not include all the kernel header ...

Please try to add this ' -I(linux kernel source path)/include ' to your=
 makefile as CFLAGS.

Best regards,
Lo Chun Chung

-----Original Message-----
From: linuxppc-embedded-bounces+cclo=3Dastri.org@ozlabs.org=
 [mailto:linuxppc-embedded-bounces+cclo=3Dastri.org@ozlabs.org] On Behalf=
 Of Keinen Namen
Sent: Friday, 25 August, 2006 1:29 PM
To: linuxppc-embedded@ozlabs.org
Subject: Problems with uaccsess.h


Hi

when I compile my program i got this message

bash-2.05b# make
gcc -O2 -DMODULE -D__KERNEL__ -W -Wall -Wstrict-prototypes=
 -Wmissing-prototypes -isystem /lib/modules/`uname -r`/build/include -c -o=
 hello.o hello.c
hello.c:5:25: linux/version: No such file or directory
In file included from hello.c:9:
/usr/include/asm/uaccess.h: In function `verify_area':
/usr/include/asm/uaccess.h:37: error: `CONFIG_TASK_SIZE' undeclared (first=
 use in this function)
/usr/include/asm/uaccess.h:37: error: (Each undeclared identifier is=
 reported only once
/usr/include/asm/uaccess.h:37: error: for each function it appears in.)
/usr/include/asm/uaccess.h: In function `copy_from_user':
/usr/include/asm/uaccess.h:280: error: `CONFIG_TASK_SIZE' undeclared (first=
 use in this function)
/usr/include/asm/uaccess.h: In function `copy_to_user':
/usr/include/asm/uaccess.h:294: error: `CONFIG_TASK_SIZE' undeclared (first=
 use in this function)
/usr/include/asm/uaccess.h: In function `clear_user':
/usr/include/asm/uaccess.h:313: error: `CONFIG_TASK_SIZE' undeclared (first=
 use in this function)
/usr/include/asm/uaccess.h: In function `strncpy_from_user':
/usr/include/asm/uaccess.h:327: error: `CONFIG_TASK_SIZE' undeclared (first=
 use in this function)
/usr/include/asm/uaccess.h: In function `strnlen_user':
/usr/include/asm/uaccess.h:350: error: `CONFIG_TASK_SIZE' undeclared (first=
 use in this function)

These Header files I have include

#include <linux/module.h>  /* Needed by all modules */
#include <linux/kernel.h>  /* Needed for KERN_ALERT */
#include <linux/slab.h>
#include <linux/delay.h>
#include <linux/version>
#include <linux/init.h>
#include <linux/fs.h>


#include <asm/types.h>
#include <asm/mpc8260.h>
#include <asm/cpm_8260.h>
#include <asm/page.h>

#include <asm/uaccess.h>

My linux is 2.4.25
Need I a patch to correct this ?? I need the funktion copy_to_user.

Regards
Fred


--=0D


Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen! Ideal f=
=FCr Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org=
 https://ozlabs.org/mailman/listinfo/linuxppc-embedded

This message (including any attachments) is for the named addressee(s)'s=
 use only. It may contain
sensitive, confidential, private proprietary or legally privileged=
 information intended for a
specific individual and purpose, and is protected by law. If you are not=
 the intended recipient,
please immediately delete it and all copies of it from your system, destroy=
 any hard copies of it
and notify the sender. Any use, disclosure, copying, or distribution of=
 this message and/or any
attachments is strictly prohibited.
