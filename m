Return-Path: <borntraeger@de.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7DC6E1A0204
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 08:53:46 +1100 (AEDT)
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Tue, 2 Feb 2016 21:53:41 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 89D6D2190046
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2016 21:53:25 +0000 (GMT)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u12LrccH4194814
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Feb 2016 21:53:38 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u12Lrb4v020575
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Feb 2016 16:53:38 -0500
Subject: Re: [PATCH v3 2/3] x86: query dynamic DEBUG_PAGEALLOC setting
To: David Rientjes <rientjes@google.com>
References: <1453889401-43496-1-git-send-email-borntraeger@de.ibm.com>
 <1453889401-43496-3-git-send-email-borntraeger@de.ibm.com>
 <alpine.DEB.2.10.1601271414180.23510@chino.kir.corp.google.com>
 <56A9E3D1.3090001@de.ibm.com>
 <alpine.DEB.2.10.1601281500160.31035@chino.kir.corp.google.com>
 <alpine.DEB.2.10.1602021351290.4977@chino.kir.corp.google.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org, x86@kernel.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, davej@codemonkey.org.uk
From: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <56B12560.4010201@de.ibm.com>
Date: Tue, 2 Feb 2016 22:53:36 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1602021351290.4977@chino.kir.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/02/2016 10:51 PM, David Rientjes wrote:
> On Thu, 28 Jan 2016, David Rientjes wrote:
> 
>> On Thu, 28 Jan 2016, Christian Borntraeger wrote:
>>
>>> Indeed, I only touched the identity mapping and dump stack.
>>> The question is do we really want to change free_init_pages as well?
>>> The unmapping during runtime causes significant overhead, but the
>>> unmapping after init imposes almost no runtime overhead. Of course,
>>> things get fishy now as what is enabled and what not.
>>>
>>> Kconfig after my patch "mm/debug_pagealloc: Ask users for default setting of debug_pagealloc"
>>> (in mm) now states
>>> ----snip----
>>> By default this option will have a small overhead, e.g. by not
>>> allowing the kernel mapping to be backed by large pages on some
>>> architectures. Even bigger overhead comes when the debugging is
>>> enabled by DEBUG_PAGEALLOC_ENABLE_DEFAULT or the debug_pagealloc
>>> command line parameter.
>>> ----snip----
>>>
>>> So I am tempted to NOT change free_init_pages, but the x86 maintainers
>>> can certainly decide differently. Ingo, Thomas, H. Peter, please advise.
>>>
>>
>> I'm sorry, but I thought the discussion of the previous version of the 
>> patchset led to deciding that all CONFIG_DEBUG_PAGEALLOC behavior would be 
>> controlled by being enabled on the commandline and checked with 
>> debug_pagealloc_enabled().
>>
>> I don't think we should have a CONFIG_DEBUG_PAGEALLOC that does some stuff 
>> and then a commandline parameter or CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT 
>> to enable more stuff.  It should either be all enabled by the commandline 
>> (or config option) or split into a separate entity.  
>> CONFIG_DEBUG_PAGEALLOC_LIGHT and CONFIG_DEBUG_PAGEALLOC would be fine, but 
>> the current state is very confusing about what is being done and what 
>> isn't.
>>
> 
> Ping?
> 
https://lkml.org/lkml/2016/1/29/266 
?
