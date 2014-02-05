Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 316912C0096
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Feb 2014 20:15:58 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [RFC PATCH 01/10] KVM: PPC: BOOK3S: PR: Fix PURR and SPURR
 emulation
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20140131221743.GA12086@iris.ozlabs.ibm.com>
Date: Wed, 5 Feb 2014 10:15:47 +0100
Message-Id: <046680B9-2422-4F19-85D7-6F9CF8BF6835@suse.de>
References: <1390927455-3312-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1390927455-3312-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <52E92D15.8000901@suse.de> <87y51wjv0w.fsf@linux.vnet.ibm.com>
 <5C99D2BA-7E11-4012-B3BD-9B01F4F865ED@suse.de>
 <20140131221743.GA12086@iris.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 kvm-ppc <kvm-ppc@vger.kernel.org>, kvm-devel <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 31.01.2014, at 23:17, Paul Mackerras <paulus@samba.org> wrote:

> On Fri, Jan 31, 2014 at 11:47:44AM +0100, Alexander Graf wrote:
>>=20
>> On 31.01.2014, at 11:38, Aneesh Kumar K.V =
<aneesh.kumar@linux.vnet.ibm.com> wrote:
>>=20
>>> Alexander Graf <agraf@suse.de> writes:
>>>=20
>>>> On 01/28/2014 05:44 PM, Aneesh Kumar K.V wrote:
>>>>> We definitely don't need to emulate mtspr, because both the =
registers
>>>>> are hypervisor resource.
>>>>=20
>>>> This patch description doesn't cover what the patch actually does. =
It=20
>>>> changes the implementation from "always tell the guest it uses =
100%" to=20
>>>> "give the guest an accurate amount of cpu time spent inside guest
>>>> context".
>>>=20
>>> Will fix that
>>>=20
>>>>=20
>>>> Also, I think we either go with full hyp semantics which means we =
also=20
>>>> emulate the offset or we go with no hyp awareness in the guest at =
all=20
>>>> which means we also don't emulate SPURR which is a hyp privileged
>>>> register.
>>>=20
>>> Can you clarify this ?
>>=20
>> In the 2.06 ISA SPURR is hypervisor privileged. That changed for 2.07 =
where it became supervisor privileged. So I suppose your patch is ok. =
When reviewing those patches I only had 2.06 around because power.org =
was broken.
>=20
> It's always been supervisor privilege for reading and hypervisor
> privilege for writing, ever since it was introduced in 2.05, and that
> hasn't changed.  So I think what Aneesh is doing is correct.

This is what ISA 2.06B says:

308	SPURR	hypv		hypv		64	S
309	PURR	hypv		yes		64	S

And this is ISA 2.07:

308	SPURR	hypv		yes		64	S
309	PURR	hypv		yes		64	S

So as you can see, from 2.06 to 2.07 SPURR became supervisor readable. =
Either the spec is wrong, the respective POWER CPUs don't implement the =
spec correctly or "hypv" doesn't mean "hypv" but means "may be hypv or =
yes".

I think in the context of this patch it's perfectly reasonable to treat =
SPURR as supervisor readable.


Alex
