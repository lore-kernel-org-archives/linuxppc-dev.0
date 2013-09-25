Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 422E92C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 01:52:05 +1000 (EST)
Subject: Re: [PATCH] powerpc/kvm: Handle the boundary condition correctly
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <87vc1odi10.fsf@linux.vnet.ibm.com>
Date: Wed, 25 Sep 2013 17:51:58 +0200
Message-Id: <9E72F2C3-04DB-4B0B-B195-2E3442981BB7@suse.de>
References: <1377171479-25738-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1683D101-052D-4BEB-8ED1-6F32C6904850@suse.de>
 <87haeh13s2.fsf@linux.vnet.ibm.com>
 <527D8312-EA18-4962-9069-B54FA738F5FA@suse.de>
 <87wqn9dtbi.fsf@linux.vnet.ibm.com>
 <932EC6E7-BC15-474F-9E8B-4321B2126BE4@suse.de>
 <87k3j8ejjq.fsf@linux.vnet.ibm.com> <87vc1odi10.fsf@linux.vnet.ibm.com>
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


On 25.09.2013, at 17:42, Aneesh Kumar K.V wrote:

>=20
> Hi Alex,
>=20
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>>>>> Ok, please give me an example with real numbers and why it breaks.
>>>>>=20
>>>>>>=20
>>>>>> =
http://mid.gmane.org/1376995766-16526-4-git-send-email-aneesh.kumar@linux.=
vnet.ibm.com
>>>>>>=20
>>>>=20
>>>> Didn't quiet get what you are looking for. As explained before, we =
now
>>>> need to pass an array with array size 3 even though we know we need =
to
>>>> read only 2 entries because kernel doesn't loop correctly.
>>>=20
>>> But we need to do that regardless, because newer QEMU needs to be =
able to run on older kernels, no?
>>>=20
>>=20
>> yes. So use space will have to pass an array of size 3. But that =
should
>> not prevent us from fixing this right ?
>>=20
>=20
> Do we still want this patch or should I drop this ?

If we really want it we need to be able to tell user space that we =
support this feature through a CAP, so that it can act accordingly. =
Given the additional complexity of this and the fact that we do want to =
support older KVM versions regardless, I don't think it's worth the =
hassle.


Alex
