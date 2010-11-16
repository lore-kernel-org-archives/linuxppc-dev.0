Return-Path: <haishan.bai@gmail.com>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) by ozlabs.org (Postfix) with ESMTP id 514AFB7114
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Nov 2010 00:16:51 +1100 (EST)
Received: by gxk3 with SMTP id 3so330351gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Nov 2010 05:16:49 -0800 (PST)
Subject: Re: Corrected data type mismatch
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: bhs <haishan.bai@gmail.com>
In-Reply-To: <4CE27404.7020307@windriver.com>
Date: Tue, 16 Nov 2010 21:16:36 +0800
Message-Id: <029A97EE-F051-4E8A-93E9-C259D2A7622E@gmail.com>
References: <1289700419-11072-2-git-send-email-shan.hai@windriver.com>
	<mdm-kgbd-badfix@mdm.bga.com> <4CE27404.7020307@windriver.com>
To: DDD <dongdong.deng@windriver.com>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Milton Miller <miltonm@bga.com>, Hai Shan <shan.hai@windriver.com>,
	Jason Wessel <jason.wessel@windriver.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 16, 2010, at 8:07 PM, DDD wrote:

> Milton Miller wrote:
>> [added cc's based on from ff10b88b5a05c8f1646dd15fb9f6093c1384ff6d,
>> which added the patched line ]
>> https://patchwork.kernel.org/patch/323022/
>> On Sun, 14 Nov 2010 around 02:06:59 -0000, Hai Shan wrote:
>>> Corrected data type mismatch
>>>=20
>> This merely hides the type mismatch by force casting it.
>> Looking at the context I believe the intent is to copy the the value =
to
>> or from the register content slot, not take the previous value of the
>> register and use that as an address to copy to or from.
>=20
>=20
> OOPS! It is wrong here, The right one should be as following:
>=20
> -   memcpy(mem, current->thread.evr[regno-32],
> +   memcpy(mem, (void*)&current->thread.evr[regno-32], =
dbg_reg_def[regno].size);
>=20
> Thanks milton & Shan.Hai, I will send out the fix to Jason ASAP.
>=20


Sorry for my crude fix :)


> Dongdong
>=20
>=20
>> milton
>>> Signed-off-by: Hai Shan <shan.hai@windriver.com>
>>>=20
>>> ---
>>> arch/powerpc/kernel/kgdb.c |    4 ++--
>>> 1 files changed, 2 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
>>> index 7a9db64..c5ce65f 100644
>>> --- a/arch/powerpc/kernel/kgdb.c
>>> +++ b/arch/powerpc/kernel/kgdb.c
>>> @@ -337,7 +337,7 @@ char *dbg_get_reg(int regno, void *mem, struct =
pt_regs *regs)
>>> 		/* FP registers 32 -> 63 */
>>> #if defined(CONFIG_FSL_BOOKE) && defined(CONFIG_SPE)
>>> 		if (current)
>>> -			memcpy(mem, current->thread.evr[regno-32],
>>> +			memcpy(mem, (void =
*)current->thread.evr[regno-32],
>>> 					dbg_reg_def[regno].size);
>>> #else
>>> 		/* fp registers not used by kernel, leave zero */
>>> @@ -362,7 +362,7 @@ int dbg_set_reg(int regno, void *mem, struct =
pt_regs *regs)
>>> 	if (regno >=3D 32 && regno < 64) {
>>> 		/* FP registers 32 -> 63 */
>>> #if defined(CONFIG_FSL_BOOKE) && defined(CONFIG_SPE)
>>> -		memcpy(current->thread.evr[regno-32], mem,
>>> +		memcpy((void *)current->thread.evr[regno-32], mem,
>>> 				dbg_reg_def[regno].size);
>>> #else
>>> 		/* fp registers not used by kernel, leave zero */
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe =
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
