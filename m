Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMpzl0p4rzDqHG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 15:17:39 +1100 (AEDT)
Message-ID: <1487045859.21048.27.camel@neuling.org>
Subject: Re: [PATCH 3/3] powerpc/mm/radix: Skip ptesync in pte update helpers
From: Michael Neuling <mikey@neuling.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 14 Feb 2017 15:17:39 +1100
In-Reply-To: <1486609101-5231-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1486609101-5231-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1486609101-5231-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On Thu, 2017-02-09 at 08:28 +0530, Aneesh Kumar K.V wrote:
> We do them at the start of tlb flush, and we are sure a pte update will b=
e
> followed by a tlbflush. Hence we can skip the ptesync in pte update helpe=
rs.
>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Tested-by: Michael Neuling <mikey@neuling.org>

> ---
> =C2=A0arch/powerpc/include/asm/book3s/64/radix.h | 3 ---
> =C2=A01 file changed, 3 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/book3s/64/radix.h
> b/arch/powerpc/include/asm/book3s/64/radix.h
> index fcf822d6c204..77e590c77299 100644
> --- a/arch/powerpc/include/asm/book3s/64/radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/radix.h
> @@ -144,13 +144,11 @@ static inline unsigned long radix__pte_update(struc=
t
> mm_struct *mm,
> =C2=A0		=C2=A0* new value of pte
> =C2=A0		=C2=A0*/
> =C2=A0		new_pte =3D (old_pte | set) & ~clr;
> -		asm volatile("ptesync" : : : "memory");
> =C2=A0		radix__flush_tlb_pte_p9_dd1(old_pte, mm, addr);
> =C2=A0		if (new_pte)
> =C2=A0			__radix_pte_update(ptep, 0, new_pte);
> =C2=A0	} else
> =C2=A0		old_pte =3D __radix_pte_update(ptep, clr, set);
> -	asm volatile("ptesync" : : : "memory");
> =C2=A0	if (!huge)
> =C2=A0		assert_pte_locked(mm, addr);
> =C2=A0
> @@ -195,7 +193,6 @@ static inline void radix__ptep_set_access_flags(struc=
t
> mm_struct *mm,
> =C2=A0		unsigned long old_pte, new_pte;
> =C2=A0
> =C2=A0		old_pte =3D __radix_pte_update(ptep, ~0, 0);
> -		asm volatile("ptesync" : : : "memory");
> =C2=A0		/*
> =C2=A0		=C2=A0* new value of pte
> =C2=A0		=C2=A0*/
