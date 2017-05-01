Return-Path: <roy.pledge@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0043.outbound.protection.outlook.com [104.47.1.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGtz92vLGzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 May 2017 05:00:20 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: Scott Wood <oss@buserror.net>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>
CC: Madalin-Cristian Bucur <madalin.bucur@nxp.com>
Subject: Re: [PATCH v2 07/11] soc/fsl/qbman: Rework ioremap() calls for ARM/PPC
Date: Mon, 1 May 2017 19:00:14 +0000
Message-ID: <VI1PR04MB3216F7EC8657711225E30AAC86140@VI1PR04MB3216.eurprd04.prod.outlook.com>
References: <1492634930-10765-1-git-send-email-roy.pledge@nxp.com>
 <1492634930-10765-8-git-send-email-roy.pledge@nxp.com>
 <1492998461.25397.16.camel@buserror.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 4/23/2017 9:47 PM, Scott Wood wrote:=0A=
> On Wed, 2017-04-19 at 16:48 -0400, Roy Pledge wrote:=0A=
>> Rework ioremap() for PPC and ARM. The PPC devices require a=0A=
>> non-coherent mapping while ARM will work with a non-cachable/write=0A=
>> combine mapping.=0A=
>>=0A=
>> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>=0A=
>> ---=0A=
>>  drivers/soc/fsl/qbman/bman_portal.c | 16 +++++++++++++---=0A=
>>  drivers/soc/fsl/qbman/qman_portal.c | 16 +++++++++++++---=0A=
>>  2 files changed, 26 insertions(+), 6 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/soc/fsl/qbman/bman_portal.c=0A=
>> b/drivers/soc/fsl/qbman/bman_portal.c=0A=
>> index 8354d4d..a661f30 100644=0A=
>> --- a/drivers/soc/fsl/qbman/bman_portal.c=0A=
>> +++ b/drivers/soc/fsl/qbman/bman_portal.c=0A=
>> @@ -125,7 +125,18 @@ static int bman_portal_probe(struct platform_device=
=0A=
>> *pdev)=0A=
>>  	}=0A=
>>  	pcfg->irq =3D irq;=0A=
>>  =0A=
>> -	va =3D ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]),=
=0A=
>> 0);=0A=
>> +#ifdef CONFIG_PPC=0A=
>> +	/* PPC requires a cacheable/non-coherent mapping of the portal */=0A=
>> +	va =3D ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]),=
=0A=
>> +			  (pgprot_val(PAGE_KERNEL) & ~_PAGE_COHERENT));=0A=
>> +#else=0A=
>> +	/*=0A=
>> +	 * For ARM we can use write combine mapping.  A cacheable/non=0A=
>> shareable=0A=
>> +	 * mapping will perform better but equires additional platform=0A=
>> +	 * support which is not currently available=0A=
>> +	 */=0A=
> s/equires/requires/=0A=
>=0A=
> Would be nice to describe the platform support that is required.=0A=
Thanks for your feedback Scott, going to try to get a v3 of this set=0A=
ASAP. I think I will remove the=0A=
above statement for now.  We did send patches for do non-shareable=0A=
support on DPAA2 and there was significant feedback so I'm in the=0A=
process of discussing the issue with SOC architects here.  We will=0A=
follow up with ARM folks on this eventually but I'd like to get the=0A=
basic DPAA1 support in before adding the more advanced features.=0A=
=0A=
Roy=0A=
>=0A=
> -Scott=0A=
>=0A=
>=0A=
=0A=
