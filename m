Return-Path: <rusty@rustcorp.com.au>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] cpumask: use mm_cpumask() wrapper: powerpc
Date: Mon, 23 Mar 2009 16:13:22 +1030
References: <200903161446.43726.rusty@rustcorp.com.au>
	<1237530977.25062.572.camel@pasglop>
In-Reply-To: <1237530977.25062.572.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200903231613.23213.rusty@rustcorp.com.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 20 March 2009 17:06:17 Benjamin Herrenschmidt wrote:
> On Mon, 2009-03-16 at 14:46 +1030, Rusty Russell wrote:
> > Makes code futureproof against the impending change to mm->cpu_vm_mask.
> >=20
> > It's also a chance to use the new cpumask_ ops which take a pointer
> > (the older ones are deprecated, but there's no hurry for arch code).
>=20
> Boom :-)
>=20
> In file included from /home/benh/linux-powerpc-test/arch/powerpc/kernel/v=
dso.c:30:
> /home/benh/linux-powerpc-test/arch/powerpc/include/asm/mmu_context.h: In =
function =E2=80=98switch_mm=E2=80=99:
> /home/benh/linux-powerpc-test/arch/powerpc/include/asm/mmu_context.h:34: =
error: implicit declaration of function =E2=80=98mm_cpumask=E2=80=99
> /home/benh/linux-powerpc-test/arch/powerpc/include/asm/mmu_context.h:34: =
warning: passing argument 2 of =E2=80=98cpumask_set_cpu=E2=80=99 makes poin=
ter from integer without a cast

Hmm, I think you need to pull from Linus?  He only added the accessor
in "45e575ab (Rusty Russell       2009-03-12 14:35:44 -0600 281)"; you
can't get struct mm_struct without seeing mm_cpumask.

Thanks,
Rusty.
