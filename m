Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id F335CB7108
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Nov 2010 02:26:50 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP id 17614-09 for <linuxppc-dev@ozlabs.org>;
	Mon,  8 Nov 2010 15:20:08 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: INFO: task snmpd:398 blocked for more than 120 seconds.
Date: Mon, 8 Nov 2010 15:19:22 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AB9A@saturn3.aculab.com>
In-Reply-To: <OF385C74E5.E81887CB-ONC12577D5.00527686-C12577D5.0052E6B5@transmode.se>
From: "David Laight" <David.Laight@ACULAB.COM>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> I can't make out what is causing this hang every now an then:
>=20
> INFO: task snmpd:398 blocked for more than 120 seconds.

My problem with that 'error' message is that there is no way
for a driver to disable it on a per-process basis.
We have some processes whose 'normal state' is to sleep
uninterruptibly in the kernel. Shutdown is handled by
an explicit request (not by sending a signal).
The processes could be kernel worker threads (except that
is is ~impossible to handle them exiting from a loadble
kernel module) so are actually children of a daemon sat
inside an ioctl() request that never terminates!

However, on the face of it, your case does look as though
the mutex is fubar'ed.

Might be worth (somehow) dumping the mutex state.

	David
