Return-Path: <Clive.Jenkins@xerox.com>
Received: from wvmler1.mail.xerox.com (wvmler1.mail.xerox.com [13.8.138.216])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wvmler1.mail.xerox.com",
	Issuer "wvmler1.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 55A99DDF05
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Jan 2008 07:34:03 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Adding new driver in Linux 2.6 - read fails with -1
Date: Fri, 18 Jan 2008 20:15:46 -0000
Message-ID: <35786B99AB3FDC45A821572461791973013565B3@gbrwgceumf01.eu.xerox.net>
In-Reply-To: <4f8c3030801180428k51645960sf0e1765f82eae1d8@mail.gmail.com>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: "Ramkumar J" <ramkumarj2000@gmail.com>
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

> From: Ramkumar J [mailto:ramkumarj2000@gmail.com]=20
> Sent: 18 January 2008 12:29
> To: Jenkins, Clive
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: Adding new driver in Linux 2.6 - read fails with -1
> [...]
>=20
> Hi,
>=20
> Thanks a lot for replying. I will try using the perror() function and
> modify the  busy-loop through wait-for functions. Also, the way I have
> accessed the memory  mapped IO, is to ioremap() the physical address
> and then use readl() functions.  Is this correct.=20
>=20
> Following is the link to the driver file,
> http://www.geocities.com/ramkumarj_2000/impulse-stream.c
> http://www.geocities.com/ramkumarj_2000/1.txt as impulse-stream.h
>
> This is intermediate layer and part of my application space,
> http://www.geocities.com/ramkumarj_2000/co_stream_linux.c
>=20
> The application is,
> http://www.geocities.com/ramkumarj_2000/HelloWorld.c
> http://www.geocities.com/ramkumarj_2000/HelloWorld_sw.c
>=20
> Logs at,
> http://www.geocities.com/ramkumarj_2000/logs.txt
> http://www.geocities.com/ramkumarj_2000/kernellog.txt
>=20
> My apologies for the dirty code. To add some background, it starts
> from the main() in HelloWorld.c and it proceeds calling the
> hear_hello() in HelloWorld_sw.c . The co_stream_* functions are
> defined in intermediate layer co_stream_linux.c and co_stream_open
> is defined to nothing in one header file. The open and ioctl call
> ( modified a little in the driver now for debugging) map from
> co_stream_attach.=20
> co_stream_read is read and co_stream_write is the write to driver.
=20
> Though the logs indicate the call of release function before the
> read, I m not quite sure about this as the read not being called
> have failed to get inside the kernel messages.

I still can't see everything because the header files are not shown.

But anyway, it is getting too complex. I think you need to cut the code
down to the mininum that causes the error if you want help from the
list.

A couple of hints regarding the driver's read method:
1. If you really want to copy different data sizes into the same
variable
then use a union.
2. *(char*)buffer=3Dx puts x where buffer points to; I think you wanted
to put x into the variable buffer: *(char*)&buffer =3D x, but this is
not very clear -- better to use a union.
3. copy_{to,from)_user() return values that should be checked. Always
check function return values (except maybe printf and printk), and
display all error information.

Clive
