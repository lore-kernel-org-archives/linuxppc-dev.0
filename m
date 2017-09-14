Return-Path: <roy.pledge@nxp.com>
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-eopbgr50082.outbound.protection.outlook.com [40.107.5.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtRsq2Dx3zDqHc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 04:30:20 +1000 (AEST)
From: Roy Pledge <roy.pledge@nxp.com>
To: Catalin Marinas <catalin.marinas@arm.com>
CC: Leo Li <leoyang.li@nxp.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "mark.rutland@arm.com"
 <mark.rutland@arm.com>, "arnd@arndb.de" <arnd@arndb.de>, "Madalin-cristian
 Bucur" <madalin.bucur@nxp.com>, "linux@armlinux.org.uk"
 <linux@armlinux.org.uk>, "oss@buserror.net" <oss@buserror.net>, "Claudiu
 Manoil" <claudiu.manoil@nxp.com>
Subject: Re: [v4 05/11] soc/fsl/qbman: Drop L1_CACHE_BYTES compile time check
Date: Thu, 14 Sep 2017 18:30:14 +0000
Message-ID: <DB6PR04MB2999FB14FAF5F663C7E02680866F0@DB6PR04MB2999.eurprd04.prod.outlook.com>
References: <1503607075-28970-1-git-send-email-roy.pledge@nxp.com>
 <1503607075-28970-6-git-send-email-roy.pledge@nxp.com>
 <20170914134916.evw2mhjhxa6zo72x@localhost>
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

On 9/14/2017 9:49 AM, Catalin Marinas wrote:=0A=
> On Thu, Aug 24, 2017 at 04:37:49PM -0400, Roy Pledge wrote:=0A=
>> From: Claudiu Manoil <claudiu.manoil@nxp.com>=0A=
>>=0A=
>> Not relevant and arch dependent. Overkill for PPC.=0A=
>>=0A=
>> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>=0A=
>> Signed-off-by: Roy Pledge <roy.pledge@nxp.com>=0A=
>> ---=0A=
>>   drivers/soc/fsl/qbman/dpaa_sys.h | 4 ----=0A=
>>   1 file changed, 4 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/soc/fsl/qbman/dpaa_sys.h b/drivers/soc/fsl/qbman/dp=
aa_sys.h=0A=
>> index 2ce394a..f85c319 100644=0A=
>> --- a/drivers/soc/fsl/qbman/dpaa_sys.h=0A=
>> +++ b/drivers/soc/fsl/qbman/dpaa_sys.h=0A=
>> @@ -49,10 +49,6 @@=0A=
>>   #define DPAA_PORTAL_CE 0=0A=
>>   #define DPAA_PORTAL_CI 1=0A=
>>   =0A=
>> -#if (L1_CACHE_BYTES !=3D 32) && (L1_CACHE_BYTES !=3D 64)=0A=
>> -#error "Unsupported Cacheline Size"=0A=
>> -#endif=0A=
> =0A=
> Maybe this check was for a reason on PPC as it uses WB memory mappings=0A=
> for some of the qbman descriptors (which IIUC fit within a cacheline).=0A=
> You could add a check for CONFIG_PPC if you think there is any chance of=
=0A=
> this constant going higher.=0A=
> =0A=
=0A=
No, the reason PPC needs WB (technically any cacheable mapping) is that =0A=
the QBMan block on those parts will raise an error IRQ if it sees any =0A=
transaction less than cacheline size.  We know that this cannot happen =0A=
on PPC parts with QBMan when there is a cacheable mapping because we =0A=
also developed the interconnect for everything that has a QBMan block.=0A=
=0A=
We dropped the check for L1_CACHE_BYTES due to the value being set to =0A=
128 on ARM64 even on parts that has smaller caches. I don't think there =0A=
is much to worry about here as cacheline size isn't something SW =0A=
controls in any case. If we produce a part with QBMan that has a larger =0A=
cache granularity we will need to address that in other parts of the =0A=
code as well. The check was in the code for PPC as a sanity check but =0A=
since the value isn't (in my opinion) meaningful on ARM we can remove it =
=0A=
to avoid problems.=0A=
=0A=
