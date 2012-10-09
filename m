Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 64C002C008D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2012 10:53:04 +1100 (EST)
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id C7F543EE0C1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2012 08:53:00 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id A824145DE55
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2012 08:53:00 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 8D48C45DE50
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2012 08:53:00 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 7745F1DB8038
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2012 08:53:00 +0900 (JST)
Received: from g01jpexchkw24.g01.fujitsu.local
 (g01jpexchkw24.g01.fujitsu.local [10.0.193.107])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 32243E08002
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2012 08:53:00 +0900 (JST)
Message-ID: <5074B8B5.3010307@jp.fujitsu.com>
Date: Wed, 10 Oct 2012 08:52:21 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: build failure after merge of the origin tree
References: <20121010102150.81c192c6fdf60689dc823b20@canb.auug.org.au>
 <20121009164514.b7a7e227.akpm@linux-foundation.org>
In-Reply-To: <20121009164514.b7a7e227.akpm@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-next@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Stephen,

2012/10/10 8:45, Andrew Morton wrote:
> On Wed, 10 Oct 2012 10:21:50 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
>> Hi Linus,
>>
>> In Linus' tree, today's linux-next build (powerpc ppc64_defconfig) failed
>> like this:
>>
>> arch/powerpc/platforms/pseries/hotplug-memory.c: In function 'pseries_remove_memblock':
>> arch/powerpc/platforms/pseries/hotplug-memory.c:103:17: error: unused variable 'pfn' [-Werror=unused-variable]
>>
>> Caused by commit d760afd4d257 ("memory-hotplug: suppress "Trying to free
>> nonexistent resource <XXXXXXXXXXXXXXXX-YYYYYYYYYYYYYYYY>" warning").
>>
>> I can't see what the point of the "pfn" variable is
>
> This:
>
> --- a/arch/powerpc/platforms/pseries/hotplug-memory.c~a
> +++ a/arch/powerpc/platforms/pseries/hotplug-memory.c
> @@ -101,7 +101,7 @@ static int pseries_remove_memblock(unsig
>   	sections_to_remove = (memblock_size >> PAGE_SHIFT) / PAGES_PER_SECTION;
>   	for (i = 0; i < sections_to_remove; i++) {
>   		unsigned long pfn = start_pfn + i * PAGES_PER_SECTION;
> -		ret = __remove_pages(zone, start_pfn,  PAGES_PER_SECTION);
> +		ret = __remove_pages(zone, pfn, PAGES_PER_SECTION);
>   		if (ret)
>   			return ret;
>   	}

I believe the error to be fixed with this patch.
Could you try it?

Thanks,
Yasuaki Ishimatsu

>
>> and this patch never
>> appeared in linux-next before being merged.  :-(
>
> It was first sighted October 3.
>
>> I have reverted that commit for today.
>>
>> If this patch truly was authored yesterday (according the Author Date in
>> git), why was it merged yesterday while still under discussion?  And the
>> latest update to it still has this build problem ... did anyone even try
>> to build this for powerpc (since that architecture was obviously
>> affected)?
>
> Apparently not - the ppc bit was a best-effort fixup for a patch which
> addresses an x86 problem.
>
