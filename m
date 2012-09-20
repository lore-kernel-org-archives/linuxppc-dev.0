Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1B43F2C0095
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2012 23:19:29 +1000 (EST)
Subject: Re: [RFC][PATCH 2/3] iommu/fsl: Add iommu domain attributes required
 by fsl PAMU driver.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <C5ECD7A89D1DC44195F34B25E172658D1A49A2@039-SN2MPN1-013.039d.mgd.msft.net>
Date: Thu, 20 Sep 2012 08:19:13 -0500
Message-Id: <84F4C3DA-4B61-4D1D-9FB3-B3F520BFE022@kernel.crashing.org>
References: <1348060632-12997-1-git-send-email-b16395@freescale.com>
 <1348060632-12997-3-git-send-email-b16395@freescale.com>
 <6B8A3365-C97E-4742-A0DD-D8FD6BA358EB@kernel.crashing.org>
 <1348099936.22800.21@snotra>
 <C5ECD7A89D1DC44195F34B25E172658D1A49A2@039-SN2MPN1-013.039d.mgd.msft.net>
To: Sethi Varun-B16395 <B16395@freescale.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "joerg.roedel@amd.com" <joerg.roedel@amd.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 20, 2012, at 4:46 AM, Sethi Varun-B16395 wrote:

>=20
>=20
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Thursday, September 20, 2012 5:42 AM
>> To: Kumar Gala
>> Cc: Sethi Varun-B16395; joerg.roedel@amd.com; iommu@lists.linux-
>> foundation.org; linuxppc-dev@lists.ozlabs.org; linux-
>> kernel@vger.kernel.org; Sethi Varun-B16395
>> Subject: Re: [RFC][PATCH 2/3] iommu/fsl: Add iommu domain attributes
>> required by fsl PAMU driver.
>>=20
>> On 09/19/2012 08:52:27 AM, Kumar Gala wrote:
>>>=20
>>> On Sep 19, 2012, at 8:17 AM, <b16395@freescale.com>
>>> <b16395@freescale.com> wrote:
>>>=20
>>>> From: Varun Sethi <Varun.Sethi@freescale.com>
>>>>=20
>>>> Added the following domain attributes required by FSL PAMU driver:
>>>> 1. Subwindows field added to the iommu domain geometry attribute.
>>>> 2. Added new iommu stash attribute, which allows setting of the
>>>>  LIODN specific stash id parameter through IOMMU API.
>>>> 3. Added an attribute for enabling/disabling DMA to a particular
>>>>  memory window.
>>>>=20
>>>> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
>>>> ---
>>>> include/linux/iommu.h |   30 ++++++++++++++++++++++++++++++
>>>> 1 files changed, 30 insertions(+), 0 deletions(-)
>>>>=20
>>>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h index
>>>> 7e83370..eaa40c6 100644
>>>> --- a/include/linux/iommu.h
>>>> +++ b/include/linux/iommu.h
>>>> @@ -44,6 +44,28 @@ struct iommu_domain_geometry {
>>>> 	dma_addr_t aperture_start; /* First address that can be
>>> mapped    */
>>>> 	dma_addr_t aperture_end;   /* Last address that can be
>>> mapped     */
>>>> 	bool force_aperture;       /* DMA only allowed in mappable
>>> range? */
>>>> +
>>>> +	/* The subwindows field indicates number of DMA subwindows
>>> supported
>>>> +	 * by the geometry. Following is the interpretation of
>>>> +	 * values for this field:
>>>> +	 * 0 : This implies that the supported geometry size is 1 MB
>>>> +         * with each subwindow size being 4KB. Thus number of
>>> subwindows
>>>> +	 * being =3D 1MB/4KB =3D 256.
>>>> +	 * 1 : Only one DMA window i.e. no subwindows.
>>>> +	 * value other than 0 or 1 would indicate actual number of
>>> subwindows.
>>>> +	 */
>>>> +	u32 subwindows;
>>>> +};
>>>> +
>>>> +/* This attribute corresponds to IOMMUs capable of generating
>>>> + * a stash transaction. A stash transaction is typically a
>>>> + * hardware initiated prefetch of data from memory to cache.
>>>> + * This attribute allows configuring stashig specific parameters
>>>> + * in the IOMMU hardware.
>>>> + */
>>>> +struct iommu_stash_attribute {
>>>> +	u32 	cpu;	/* cpu number */
>>>> +	u32 	cache;	/* cache to stash to: L1,L2,L3 */
>>>=20
>>> seems like this should be enum instead of u32 for cache
>>>=20
>>> With enum being something like:
>>>=20
>>> enum iommu_attr_stash_cache {
>>> 	IOMMU_ATTR_CACHE_L1,
>>> 	IOMMU_ATTR_CACHE_L2,
>>> 	IOMMU_ATTR_CACHE_L3,
>>> };
>>=20
>> Don't we want these structs to be usable via some VFIO ioctl?  In =
that
>> case they need to use fixed size types.
>>=20
> Yes, this would be usable via vfio ioctl. But, then the caller should =
be
> aware of supported stash targets. May be I should add an interface for =
the caller,
> to query supported stash targets.

Guess the caller probably knows, but thinking we should move the =
#defines for valid values into this file out of pamu specific files.

- k=
