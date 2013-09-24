Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AE2DC2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2013 01:48:58 +1000 (EST)
Subject: Re: [PATCH v4 1/4] powerpc/fsl: add E6500 PVR and SPRN_PWRMGTCR0
 define
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D0717DD00@039-SN2MPN1-011.039d.mgd.msft.net>
Date: Tue, 24 Sep 2013 10:48:45 -0500
Message-Id: <D3D5E237-6C31-424C-A340-E79F6AF5B0B2@kernel.crashing.org>
References: <1380014871-22937-1-git-send-email-dongsheng.wang@freescale.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0717DD00@039-SN2MPN1-011.039d.mgd.msft.net>
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Wang Dongsheng-B40534 <B40534@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 24, 2013, at 6:21 AM, Bhushan Bharat-R65777 wrote:

>=20
>=20
>> -----Original Message-----
>> From: Linuxppc-dev [mailto:linuxppc-dev-
>> bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.org] On Behalf Of =
Dongsheng
>> Wang
>> Sent: Tuesday, September 24, 2013 2:58 PM
>> To: Wood Scott-B07421
>> Cc: linuxppc-dev@lists.ozlabs.org; Wang Dongsheng-B40534
>> Subject: [PATCH v4 1/4] powerpc/fsl: add E6500 PVR and SPRN_PWRMGTCR0 =
define
>>=20
>> From: Wang Dongsheng <dongsheng.wang@freescale.com>
>>=20
>> E6500 PVR and SPRN_PWRMGTCR0 will be used in subsequent pw20/altivec =
idle
>> patches.
>>=20
>> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
>> ---
>> *v3:
>> Add bit definitions for PWRMGTCR0.
>>=20
>> arch/powerpc/include/asm/reg.h       | 2 ++
>> arch/powerpc/include/asm/reg_booke.h | 9 +++++++++
>> 2 files changed, 11 insertions(+)
>>=20
>> diff --git a/arch/powerpc/include/asm/reg.h =
b/arch/powerpc/include/asm/reg.h
>> index 64264bf..d4160ca 100644
>> --- a/arch/powerpc/include/asm/reg.h
>> +++ b/arch/powerpc/include/asm/reg.h
>> @@ -1053,6 +1053,8 @@
>> #define PVR_8560	0x80200000
>> #define PVR_VER_E500V1	0x8020
>> #define PVR_VER_E500V2	0x8021
>> +#define PVR_VER_E6500	0x8040
>> +
>> /*
>>  * For the 8xx processors, all of them report the same PVR family for
>>  * the PowerPC core. The various versions of these processors must be =
diff --
>> git a/arch/powerpc/include/asm/reg_booke.h
>> b/arch/powerpc/include/asm/reg_booke.h
>> index ed8f836..4a6457e 100644
>> --- a/arch/powerpc/include/asm/reg_booke.h
>> +++ b/arch/powerpc/include/asm/reg_booke.h
>> @@ -170,6 +170,7 @@
>> #define SPRN_L2CSR1	0x3FA	/* L2 Data Cache Control and Status =
Register 1
>> */
>> #define SPRN_DCCR	0x3FA	/* Data Cache Cacheability Register */
>> #define SPRN_ICCR	0x3FB	/* Instruction Cache Cacheability =
Register */
>> +#define SPRN_PWRMGTCR0	0x3FB	/* Power management control =
register 0 */
>=20
> Is this generic for booke or e6500 specific? I can't see this register =
either in ISA and EREF.
> Also I can see SPRN_ICCR also with same SPRN, how that is possible?

Its possibly because the register maybe in implementation specific =
region.  I'm guessing ICCR is a 40x specific register.

- k
