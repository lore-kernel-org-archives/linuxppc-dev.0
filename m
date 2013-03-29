Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E8B782C00D2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2013 08:55:31 +1100 (EST)
Date: Fri, 29 Mar 2013 16:55:22 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V2] powerpc/MPIC: Add get_version API both for internal
 and external use
To: Scott Wood <scottwood@freescale.com>
References: <1364275690-26790-1-git-send-email-hongtao.jia@freescale.com>
 <1364593919.13310.12@snotra>
In-Reply-To: <1364593919.13310.12@snotra> (from scottwood@freescale.com on
 Fri Mar 29 16:51:59 2013)
Message-ID: <1364594122.13310.14@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc-dev@lists.ozlabs.org, hongtao.jia@freescale.com,
 B07421@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/29/2013 04:51:59 PM, Scott Wood wrote:
> On 03/26/2013 12:28:10 AM, Jia Hongtao wrote:
>> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
>> index d30e6a6..c893a4b 100644
>> --- a/arch/powerpc/sysdev/mpic.c
>> +++ b/arch/powerpc/sysdev/mpic.c
>> @@ -1165,10 +1165,27 @@ static struct irq_domain_ops mpic_host_ops =3D =20
>> {
>>  	.xlate =3D mpic_host_xlate,
>>  };
>>=20
>> +static u32 mpic_get_version(struct mpic *mpic)
>> +{
>> +	u32 brr1;
>> +
>> +	brr1 =3D _mpic_read(mpic->reg_type, &mpic->thiscpuregs,
>> +			MPIC_FSL_BRR1);
>> +
>> +	return brr1 & MPIC_FSL_BRR1_VER;
>> +}
>> +
>>  /*
>>   * Exported functions
>>   */
>>=20
>> +u32 mpic_primary_get_version(void)
>> +{
>> +	struct mpic *mpic =3D mpic_primary;
>> +
>> +	return mpic_get_version(mpic);
>> +}
>=20
> So this just crashes if there is no mpic_primary or it's a non-FSL =20
> MPIC?

...and since it's specifically checking for the FSL version, "fsl" =20
should be in the name.

-Scott=
