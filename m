Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6C8AE2C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 21:47:48 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [RFC PATCH 01/10] KVM: PPC: BOOK3S: PR: Fix PURR and SPURR
 emulation
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <87y51wjv0w.fsf@linux.vnet.ibm.com>
Date: Fri, 31 Jan 2014 11:47:44 +0100
Message-Id: <5C99D2BA-7E11-4012-B3BD-9B01F4F865ED@suse.de>
References: <1390927455-3312-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1390927455-3312-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <52E92D15.8000901@suse.de> <87y51wjv0w.fsf@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc <kvm-ppc@vger.kernel.org>, kvm-devel <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 31.01.2014, at 11:38, Aneesh Kumar K.V =
<aneesh.kumar@linux.vnet.ibm.com> wrote:

> Alexander Graf <agraf@suse.de> writes:
>=20
>> On 01/28/2014 05:44 PM, Aneesh Kumar K.V wrote:
>>> We definitely don't need to emulate mtspr, because both the =
registers
>>> are hypervisor resource.
>>=20
>> This patch description doesn't cover what the patch actually does. It=20=

>> changes the implementation from "always tell the guest it uses 100%" =
to=20
>> "give the guest an accurate amount of cpu time spent inside guest
>> context".
>=20
> Will fix that
>=20
>>=20
>> Also, I think we either go with full hyp semantics which means we =
also=20
>> emulate the offset or we go with no hyp awareness in the guest at all=20=

>> which means we also don't emulate SPURR which is a hyp privileged
>> register.
>=20
> Can you clarify this ?

In the 2.06 ISA SPURR is hypervisor privileged. That changed for 2.07 =
where it became supervisor privileged. So I suppose your patch is ok. =
When reviewing those patches I only had 2.06 around because power.org =
was broken.


Alex
