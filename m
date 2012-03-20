Return-Path: <richard.weinberger@gmail.com>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
 [209.85.160.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DB992B6EF4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2012 00:30:57 +1100 (EST)
Received: by ghbg19 with SMTP id g19so31592ghb.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2012 06:30:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFPAmTQs9dOpQTaXU=6Or66YU+my_CnPw33TE4h++YArBNa38g@mail.gmail.com>
References: <CAFPAmTQs9dOpQTaXU=6Or66YU+my_CnPw33TE4h++YArBNa38g@mail.gmail.com>
Date: Tue, 20 Mar 2012 14:30:49 +0100
Message-ID: <CAFLxGvwW2XcYSoidZZ0XF_a-pH3SwONqS+hCnpGUecQ__DLa_g@mail.gmail.com>
Subject: Re: [PATCH 0/20] mmu: arch/mm: Port OOM changes to arch page fault
 handlers.
From: richard -rw- weinberger <richard.weinberger@gmail.com>
To: Kautuk Consul <consul.kautuk@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-am33-list@redhat.com,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-cris-kernel@axis.com, linux-sh@vger.kernel.org,
 microblaze-uclinux@itee.uq.edu.au, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-m68k@lists.linux-m68k.org, linux@lists.openrisc.net,
 sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 20, 2012 at 2:18 PM, Kautuk Consul <consul.kautuk@gmail.com> wrote:
> Commit d065bd810b6deb67d4897a14bfe21f8eb526ba99
> (mm: retry page fault when blocking on disk transfer) and
> commit 37b23e0525d393d48a7d59f870b3bc061a30ccdb
> (x86,mm: make pagefault killable)
>
> The above commits introduced changes into the x86 pagefault handler
> for making the page fault handler retryable as well as killable.
>
> These changes reduce the mmap_sem hold time, which is crucial
> during OOM killer invocation.
>
> I was facing hang and livelock problems on my ARM and MIPS boards when
> I invoked OOM by running the stress_32k.c test-case attached to this email.
>
> Since both the ARM and MIPS porting chainges were accepted, me and my
> co-worker decided to take the initiative to port these changes to all other
> MMU based architectures.
>
> Please review and do write back if there is any way I need to
> improve/rewrite any
> of these patches.
>

What about arch/um/?
Does UML not need this change?

-- 
Thanks,
//richard
