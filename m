Return-Path: <kernelfans@gmail.com>
Received: from mail-oa0-f41.google.com (mail-oa0-f41.google.com
 [209.85.219.41])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0708E140097
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Apr 2014 13:28:25 +1000 (EST)
Received: by mail-oa0-f41.google.com with SMTP id j17so3835528oag.14
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Apr 2014 20:28:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <53426385.2010102@suse.de>
References: <1390292129-15871-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <8761pdk6x5.fsf@linux.vnet.ibm.com>
 <C4D7ADEA-9CEB-4717-9AFD-CC8EFB18184A@suse.de>
 <CAFgQCTs8LSXUi+AwxR9j+2-QRGw4EFZWx-JxktAnJ3VvwLJb9A@mail.gmail.com>
 <533D47CD.906@suse.com> <87bnwdshzu.fsf@linux.vnet.ibm.com>
 <53426385.2010102@suse.de>
Date: Thu, 10 Apr 2014 11:28:22 +0800
Message-ID: <CAFgQCTtbxRYMBVQL5Fw0254sFAZ_HSzkAfiH0ppNXacRSmxu-w@mail.gmail.com>
Subject: Re: [PATCH v2] powernv: kvm: make _PAGE_NUMA take effect
From: Liu ping fan <kernelfans@gmail.com>
To: Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset=UTF-8
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

On Mon, Apr 7, 2014 at 4:36 PM, Alexander Graf <agraf@suse.de> wrote:
>
> On 07.04.14 09:42, Aneesh Kumar K.V wrote:
>>
>> Alexander Graf <agraf@suse.com> writes:
>>
>>> On 03.04.14 04:36, Liu ping fan wrote:
>>>>
>>>> Hi Alex, could you help to pick up this patch? since  v3.14 kernel can
>>>> enable numa fault for powerpc.
>>>
>>> What bad happens without this patch? We map a page even though it was
>>> declared to get NUMA migrated? What happens next?
>>
>> Nothing much, we won't be properly accounting the numa access in the
>> host.  What we want to achieve is to convert a guest access of the page to
>> a host fault so that we can do proper numa access accounting in the
>> host. This would enable us to migrate the page to the correct numa
>> node.
>
>
> Ok, so no breakages, just less performance. I wouldn't consider it stable
> material then :).
>
Sorry to reply late, since I am half out of office during this period.
I am puzzling about you reply.    Without this patch, the guest can
NOT sense the numa changes and ask host to put the pages in right
place.  So the pages which is used by guest will be always misplaced.
The numa-fault method is inspired by real requirement to improve
performance, so we should also consider the performance drop of guest.
Right?

Regards,
Fan

>
> Alex
>
