Return-Path: <ryabinin.a.a@gmail.com>
Received: from mail-vk0-x229.google.com (mail-vk0-x229.google.com
 [IPv6:2607:f8b0:400c:c05::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E8971A0501
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 21:29:21 +1000 (AEST)
Received: by vkbg64 with SMTP id g64so39916766vkb.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 04:29:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87mvxqp7l5.fsf@linux.vnet.ibm.com>
References: <1439793400-18147-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1439794492.2416.8.camel@kernel.crashing.org>
 <87mvxqp7l5.fsf@linux.vnet.ibm.com>
Date: Mon, 17 Aug 2015 14:29:18 +0300
Message-ID: <CAPAsAGzLY86BLT2KwE+dc=R+rnTPbMbxH_V4eror-Nvnd=3K8w@mail.gmail.com>
Subject: Re: [RFC PATCH V1 0/8] KASAN ppc64 support
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2015-08-17 12:50 GMT+03:00 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
> Because of the above I concluded that we may not be able to do
> inline instrumentation. Now if we are not doing inline instrumentation,
> we can simplify kasan support by not creating a shadow mapping at all
> for vmalloc and vmemmap region. Hence the idea of returning the address
> of a zero page for anything other than kernel linear map region.
>

Yes, mapping zero page needed only for inline instrumentation.
You simply don't need to check shadow for vmalloc/vmemmap.

So, instead of redefining kasan_mem_to_shadow() I'd suggest to
add one more arch hook. Something like:

bool kasan_tracks_vaddr(unsigned long addr)
{
     return REGION_ID(addr) == KERNEL_REGION_ID;
}

And in check_memory_region():
       if (!(kasan_enabled() && kasan_tracks_vaddr(addr)))
               return;
