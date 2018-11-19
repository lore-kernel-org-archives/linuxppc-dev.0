Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A92C04EBA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 16:51:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7E3208E3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 16:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7E3208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zFHG32MHzF3Hj
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 03:51:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.194; helo=mail-qk1-f194.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zFCB711GzF3LQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 03:48:22 +1100 (AEDT)
Received: by mail-qk1-f194.google.com with SMTP id n12so49628708qkh.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 08:48:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xg6Y6slrTdFIaEN2P3vXaS05djo0SrywOjWqLbprJVs=;
 b=LXlM1i2Qj/I17bo6NtSG9g31NgUZ9bm6R8Nvgy6nEWBVvvkk//kPGUygK3tQ/1FYFx
 r/2F88nVLEcM+xpRuSOuBvkq8fbFag4pDoo6z0wR/0EqLyNX6rzwApZYdgHYtOJVMuqq
 l5tOqJPUQUzuocoOimss17qNnIVtLTXpSBaF17jLDh1gJgAGJ0S061RgRXfh5a8uGDyq
 h2W42PCmUPrUKoLACiPy7ANv6Pc/HQ250byrHwPTxWGzQOOaRK/OAOjnqsEbiYoYt9M2
 ohk0Er8qeqbW3TaFl7tbrWKFO8ZXYTQiFGw3kCjUMMemr3jPdDZvT70rW8jItCUPF8Yv
 Df9w==
X-Gm-Message-State: AGRZ1gJYDAgvOKzWDWsvMzLYbTyGU4cTN5VPRjFJxy023qFxw2T+4eDS
 jgjF1oTjyAC2DRZRXGF5/vrWGd8iiat1I0PIM2A=
X-Google-Smtp-Source: AJdET5daOPGsp+adybuSPmk20wC52axHHLfq+lN8Eu0P3yqReMpN6Mmo44ZVMiUZygFhFEAADo2UYUOTi3M0YUVXD2g=
X-Received: by 2002:aed:35c5:: with SMTP id d5mr21493142qte.212.1542646100257; 
 Mon, 19 Nov 2018 08:48:20 -0800 (PST)
MIME-Version: 1.0
References: <1542189798-27713-1-git-send-email-firoz.khan@linaro.org>
 <1542189798-27713-4-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1542189798-27713-4-git-send-email-firoz.khan@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 19 Nov 2018 17:48:02 +0100
Message-ID: <CAK8P3a1jnuabJ+NFm-XAzQ8dk7V991H+YEfTZ2GZjNBovuAoDw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] powerpc: add system call table generation support
To: Firoz Khan <firoz.khan@linaro.org>
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
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
 linux-arch <linux-arch@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, Boqun Feng <boqun.feng@gmail.com>,
 Philippe Ombredanne <pombredanne@nexb.com>, linuxram@us.ibm.com,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>, leitao@debian.org,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Nov 14, 2018 at 11:04 AM Firoz Khan <firoz.khan@linaro.org> wrote:

> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
>         - Compat entry name, if required.
>
> syscallhdr.sh and syscalltbl.sh will generate uapi header-
> unistd_32/64.h and syscall_table_32/64/c32.h files respect-
> ively. File syscall_table_32/64/c32.h is included by sys-
> call.S - the real system call table. Both .sh files will
> parse the content syscall.tbl to generate the header and
> table files.

You don't mention how this handles the SPU, which seems to be the main
difference from the other architectures.

> +# The format is:
> +# <number> <abi> <name> <entry point> <compat entry point> <spu entry point>
> +#
> +# The <abi> can be common, 64, or 32 for this file.
> +#
> +0      common  restart_syscall                 sys_restart_syscall             sys_restart_syscall
> +1      common  exit                            sys_exit                        sys_exit
> +2      common  fork                            ppc_fork                        ppc_fork
> +3      common  read                            sys_read                        sys_read                                sys_read
> +4      common  write                           sys_write                       sys_write                               sys_write
> +5      common  open                            sys_open                        compat_sys_open                         sys_open
> +6      common  close                           sys_close                       sys_close                               sys_close
> +7      common  waitpid                         sys_waitpid                     sys_waitpid                             sys_waitpid
> +8      common  creat                           sys_creat                       sys_creat                               sys_creat

The SPU syscall is always the same as the 64-bit syscall, so listing it
explictily in the last column seems to add a lot of duplication, and
makes the format different from the other architectures.

Have you considered using the <abi> field (second column) to decide whether
a syscall is used for SPU or not instead?

I would have done it like

|+0      nospu  restart_syscall                 sys_restart_syscall
         sys_restart_syscall
|+1      nospu  exit                            sys_exit
         sys_exit
