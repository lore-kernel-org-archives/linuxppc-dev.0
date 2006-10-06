Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 3C6EB67ECA
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Oct 2006 21:54:10 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] spufs: change ppc_rtas declaration to weak
Date: Fri, 6 Oct 2006 13:53:59 +0200
References: <45255069.2020206@am.sony.com>
In-Reply-To: <45255069.2020206@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610061354.00398.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 05 October 2006 20:35, Geoff Levand wrote:
> Index: cell--common--5/include/asm-powerpc/syscalls.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- cell--common--5.orig/include/asm-powerpc/syscalls.h
> +++ cell--common--5/include/asm-powerpc/syscalls.h
> @@ -37,7 +37,7 @@
> =A0asmlinkage int sys_ipc(uint call, int first, unsigned long second,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0long third, void __user *=
ptr, long fifth);
> =A0asmlinkage long ppc64_personality(unsigned long personality);
> -asmlinkage int ppc_rtas(struct rtas_args __user *uargs);
> +asmlinkage int ppc_rtas(struct rtas_args __user *uargs) __attribute__((w=
eak));
> =A0asmlinkage time_t sys64_time(time_t __user * tloc);
> =A0asmlinkage long ppc_newuname(struct new_utsname __user * name);
> =A0

Hmm, I can't see why this does the right thing. __attribute__((weak)) should
normally be put only into the definition of a function, not into the common
declaration. This looks like it makes _both_ definitions (kernel/sys.c and
arch/powerpc/kernel/rtas.c) weak, so on pseries it becomes unspecific which
one is actually used.

The problem that this is trying to work around is probably caused by the
dot-symbols: cond_syscall defines a ".ppc_rtas", but not a "ppc_rtas" symbo=
l,
which spufs tries to resolve.

	Arnd <><=20
