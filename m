Return-Path: <jbailey@ubuntu.com>
Received: from adelie.ubuntu.com (adelie.ubuntu.com [82.211.81.139])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7DD567DB6
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Oct 2006 02:22:42 +1000 (EST)
Subject: Re: glibc-2.5 test suite hangs/crashes the machine
From: Jeff Bailey <jbailey@ubuntu.com>
To: Fabio Massimo Di Nitto <fabbione@ubuntu.com>
In-Reply-To: <45419F79.2020300@ubuntu.com>
References: <45419F79.2020300@ubuntu.com>
Content-Type: text/plain; charset=utf-8
Date: Fri, 27 Oct 2006 12:22:33 -0400
Message-Id: <1161966154.18515.1.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Ben Collins <ben.collins@ubuntu.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Le vendredi 27 octobre 2006 =C3=A0 07:56 +0200, Fabio Massimo Di Nitto a
=C3=A9crit :
> Hi everybody,
>=20
> i am in the process of bootstrapping the new toolchain for ubuntu and I a=
m
> hitting a problem building glibc-2.5 on ppc.
>=20
> This behaviour has been reproduced on 2.6.15/2.6.17 and 2.6.19-rc2 (where=
 the
> machine crashes) and with ppc32 and ppc64 kernels.
> A hard reboot of the machine is required to get rid of the Zl processes h=
anging
> around that keep spinning the CPU at 100%.
>=20
> I did place sources here: http://people.ubuntu.com/~fabbione/benh/
>=20
> but i start to believe it is a kernel bug we are exploiting only now.
>=20
> Any hint or help for what to look for would be extremely appreciated.

Heya Fabio, just an update, it looks like the tests that are zombie'ing
are the nptl tst-robust[1-8] tests.  According to /proc/##/wchan, the
tasks are cheerfully spinning in do_exit.

If there's other info I can get you, lemme know.

--=20
Jeff Bailey
Manager, Technical Support
Canonical Ltd. - Sales, Service, and Support.
+1 514 940-8910
http://www.ubuntu.com/
