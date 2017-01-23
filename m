Return-Path: <bhsharma@redhat.com>
Received: from mail-ot0-f169.google.com (mail-ot0-f169.google.com
 [74.125.82.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v6KkV4LqGzDqRF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 16:34:26 +1100 (AEDT)
Received: by mail-ot0-f169.google.com with SMTP id 104so95194864otd.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Jan 2017 21:34:26 -0800 (PST)
MIME-Version: 1.0
From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Mon, 23 Jan 2017 11:04:23 +0530
Message-ID: <CACi5LpOkWV2t1MyYLjDckbkoBSx6QxOw7OVayx-GqWjhVHV1tQ@mail.gmail.com>
Subject: Query regarding randomization bits for a ASLR elf on PPC64
To: linuxppc-dev@lists.ozlabs.org
Cc: keescook@chromium.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Experts,

I was recently looking at ways to extend the randomization range for a
ASLR elf on a PPC64LE system.

I basically have been using 28-bits of randomization on x86_64 for an
ASLR elf using appropriate ARCH_MMAP_RND_BITS_MIN and
ARCH_MMAP_RND_BITS_MAX values:

http://lxr.free-electrons.com/source/arch/x86/Kconfig#L192

And I understand from looking at the PPC64 code base that both
ARCH_MMAP_RND_BITS_MIN and ARCH_MMAP_RND_BITS_MAX are not used in the
current upstream code.

I am looking at ways to randomize the mmap, stack and brk ranges for a
ALSR elf on PPC64LE. Currently I am using a PAGE SIZE of 64K in my
config file and hence the randomization usually translates to
something like this for me:

mmap:
-------
http://lxr.free-electrons.com/source/arch/powerpc/mm/mmap.c#L67

rnd = get_random_long() % (1UL<<(30-PAGE_SHIFT));

Since PAGE_SHIFT is 16 for 64K page size, this computation reduces to:
rnd = get_random_long() % (1UL<<(14));

If I compare this to x86_64, I see there:

http://lxr.free-electrons.com/source/arch/x86/mm/mmap.c#L79

rnd = get_random_long() & ((1UL << mmap_rnd_bits) - 1);

So, if mmap_rnd_bits = 28, this equates to:
rnd = get_random_long() & ((1UL << 28) - 1);

Observations and Queries:
--------------------------------------

- So, x86_64 gives approx twice number of random bits for a ASLR elf
running on it as compared to PPC64 although both use a 48-bit VA.

- I also see this comment for PPC at various places, regarding 1GB
randomness spread for PPC64. Is this restricted by the hardware or the
kernel usage?:

/* 8MB for 32bit, 1GB for 64bit */
 64         if (is_32bit_task())
 65                 rnd = get_random_long() % (1<<(23-PAGE_SHIFT));
 66         else
 67                 rnd = get_random_long() % (1UL<<(30-PAGE_SHIFT));

- I tried to increase the randomness to 28 bits for PPC as well by
making the PPC mmap, brk code equivalent to x86_64 and it works fine
for my use case.

- But, I am not sure this is the right thing to do and whether the
PPC64 also supports the MIN and MAX ranges for randomization.

- If it does I would like to understand, test and push a patch to
implement the same for PPC64 in upstream.

Sorry for the long mail, but would really appreciate if someone can
help me understand the details here.

Thanks,
Bhupesh
