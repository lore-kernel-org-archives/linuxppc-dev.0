Return-Path: <dh.herrmann@gmail.com>
Received: from mail-ie0-x234.google.com (mail-ie0-x234.google.com
 [IPv6:2607:f8b0:4001:c03::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8CEFD1A002C
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Sep 2014 00:34:05 +1000 (EST)
Received: by mail-ie0-f180.google.com with SMTP id rl12so5036762iec.11
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Aug 2014 07:34:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJhHMCDaSAzU3zvhY2FRFoBaQH4oQBTsUsYMU6pvBbCXydROZQ@mail.gmail.com>
References: <1409369788-22563-1-git-send-email-bobby.prani@gmail.com>
 <CAMuHMdV_naTfQOLwOshWq1Q15kSE39a8GWChsjt3RrWRcd6peg@mail.gmail.com>
 <CAJhHMCDaSAzU3zvhY2FRFoBaQH4oQBTsUsYMU6pvBbCXydROZQ@mail.gmail.com>
Date: Sun, 31 Aug 2014 16:34:03 +0200
Message-ID: <CANq1E4SCnDjN5yetrgtaRNdvDr7xqGOm1BXz7dbGvX3mnsm-MA@mail.gmail.com>
Subject: Re: [RFC PATCH] powerpc: Wire up three syscalls
From: David Herrmann <dh.herrmann@gmail.com>
To: Pranith Kumar <bobby.prani@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: open list <linux-kernel@vger.kernel.org>, Fabian Frederick <fabf@skynet.be>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Anton Blanchard <anton@samba.org>,
 Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>,
 "open list:LINUX FOR POWERPC..." <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi

On Sun, Aug 31, 2014 at 2:52 PM, Pranith Kumar <bobby.prani@gmail.com> wrote:
> Hi Geert,
>
> On Sun, Aug 31, 2014 at 4:53 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> Hi Pranith,
>>
>> On Sat, Aug 30, 2014 at 5:36 AM, Pranith Kumar <bobby.prani@gmail.com> wrote:
>>> I see that the three syscalls seccomp, getrandom and memfd_create are not wired
>>> because of which we get a warning while compilation.
>>>
>>> So I wired them up in this patch. What else needs to be done? I tried the
>>> memfd_test after compiling this kernel, but it is failing. What am I missing for
>>> this to work? Any advice is really appreciated! :)
>>
>> Did it fail due to the (silly) "ifeq ($(ARCH),X86)" checks in
>> tools/testing/selftests/memfd/Makefile?
>>
>
> I removed that check and compiled memfd_test.c by hand. This is the
> following error which I get when I run the test:
>
> $ ./memfd_test
> memfd: CREATE
> memfd: BASIC
> 10 != 0 = GET_SEALS(3)
> Aborted
>
> This is basically when checking the seals which we already added. It
> should return 10 (F_SEAL_SHRINK | F_SEAL_WRITE), instead it is returning 0.
>
> What else needs to be done for this to properly work? I see that for
> m68k, you just wired it up like in this patch. Did it work after that?

The only arch-dependent code for memfd_test.c is the syscall invocation:
    memfd_create(const char *name, unsigned int flags);
via glibc as:
    syscall(__NR_memfd_create, name, flags);

Can you debug your test-run (maybe via simple printk() in mm/shmem.c
memfd_create()) and see what's going wrong there?

Thanks
David
