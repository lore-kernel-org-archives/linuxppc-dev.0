Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F05CC1A007D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 16:52:30 +1000 (EST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 2/3] drivers/vfio: EEH support for VFIO PCI device
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1400815400.3289.436.camel@ul30vt.home>
Date: Fri, 23 May 2014 08:52:23 +0200
Message-Id: <22ECE7F7-2C1F-4E54-AD6B-0D2405357C9A@suse.de>
References: <1400747034-15045-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1400747034-15045-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <537DC991.9010401@suse.de> <20140523001730.GA12584@shangw>
 <20140523003737.GA15136@shangw> <1400815400.3289.436.camel@ul30vt.home>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "aik@ozlabs.ru" <aik@ozlabs.ru>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "qiudayu@linux.vnet.ibm.com" <qiudayu@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> Am 23.05.2014 um 05:23 schrieb Alex Williamson <alex.williamson@redhat.com=
>:
>=20
>> On Fri, 2014-05-23 at 10:37 +1000, Gavin Shan wrote:
>>> On Fri, May 23, 2014 at 10:17:30AM +1000, Gavin Shan wrote:
>>>> On Thu, May 22, 2014 at 11:55:29AM +0200, Alexander Graf wrote:
>>>> On 22.05.14 10:23, Gavin Shan wrote:
>>=20
>> .../...
>>=20
>>>>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>>>>> index cb9023d..ef55682 100644
>>>>> --- a/include/uapi/linux/vfio.h
>>>>> +++ b/include/uapi/linux/vfio.h
>>>>> @@ -455,6 +455,59 @@ struct vfio_iommu_spapr_tce_info {
>>>>> #define VFIO_IOMMU_SPAPR_TCE_GET_INFO    _IO(VFIO_TYPE, VFIO_BASE + 12=
)
>>>>> +/*
>>>>> + * EEH functionality can be enabled or disabled on one specific devic=
e.
>>>>> + * Also, the DMA or IO frozen state can be removed from the frozen PE=

>>>>> + * if required.
>>>>> + */
>>>>> +struct vfio_eeh_pe_set_option {
>>>>> +    __u32 argsz;
>>>>=20
>>>> What is this argsz thing? Is this your way of maintaining backwards
>>>> compatibility when we introduce new fields? A new field will change
>>>> the ioctl number, so I don't think that makes a lot of sense :).
>>>>=20
>>>> Just make the ioctl have a u32 as incoming argument. No fancy
>>>> structs, no complicated code.
>>>>=20
>>>> The same applies for a number of structs below.
>>>=20
>>> ok. Will do in next revision.
>>=20
>> Rechecked include/uapi/linux/vfio.h, the data struct for each ioctl comma=
nd
>> always has "argsz". I guess it was used as checker by Alex.W. Do you real=
ly
>> want remove "argsz" ?
>=20
>=20
> IIRC, this was actually a suggestion incorporated from David Gibson, but
> using _IO with an argsz and flags field we can maintain compatibility
> without bumping the ioctl number.  It really only makes sense if we have
> a flags field so we can identify what additional information is being
> provided.  Flags can be used as a bitmap of trailing structures or as
> revision if we want a set of trailing structures that may change over
> time.  Unless you can come up with a good argument against it that would
> prevent us inventing a new ioctl as soon as we need a minor tweak, I'd
> prefer to keep it.  As I noted in a previous comment, the one ioctl we
> have for reset that doesn't take any options is likely going to be the
> first ioctl that we need to entirely replace.  If we don't keep argsz,
> it seems like we probably need a flags field and reserved structures.
>=20
>>>>> +    __u32 option;
>>>>> +};
>>>>> +
>>>>> +#define VFIO_EEH_PE_SET_OPTION        _IO(VFIO_TYPE, VFIO_BASE + 21)
>>>>> +
>>>>> +/*
>>>>> + * Each EEH PE should have unique address to be identified. The comma=
nd
>>>>> + * helps to retrieve the address and the sharing mode of the PE.
>>>>> + */
>>>>> +struct vfio_eeh_pe_get_addr {
>>>>> +    __u32 argsz;
>>>>> +    __u32 option;
>>>>> +    __u32 info;
>>>>=20
>>>> Any particular reason you need the info field? Can't the return value
>>>> of the ioctl hold this? Then you only have a single u32 argument left
>>>> to the ioctl again.
>>>=20
>>> ok. Will do in next revision.
>>=20
>> If we eventually remove "argsz" and let ioctl() return value to hold
>> information (or negative number for errors), we don't need any data
>> struct because the 3rd parameter of ioctl() would be used as input
>> and I only need one input parameter. Do you want see this ?
>>=20
>> Hopefully, Alex.W saw this and hasn't objections :)
>=20
> I'm not sure why we're pushing for the minimal data set to pass to an
> ioctl.  Seems like a recipe for dead, useless ioctls.  Thanks,
>=20

The ioctl number includes sizeof(payload). So if a new parameter gets added,=
 that would be a different ioctl number.

If you want to maintain backwards compatibility ioctl number wise in the ker=
nel, you'll have to have a "flags" field to indicate whether new data is ava=
ilable and a "pad" field, prefarably in a union, that ensures the size of th=
e struct doesn't change.

I'm not sure it's really necessary here to have identical ioctl numbers if w=
e add parameters, since we can always just define a new ioctl with a bigger p=
ayload that can then become the default handler and a shim backwards compati=
ble handler with the old number.

But if you think it is important, let's do it for real, not just halfway.


Alex
