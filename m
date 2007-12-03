Return-Path: <Leonid@a-k-a.net>
Received: from mis011.exch011.intermedia.net (mis011.exch011.intermedia.net
	[64.78.21.10]) by ozlabs.org (Postfix) with ESMTP id 01F47DDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Dec 2007 07:25:47 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Cannot login via tinylogin on sequoia
Date: Mon, 3 Dec 2007 12:25:42 -0800
Message-ID: <406A31B117F2734987636D6CCC93EE3C028D2656@ehost011-3.exch011.intermedia.net>
In-Reply-To: <406A31B117F2734987636D6CCC93EE3C028D2294@ehost011-3.exch011.intermedia.net>
References: Your message of "Fri, 30 Nov
	200714:33:38+0100."<f8f856500711300533t3bad1c1dxb4ff137534acbccb@mail.gmail.com><20071130221554.3AA0124075@gemini.denx.de><821B2170E9E7F04FA38DF7EC21DE48710BA65802@VCAEXCH01.hq.corp.viasat.com>
	<406A31B117F2734987636D6CCC93EE3C028D2294@ehost011-3.exch011.intermedia.net>
From: "Leonid" <Leonid@a-k-a.net>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I can avoid login procedure at all by replacing tinylogin call by simple
sh in inittab or by removing inittab at all:

#::askfirst:/bin/tinylogin login -f root=20
::askfirst:/bin/sh

I get shell prompt all right without logging. However login doesn't work
and I don't understand why.=20

I tried to change password using passwd (user: root, password: root),
but login still doesn't work:

/ # passwd root
Changing password for root
Enter the new password (minimum of 5, maximum of 8 characters) Please
use a combination of upper and lower case letters and numbers.
Enter new password:
Re-enter new password:
Password changed.
/ # Dec 31 18:02:29 Sequoia auth.info passwd[38]: password for `root'
changed by user `root'

/ # login

Sequoia login: root
Password:
Login incorrect

Does somebody know a way to make tinylogin give out more detailed
iunformation? Of course, I can always debug it since I have source...

Thanks,

Leonid.

-----Original Message-----
From: linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org
[mailto:linuxppc-embedded-bounces+leonid=3Da-k-a.net@ozlabs.org] On =
Behalf
Of Leonid
Sent: Friday, November 30, 2007 3:10 PM
To: linuxppc-embedded@ozlabs.org
Subject: Cannot login via tinylogin on sequoia

Hi:

I have built u-boot, kernel and filesystem using ELDK 4.1 for AMCC
PPC440EPx sequoia board. When I boot linux using NFS filesystem,
supplied with ELDK itself, I can login (usrr root, no password). However
I couldn't login while used ramdisk, built by myself or taken from AMCC
resource CD. Combinations root/root or root/nothing don't work.=20

Sequoia login: root
Password:
Login incorrect

Please press Enter to activate this console. Dec 31 18:00:26 Sequoia
auth.warn login[37]: invalid password for `UNKNOWN' on `ttyS0'
Dec 31 18:00:26 Sequoia daemon.info init: Process '/bin/tinylogin login
-f root' (pid 37) exited.  Scheduling it for restart.

How I can learn what user/password combination are configured and how do
I change them? This is static/etc/passwd from my SIMPLE filesystem:

root::0:0:root:/root:/bin/sh
bin:*:1:1:bin:/bin:
daemon:*:2:2:daemon:/sbin:
halt:*:7:0:halt:/sbin:/sbin/halt
ftp:*:14:50:FTP User:/
nobody:*:99:99:Nobody:/:
target:$1$x4Rc1j78$n5FVlLwarSyMYoZaMlijU1:200:100:Test
User:/home:/bin/sh

Thanks,

Leonid.
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
