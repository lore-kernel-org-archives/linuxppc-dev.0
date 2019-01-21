Return-Path: <SRS0=gbiG=P5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54F4BC37120
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 20:42:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1B82089F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 20:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1B82089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43k3Pj6MJXzDqT5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 07:42:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.195; helo=mail-qt1-f195.google.com;
 envelope-from=arndbergmann@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43k3Mm3qc1zDqRd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 07:40:20 +1100 (AEDT)
Received: by mail-qt1-f195.google.com with SMTP id k12so25000229qtf.7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jan 2019 12:40:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dkvN5kxF5ScgcD3pJdfvtsR7PQS22YCBaQenUgPUi4M=;
 b=e0Pa/SDwAuBgDY3pJ+XFDYiuZaCvYduu1VwmZGyR4IQ4cbLcQtLyie6iEz3vxlcWFn
 aIQNTaKqtamETfpiCyLi5nvxKIwvhp7OMIN1tAe0q4DD9NeOFSZOv//aG5ayFrAP5ElS
 c32BayyJMLPZ8iwE3KJ5DBg6vrjaoXe8L/88fI/SJpfltr5dAY2G64oJbi23K1vrqZo8
 S+1Xy9EAVvREWOHCKSZhm10iFIbQ5H3VRqc3I4DaDO/Jz4wahE3LxGlOM3YlZTv69Di0
 49Q4jF5SnySzjWY+7rIql/gx63qmHYPrG3MNJ9a2dVyDh9m/xphSldwlNn5zuBI2Vbvr
 MaeA==
X-Gm-Message-State: AJcUukf0E3nUOnXZIxO8T2L0tlpLSocx+TL377H4lyJNZ0GQIvcbacb+
 ni7Fexufv5a4HpcUIpOaZRXJRYBY8hIvvhV1yNc=
X-Google-Smtp-Source: ALg8bN6NJA3JpmMy0Rnw4UHCeBwdUwtaoF1faqE/rX9S/LB1A3Pp1thWOe1j9+1qk4H6TfQ6cwy2yDs31Lm4Qgs2hsM=
X-Received: by 2002:a05:6214:1087:: with SMTP id
 o7mr27413754qvr.115.1548103218172; 
 Mon, 21 Jan 2019 12:40:18 -0800 (PST)
MIME-Version: 1.0
References: <20190118161835.2259170-1-arnd@arndb.de>
 <20190118161835.2259170-30-arnd@arndb.de>
 <CALCETrXqM5mhvwreN5y-9K99h1j9rs9MAVK-cNLC54s1fdHA6w@mail.gmail.com>
 <CAK8P3a0V+xboaGAF2nqrYtpjXXA7y0LcvCKi4ngLTus1D_XZBA@mail.gmail.com>
 <CALCETrWPj6dHEyo=AELoVjXGsiwuSpRp17x3CEWBHvp7i3cy+Q@mail.gmail.com>
 <20190119142852.cntdihah4mpa3lgx@e5254000004ec.dyn.armlinux.org.uk>
 <CAMuHMdXzQNEEDjWrmTph8Krovj1g2WhnBUaM=FvKB+J2fZqctA@mail.gmail.com>
 <CAK8P3a04UC2dHVqx1gHXJQzsDw446h1ghLEuRe0xmUyJgrOktw@mail.gmail.com>
In-Reply-To: <CAK8P3a04UC2dHVqx1gHXJQzsDw446h1ghLEuRe0xmUyJgrOktw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 21 Jan 2019 21:40:01 +0100
Message-ID: <CAK8P3a11Pme2d6VbTb2t7fi_vd7UmNuN-yOf2zT59KPzbCT1Lw@mail.gmail.com>
Subject: Re: [PATCH v2 29/29] y2038: add 64-bit time_t syscalls to all 32-bit
 architectures
To: Geert Uytterhoeven <geert@linux-m68k.org>
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
Cc: Rich Felker <dalias@libc.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-mips@vger.kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 Network Development <netdev@vger.kernel.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, Helge Deller <deller@gmx.de>,
 X86 ML <x86@kernel.org>,
 Russell King - ARM Linux admin <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Firoz Khan <firoz.khan@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Will Deacon <will.deacon@arm.com>,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Linux API <linux-api@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Paul Burton <paul.burton@mips.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 alpha <linux-alpha@vger.kernel.org>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jan 21, 2019 at 6:08 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jan 21, 2019 at 9:19 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Regardless, I'm wondering what to do with the holes marked "room for
> > arch specific calls".
> > When is a syscall really arch-specific, and can it be added there, and
> > when does it turn out (later) that it isn't, breaking the
> > synchronization again?
>
> We've had a bit of that already, with cacheflush(), which exists on
> a couple of architectures, including some that use the first
> 'arch specific' slot (244) of the asm-generic table. I think this
> will be rare enough that we can figure out a solution when we
> get there.
>
> > The pkey syscalls may be a bad example, as AFAIU they can be implemented
> > on some architectures, but not on some others.  Still, I had skipped them
> > when adding new syscalls to m68k.
> >
> > Perhaps we should get rid of the notion of "arch-specific syscalls", and
> > reserve a slot everywhere anyway?
>
> I don't mind calling the hole something else if that helps. Out of
> principle I would already assume that anything we add for x86
> or the generic table should be added everywhere, but we can
> make it broader than that.

Applying this fixup below,

     ARnd

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl
b/arch/x86/entry/syscalls/syscall_32.tbl
index d9c2d2eea044..955ab6a3b61f 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -398,7 +398,7 @@
 384    i386    arch_prctl              sys_arch_prctl
 __ia32_compat_sys_arch_prctl
 385    i386    io_pgetevents           sys_io_pgetevents_time32
 __ia32_compat_sys_io_pgetevents
 386    i386    rseq                    sys_rseq
 __ia32_sys_rseq
-# room for arch specific syscalls
+# don't use numbers 387 through 392, add new calls at the end
 393    i386    semget                  sys_semget
 __ia32_sys_semget
 394    i386    semctl                  sys_semctl
 __ia32_compat_sys_semctl
 395    i386    shmget                  sys_shmget
 __ia32_sys_shmget
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl
b/arch/x86/entry/syscalls/syscall_64.tbl
index 43a622aec07e..2ae92fddb6d5 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -343,6 +343,8 @@
 332    common  statx                   __x64_sys_statx
 333    common  io_pgetevents           __x64_sys_io_pgetevents
 334    common  rseq                    __x64_sys_rseq
+# don't use numbers 387 through 423, add new calls after the last
+# 'common' entry

 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/include/uapi/asm-generic/unistd.h
b/include/uapi/asm-generic/unistd.h
index 53831e4a4c86..acf9a07ab2ff 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -740,7 +740,7 @@ __SC_COMP_3264(__NR_io_pgetevents,
sys_io_pgetevents_time32, sys_io_pgetevents,
 __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_kexec_file_load 294
 __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
-/* 295 through 402 are unassigned to sync up with generic numbers */
+/* 295 through 402 are unassigned to sync up with generic numbers, don't use */
 #if __BITS_PER_LONG == 32
 #define __NR_clock_gettime64 403
 __SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
