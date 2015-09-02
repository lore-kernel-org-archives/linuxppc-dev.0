Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4544A1A1E25
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 18:35:32 +1000 (AEST)
Subject: Re: [PATCH] KVM: ppc: Fix size of the PSPB register
To: Alexander Graf <agraf@suse.de>
References: <1441143678-14295-1-git-send-email-thuth@redhat.com>
 <1441146305.2668.51.camel@au1.ibm.com>
 <20150901224521.GC23007@fergus.ozlabs.ibm.com>
 <1441148107.2668.57.camel@au1.ibm.com> <55E6A48D.5070800@redhat.com>
 <334DA903-4793-45C4-9FCB-D9B022DE74A2@suse.de>
Cc: "benh@au1.ibm.com" <benh@au1.ibm.com>, Paul Mackerras <paulus@ozlabs.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 Alexander Graf <agraf@suse.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Andrew Jones <drjones@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <55E6B4CC.3040502@redhat.com>
Date: Wed, 2 Sep 2015 10:35:24 +0200
MIME-Version: 1.0
In-Reply-To: <334DA903-4793-45C4-9FCB-D9B022DE74A2@suse.de>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/09/15 10:26, Alexander Graf wrote:
> 
>> Am 02.09.2015 um 09:26 schrieb Thomas Huth <thuth@redhat.com>:
>>
>>> On 02/09/15 00:55, Benjamin Herrenschmidt wrote:
>>>> On Wed, 2015-09-02 at 08:45 +1000, Paul Mackerras wrote:
>>>> On Wed, Sep 02, 2015 at 08:25:05AM +1000, Benjamin Herrenschmidt
>>>> wrote:
>>>>> On Tue, 2015-09-01 at 23:41 +0200, Thomas Huth wrote:
>>>>>> The size of the Problem State Priority Boost Register is only
>>>>>> 32 bits, so let's change the type of the corresponding variable
>>>>>> accordingly to avoid future trouble.
>>>>>
>>>>> It's not future trouble, it's broken today for LE and this should
>>>>> fix
>>>>> it BUT ....
>>>>
>>>> No, it's broken today for BE hosts, which will always see 0 for the
>>>> PSPB register value.  LE hosts are fine.
>>
>> Right ... I just meant that nobody really experienced trouble with this
>> today yet, but the bug is already present now already of course.
> 
> Sounds like a great candidate for kvm-unit-tests then, no? ;)

I'm certainly looking forward to seeing powerpc support in there :-)

 Thomas
