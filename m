Return-Path: <tim.martin@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 0E05CDDED4
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Jan 2007 07:01:15 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Stupid Telnet Question
Date: Wed, 3 Jan 2007 11:49:05 -0800
Message-ID: <821B2170E9E7F04FA38DF7EC21DE4871078F811B@VCAEXCH01.hq.corp.viasat.com>
In-Reply-To: <000001c72f64$b727ea70$2018010a@inphasetech.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: "Erik Habbinga" <erikhabbinga@inphase-tech.com>
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

> -----Original Message-----
> From: Erik Habbinga [mailto:erikhabbinga@inphase-tech.com]=20
> Sent: Wednesday, January 03, 2007 10:27 AM
> To: Martin, Tim
> Subject: Re: Stupid Telnet Question
>=20
> Tim,
>    Did you ever figure out how to get telnet to work with=20
> ELDK 4.0?  I've run into the same problem.  I've heard it=20
> will be fixed in ELDK 4.1,  but that's not out yet.
>=20
> Thanks!
> Erik
>=20

Erik,

I did eventually solve it - but don't remember exactly what I did.

Here's my xinetd telnet configuration file (/etc/xinet.d/telnet):
------------
# description: The telnet server serves telnet sessions; it uses \
#	unencrypted username/password pairs for authentication.
service telnet
{
	flags		=3D REUSE
	socket_type	=3D stream       =20
	wait		=3D no
	user		=3D root
	server		=3D /usr/sbin/in.telnetd
        server_args     =3D -L /bin/login
	log_on_failure	+=3D USERID
	disable		=3D no
}
------------

And here's my bootup script (/etc/rc.sh):
------------
#!/bin/sh

/sbin/ifconfig lo 127.0.0.1

>/etc/mtab

/bin/mount -n -t tmpfs tmpfs -o size=3D1M /tmp
mkdir /tmp/var
mkdir /tmp/var/log
mkdir /tmp/var/run
mkdir /tmp/dev
/etc/rc.makedev
/sbin/syslogd

# mount /proc so "reboot" works
/bin/mount -n -t proc proc /proc

/usr/sbin/xinetd -stayalive -reuse -pidfile /tmp/xinetd.pid
------------

/etc/rc.makedev is just the ELDK 4.0 makedev script, slightly taylored
to my particular board.
