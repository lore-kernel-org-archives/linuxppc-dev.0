Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 408911400E0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 20:02:41 +1000 (EST)
Message-ID: <53466C3A.5070204@suse.de>
Date: Thu, 10 Apr 2014 12:02:34 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Liu ping fan <kernelfans@gmail.com>
Subject: Re: [PATCH v2] powernv: kvm: make _PAGE_NUMA take effect
References: <1390292129-15871-1-git-send-email-pingfank@linux.vnet.ibm.com>	<8761pdk6x5.fsf@linux.vnet.ibm.com>	<C4D7ADEA-9CEB-4717-9AFD-CC8EFB18184A@suse.de>	<CAFgQCTs8LSXUi+AwxR9j+2-QRGw4EFZWx-JxktAnJ3VvwLJb9A@mail.gmail.com>	<533D47CD.906@suse.com>	<87bnwdshzu.fsf@linux.vnet.ibm.com>	<53426385.2010102@suse.de>
 <CAFgQCTtbxRYMBVQL5Fw0254sFAZ_HSzkAfiH0ppNXacRSmxu-w@mail.gmail.com>
In-Reply-To: <CAFgQCTtbxRYMBVQL5Fw0254sFAZ_HSzkAfiH0ppNXacRSmxu-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: kvm-devel <kvm@vger.kernel.org>, kvm-ppc <kvm-ppc@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 10.04.14 05:28, Liu ping fan wrote:
> On Mon, Apr 7, 2014 at 4:36 PM, Alexander Graf <agraf@suse.de> wrote:
>> On 07.04.14 09:42, Aneesh Kumar K.V wrote:
>>> Alexander Graf <agraf@suse.com> writes:
>>>
>>>> On 03.04.14 04:36, Liu ping fan wrote:
>>>>> Hi Alex, could you help to pick up this patch? since  v3.14 kernel can
>>>>> enable numa fault for powerpc.
>>>> What bad happens without this patch? We map a page even though it was
>>>> declared to get NUMA migrated? What happens next?
>>> Nothing much, we won't be properly accounting the numa access in the
>>> host.  What we want to achieve is to convert a guest access of the page to
>>> a host fault so that we can do proper numa access accounting in the
>>> host. This would enable us to migrate the page to the correct numa
>>> node.
>>
>> Ok, so no breakages, just less performance. I wouldn't consider it stable
>> material then :).
>>
> Sorry to reply late, since I am half out of office during this period.
> I am puzzling about you reply.    Without this patch, the guest can
> NOT sense the numa changes and ask host to put the pages in right
> place.  So the pages which is used by guest will be always misplaced.
> The numa-fault method is inspired by real requirement to improve
> performance, so we should also consider the performance drop of guest.
> Right?

The patch will get into Linux, I just consider a non-working new feature 
not a regression that warrants us to CC stable@vger :). After all 
performance shouldn't be worse than without the numa migration feature, 
correct?


Alex