|+2      nospu  fork                            ppc_fork
         ppc_fork
|+3      common  read                            sys_read
          sys_read
|+4      common  write                           sys_write
          sys_write
|+5      common  open                            sys_open
          compat_sys_open
|+6      common  close                           sys_close
          sys_close
...
|+291    32      fstatat64                       sys_fstatat64
          sys_fstatat64
|+291    64      newfstatat                      sys_newfstatat
|+291    spu      newfstatat                      sys_newfstatat
...

with 'nospu' meaning 64+32+compat.

> +9      common  link                            sys_link                        sys_link                                sys_link
> +10     common  unlink                          sys_unlink                      sys_unlink                              sys_unlink
> +11     common  execve                          sys_execve                      compat_sys_execve
> +12     common  chdir                           sys_chdir                       sys_chdir                               sys_chdir
> +13     common  time                            sys_time                        compat_sys_time                         sys_time
> +14     common  mknod                           sys_mknod                       sys_mknod                               sys_mknod
> +15     common  chmod                           sys_chmod                       sys_chmod                               sys_chmod
> +16     common  lchown                          sys_lchown                      sys_lchown                              sys_lchown
> +17     common  break                           sys_ni_syscall                  sys_ni_syscall
> +18     32      oldstat                         sys_stat                        sys_ni_syscall
> +18     64      oldstat                         sys_ni_syscall

'oldstat' seems odd. Your conversion is correct, but the existing
behavior of not
providing support for the syscall in compat mode feels wrong. We have four
calls in this category:

arch/powerpc/include/asm/systbl.h:OLDSYS(stat)
arch/powerpc/include/asm/systbl.h:OLDSYS(fstat)
arch/powerpc/include/asm/systbl.h:OLDSYS(lstat)
arch/powerpc/include/asm/systbl.h:OLDSYS(debug_setcontext)

For the first three, it seems that the 64-bit kernel ought to set
'__ARCH_WANT_OLD_STAT':

diff --git a/arch/powerpc/include/asm/unistd.h
b/arch/powerpc/include/asm/unistd.h
index 96ddce5c76c3..335dfcc47f20 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -42,9 +42,7 @@
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
-#ifdef CONFIG_PPC32
 #define __ARCH_WANT_OLD_STAT
-#endif
 #ifdef CONFIG_PPC64
 #define __ARCH_WANT_SYS_TIME32
 #define __ARCH_WANT_SYS_UTIME32
diff --git a/arch/powerpc/include/uapi/asm/stat.h
b/arch/powerpc/include/uapi/asm/stat.h
index afd25f2ff4e8..f64e47b46e4b 100644
--- a/arch/powerpc/include/uapi/asm/stat.h
+++ b/arch/powerpc/include/uapi/asm/stat.h
@@ -11,7 +11,7 @@

 #define STAT_HAVE_NSEC 1

-#ifndef __powerpc64__
+#if !defined(__powerpc64__) || defined(__KERNEL__)
 struct __old_kernel_stat {
        unsigned short st_dev;
        unsigned short st_ino;

For debug_setcontext(), I don't even know what that does, or whether the
omission was intentional, but it seems weird to have one missing syscall
in the emulation.

> +19     common  lseek                           sys_lseek                       compat_sys_lseek                        sys_lseek
> +20     common  getpid                          sys_getpid                      sys_getpid                              sys_getpid
> +21     common  mount                           sys_mount                       compat_sys_mount
> +22     32      umount                          sys_oldumount                   sys_oldumount
> +22     64      umount                          sys_ni_syscall

Note: for a future cleanup, I suppose we want to remove the '64' line
for this one and
others that simply refer to sys_ni_syscall. Your version keeps the
generated file
unchanged, so that that's great for now.

> +31     common  stty                            sys_ni_syscall                  sys_ni_syscall
> +32     common  gtty                            sys_ni_syscall                  sys_ni_syscall

same here.

> +82     32      select                          ppc_select                      sys_ni_syscall
> +82     64      select                          sys_ni_syscall

This one again is like 'stat': it lacks a compat handler, which exists in
arch/powerpc/kernel/syscalls.c, but is disabled in ppc64/compat mode
for unknown reasons. In this case, it's been like that since the compat
mode was first added.

> +106    common  stat                            sys_newstat                     compat_sys_newstat                      sys_newstat
> +107    32      lstat                           sys_newlstat                    compat_sys_newlstat                     sys_newlstat
> +107    64      lstat                           sys_lstat
> +108    32      fstat                           sys_newfstat                    compat_sys_newfstat                     sys_newfstat
> +108    64      fstat                           sys_fstat

Can you explain what is going on here? As far as I can see, those
should all be 'common'.

       Arnd
