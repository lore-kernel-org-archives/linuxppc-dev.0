Return-Path: <B11780@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 48AF12C02F2
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Mar 2013 07:44:02 +1100 (EST)
Received: from mail221-va3 (localhost [127.0.0.1])	by
 mail221-va3-R.bigfish.com (Postfix) with ESMTP id 87F9C6400E5	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 20:43:56 +0000 (UTC)
Received: from VA3EHSMHS021.bigfish.com (unknown [10.7.14.250])	by
 mail221-va3.bigfish.com (Postfix) with ESMTP id 9F5D730005A	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 20:43:54 +0000 (UTC)
From: Gala Kumar-B11780 <B11780@freescale.com>
To: Lan Chunhe-B25806 <B25806@freescale.com>
Subject: Re: [PATCH] mmc: sdhci-pltfm: Fix timeout on t4240's sdhci controller
Date: Fri, 8 Mar 2013 20:43:49 +0000
Message-ID: <CF1EE7AED478CD48A05574C8E2DA142D748905@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1362643535-2377-1-git-send-email-Chunhe.Lan@freescale.com>
 <CF1EE7AED478CD48A05574C8E2DA142D746975@039-SN1MPN1-004.039d.mgd.msft.net>
 <513953B5.30707@freescale.com>
In-Reply-To: <513953B5.30707@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: Gala Kumar-B11780 <B11780@freescale.com>,
 "<linuxppc-dev@lists.ozlabs.org>" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 7, 2013, at 8:57 PM, Chunhe Lan wrote:

> On 03/08/2013 12:30 AM, Gala Kumar-B11780 wrote:
>> On Mar 7, 2013, at 2:05 AM, Chunhe Lan wrote:
>>=20
>>> This patch fixes timeout problems on t4240's sdhci controller:
>>>=20
>>> 	mmc0: Too large timeout requested for CMD25!
>>> 	mmc0: Too large timeout requested for CMD25!
>>> 	mmc0: Too large timeout requested for CMD25!
>>>=20
>>> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
>>> ---
>>> drivers/mmc/host/sdhci-pltfm.c |    1 +
>>> 1 files changed, 1 insertions(+), 0 deletions(-)
>>>=20
>>> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pl=
tfm.c
>>> index 3145a78..9db7b12 100644
>>> --- a/drivers/mmc/host/sdhci-pltfm.c
>>> +++ b/drivers/mmc/host/sdhci-pltfm.c
>>> @@ -94,6 +94,7 @@ void sdhci_get_of_property(struct platform_device *pd=
ev)
>>>=20
>>> 		if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
>>> 		    of_device_is_compatible(np, "fsl,p1010-esdhc") ||
>>> +		    of_device_is_compatible(np, "fsl,t4240-esdhc") ||
>>> 		    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
>>> 			host->quirks |=3D SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>>>=20
>>> --=20
>>> 1.7.6.5
>>>=20
>>=20
>> Why does this occur?  Is it a board issue?  Is it a silicon issue?  Is i=
t due to some erratum?  Why T4 only?
>     It would be the property of T4 hardware, and please see below the pat=
ch which locates
>     the mail list of freescale:
>=20
> eSDHC: mmc:host host need long time to generate command complete interrup=
t
>=20
> According to Spec 2.0, command complete interrupt will generate within 15=
0 SD-CLK.
> But this was not enough on T4240 board. So give it sufficient time to det=
ect command
> timeout. 1000 * HZ will be enough, this value was test on all T4 board, a=
ll worked well.
>=20
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>

I still don't understand the explanation of the issue on T4.  Why doesn't P=
4080, P5020, etc suffer from the issue?

- k=
