Return-Path: <baltoo@gmail.com>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5F018B6F7B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jul 2011 17:38:21 +1000 (EST)
Received: by vxb40 with SMTP id 40so3627655vxb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jul 2011 00:38:16 -0700 (PDT)
MIME-Version: 1.0
Sender: baltoo@gmail.com
In-Reply-To: <20110711143859.0e6c95d8@schlenkerla.am.freescale.net>
References: <CABkP77e6vLmLxk3wCP39GJ7+yKnJZFc7BPUZ1OkdA8d7KkBCiw@mail.gmail.com>
	<20110711143859.0e6c95d8@schlenkerla.am.freescale.net>
Date: Tue, 12 Jul 2011 09:38:16 +0200
Message-ID: <CABkP77d8K1Of7jw8hpyi_XG+xorZ8OKkgoGfSy9_zh7iSq5kFA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/85xx: fix mpic configuration in CAMP mode
From: Fabio Baltieri <fabio.baltieri@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Poonam Aggrwal <poonam.aggrwal@freescale.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 11, 2011 at 9:38 PM, Scott Wood <scottwood@freescale.com> wrote=
:
> On Sun, 10 Jul 2011 20:55:32 +0200
> Fabio Baltieri <fabio.baltieri@gmail.com> wrote:
>
>> Change the string to check for CAMP mode boot on MPC85xx (eg. P2020) to =
match
>> the one in the corresponding dts files (p2020rdb_camp_core{0,1}.dts).
>>
>> Without this fix the mpic is configured as in the SMP boot mode, which c=
auses
>> the first core to report a protected source interrupt error for devices
>> of the other core and lock up.
>>
>> Signed-off-by: Fabio Baltieri <fabio.baltieri@gmail.com>
>> ---
>> =A0arch/powerpc/platforms/85xx/mpc85xx_rdb.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
>> b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
>> index 088f30b..a1e5e70 100644
>> --- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
>> +++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
>> @@ -58,7 +58,7 @@ void __init mpc85xx_rdb_pic_init(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 if (of_flat_dt_is_compatible(root, "fsl,85XXRDB-CAMP")) {
>> + =A0 =A0 if (of_flat_dt_is_compatible(root, "fsl,MPC85XXRDB-CAMP")) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mpic =3D mpic_alloc(np, r.start,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MPIC_PRIMARY |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MPIC_BIG_ENDIAN | MPIC_BROKE=
N_FRR_NIRQS,
>
> Shouldn't we be setting MPIC_SINGLE_DEST_CPU in this case (as we do for
> the other case)?
>
> Or just drop this and specify pic-no-reset in the mpic node.

Yeah, seems like a good idea. I still prefer to leave the
MPIC_WANTS_RESET for the default case (SMP mode), which I think is
what most people are using.

I'm sending a v2 of the patch, thanks!

--=20
Fabio Baltieri
