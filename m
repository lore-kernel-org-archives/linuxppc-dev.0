Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 721121A0010
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 20:37:37 +1000 (EST)
Message-ID: <53ABF7E9.7040104@suse.de>
Date: Thu, 26 Jun 2014 12:37:29 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/3] Prepare for in-kernel VFIO DMA operations acceleration
References: <1401953144-19186-1-git-send-email-aik@ozlabs.ru>
 <53905B14.5020204@suse.de> <5391094D.7090104@ozlabs.ru>
 <53AB3B28.3040708@suse.de> <53AB625A.5040305@ozlabs.ru>
In-Reply-To: <53AB625A.5040305@ozlabs.ru>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 26.06.14 01:59, Alexey Kardashevskiy wrote:
> On 06/26/2014 07:12 AM, Alexander Graf wrote:
>> On 06.06.14 02:20, Alexey Kardashevskiy wrote:
>>> On 06/05/2014 09:57 PM, Alexander Graf wrote:
>>>> On 05.06.14 09:25, Alexey Kardashevskiy wrote:
>>>>> This reserves 2 capability numbers.
>>>>>
>>>>> This implements an extended version of KVM_CREATE_SPAPR_TCE_64 ioctl.
>>>>>
>>>>> Please advise how to proceed with these patches as I suspect that
>>>>> first two should go via Paolo's tree while the last one via Alex Graf's
>>>>> tree
>>>>> (correct?).
>>>> They would just go via my tree, but only be actually allocated (read:
>>>> mergable to qemu) when they hit Paolo's tree.
>>>>
>>>> In fact, I don't think it makes sense to split them off at all.
>>> So? Are these patches going anywhere? Thanks.
>> So? Are you going to address the comments?
> Sorry, I cannot find here anything to fix. Ben asked some questions, I
> answered and there were no objections. What do I miss this time?...

> >> In fact, the code as is today can allocate an arbitrary amount of pinned
> >> kernel memory from within user space without any checks.
> >
> > Right. We should at least account it in the locked limit.
>
> Yup. And (probably) this thing will keep a counter of how many windows were
> created per KVM instance to avoid having multiple copies of the same table.


Alex
