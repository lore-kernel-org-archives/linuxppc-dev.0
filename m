Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 48D8EB71A1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Nov 2010 04:17:01 +1100 (EST)
Subject: Re: [PATCH] kgdb,
	ppc: Corrected the address using of current->thread.evr register
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4CE2FF5A.402@windriver.com>
Date: Wed, 17 Nov 2010 11:16:46 -0600
Message-Id: <983540C0-C0E6-44DB-9264-4A5B1E058043@kernel.crashing.org>
References: <1289912316-4580-1-git-send-email-dongdong.deng@windriver.com>
	<4CE2FF5A.402@windriver.com>
To: Jason Wessel <jason.wessel@windriver.com>
Cc: Dongdong Deng <dongdong.deng@windriver.com>,
	Sergei Shtylyov <sshtylyov@mvista.com>,
	kgdb-bugreport@lists.sourceforge.net, miltonm@bga.com, "Hai,
	Shan" <shan.hai@windriver.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 16, 2010, at 4:02 PM, Jason Wessel wrote:

> On 11/16/2010 06:58 AM, Dongdong Deng wrote:
>> Passing the address of current->thread.evr register to memcpy =
function.
>>=20
>>=20
>=20
> It turns out that out of all of my test configs and targets I did not
> have any that defined both CONFIG_FSL_BOOKE and CONFIG_SPE else this
> would have been caught in testing because will definitely crash
> dereferencing the contents of the evr registers.
>=20
>> Signed-off-by: Dongdong Deng <dongdong.deng@windriver.com>
>> CC: Hai Shan <shan.hai@windriver.com>
>> CC: Milton Miller <miltonm@bga.com>
>> CC: linuxppc-dev@lists.ozlabs.org
>> ---
>> arch/powerpc/kernel/kgdb.c |    4 ++--
>> 1 files changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
>> index 7a9db64..781acff 100644
>> --- a/arch/powerpc/kernel/kgdb.c
>> +++ b/arch/powerpc/kernel/kgdb.c
>> @@ -337,7 +337,7 @@ char *dbg_get_reg(int regno, void *mem, struct =
pt_regs *regs)
>> 		/* FP registers 32 -> 63 */
>> #if defined(CONFIG_FSL_BOOKE) && defined(CONFIG_SPE)
>> 		if (current)
>> -			memcpy(mem, current->thread.evr[regno-32],
>> +			memcpy(mem, (void =
*)&current->thread.evr[regno-32],
>> 					dbg_reg_def[regno].size);
>>=20
>=20
> As Sergei already pointed out, the (void *) casts should not be needed =
here.
>=20
> This would have been fixed correctly had I seen the compile warnings
> from the CONFIG_SPE at the test phase.   Namely at the compile phase
> doesn't even complete:
>=20
> arch/powerpc/kernel/kgdb.c: In function 'dbg_get_reg':
> arch/powerpc/kernel/kgdb.c:341: error: passing argument 2 of 'memcpy'
> makes pointer from integer without a cast
> arch/powerpc/include/asm/string.h:25: note: expected 'const void *' =
but
> argument is of type 'long unsigned int'
> arch/powerpc/kernel/kgdb.c: In function 'dbg_set_reg':
> arch/powerpc/kernel/kgdb.c:366: error: passing argument 1 of 'memcpy'
> makes pointer from integer without a cast
> arch/powerpc/include/asm/string.h:25: note: expected 'void *' but
> argument is of type 'long unsigned int'
>=20
>=20
> Moral of the story... I now have a board and config with the SPE =
turned
> on, and after boot testing confirmed the evr registers are working.
>=20
> I plan to have a pull request out to Linus with this fix and several
> other accumulated regression fixes sometime in the next 48 hours.
>=20
> Thanks,
> Jason.

Repost a version with the casts and I'll pick it up.

- k=
