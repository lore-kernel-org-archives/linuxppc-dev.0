Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8F8C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 14:30:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D72620675
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 14:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D72620675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fqPM6FpKzDqKr
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 01:30:31 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fpb53YktzDqPW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 00:53:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43fpb44tvcz8tQK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 00:53:52 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43fpb441QWz9sDB; Thu, 17 Jan 2019 00:53:52 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.195; helo=mail-qt1-f195.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43fpb35dp7z9sBZ
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2019 00:53:51 +1100 (AEDT)
Received: by mail-qt1-f195.google.com with SMTP id d19so7144200qtq.9
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2019 05:53:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GWmQa5APdWA0NhYAwkE9/EiMtG/Tl/I99k8uNevo5WQ=;
 b=FIoTTihL7ZPTiHm/SNobqOYjUa/YqT7Kaz4cLKRtvwnGRddoM7K3mZBv8dVUGLrVI2
 M/vHqTCbl9CN8ZkR9m64jRwECSRUAmGcwPGXz9xUSac6iX3qyekovgE5SWiw2DoZSpfM
 wyJ2aEahRd0fqJbwooJuTjM8cJ9wKP0mkvQunNpgLj6on9kHHpzEMu8rAtl1GhrbDAuw
 GlOba7SgwoEnTCsNBPH+qRcOwdE55ECwhQIBgSQxCcTDw/S7KVi8SDN7JqywkQMcWvVq
 67JK0rxm+6MuNI+quXYVcAh/C8dfyARu2KF1goSz43hFC5PZQZ/dTvXx1IvNS0pWSJo0
 p/oA==
X-Gm-Message-State: AJcUukeLeBqsNqoD3D5rZYjBtXXWLqVDGV1NmyZio+xgzPYYVuwfpTOr
 FLplQObTb21Zu24og1Tc3OJGf0YL8TLExAscfxk=
X-Google-Smtp-Source: ALg8bN56jT0Rv1woXnY45M5yHXkrBuQ8uf3O9SpSQdDiOtwydf5pdZG9YSC+SB+A3/Q2jRAZMkohHfmlBDBjVugA+Lw=
X-Received: by 2002:a0c:f50c:: with SMTP id j12mr6908957qvm.149.1547646828836; 
 Wed, 16 Jan 2019 05:53:48 -0800 (PST)
MIME-Version: 1.0
References: <20190116132714.20094-1-mpe@ellerman.id.au>
 <20190116132714.20094-5-mpe@ellerman.id.au>
In-Reply-To: <20190116132714.20094-5-mpe@ellerman.id.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 16 Jan 2019 14:53:32 +0100
Message-ID: <CAK8P3a2EmiT+hEmj40i1ihZM1ecK2Q42zknWNLRbgYeuOyJgrg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/5] powerpc/syscalls: Allow none instead of
 sys_ni_syscall
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Jan 16, 2019 at 2:27 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> sys_ni_syscall is the "not-implemented" syscall syscall, which just
> returns -ENOSYS.
>
> But unless you know that it's not obvious what it does, and even if
> you do know what it means it doesn't stand out that well from other
> real syscalls.
>
> So teach the scripts to treat "none" as a synonym for
> "sys_ni_syscall". This makes the table more readable.

Hmm, this actually breaks the proposed script to find bugs
in the compat handling, i.e. detecting those that have no
compat handler but only a native one.

> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
> index c5907a2dbc86..988a7e29245f 100644
> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
> @@ -24,28 +24,28 @@
>  14     common  mknod                           sys_mknod
>  15     common  chmod                           sys_chmod
>  16     common  lchown                          sys_lchown
> -17     common  break                           sys_ni_syscall
> -18     32      oldstat                         sys_stat                        sys_ni_syscall
> -18     64      oldstat                         sys_ni_syscall
> +17     common  break                           none
> +18     32      oldstat                         sys_stat                        none
> +18     64      oldstat                         none

The '64 oldstat' line can simply get dropped here, it has no value
(I failed to notice this earlier).

For break, i.e. a syscall number without any implementation,
we use a different syntax on x86 (leaving out the sys_* entirely),
and on s390 (using '-', which is visually better than 'none' IMHO).

We might also just remove those entirely across all architectures.
Some have already done this, and some have done it partially.
I can only see a couple of syscalls that got removed in the entire
git history (set_zone_reclaim, nfsservctl, vm86, timerfd), any other
ones are now literally pre-historic, and presumably nobody would
miss the macros when building a program that has no chance to
run on any kernel since at least 2.6.12.

For 32-bit oldstat, I'd argue that this should actually get fixed by adding
the compat syscall logic. I think this was discussed when Firoz
first posted his patches. Something like this:

diff --git a/arch/powerpc/include/asm/unistd.h
b/arch/powerpc/include/asm/unistd.h
index f44dbc65e38e..d954c2fc4e2f 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -41,9 +41,7 @@
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
-#ifdef CONFIG_PPC32
 #define __ARCH_WANT_OLD_STAT
-#endif
 #ifdef CONFIG_PPC64
 #define __ARCH_WANT_SYS_TIME
 #define __ARCH_WANT_SYS_UTIME
diff --git a/arch/powerpc/include/uapi/asm/stat.h
b/arch/powerpc/include/uapi/asm/stat.h
index afd25f2ff4e8..8331b350c12b 100644
--- a/arch/powerpc/include/uapi/asm/stat.h
+++ b/arch/powerpc/include/uapi/asm/stat.h
@@ -11,7 +11,7 @@

 #define STAT_HAVE_NSEC 1

-#ifndef __powerpc64__
+#if defined(__KERNEL__) || !defined(__powerpc64__)
 struct __old_kernel_stat {
        unsigned short st_dev;
        unsigned short st_ino;
@@ -25,7 +25,7 @@ struct __old_kernel_stat {
        unsigned long  st_mtime;
        unsigned long  st_ctime;
 };
-#endif /* !__powerpc64__ */
+#endif /* __KERNEL__ || !__powerpc64__ */

 struct stat {
        unsigned long   st_dev;
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl
b/arch/powerpc/kernel/syscalls/syscall.tbl
index 740dc9dbf689..cd85718c7039 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -27,7 +27,7 @@
 15     common  chmod                           sys_chmod
 16     common  lchown                          sys_lchown
 17     common  break                           sys_ni_syscall
-18     32      oldstat                         sys_stat
         sys_ni_syscall
+18     32      oldstat                         sys_stat
 18     64      oldstat                         sys_ni_syscall
 18     spu     oldstat                         sys_ni_syscall
 19     common  lseek                           sys_lseek
         compat_sys_lseek
@@ -43,7 +43,7 @@
 25     spu     stime                           sys_stime
 26     nospu   ptrace                          sys_ptrace
         compat_sys_ptrace
 27     common  alarm                           sys_alarm
-28     32      oldfstat                        sys_fstat
         sys_ni_syscall
+28     32      oldfstat                        sys_fstat
 28     64      oldfstat                        sys_ni_syscall
 28     spu     oldfstat                        sys_ni_syscall
 29     nospu   pause                           sys_pause
@@ -114,7 +114,7 @@
 82     64      select                          sys_ni_syscall
 82     spu     select                          sys_ni_syscall
 83     common  symlink                         sys_symlink
-84     32      oldlstat                        sys_lstat
         sys_ni_syscall
+84     32      oldlstat                        sys_lstat
 84     64      oldlstat                        sys_ni_syscall
 84     spu     oldlstat                        sys_ni_syscall
 85     common  readlink                        sys_readlink
