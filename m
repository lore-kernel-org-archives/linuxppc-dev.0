Return-Path: <sojkam1@fel.cvut.cz>
Received: from max.feld.cvut.cz (max.feld.cvut.cz [147.32.192.36])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s3QG82N6kzDqQ1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 15:47:44 +1000 (AEST)
From: Michal Sojka <sojkam1@fel.cvut.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: MPC5200 does not boot
In-Reply-To: <1470116323.12584.11.camel@kernel.crashing.org>
References: <874m74w1m7.fsf@steelpick.2x.cz>
 <1470116323.12584.11.camel@kernel.crashing.org>
Date: Tue, 02 Aug 2016 07:47:39 +0200
Message-ID: <87y44fvi10.fsf@steelpick.2x.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 02 2016, Benjamin Herrenschmidt wrote:
> On Tue, 2016-08-02 at 00:44 +0200, Michal Sojka wrote:
>> Hi Benjamin,
>>=20
>> the following commit causes my MPC5200 not to boot.
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0commit 9402c684613163888714df0955fa1f17142b08bf
>
> Does this fixes it for you ?

Yes, it does.

Thanks.
-Michal


> diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature=
-fixups.c
> index defb299..fd36e13 100644
> --- a/arch/powerpc/lib/feature-fixups.c
> +++ b/arch/powerpc/lib/feature-fixups.c
> @@ -154,7 +154,7 @@ static void do_final_fixups(void)
>=20=20
>  void apply_feature_fixups(void)
>  {
> -	struct cpu_spec *spec =3D *PTRRELOC(&cur_cpu_spec);
> +	struct cpu_spec *spec =3D PTRRELOC(*PTRRELOC(&cur_cpu_spec));
>=20=20
>  	/*
>  	 * Apply the CPU-specific and firmware specific fixups to kernel text
