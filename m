Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1F2042C02B5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2013 02:51:48 +1100 (EST)
Subject: Re: [PATCH 1/6 v8] iommu/fsl: Store iommu domain information pointer
 in archdata.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D3C26F6@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Thu, 28 Feb 2013 09:51:23 -0600
Message-Id: <BAB98EA5-5324-4FB2-97C2-A28A96C569DC@kernel.crashing.org>
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
 <1361191939-21260-2-git-send-email-Varun.Sethi@freescale.com>
 <20130227113045.GH26252@8bytes.org>
 <C5ECD7A89D1DC44195F34B25E172658D3C26F6@039-SN2MPN1-013.039d.mgd.msft.net>
To: Sethi Varun-B16395 <B16395@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Joerg Roedel <joro@8bytes.org>,
 "linux-kernel@vger.kernel.org list" <linux-kernel@vger.kernel.org>,
 Yoder Stuart-B08248 <B08248@freescale.com>, iommu@lists.linux-foundation.org,
 Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 27, 2013, at 6:04 AM, Sethi Varun-B16395 wrote:

> Hi Kumar,Ben,
> I am implementing the Freescale PAMU (IOMMU) driver using the Linux =
IOMMU API. In this particular patch, I have added a new field to =
dev_archdata structure to store the dma domain information.
> This field is updated whenever we attach a device to an iommu domain.
>=20
> Regards
> Varun

Would be good to see if this overlaps with Alexey's work for IOMMU =
driver for powernv.

- k

>=20
>> -----Original Message-----
>> From: Joerg Roedel [mailto:joro@8bytes.org]
>> Sent: Wednesday, February 27, 2013 5:01 PM
>> To: Sethi Varun-B16395
>> Cc: iommu@lists.linux-foundation.org; linuxppc-dev@lists.ozlabs.org;
>> linux-kernel@vger.kernel.org; Wood Scott-B07421; Yoder Stuart-B08248
>> Subject: Re: [PATCH 1/6 v8] iommu/fsl: Store iommu domain information
>> pointer in archdata.
>>=20
>> On Mon, Feb 18, 2013 at 06:22:14PM +0530, Varun Sethi wrote:
>>> Add a new field in the device (powerpc) archdata structure for =
storing
>>> iommu domain information pointer. This pointer is stored when the
>>> device is attached to a particular domain.
>>>=20
>>>=20
>>> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
>>> ---
>>> - no change.
>>> arch/powerpc/include/asm/device.h |    4 ++++
>>> 1 files changed, 4 insertions(+), 0 deletions(-)
>>>=20
>>> diff --git a/arch/powerpc/include/asm/device.h
>>> b/arch/powerpc/include/asm/device.h
>>> index 77e97dd..6dc79fe 100644
>>> --- a/arch/powerpc/include/asm/device.h
>>> +++ b/arch/powerpc/include/asm/device.h
>>> @@ -28,6 +28,10 @@ struct dev_archdata {
>>> 		void		*iommu_table_base;
>>> 	} dma_data;
>>>=20
>>> +	/* IOMMU domain information pointer. This would be set
>>> +	 * when this device is attached to an iommu_domain.
>>> +	 */
>>> +	void			*iommu_domain;
>>=20
>> Please Cc the PowerPC Maintainers on this, so that they can have a =
look
>> at it. This also must be put this into an #ifdef CONFIG_IOMMU_API.
>>=20
>>=20
>> 	Joerg
>>=20
>>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe =
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
