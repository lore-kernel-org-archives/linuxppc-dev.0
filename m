Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3FDD52C0090
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Dec 2013 17:38:14 +1100 (EST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] powerpc: book3s: kvm: Use the saved dsisr and dar values
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <8738lo9lzg.fsf@linux.vnet.ibm.com>
Date: Fri, 20 Dec 2013 07:38:05 +0100
Message-Id: <7E655340-6AF4-47C3-AB3A-331874F0ADB6@suse.de>
References: <1384178577-23721-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <0AB88010-F2B7-44A1-8FA9-2A40079706BB@suse.de>
 <87bo0d9vc5.fsf@linux.vnet.ibm.com>
 <CA6C7C49-C1EC-4277-9777-650026C9127D@suse.de>
 <8738lo9lzg.fsf@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org mailing list" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> Am 20.12.2013 um 05:37 schrieb "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet=
.ibm.com>:
>=20
> Alexander Graf <agraf@suse.de> writes:
>=20
>>> Am 19.12.2013 um 08:02 schrieb "Aneesh Kumar K.V" <aneesh.kumar@linux.vn=
et.ibm.com>:
>>>=20
>>> Alexander Graf <agraf@suse.de> writes:
>>>=20
>>>>> On 11.11.2013, at 15:02, Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm=
.com> wrote:
>>>>>=20
>>>>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>>>>>=20
>>>>> Don't try to compute these values.
>>>>>=20
>>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>>>> ---
>>>>>=20
>>>>> NOTE: I am not sure why we were originally computing dsisr and dar. So=
 may be
>>>>> we need a variant of this patch. But with this and the additional patc=
h
>>>>> "powerpc: book3s: PR: Enable Little Endian PR guest" I am able to get a=
 Little Endian
>>>>> PR guest to boot.
>>>>=20
>>>> It's quite easy to find out - git blame tells you all the history and p=
oints you to commit ca7f4203b.
>>>>=20
>>>> commit ca7f4203b9b66e12d0d9968ff7dfe781f3a9695a
>>>> Author: Alexander Graf <agraf@suse.de>
>>>> Date:   Wed Mar 24 21:48:28 2010 +0100
>>>>=20
>>>>   KVM: PPC: Implement alignment interrupt
>>>>=20
>>>>   Mac OS X has some applications - namely the Finder - that require ali=
gnment
>>>>   interrupts to work properly. So we need to implement them.
>>>>=20
>>>>   But the spec for 970 and 750 also looks different. While 750 requires=
 the
>>>>   DSISR and DAR fields to reflect some instruction bits (DSISR) and the=
 fault
>>>>   address (DAR), the 970 declares this as an optional feature. So we ne=
ed
>>>>   to reconstruct DSISR and DAR manually.
>>>>=20
>>>>   Signed-off-by: Alexander Graf <agraf@suse.de>
>>>>   Signed-off-by: Avi Kivity <avi@redhat.com>
>>>>=20
>>>> Read this as "on 970, alignment interrupts don't give us DSISR and DAR o=
f the faulting instruction" as otherwise I wouldn't have implemented it.
>>>>=20
>>>> So this is clearly a nack on this patch :).
>>>=20
>>> I can possibly do a if (cpu_has_feature(CPU_FTR_ARCH_201)). But do we ne=
ed
>>> to do that ? According to Paul we should always find DAR.
>>=20
>> Paul only mentioned DAR, not DSISR. Please verify whether 970 gives us a p=
roper DAR value - we can then remove that part.
>>=20
>> But for DSISR I'm not convinced CPUs above 970 handle this
>> correctly. So we would at least need a guest cpu check to find out
>> whether the vcpu expects a working dsisr and emulate it then.
>=20
>>=20
>> I don't really fully understand the problem though. Why does the
>> calculation break at all for you?
>=20
>=20
> IIRC this was to get little endian PR setup to work. This is to avoid
> handling new instructions, because in little endian mode we get
> alignment interrupt for a larger instructon set

Ok, please limit dar/dsisr calculation to book3s_32 vcpus then :).

Alex

>=20
> -aneesh
>=20
