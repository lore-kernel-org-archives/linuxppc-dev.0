Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Gtzn1BT0zF1bH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Apr 2018 17:01:57 +1000 (AEST)
Date: Thu, 05 Apr 2018 09:01:44 +0200
Message-ID: <20180405090144.Horde.MbhP02FnROsZKa5LclAqgA6@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH v2 03/19] powerpc: Mark variables as unused
References: <20180322202007.23088-4-malat@debian.org>
 <20180328193307.978-1-malat@debian.org>
 <20180329181422.Horde.4gvIQbpSZkuyC4Yzg06PKw2@messagerie.si.c-s.fr>
 <87fu4atct4.fsf@concordia.ellerman.id.au>
In-Reply-To: <87fu4atct4.fsf@concordia.ellerman.id.au>
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

Michael Ellerman <mpe@ellerman.id.au> a =C3=A9crit=C2=A0:

> LEROY Christophe <christophe.leroy@c-s.fr> writes:
>
>> Mathieu Malaterre <malat@debian.org> a =C3=A9crit=C2=A0:
>>
>>> Add gcc attribute unused for two variables. Fix warnings treated as err=
ors
>>> with W=3D1:
>>>
>>>   arch/powerpc/kernel/prom_init.c:1388:8: error: variable =E2=80=98path=
=E2=80=99 set
>>> but not used [-Werror=3Dunused-but-set-variable]
>>>
>>> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>>> ---
>>> v2: move path within ifdef DEBUG_PROM
>>>
>>>  arch/powerpc/kernel/prom_init.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kernel/prom_init.c
>>> b/arch/powerpc/kernel/prom_init.c
>>> index acf4b2e0530c..4163b11abb6c 100644
>>> --- a/arch/powerpc/kernel/prom_init.c
>>> +++ b/arch/powerpc/kernel/prom_init.c
>>> @@ -603,7 +603,7 @@ static void __init early_cmdline_parse(void)
>>>  	const char *opt;
>>>
>>>  	char *p;
>>> -	int l =3D 0;
>>> +	int l __maybe_unused =3D 0;
>>>
>>>  	prom_cmd_line[0] =3D 0;
>>>  	p =3D prom_cmd_line;
>>> @@ -1385,7 +1385,7 @@ static void __init reserve_mem(u64 base, u64 size=
)
>>>  static void __init prom_init_mem(void)
>>>  {
>>>  	phandle node;
>>> -	char *path, type[64];
>>> +	char *path __maybe_unused, type[64];
>>
>> You should enclose that in an ifdef DEBUG_PROM instead of hiding the war=
ning
>
> I disagree, the result is horrible:
>
>  static void __init prom_init_mem(void)
>  {
> 	phandle node;
> -	char *path, type[64];
> +#ifdef DEBUG_PROM
> +	char *path;
> +#endif
> +	char type[64];
> 	unsigned int plen;
> 	cell_t *p, *endp;
> 	__be32 val;
>
>
> The right fix is to move the debug logic into a helper, and put the path
> in there, eg. something like (not tested):
>
> diff --git a/arch/powerpc/kernel/prom_init.c=20=20
>=20b/arch/powerpc/kernel/prom_init.c
> index f9d6befb55a6..b02fa2ccc70b 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -1389,6 +1389,18 @@ static void __init reserve_mem(u64 base, u64 size)
>  	mem_reserve_cnt =3D cnt + 1;
>  }
>
> +#ifdef DEBUG_PROM
> +static void prom_debug_path(phandle node)
> +{
> +	char *path;
> +	path =3D prom_scratch;
> +	memset(path, 0, PROM_SCRATCH_SIZE);
> +	call_prom("package-to-path", 3, 1, node, path, PROM_SCRATCH_SIZE-1);
> +	prom_debug("  node %s :\n", path);
> +}
> +#else
> +static void prom_debug_path(phandle node) { }

Or put the ifdef inside the function to avoid double definition ?

> +#endif /* DEBUG_PROM */
>  /*
>   * Initialize memory allocation mechanism, parse "memory" nodes and
>   * obtain that way the top of memory and RMO to setup out local allocato=
r
> @@ -1441,11 +1453,7 @@ static void __init prom_init_mem(void)
>  		p =3D regbuf;
>  		endp =3D p + (plen / sizeof(cell_t));
>
> -#ifdef DEBUG_PROM
> -		memset(path, 0, PROM_SCRATCH_SIZE);
> -		call_prom("package-to-path", 3, 1, node, path, PROM_SCRATCH_SIZE-1);
> -		prom_debug("  node %s :\n", path);
> -#endif /* DEBUG_PROM */
> +		prom_debug_path(node);
>
>  		while ((endp - p) >=3D (rac + rsc)) {
>  			unsigned long base, size;
>
>
> Although that also begs the question of why the hell do we need path at
> all, and not just use prom_scratch directly?

Wondering the same, why not use prom_scratch directly

Christophe

>
> cheers
