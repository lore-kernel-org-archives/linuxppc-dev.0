Return-Path: <Clive.Jenkins@xerox.com>
Received: from wbmler2.mail.xerox.com (wbmler2.mail.xerox.com [13.13.138.217])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wbmler2.mail.xerox.com",
	Issuer "wbmler2.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id F4214DDEBB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Jan 2008 22:34:05 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Adding new driver in Linux 2.6 - read fails with -1
Date: Fri, 18 Jan 2008 11:22:51 -0000
Message-ID: <35786B99AB3FDC45A821572461791973013565AC@gbrwgceumf01.eu.xerox.net>
In-Reply-To: <4f8c3030801180254l1fed257bpdb6839afcfdf2196@mail.gmail.com>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: "Ramkumar J" <ramkumarj2000@gmail.com>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> From: linuxppc-embedded-bounces+clive.jenkins=3Dxerox.com@ozlabs.org
> =
[mailto:linuxppc-embedded-bounces+clive.jenkins=3Dxerox.com@ozlabs.org]
> On Behalf Of Ramkumar J
> Sent: 18 January 2008 10:54
> To: linuxppc-embedded@ozlabs.org
> Subject: Adding new driver in Linux 2.6 - read fails with -1
>
> Hi All,
>
> I m using the Linux 2.6(2.6.23-rc2) from Grants for ML-403 and
> I tried to add a new driver for a hardware based stream.
> [...] For read, the function doesnt seem calling the drivers read
> routine and exits with -1. [...]

You are not giving enough information -- better to supply the complete
code of driver and application, and the complete kernel log, or put
them on a web/ftp site and supply pointers to them.
=20
When your application calls read(), I cannot see whether you are
passing a valid file descriptor, whether you have opened the device
etc.  You say read() returns -1, but you don't give the value of errno
or the error string corresponding to that value. An easy way to get
this is to use perror() in your app.

>         /* Wait while empty. */
>         while (((status=3Dreadl( ((volatile unsigned char*)
remapped_address)
>  + 8)&3))=3D=3D0)=20

One thing I can see is that you have a "busy wait" loop in your
driver's read method. This will waste CPU time and may hang
indefinitely. Better to use wait-event_interruptible, and check for
termination of the wait by unexpected events such as signals and
changes of power management state.

Clive
