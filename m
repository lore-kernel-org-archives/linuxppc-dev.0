Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 705BDDDE32
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 00:54:22 +1000 (EST)
Subject: Re: [RFC Patch 4/6] Modify process handling code to handle
	hardware debug registers
From: Michael Ellerman <michael@ellerman.id.au>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
In-Reply-To: <20090514134528.GE14229@in.ibm.com>
References: <20090514133312.360702378@prasadkr_t60p.in.ibm.com>
	<20090514134528.GE14229@in.ibm.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-xfOMZLfz0hOGmMeMxkTg"
Date: Fri, 15 May 2009 00:54:21 +1000
Message-Id: <1242312861.8608.37.camel@concordia>
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, Alan Stern <stern@rowland.harvard.edu>,
	paulus@samba.org, Roland McGrath <roland@redhat.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-xfOMZLfz0hOGmMeMxkTg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-05-14 at 19:15 +0530, K.Prasad wrote:
> plain text document attachment (ppc64_modify_process_handling_04)

> Index: linux-2.6-tip.hbkpt/arch/powerpc/kernel/process.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6-tip.hbkpt.orig/arch/powerpc/kernel/process.c
> +++ linux-2.6-tip.hbkpt/arch/powerpc/kernel/process.c
> @@ -50,6 +50,7 @@
>  #include <asm/syscalls.h>
>  #ifdef CONFIG_PPC64
>  #include <asm/firmware.h>
> +#include <asm/hw_breakpoint.h>
>  #endif
>  #include <linux/kprobes.h>
>  #include <linux/kdebug.h>
> @@ -254,8 +255,10 @@ void do_dabr(struct pt_regs *regs, unsig
>  			11, SIGSEGV) =3D=3D NOTIFY_STOP)
>  		return;
> =20
> +#ifndef CONFIG_PPC64
>  	if (debugger_dabr_match(regs))
>  		return;
> +#endif
> =20
>  	/* Clear the DAC and struct entries.  One shot trigger */
>  #if defined(CONFIG_BOOKE)
> @@ -372,8 +375,13 @@ struct task_struct *__switch_to(struct t
> =20
>  #endif /* CONFIG_SMP */
> =20
> +#ifdef CONFIG_PPC64
> +		if (unlikely(test_tsk_thread_flag(new, TIF_DEBUG)))
> +			switch_to_thread_hw_breakpoint(new);
> +#else

To avoid all these ifdefs in the code we need something like this in a
header:

static inline int task_uses_debug_regs(struct task_struct *tsk)
{
#ifdef CONFIG_PPC64
	return test_tsk_thread_flag(tsk, TIF_DEBUG);
#else
	return 0;
#endif
}

> @@ -605,6 +617,9 @@ int copy_thread(unsigned long clone_flag
>  	struct pt_regs *childregs, *kregs;
>  	extern void ret_from_fork(void);
>  	unsigned long sp =3D (unsigned long)task_stack_page(p) + THREAD_SIZE;
> +#ifdef CONFIG_PPC64
> +	struct task_struct *tsk =3D current;
> +#endif
> =20
>  	CHECK_FULL_REGS(regs);
>  	/* Copy registers */
> @@ -672,6 +687,9 @@ int copy_thread(unsigned long clone_flag
>  	 * function.
>   	 */
>  	kregs->nip =3D *((unsigned long *)ret_from_fork);
> +
> +	if (unlikely(test_tsk_thread_flag(tsk, TIF_DEBUG)))
> +		copy_thread_hw_breakpoint(tsk, p, clone_flags);

If you just use current here you don't need to define tsk above.

cheers

--=-xfOMZLfz0hOGmMeMxkTg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoMMJ0ACgkQdSjSd0sB4dKphACfXIOiL5gan2Ctoq+ziZwcOSFJ
xhAAoLVF3cgZakOuRa5qmJvxlO9HuHcc
=ia6J
-----END PGP SIGNATURE-----

--=-xfOMZLfz0hOGmMeMxkTg--
