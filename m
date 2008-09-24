Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] remove bogus ppc_select syscall
Date: Wed, 24 Sep 2008 19:03:38 +0200
References: <7B7EF7F090B9804A830ACC82F2CDE95D56E206@insardxms01.ap.sony.com>
	<200809240839.14902.arnd@arndb.de>
	<18650.27350.410563.484089@cargo.ozlabs.ibm.com>
In-Reply-To: <18650.27350.410563.484089@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809241903.39443.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 24 September 2008, Paul Mackerras wrote:
> > diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/a=
sm/systbl.h
> > index f6cc7a4..5a69b32 100644
> > --- a/arch/powerpc/include/asm/systbl.h
> > +++ b/arch/powerpc/include/asm/systbl.h
> > @@ -85,7 +85,7 @@ COMPAT_SYS_SPU(gettimeofday)
> > =A0COMPAT_SYS_SPU(settimeofday)
> > =A0COMPAT_SYS_SPU(getgroups)
> > =A0COMPAT_SYS_SPU(setgroups)
> > -SYSX(sys_ni_syscall,sys_ni_syscall,ppc_select)
> > +SYSCALL(sys_ni_syscall)
>=20
> I don't see any reason to remove the old select syscall on 32-bit
> kernels. =A0

Well, the point I made earlier ist that the native ppc32 path should
behave the same way as the compat ppc32 path. If we keep ppc_select
in one way or another, we should also have a compat wrapper for that,
right?

	Arnd <><
