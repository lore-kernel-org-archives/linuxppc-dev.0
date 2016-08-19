Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFtnK73k7zDqCZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 16:47:33 +1000 (AEST)
Message-ID: <1471589253.5780.122.camel@neuling.org>
Subject: Re: [PATCH v3 04/21] powerpc: Return the new MSR from
 msr_check_and_set()
From: Michael Neuling <mikey@neuling.org>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 wei.guo.simon@gmail.com
Cc: anton@samba.org
Date: Fri, 19 Aug 2016 16:47:33 +1000
In-Reply-To: <20160817034323.23053-5-cyrilbur@gmail.com>
References: <20160817034323.23053-1-cyrilbur@gmail.com>
 <20160817034323.23053-5-cyrilbur@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-08-17 at 13:43 +1000, Cyril Bur wrote:
> mfmsr() is a fairly expensive call and callers of msr_check_and_set()
> may want to make decisions bits in the MSR that it did not change but
> may not know the value of.

I can't grok this. =C2=A0Please reword.

Mikey

> This patch would avoid a two calls to mfmsr().
>=20
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
> =C2=A0arch/powerpc/include/asm/reg.h | 2 +-
> =C2=A0arch/powerpc/kernel/process.c=C2=A0=C2=A0| 4 +++-
> =C2=A02 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/reg.h
> b/arch/powerpc/include/asm/reg.h
> index f69f40f..0a3dde9 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -1247,7 +1247,7 @@ static inline void mtmsr_isync(unsigned long val)
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0: "memory")
> =C2=A0#endif
> =C2=A0
> -extern void msr_check_and_set(unsigned long bits);
> +extern unsigned long msr_check_and_set(unsigned long bits);
> =C2=A0extern bool strict_msr_control;
> =C2=A0extern void __msr_check_and_clear(unsigned long bits);
> =C2=A0static inline void msr_check_and_clear(unsigned long bits)
> diff --git a/arch/powerpc/kernel/process.c
> b/arch/powerpc/kernel/process.c
> index 82308fd..c42581b 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -110,7 +110,7 @@ static int __init enable_strict_msr_control(char
> *str)
> =C2=A0}
> =C2=A0early_param("ppc_strict_facility_enable", enable_strict_msr_control=
);
> =C2=A0
> -void msr_check_and_set(unsigned long bits)
> +unsigned long msr_check_and_set(unsigned long bits)
> =C2=A0{
> =C2=A0	unsigned long oldmsr =3D mfmsr();
> =C2=A0	unsigned long newmsr;
> @@ -124,6 +124,8 @@ void msr_check_and_set(unsigned long bits)
> =C2=A0
> =C2=A0	if (oldmsr !=3D newmsr)
> =C2=A0		mtmsr_isync(newmsr);
> +
> +	return newmsr;
> =C2=A0}
> =C2=A0
> =C2=A0void __msr_check_and_clear(unsigned long bits)
