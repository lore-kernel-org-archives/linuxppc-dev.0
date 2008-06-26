Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 63E1DDE20C
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 02:46:26 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: monstr@seznam.cz
Subject: Re: [PATCH 52/60] microblaze_v4: fcntl.h sockios.h ucontext.h
Date: Thu, 26 Jun 2008 18:46:12 +0200
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-53-git-send-email-monstr@seznam.cz>
	<200806261743.10441.arnd@arndb.de>
In-Reply-To: <200806261743.10441.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200806261846.13599.arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	linux-kernel@vger.kernel.org, drepper@redhat.com,
	linuxppc-dev@ozlabs.org, will.newton@gmail.com, hpa@zytor.com,
	John.Linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 June 2008, Arnd Bergmann wrote:
> On Thursday 26 June 2008, monstr@seznam.cz wrote:
> > =A0include/asm-generic/sockios.h =A0 =A0 | =A0 23 +++++++++++++++++++++=
++
> > =A0include/asm-generic/ucontext.h =A0 =A0| =A0 24 +++++++++++++++++++++=
+++
> > =A0include/asm-microblaze/fcntl.h =A0 =A0| =A0 =A01 +
> > =A0include/asm-microblaze/sockios.h =A0| =A0 23 +++++++++++++++++++++++
> > =A0include/asm-microblaze/ucontext.h | =A0 =A01 +
>=20
> Also, the sockios file here looks like it should be in asm-generic.

I just realized that you are adding the same sockios file to both
asm-generic and asm-microblaze, so I guess that is just an oversight
and you meant the microblaze file to be just a redirection.

Note that when you add an asm-generic header file that contains
a user interface, you need to add it to asm-generic/Kbuild as well
in order to get it installed correctly with make headers_install.

Running make headers_check should tell you about this problem if
it exists in other places.

	Arnd <><
