Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSpSv4KpVzDsNK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Sep 2016 11:11:11 +1000 (AEST)
Message-ID: <1473124271.6491.37.camel@neuling.org>
Subject: Re: [PATCH 2/4] powerpc/mm/radix: Use different RTS encoding for
 different POWER9 revs
From: Michael Neuling <mikey@neuling.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 06 Sep 2016 11:11:11 +1000
In-Reply-To: <1472031219-18759-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1472031219-18759-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1472031219-18759-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

On Wed, 2016-08-24 at 15:03 +0530, Aneesh Kumar K.V wrote:
> POWER9 DD1 uses RTS - 28 for the RTS value but other revisions use
> RTS - 31.=C2=A0=C2=A0This makes this distinction for the different revisi=
ons
>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Acked-by: Michael Neuling <mikey@neuling.org>

> ---
> =C2=A0arch/powerpc/include/asm/book3s/64/radix.h | 13 +++++++++----
> =C2=A01 file changed, 9 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/in=
clude/asm/book3s/64/radix.h
> index df294224e280..a2fe8fbfbd3d 100644
> --- a/arch/powerpc/include/asm/book3s/64/radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/radix.h
> @@ -233,14 +233,19 @@ static inline unsigned long radix__get_tree_size(vo=
id)
> =C2=A0{
> =C2=A0	unsigned long rts_field;
> =C2=A0	/*
> -	=C2=A0* we support 52 bits, hence 52-31 =3D 21, 0b10101
> +	=C2=A0* We support 52 bits, hence:
> +	=C2=A0*=C2=A0=C2=A0DD1=C2=A0=C2=A0=C2=A0=C2=A052-28 =3D 24, 0b11000
> +	=C2=A0*=C2=A0=C2=A0Others 52-31 =3D 21, 0b10101
> =C2=A0	=C2=A0* RTS encoding details
> =C2=A0	=C2=A0* bits 0 - 3 of rts -> bits 6 - 8 unsigned long
> =C2=A0	=C2=A0* bits 4 - 5 of rts -> bits 62 - 63 of unsigned long
> =C2=A0	=C2=A0*/
> -	rts_field =3D (0x5UL << 5); /* 6 - 8 bits */
> -	rts_field |=3D (0x2UL << 61);
> -
> +	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
> +		rts_field =3D (0x3UL << 61);
> +	else {
> +		rts_field =3D (0x5UL << 5); /* 6 - 8 bits */
> +		rts_field |=3D (0x2UL << 61);
> +	}
> =C2=A0	return rts_field;
> =C2=A0}
> =C2=A0#endif /* __ASSEMBLY__ */
