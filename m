Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 0DF102C00D0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Oct 2013 09:59:12 +1000 (EST)
Subject: Re: [PATCH] kvm: powerpc: book3s: Fix build break for BOOK3S_32
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20131004234509.GB2256@iris.ozlabs.ibm.com>
Date: Sat, 5 Oct 2013 01:59:03 +0200
Message-Id: <FF88FE16-68D9-447E-8F42-CD18A3C81777@suse.de>
References: <1380724724-12892-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20131003041415.GA2801@iris.ozlabs.ibm.com>
 <EB193553-5B3C-4669-9C71-BACC6882D18B@suse.de>
 <36F00CBE-E313-465A-BD93-A8E1B96FD2A9@suse.de>
 <20131004123545.GC26884@iris.ozlabs.ibm.com>
 <1945837D-825F-4509-9D7C-D839917863A9@suse.de>
 <20131004234509.GB2256@iris.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 05.10.2013, at 01:45, Paul Mackerras wrote:

> On Fri, Oct 04, 2013 at 03:00:11PM +0200, Alexander Graf wrote:
>>=20
>> On 04.10.2013, at 14:35, Paul Mackerras wrote:
>>=20
>>> On Fri, Oct 04, 2013 at 02:27:02PM +0200, Alexander Graf wrote:
>>>>=20
>>>> On 04.10.2013, at 14:23, Alexander Graf wrote:
>>>>=20
>>>>>=20
>>>>> On 03.10.2013, at 06:14, Paul Mackerras wrote:
>>>>>=20
>>>>>> On Wed, Oct 02, 2013 at 08:08:44PM +0530, Aneesh Kumar K.V wrote:
>>>>>>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>>>>>>>=20
>>>>>>> This was introduced by 85a0d845d8bb5df5d2669416212f56cbe1474c6b
>>>>>>=20
>>>>>> It's a good idea to give the headline of the commit as well as =
the ID.
>>>>>> I also like to trim the ID to 10 characters or so.  So it should =
look
>>>>>> like this:
>>>>>>=20
>>>>>> This was introduced by 85a0d845d8 ("KVM: PPC: Book3S PR: Allocate
>>>>>> kvm_vcpu structs from kvm_vcpu_cache").
>>>>>>=20
>>>>>>> arch/powerpc/kvm/book3s_pr.c: In function =
'kvmppc_core_vcpu_create':
>>>>>>> arch/powerpc/kvm/book3s_pr.c:1182:30: error: 'struct =
kvmppc_vcpu_book3s' has no member named 'shadow_vcpu'
>>>>>>> make[1]: *** [arch/powerpc/kvm/book3s_pr.o] Error 1
>>>>>>>=20
>>>>>>> Signed-off-by: Aneesh Kumar K.V =
<aneesh.kumar@linux.vnet.ibm.com>
>>>>>>=20
>>>>>> Acked-by: Paul Mackerras <paulus@samba.org>
>>>>>=20
>>>>> Would you guys mind if I merge this into the offending patch? It's =
not trickled into -next yet, so rebasing should work.
>>>>>=20
>>>>> If not, please resend with the fixed commit message.
>>>>=20
>>>> Eh - I must've missed v2 :). So that leaves only the question on =
whether you'd be ok to squash the patch instead. It'd help =
bisectability.
>>>=20
>>> I'm OK with that.  If you do, why don't you squash the first of the
>>> two patches that I just sent into the commit it fixes as well?
>>=20
>> Because patch 1/2 spans two separate commits it would have to get =
squashed into (6aa82e, 70afec) and patch 2/2 doesn't make sense to get =
squashed anywhere :).
>=20
> Actually 70afec is fine, if you look at it, it's only 6aa82e that
> needs fixing.

True. Squashed them :).


Alex
