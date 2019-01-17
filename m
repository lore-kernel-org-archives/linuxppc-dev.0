Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C55BC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 10:36:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 234972054F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 10:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234972054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gL9H28H9zDqpg
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 21:36:51 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gL7C6qXNzDqNr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 21:35:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43gL7C5xFgz9sD4; Thu, 17 Jan 2019 21:35:03 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43gL7C4PGrz9sCX;
 Thu, 17 Jan 2019 21:35:03 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v2 5/5] powerpc/syscalls: Allow none instead of
 sys_ni_syscall
In-Reply-To: <CAK8P3a2EmiT+hEmj40i1ihZM1ecK2Q42zknWNLRbgYeuOyJgrg@mail.gmail.com>
References: <20190116132714.20094-1-mpe@ellerman.id.au>
 <20190116132714.20094-5-mpe@ellerman.id.au>
 <CAK8P3a2EmiT+hEmj40i1ihZM1ecK2Q42zknWNLRbgYeuOyJgrg@mail.gmail.com>
Date: Thu, 17 Jan 2019 21:35:03 +1100
Message-ID: <87r2db4lns.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@ozlabs.org, Firoz Khan <firoz.khan@linaro.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Arnd,

Arnd Bergmann <arnd@arndb.de> writes:
> On Wed, Jan 16, 2019 at 2:27 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> sys_ni_syscall is the "not-implemented" syscall syscall, which just
>> returns -ENOSYS.
>>
>> But unless you know that it's not obvious what it does, and even if
>> you do know what it means it doesn't stand out that well from other
>> real syscalls.
>>
>> So teach the scripts to treat "none" as a synonym for
>> "sys_ni_syscall". This makes the table more readable.
>
> Hmm, this actually breaks the proposed script to find bugs
> in the compat handling, i.e. detecting those that have no
> compat handler but only a native one.

I don't understand how? It just makes none an alias for sys_ni_syscall,
so surely the worse case is that script will need to do the reverse
transformation?

>> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
>> index c5907a2dbc86..988a7e29245f 100644
>> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
>> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
>> @@ -24,28 +24,28 @@
>>  14     common  mknod                           sys_mknod
>>  15     common  chmod                           sys_chmod
>>  16     common  lchown                          sys_lchown
>> -17     common  break                           sys_ni_syscall
>> -18     32      oldstat                         sys_stat                        sys_ni_syscall
>> -18     64      oldstat                         sys_ni_syscall
>> +17     common  break                           none
>> +18     32      oldstat                         sys_stat                        none
>> +18     64      oldstat                         none
>
> The '64 oldstat' line can simply get dropped here, it has no value
> (I failed to notice this earlier).

It does add value. It causes the syscall number to be defined in
unistd.h (now unistd_64.h).

If you remove it then that syscall number is no longer defined which
changes the uapi header and could break something.

Sure arguably it shouldn't be defined, and it's old etc. but it was
previously defined, so removing it seems risky.


> For break, i.e. a syscall number without any implementation,
> we use a different syntax on x86 (leaving out the sys_* entirely),
> and on s390 (using '-', which is visually better than 'none' IMHO).

Except a blank compat syscall doesn't mean the syscall doesn't exist for
compat tasks, it means they get the non-compat entry point. So blank or
'-' are not explicit enough IMO because the script might have some
default logic which you can't see by looking at the table.

"none" is pretty explicit I thought. Possibly better is a literal
"ENOSYS", which stands out well and should be obvious to new comers.

> We might also just remove those entirely across all architectures.
> Some have already done this, and some have done it partially.
> I can only see a couple of syscalls that got removed in the entire
> git history (set_zone_reclaim, nfsservctl, vm86, timerfd), any other
> ones are now literally pre-historic, and presumably nobody would
> miss the macros when building a program that has no chance to
> run on any kernel since at least 2.6.12.

I don't see the benefit, a single missing #define could be a build break
for some random pieces of software out there.


> For 32-bit oldstat, I'd argue that this should actually get fixed by adding
> the compat syscall logic. I think this was discussed when Firoz
> first posted his patches. Something like this:

I'm not clear why we would do that? If there were programs out there
that wanted oldstat in compat mode surely we would have got a bug report
by now.

So this just wires up a syscall that no one will ever use?

cheers

> diff --git a/arch/powerpc/include/asm/unistd.h
> b/arch/powerpc/include/asm/unistd.h
> index f44dbc65e38e..d954c2fc4e2f 100644
> --- a/arch/powerpc/include/asm/unistd.h
> +++ b/arch/powerpc/include/asm/unistd.h
> @@ -41,9 +41,7 @@
>  #define __ARCH_WANT_SYS_OLDUMOUNT
>  #define __ARCH_WANT_SYS_SIGPENDING
>  #define __ARCH_WANT_SYS_SIGPROCMASK
> -#ifdef CONFIG_PPC32
>  #define __ARCH_WANT_OLD_STAT
> -#endif
>  #ifdef CONFIG_PPC64
>  #define __ARCH_WANT_SYS_TIME
>  #define __ARCH_WANT_SYS_UTIME
> diff --git a/arch/powerpc/include/uapi/asm/stat.h
> b/arch/powerpc/include/uapi/asm/stat.h
> index afd25f2ff4e8..8331b350c12b 100644
> --- a/arch/powerpc/include/uapi/asm/stat.h
> +++ b/arch/powerpc/include/uapi/asm/stat.h
> @@ -11,7 +11,7 @@
>
>  #define STAT_HAVE_NSEC 1
>
> -#ifndef __powerpc64__
> +#if defined(__KERNEL__) || !defined(__powerpc64__)
>  struct __old_kernel_stat {
>         unsigned short st_dev;
>         unsigned short st_ino;
> @@ -25,7 +25,7 @@ struct __old_kernel_stat {
>         unsigned long  st_mtime;
>         unsigned long  st_ctime;
>  };
> -#endif /* !__powerpc64__ */
> +#endif /* __KERNEL__ || !__powerpc64__ */
>
>  struct stat {
>         unsigned long   st_dev;
> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl
> b/arch/powerpc/kernel/syscalls/syscall.tbl
> index 740dc9dbf689..cd85718c7039 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -27,7 +27,7 @@
>  15     common  chmod                           sys_chmod
>  16     common  lchown                          sys_lchown
>  17     common  break                           sys_ni_syscall
> -18     32      oldstat                         sys_stat           sys_ni_syscall
> +18     32      oldstat                         sys_stat
>  18     64      oldstat                         sys_ni_syscall
>  18     spu     oldstat                         sys_ni_syscall
>  19     common  lseek                           sys_lseek
>          compat_sys_lseek
> @@ -43,7 +43,7 @@
>  25     spu     stime                           sys_stime
>  26     nospu   ptrace                          sys_ptrace
>          compat_sys_ptrace
>  27     common  alarm                           sys_alarm
> -28     32      oldfstat                        sys_fstat           sys_ni_syscall
> +28     32      oldfstat                        sys_fstat
>  28     64      oldfstat                        sys_ni_syscall
>  28     spu     oldfstat                        sys_ni_syscall
>  29     nospu   pause                           sys_pause
> @@ -114,7 +114,7 @@
>  82     64      select                          sys_ni_syscall
>  82     spu     select                          sys_ni_syscall
>  83     common  symlink                         sys_symlink
> -84     32      oldlstat                        sys_lstat           sys_ni_syscall
> +84     32      oldlstat                        sys_lstat
>  84     64      oldlstat                        sys_ni_syscall
>  84     spu     oldlstat                        sys_ni_syscall
>  85     common  readlink                        sys_readlink
