Message-ID: <A109131318C4D1119AC20060088DECE330F305@MAIL>
From: Lucinda Schafer <lucsch@adaptivemicro.com>
To: jra@febo.com, csmall@small.dropbear.id.au, g4klx@g4klx.demon.co.uk,
        linuxppc-embedded@lists.linuxppc.org
Subject: AX.25 error--Address already in use (error 98)
Date: Fri, 2 Jun 2000 16:39:30 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello to all,

We are having great success in using AX.25 in an embedded PPC-based system.
However, one stumbling block exists. We are seeing an address already in use
error come back on a connect. I used the ax25_call program as a starting
point. Most of the time our main unit connects to another one of our units
and communicates back and forth perfectly. However, after the main unit
issues a disconnect (by a close on the socket), then trys to reconnect to
the other unit, we get the error.

I have been tracking this through the AX.25 kernel code (we are using the
2.2.12 for the embedded ppc). There is only one place in the connect code
which returns this error. It will return this if a control block already is
in the ax25 list of connections. It is supposed to be removed on the close.
Any ideas?

Sometimes if we retry the connect it will work.

We also noticed that if the disconnect message reaches the other unit, but
its response doesn't make it back, ax25 will continue to try to disconnect,
but the (now disconnected) other unit will not send the AX25_DM response (it
is silent) so we continue to send out the AX25_DISC for N times every T1
time until it gives up. In this case we will get the already connected error
98 also.

We appreciate any help you may provide.

Lucinda Schafer
Staff Software Engineer
Adaptive Micro-Ware, Inc.

-----Original Message-----
From:	Lucinda Schafer
Sent:	Thursday, February 24, 2000 4:54 PM
To:	'jra@febo.com'; 'csmall@small.dropbear.id.au';
'g4klx@g4klx.demon.co.uk'; linuxppc-embedded@lists.linuxppc.org
Subject:	AX.25 and libraries

We have been reading the Linux AX.25 Configuration Document from the website
febo.com.

We want to use the AX.25 driver in an embedded application.

We need to determine which libraries will work for our cross-platform
development and with AX.25.

Our Hardware Platform is the BrightStar Engineering ipEngine (with PPC823).

The Linux AX.25 Configuration Document specifies the libc6/glibc2.1
libraries to be used with the 2.2.x kernel. Also, it specifies
libax25-0.0.7.

Our BSE board came with Linux Kernel 2.2.13, libc1.99-8xx, AX.25 Release 037
(which says it requires 2.1.15 kernel).

Do you know the compatibility of the BSE Linux with AX.25? Or maybe give us
the email address of the person who wrote the Linux AX.25 Configuration
Document?


Adaptive-Microware, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
