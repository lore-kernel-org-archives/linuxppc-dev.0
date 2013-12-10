Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id DF9A52C0393
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Dec 2013 09:53:49 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1812\))
Subject: Re: [PATCH] KVM: PPC: Use schedule instead of cond_resched
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <877gbcsn81.fsf@linux.vnet.ibm.com>
Date: Tue, 10 Dec 2013 18:00:00 +0100
Message-Id: <782C5119-BD6F-4C57-838A-076A7CC884C6@suse.de>
References: <1386685284-3862-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <C3F93DB3-202A-427D-A7B6-A868F3743507@suse.de>
 <877gbcsn81.fsf@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org,
 "kvm@vger.kernel.org mailing list" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 10.12.2013, at 17:08, Aneesh Kumar K.V =
<aneesh.kumar@linux.vnet.ibm.com> wrote:

> Alexander Graf <agraf@suse.de> writes:
>=20
>> On 10.12.2013, at 15:21, Aneesh Kumar K.V =
<aneesh.kumar@linux.vnet.ibm.com> wrote:
>>=20
>>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>>>=20
>>> We already checked need_resched. So we can call schedule directly
>>>=20
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>=20
>> The real fix for the issue you're seeing is
>>=20
>>  https://lkml.org/lkml/2013/11/28/241
>=20
> True, I mentioned that in the thread
>=20
> https://lkml.org/lkml/2013/12/9/64
>=20
> But do we need to do cond_resched after we checked for need_resched() =
?

This is really just copying the logic from kvm_resched() from =
virt/kvm/kvm_main.c. And I'd prefer not to diverge from that. I do agree =
that there's a good chance we don't need it, as it seems to predate =
preempt notifiers:

  =
https://git.kernel.org/cgit/virt/kvm/kvm.git/commit/?id=3D3fca03653010b8c5=
fa63b99fc94c78cbfb433d00

But this is a discussion that should occur on the non-ppc specific code =
first :).


Alex
