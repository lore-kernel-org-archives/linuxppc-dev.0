Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C5181A1E28
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 17:26:12 +1000 (AEST)
Subject: Re: [PATCH] KVM: ppc: Fix size of the PSPB register
To: benh@au1.ibm.com, Paul Mackerras <paulus@ozlabs.org>
References: <1441143678-14295-1-git-send-email-thuth@redhat.com>
 <1441146305.2668.51.camel@au1.ibm.com>
 <20150901224521.GC23007@fergus.ozlabs.ibm.com>
 <1441148107.2668.57.camel@au1.ibm.com>
Cc: kvm-ppc@vger.kernel.org, Alexander Graf <agraf@suse.com>,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
From: Thomas Huth <thuth@redhat.com>
Message-ID: <55E6A48D.5070800@redhat.com>
Date: Wed, 2 Sep 2015 09:26:05 +0200
MIME-Version: 1.0
In-Reply-To: <1441148107.2668.57.camel@au1.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/09/15 00:55, Benjamin Herrenschmidt wrote:
> On Wed, 2015-09-02 at 08:45 +1000, Paul Mackerras wrote:
>> On Wed, Sep 02, 2015 at 08:25:05AM +1000, Benjamin Herrenschmidt
>> wrote:
>>> On Tue, 2015-09-01 at 23:41 +0200, Thomas Huth wrote:
>>>> The size of the Problem State Priority Boost Register is only
>>>> 32 bits, so let's change the type of the corresponding variable
>>>> accordingly to avoid future trouble.
>>>
>>> It's not future trouble, it's broken today for LE and this should
>>> fix
>>> it BUT ....
>>
>> No, it's broken today for BE hosts, which will always see 0 for the
>> PSPB register value.  LE hosts are fine.

Right ... I just meant that nobody really experienced trouble with this
today yet, but the bug is already present now already of course.

>>> The asm accesses it using lwz/stw and C accesses it as a ulong. On
>>> LE
>>> that will mean that userspace will see the value << 32
>>
>> No, that will happen on BE, and since KVM_REG_PPC_PSPB says it's a
>> 32-bit register, we'll just pass 0 back to userspace when it reads
>> it.
> 
> Ah ok, I missed that bit about KVM_REG_PPC_PSPB
> 
>>> Now "fixing" it might break migration if that field is already
>>> stored/loaded in its "broken" form. We may have to keep the
>>> "broken"
>>> behaviour and document that qemu sees a value shifted by 32.
>>
>> It will be being set to 0 on BE hosts across migration today
>> (fortunately 0 is a benign value for PSPB).  If we fix this on both
>> the source and destination host, then the value will get migrated
>> across correctly.
> 
> Ok, I missed the part where KVM_REG_PPC_PSPB passed it down as a 32
> -bit. That means Thomas patch should work indeed.

... and if I get the QEMU source code right, the register is currently
not migrated at all - or at least I was not able to find the spot in the
source code that migrates this register.

>> I think Thomas's patch is fine, it just needs a stronger patch
>> description saying that it fixes an actual bug.

Ok, I'll resend with a better patch description.

 Thomas
