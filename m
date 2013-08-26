Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1EA302C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Aug 2013 22:14:17 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 26 Aug 2013 17:35:07 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 0161D1258052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Aug 2013 17:43:54 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7QCFeeZ24969432
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Aug 2013 17:45:40 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7QCE2L1012181
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Aug 2013 17:44:03 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] powerpc/kvm: Handle the boundary condition correctly
In-Reply-To: <932EC6E7-BC15-474F-9E8B-4321B2126BE4@suse.de>
References: <1377171479-25738-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1683D101-052D-4BEB-8ED1-6F32C6904850@suse.de>
 <87haeh13s2.fsf@linux.vnet.ibm.com>
 <527D8312-EA18-4962-9069-B54FA738F5FA@suse.de>
 <87wqn9dtbi.fsf@linux.vnet.ibm.com>
 <932EC6E7-BC15-474F-9E8B-4321B2126BE4@suse.de>
Date: Mon, 26 Aug 2013 17:44:01 +0530
Message-ID: <87k3j8ejjq.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 26.08.2013, at 05:28, Aneesh Kumar K.V wrote:
>
>> Alexander Graf <agraf@suse.de> writes:
>> 
>>> On 23.08.2013, at 04:31, Aneesh Kumar K.V wrote:
>>> 
>>>> Alexander Graf <agraf@suse.de> writes:
>>>> 
>>>>> On 22.08.2013, at 12:37, Aneesh Kumar K.V wrote:
>>>>> 
>>>>>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>>>>> 
>>>>> Isn't this you?
>>>> 
>>>> Yes. The patches are generated using git format-patch and sent by
>>>> git send-email. That's how it always created patches for me. I am not sure if
>>>> there is a config I can change to avoid having From:
>>>> 
>>>>> 
>>>>>> 
>>>>>> We should be able to copy upto count bytes
>>>>> 
>>>>> Why?
>>>>> 
>>>> 
>>>> Without this we end up doing
>>>> 
>>>> +    struct kvm_get_htab_buf {
>>>> +        struct kvm_get_htab_header header;
>>>> +        /*
>>>> +         * Older kernel required one extra byte.
>>>> +         */
>>>> +        unsigned long hpte[3];
>>>> +    } hpte_buf;
>>>> 
>>>> 
>>>> even though we are only looking for one hpte entry.
>>> 
>>> Ok, please give me an example with real numbers and why it breaks.
>>> 
>>>> 
>>>> http://mid.gmane.org/1376995766-16526-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com
>>>> 
>> 
>> Didn't quiet get what you are looking for. As explained before, we now
>> need to pass an array with array size 3 even though we know we need to
>> read only 2 entries because kernel doesn't loop correctly.
>
> But we need to do that regardless, because newer QEMU needs to be able to run on older kernels, no?
>

yes. So use space will have to pass an array of size 3. But that should
not prevent us from fixing this right ?

-aneesh
