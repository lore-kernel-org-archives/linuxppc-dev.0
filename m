Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Bqcv4rHZzF1Yx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2018 03:16:31 +1100 (AEDT)
Date: Thu, 29 Mar 2018 18:16:09 +0200
Message-ID: <20180329181609.Horde.TWj0eWAkAjHcBe3PlwHHEQ6@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Mathieu Malaterre <malat@debian.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Paul
 Mackerras <paulus@samba.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 05/19] powerpc/chrp/setup: Add attribute unused and
 make some functions static
References: <20180322202007.23088-6-malat@debian.org>
 <20180328193553.1122-1-malat@debian.org>
In-Reply-To: <20180328193553.1122-1-malat@debian.org>
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

The subject of the patch should be updated as well

Christophe


Mathieu Malaterre <malat@debian.org> a =C3=A9crit=C2=A0:

> Remove variable declaration idu_size and associated code since not used.
>
> These functions can all be static, make it so. Fix warnings treated as
> errors with W=3D1:
>
>   arch/powerpc/platforms/chrp/setup.c:97:6: error: no previous=20=20
>=20prototype for =E2=80=98chrp_show_cpuinfo=E2=80=99 [-Werror=3Dmissing-pr=
ototypes]
>   arch/powerpc/platforms/chrp/setup.c:302:13: error: no previous=20=20
>=20prototype for =E2=80=98chrp_setup_arch=E2=80=99 [-Werror=3Dmissing-prot=
otypes]
>   arch/powerpc/platforms/chrp/setup.c:385:16: error: variable=20=20
>=20=E2=80=98idu_size=E2=80=99 set but not used [-Werror=3Dunused-but-set-v=
ariable]
>   arch/powerpc/platforms/chrp/setup.c:526:13: error: no previous=20=20
>=20prototype for =E2=80=98chrp_init_IRQ=E2=80=99 [-Werror=3Dmissing-protot=
ypes]
>   arch/powerpc/platforms/chrp/setup.c:559:1: error: no previous=20=20
>=20prototype for =E2=80=98chrp_init2=E2=80=99 [-Werror=3Dmissing-prototype=
s]
>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v2: Remove totally variable idu_size
>  arch/powerpc/platforms/chrp/setup.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/platforms/chrp/setup.c=20=20
>=20b/arch/powerpc/platforms/chrp/setup.c
> index 481ed133e04b..d6d8ffc0271e 100644
> --- a/arch/powerpc/platforms/chrp/setup.c
> +++ b/arch/powerpc/platforms/chrp/setup.c
> @@ -94,7 +94,7 @@ static const char *chrp_names[] =3D {
>  	"Total Impact Briq"
>  };
>
> -void chrp_show_cpuinfo(struct seq_file *m)
> +static void chrp_show_cpuinfo(struct seq_file *m)
>  {
>  	int i, sdramen;
>  	unsigned int t;
> @@ -299,7 +299,7 @@ static __init void chrp_init(void)
>  	of_node_put(node);
>  }
>
> -void __init chrp_setup_arch(void)
> +static void __init chrp_setup_arch(void)
>  {
>  	struct device_node *root =3D of_find_node_by_path("/");
>  	const char *machine =3D NULL;
> @@ -382,7 +382,7 @@ static void __init chrp_find_openpic(void)
>  {
>  	struct device_node *np, *root;
>  	int len, i, j;
> -	int isu_size, idu_size;
> +	int isu_size;
>  	const unsigned int *iranges, *opprop =3D NULL;
>  	int oplen =3D 0;
>  	unsigned long opaddr;
> @@ -427,11 +427,9 @@ static void __init chrp_find_openpic(void)
>  	}
>
>  	isu_size =3D 0;
> -	idu_size =3D 0;
>  	if (len > 0 && iranges[1] !=3D 0) {
>  		printk(KERN_INFO "OpenPIC irqs %d..%d in IDU\n",
>  		       iranges[0], iranges[0] + iranges[1] - 1);
> -		idu_size =3D iranges[1];
>  	}
>  	if (len > 1)
>  		isu_size =3D iranges[3];
> @@ -523,7 +521,7 @@ static void __init chrp_find_8259(void)
>  	}
>  }
>
> -void __init chrp_init_IRQ(void)
> +static void __init chrp_init_IRQ(void)
>  {
>  #if defined(CONFIG_VT) && defined(CONFIG_INPUT_ADBHID) &&=20=20
>=20defined(CONFIG_XMON)
>  	struct device_node *kbd;
> @@ -555,7 +553,7 @@ void __init chrp_init_IRQ(void)
>  #endif
>  }
>
> -void __init
> +static void __init
>  chrp_init2(void)
>  {
>  #ifdef CONFIG_NVRAM
> --
> 2.11.0
