Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-f178.google.com (mail-yk0-f178.google.com
 [209.85.160.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CECED1A2BD6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 20:42:18 +1000 (AEST)
Received: by ykdt18 with SMTP id t18so128054399ykd.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 03:42:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150914100034.GD22991@e104818-lin.cambridge.arm.com>
References: <1442169397-4271-1-git-send-email-kda@linux-powerpc.org>
 <1442210677.8149.1.camel@ellerman.id.au>
 <20150914091529.GC22991@e104818-lin.cambridge.arm.com>
 <1442223409.21802.1.camel@ellerman.id.au>
 <20150914100034.GD22991@e104818-lin.cambridge.arm.com>
Date: Mon, 14 Sep 2015 13:42:15 +0300
Message-ID: <CAOJe8K3a9VZq1U=P8icNUgBoo3qj_s7+vg5kf+NnPmSTXD-zLQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc: msi: mark bitmap with kmemleak_not_leak()
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 9/14/15, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Sep 14, 2015 at 07:36:49PM +1000, Michael Ellerman wrote:
>> On Mon, 2015-09-14 at 10:15 +0100, Catalin Marinas wrote:
>> > You could add some flag to struct msi_bitmap based on mem_init_done to
>> > be able to reclaim some slab memory later. If the bitmap is small and
>> > such allocation doesn't happen outside boot, it may not be worth the
>> > effort.
>>
>> Right, I think that's the only solution, and it's not quite worth the
>> trouble
>> because it's generally not freed at all, except via error paths.
>>
>> Still I think it would be better to move the kmemleak annotation into the
>> msi
>> bitmap test code, or maybe a wrapper that's called by the test code.
>
> Other kmemleak annotations throughout the kernel are usually added
> immediately after the allocation place (since that's what kmemleak
> reports as a leak).
>
>> That way if someone starts calling alloc/free from a hotplug path for
>> example,
>> kmemleak will still notice that free isn't really freeing.
>
> Kmemleak would only notice the moment you clear the last reference to
> the allocated memory block (like bmp->bitmap = NULL), so this patch
> should work as along as "freeing" is done via msi_bitmap_free().

Ok, I'll move kmemleak annotaion for the bitmap inside the test_basics()
plus add a flag into msi_bitmap to test for the type of allocation
though the slab_is_available()

Thank you.

>
> BTW, you can even use kmemleak_ignore(). The difference is that the
> bitmap won't be scanned by kmemleak and that's fine since it doesn't
> contain any pointers.
>
> --
> Catalin
>
>
