Return-Path: <sojkam1@fel.cvut.cz>
Received: from max.feld.cvut.cz (max.feld.cvut.cz [147.32.192.36])
 by lists.ozlabs.org (Postfix) with ESMTP id 3s8VC76Z9nzDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 22:02:43 +1000 (AEST)
From: Michal Sojka <sojkam1@fel.cvut.cz>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: MPC5200 does not boot
In-Reply-To: <1470116323.12584.11.camel@kernel.crashing.org>
References: <874m74w1m7.fsf@steelpick.2x.cz>
 <1470116323.12584.11.camel@kernel.crashing.org>
Date: Wed, 10 Aug 2016 12:52:57 +0200
Message-ID: <87twesq4ja.fsf@steelpick.2x.cz>
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

Hi all,

my MPC5200 still does not boot even with the fix bellow applied. I dug a
bit into it and now it seems that commit
309b315b6ec686ce050758cc4e29f6ad1125a83f is to blame.

commit 309b315b6ec686ce050758cc4e29f6ad1125a83f
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Sat Jul 23 14:42:38 2016 +0530

    powerpc: Call jump_label_init() in apply_feature_fixups()
=20=20=20=20
    Call jump_label_init() early so that we can use static keys for CPU and
    MMU feature checks.
=20=20=20=20
    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

The following summarizes the situation from my point of view:

1) My system does not boot with 9402c684613163888714df0955fa1f17142b08bf
   "powerpc: Factor do_feature_fixup calls"

2) When the fix bellow is applied on top of
   9402c684613163888714df0955fa1f17142b08bf my system boots.

3) My system does not boot 2c0f99516f53911c3f2f81ab3815841e3408f11e
   which is the mainline commit containing the fix below.

4) I bisected the commits between
   9402c684613163888714df0955fa1f17142b08bf and
   2c0f99516f53911c3f2f81ab3815841e3408f11e with manually applying the
   fix bellow and 309b315b6ec686ce050758cc4e29f6ad1125a83f was the first
   bad commit that didn't boot.

Let me know if you need more information.

Thanks.
-Michal

On Tue, Aug 02 2016, Benjamin Herrenschmidt wrote:
> On Tue, 2016-08-02 at 00:44 +0200, Michal Sojka wrote:
>> Hi Benjamin,
>>=20
>> the following commit causes my MPC5200 not to boot.
>>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0commit 9402c684613163888714df0955fa1f17142b08bf
>> =C2=A0=C2=A0=C2=A0=C2=A0Author: Benjamin Herrenschmidt <benh@kernel.cras=
hing.org>
>> =C2=A0=C2=A0=C2=A0=C2=A0Date:=C2=A0=C2=A0=C2=A0Tue Jul 5 15:03:41 2016 +=
1000
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0powerpc: Factor do_featu=
re_fixup calls
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A032 and 64-bit do a simil=
ar set of calls early on, we move it
>> all to
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0a single common function=
 to make the boot code more readable.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: Benjamin =
Herrenschmidt <benh@kernel.crashing.o
>> rg>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: Michael E=
llerman <mpe@ellerman.id.au>
>>=20
>> I suspect that the cause will be similar as described in commit
>> 1cd03890ea64795e53f17a94928cca22495acb2a. Unfortunately, I don't have
>> much time to debug this, but I can easily test patches.
>
> Does this fixes it for you ?
>
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
