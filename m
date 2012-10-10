Return-Path: <patrickdepinguin@gmail.com>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A9CD02C0086
 for <linuxppc-dev@ozlabs.org>; Thu, 11 Oct 2012 06:05:39 +1100 (EST)
Received: by mail-pa0-f42.google.com with SMTP id fa1so768512pad.15
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Oct 2012 12:05:37 -0700 (PDT)
MIME-Version: 1.0
Sender: patrickdepinguin@gmail.com
In-Reply-To: <CAAXf6LVxFHGytLiiGXs77kqJkBF24H7e3yOOzkWsnvuEkhU6iw@mail.gmail.com>
References: <CAAXf6LVxFHGytLiiGXs77kqJkBF24H7e3yOOzkWsnvuEkhU6iw@mail.gmail.com>
Date: Wed, 10 Oct 2012 21:05:37 +0200
Message-ID: <CAAXf6LUXWB_BxTO+go-CSdV+R8XYav1y7TaeMQTy-5GA=GXagA@mail.gmail.com>
Subject: Re: Changing TASK_UNMAPPED_BASE to a low address
From: Thomas De Schampheleire <patrickdepinguin+linuxppc@gmail.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ronny Meeus <Ronny.Meeus@gmail.com>, patrickdepinguin+linuxppc@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Fri, Oct 5, 2012 at 11:47 AM, Thomas De Schampheleire
<patrickdepinguin+linuxppc@gmail.com> wrote:
> Hi,
>
> The current virtual address space of a 32-bit userspace process looks
> like this on powerpc:
> # cat /proc/28922/maps
> 00100000-00102000 r-xp 00000000 00:00 0          [vdso]
> 0fe70000-0ffd8000 r-xp 00000000 00:01 754        /lib/libc-2.10.1.so
> 0ffd8000-0ffe8000 ---p 00168000 00:01 754        /lib/libc-2.10.1.so
> 0ffe8000-0ffea000 r--p 00168000 00:01 754        /lib/libc-2.10.1.so
> 0ffea000-0ffed000 rwxp 0016a000 00:01 754        /lib/libc-2.10.1.so
> 0ffed000-0fff0000 rwxp 00000000 00:00 0
> 10000000-10001000 r-xp 00000000 00:12 73         /tmp/memory_alloc
> 10010000-10011000 rwxp 00000000 00:12 73         /tmp/memory_alloc
> 10011000-47a32000 rwxp 00000000 00:00 0          [heap]
> 48000000-4801d000 r-xp 00000000 00:01 793        /lib/ld-2.10.1.so
> 4801d000-4801f000 rw-p 00000000 00:00 0
> 4801f000-48021000 rw-p 00000000 00:00 0
> 4802d000-4802e000 r--p 0001d000 00:01 793        /lib/ld-2.10.1.so
> 4802e000-4802f000 rwxp 0001e000 00:01 793        /lib/ld-2.10.1.so
> 4802f000-bf6ee000 rw-p 00000000 00:00 0
> bfa18000-bfa39000 rw-p 00000000 00:00 0          [stack]
>
> The process text and data area are at 0x10000000 (fixed), the
> mmap_base is at 0x48000000 (TASK_UNMAPPED_BASE = 3/8*0xc0000000), and
> shared libraries are put directly above 0x10000000.
>
> When your application starts allocating memory, the first blocks are
> taken starting from mmap_base (0x48000000) until you reached the stack
> area (0xbfa18000 in this example). Then, a 'heap' region is created
> after the process text/data area (0x10011000 in this example) and the
> mmap_base (0x48000000). When this is also filled, any further
> allocation fails.
> However, between 0x0 and the first shared library, there is still
> plenty of space. Without any shared library, there would be approx.
> 256 MB free. Even with a few shared libraries, this typically is >200
> MB, at least in the type of applications I'm envisioning.
>
> Because of the 3GB/1GB userspace/kernelspace virtual address split,
> one expects an application to be able to allocate close to 3GB = 3072
> MB. Due to the 256MB 'unused' area mentioned, you can only allocate
> something like 2800 MB. If your application needs more than that, and
> you're bound to 32-bit processors, this is a problem.
>
> I've been looking at two ways to use the extra memory:
> 1. do an anonymous mmap with an address hint in that range, e.g. at
> address 0x00110000. This does return memory, and if you know how much
> is free there, you can take all of it.
>
> 2. change the TASK_UNMAPPED_BASE setting in the kernel
> (arch/powerpc/include/asm/processor.h) to a low address, e.g. 0x40000.
> The advantage of this is that applications need no change.
>
> The second approach seems to work fine. The memory map changes to:
>
> # cat /proc/6954/maps
> 00040000-0005d000 r-xp 00000000 00:01 787        /lib/ld-2.10.1.so
> 0005d000-0005f000 rw-p 00000000 00:00 0
> 0005f000-00061000 rw-p 00000000 00:00 0
> 0006d000-0006e000 r--p 0001d000 00:01 787        /lib/ld-2.10.1.so
> 0006e000-0006f000 rwxp 0001e000 00:01 787        /lib/ld-2.10.1.so
> 00100000-00102000 r-xp 00000000 00:00 0          [vdso]
> 00102000-0c904000 rw-p 00000000 00:00 0
> 0ca00000-0ca21000 rw-p 00000000 00:00 0
> 0ca21000-0cb00000 ---p 00000000 00:00 0
> 0fe70000-0ffd8000 r-xp 00000000 00:01 750        /lib/libc-2.10.1.so
> 0ffd8000-0ffe8000 ---p 00168000 00:01 750        /lib/libc-2.10.1.so
> 0ffe8000-0ffea000 r--p 00168000 00:01 750        /lib/libc-2.10.1.so
> 0ffea000-0ffed000 rwxp 0016a000 00:01 750        /lib/libc-2.10.1.so
> 0ffed000-0fff0000 rwxp 00000000 00:00 0
> 10000000-10001000 r-xp 00000000 00:12 119
> /mnt/repo/tdescham/reborn/isam-linux-target-apps/memory_alloc
> 10010000-10011000 rwxp 00000000 00:12 119
> /mnt/repo/tdescham/reborn/isam-linux-target-apps/memory_alloc
> 10011000-cb82f000 rw-p 00000000 00:00 0          [heap]
> bffaf000-bffd0000 rw-p 00000000 00:00 0          [stack]
>
>
> I have not seen anything 'weird' about this change.
> I found the following thread that also discusses such a change:
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2004-February/016513.html
> The thread talks about a few problems, but later concludes that these
> have been fixed. Since the thread dates from 2004, I assume that
> indeed this has been fixed.
>
> Is there any reason why this change is not OK? I'm not necessarily
> talking about mainlining the change. I first would like to know if it
> is 'dangerous' or if there are other reasons not to do it.
>
> This post is using linux-2.6.36.4 as base, but I looked at more recent
> kernels and the settings seem the same.


Any feedback on this topic?

Thanks,
Thomas
