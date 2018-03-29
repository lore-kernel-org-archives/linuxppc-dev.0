Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Bqgm45jBzF0wQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 03:19:00 +1100 (AEDT)
Date: Thu, 29 Mar 2018 18:18:38 +0200
Message-ID: <20180329181838.Horde.opfAaSRmEf1pJwACgzIcVg8@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Mathieu Malaterre <malat@debian.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 04/19] powerpc/kvm: Prefer fault_in_pages_readable
 function
References: <20180322202007.23088-5-malat@debian.org>
 <20180328195811.27758-1-malat@debian.org>
In-Reply-To: <20180328195811.27758-1-malat@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mathieu Malaterre <malat@debian.org> a =C3=A9crit=C2=A0:

> Directly use fault_in_pages_readable instead of manual __get_user code. F=
ix
> warning treated as error with W=3D1:
>
>   arch/powerpc/kernel/kvm.c:675:6: error: variable =E2=80=98tmp=E2=80=99 =
set but not=20=20
>=20used [-Werror=3Dunused-but-set-variable]
>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
> v2: use fault_in_pages_readable instead
>  arch/powerpc/kernel/kvm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
> index 9ad37f827a97..124c51030b75 100644
> --- a/arch/powerpc/kernel/kvm.c
> +++ b/arch/powerpc/kernel/kvm.c
> @@ -25,6 +25,7 @@
>  #include <linux/kvm_para.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
> +#include <linux/pagemap.h>
>
>  #include <asm/reg.h>
>  #include <asm/sections.h>
> @@ -672,14 +673,13 @@ static void kvm_use_magic_page(void)
>  {
>  	u32 *p;
>  	u32 *start, *end;
> -	u32 tmp;
>  	u32 features;
>
>  	/* Tell the host to map the magic page to -4096 on all CPUs */
>  	on_each_cpu(kvm_map_magic_page, &features, 1);
>
>  	/* Quick self-test to see if the mapping works */
> -	if (__get_user(tmp, (u32*)KVM_MAGIC_PAGE)) {
> +	if (!fault_in_pages_readable((const char *)KVM_MAGIC_PAGE, sizeof(u32))=
) {
>  		kvm_patching_worked =3D false;
>  		return;
>  	}
> --
> 2.11.0
