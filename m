Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 0BE462C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Aug 2013 21:10:42 +1000 (EST)
Subject: Re: [PATCH] powerpc/kvm: Handle the boundary condition correctly
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <87wqn9dtbi.fsf@linux.vnet.ibm.com>
Date: Mon, 26 Aug 2013 13:10:33 +0200
Message-Id: <932EC6E7-BC15-474F-9E8B-4321B2126BE4@suse.de>
References: <1377171479-25738-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1683D101-052D-4BEB-8ED1-6F32C6904850@suse.de>
 <87haeh13s2.fsf@linux.vnet.ibm.com>
 <527D8312-EA18-4962-9069-B54FA738F5FA@suse.de>
 <87wqn9dtbi.fsf@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 26.08.2013, at 05:28, Aneesh Kumar K.V wrote:

> Alexander Graf <agraf@suse.de> writes:
>=20
>> On 23.08.2013, at 04:31, Aneesh Kumar K.V wrote:
>>=20
>>> Alexander Graf <agraf@suse.de> writes:
>>>=20
>>>> On 22.08.2013, at 12:37, Aneesh Kumar K.V wrote:
>>>>=20
>>>>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>>>>=20
>>>> Isn't this you?
>>>=20
>>> Yes. The patches are generated using git format-patch and sent by
>>> git send-email. That's how it always created patches for me. I am =
not sure if
>>> there is a config I can change to avoid having From:
>>>=20
>>>>=20
>>>>>=20
>>>>> We should be able to copy upto count bytes
>>>>=20
>>>> Why?
>>>>=20
>>>=20
>>> Without this we end up doing
>>>=20
>>> +    struct kvm_get_htab_buf {
>>> +        struct kvm_get_htab_header header;
>>> +        /*
>>> +         * Older kernel required one extra byte.
>>> +         */
>>> +        unsigned long hpte[3];
>>> +    } hpte_buf;
>>>=20
>>>=20
>>> even though we are only looking for one hpte entry.
>>=20
>> Ok, please give me an example with real numbers and why it breaks.
>>=20
>>>=20
>>> =
http://mid.gmane.org/1376995766-16526-4-git-send-email-aneesh.kumar@linux.=
vnet.ibm.com
>>>=20
>=20
> Didn't quiet get what you are looking for. As explained before, we now
> need to pass an array with array size 3 even though we know we need to
> read only 2 entries because kernel doesn't loop correctly.

But we need to do that regardless, because newer QEMU needs to be able =
to run on older kernels, no?


Alex
