Return-Path: <davidel@xmailserver.org>
Received: from x35.xmailserver.org (x35.xmailserver.org [64.71.152.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "x35.xmailserver.org",
	Issuer "x35.xmailserver.org" (not verified))
	by ozlabs.org (Postfix) with ESMTP id ADF5BDDE38
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 06:33:48 +1100 (EST)
Received: from alien.or.mcafeemobile.com
	by x35.xmailserver.org with [XMail 1.25 ESMTP Server]
	id <S260A2D> for <linuxppc-dev@ozlabs.org> from
	<davidel@xmailserver.org>; Wed, 28 Nov 2007 14:25:34 -0500
Date: Wed, 28 Nov 2007 11:25:30 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.24-rc3-mm2 - Build Failure on powerpc timerfd() undeclared
In-Reply-To: <20071128104345.9474025e.akpm@linux-foundation.org>
Message-ID: <Pine.LNX.4.64.0711281123360.14548@alien.or.mcafeemobile.com>
References: <20071128034140.648383f0.akpm@linux-foundation.org>
	<474D61CF.6080400@linux.vnet.ibm.com>
	<200711281432.09178.arnd@arndb.de>
	<20071128104345.9474025e.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="1795850513-290824188-1196277930=:14548"
Cc: Michael Kerrisk <mtk-manpages@gmx.net>, Arnd Bergmann <arnd@arndb.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1795850513-290824188-1196277930=:14548
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 28 Nov 2007, Andrew Morton wrote:

> On Wed, 28 Nov 2007 14:32:07 +0100 Arnd Bergmann <arnd@arndb.de> wrote:
>=20
> > On Wednesday 28 November 2007, Kamalesh Babulal wrote:
> > > Kernel build fails, with build error
> > >=20
> > > =C2=A0 CC =C2=A0 =C2=A0 =C2=A0arch/powerpc/platforms/cell/spu_callbac=
ks.o
> > > In file included from arch/powerpc/platforms/cell/spu_callbacks.c:49:
> > > include/asm/systbl.h:312: error: =E2=80=98sys_timerfd=E2=80=99 undecl=
ared here (not in a function)
> > > make[2]: *** [arch/powerpc/platforms/cell/spu_callbacks.o] Error 1
> > > make[1]: *** [arch/powerpc/platforms/cell] Error 2
> > > make: *** [arch/powerpc/platforms] Error 2
> > >=20
> >=20
> > I guess all architectures except x86 are currently broken because they
> > reference the old sys_timerfd function.
>=20
> None of them were broken in my testing and I'm unsure why powerpc broke
> here.
>=20
> > This patch should add the missing
> > bits to powerpc.
> >=20
>=20
> Because the patches in -mm left the stubs in place in sys_ni.c and powerp=
c
> _should_ have (incorrectly) picked those up.

My fault. I forgot to update sys_ni.c with the new functions (and with the
sys_timerfd->sys_timerfd_create name change).
Do you want a patch Andrew?



- Davide

--1795850513-290824188-1196277930=:14548--
