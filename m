Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A02401A0174
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 14:19:11 +1100 (AEDT)
Received: by mail-pa0-x229.google.com with SMTP id ho8so108167191pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 19:19:11 -0800 (PST)
Subject: Re: [kernel] powerpc: Make vmalloc_to_phys() public
To: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <1453361708-19422-1-git-send-email-aik@ozlabs.ru>
 <20160125054603.5D55B140326@ozlabs.org>
 <20160125100609.GA24295@fergus.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <56A83728.4090601@ozlabs.ru>
Date: Wed, 27 Jan 2016 14:19:04 +1100
MIME-Version: 1.0
In-Reply-To: <20160125100609.GA24295@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/25/2016 09:06 PM, Paul Mackerras wrote:
> On Mon, Jan 25, 2016 at 04:46:03PM +1100, Michael Ellerman wrote:
>> On Thu, 2016-21-01 at 07:35:08 UTC, Alexey Kardashevskiy wrote:
>>> This makes vmalloc_to_phys() public as there will be another user
>>> (in-kernel VFIO acceleration) for it soon.
>>>
>>> As a part of future little optimization, this changes the helper to call
>>> vmalloc_to_pfn() instead of vmalloc_to_page() as the size of the
>>> struct page may not be power-of-two aligned which will make gcc use
>>> multiply instructions instead of shifts.
>>
>> You should also mention why you need to export it, presumably because whatever
>> new user you have in mind can be built as a module.
>
> If I remember correctly, it's the *existing* user in hv-24x7.c that
> needs the export.

No, CONFIG_HV_PERF_CTRS (which controls hv-24x7.c) is "bool" so today 
hv-24x7.c cannot compile as a module.

This exports the vmalloc_to_phys() symbol as a new user is going to be KVM 
which can compile as a module.


-- 
Alexey
