Return-Path: <ryabinin.a.a@gmail.com>
Received: from mail-vk0-x22e.google.com (mail-vk0-x22e.google.com
 [IPv6:2607:f8b0:400c:c05::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8BB8D1A0372
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 21:36:58 +1000 (AEST)
Received: by vkaw128 with SMTP id w128so22477816vka.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2015 04:36:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1439793400-18147-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1439793400-18147-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1439793400-18147-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 17 Aug 2015 14:36:56 +0300
Message-ID: <CAPAsAGxs8NhxJ22DXOgcbBkuALzd0zd7WL+SCGeNmsWCrMi3nA@mail.gmail.com>
Subject: Re: [RFC PATCH V1 4/8] kasan: Don't use kasan shadow pointer in
 generic functions
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/17/2015 09:36 AM, Aneesh Kumar K.V wrote:
> We can't use generic functions like print_hex_dump to access kasan
> shadow region. This require us to setup another kasan shadow region
> for the address passed (kasan shadow address). Most architecture won't
> be able to do that. Hence remove dumping kasan shadow region dump. If
> we really want to do this we will have to have a kasan internal implemen
> tation of print_hex_dump for which we will disable address sanitizer
> operation.
>

I didn't understand that.
Yes, you don't have shadow for shadow. But, for shadow addresses you
return return (void *)kasan_zero_page in kasan_mem_to_shadow(), so we
should be fine to access shadow in generic code.

And with kasan_tracks_vaddr(), this should work too.
