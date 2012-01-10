Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5694FB6FAB
 for <linuxppc-dev@ozlabs.org>; Tue, 10 Jan 2012 20:15:08 +1100 (EST)
Message-ID: <4F0C01BA.3040302@windriver.com>
Date: Tue, 10 Jan 2012 17:15:38 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Tiejun Chen <tiejun.chen@windriver.com>
Subject: Re: [PATCH v2 0/3] ppc32/kprobe: Fix a bug for kprobe stwu r1
References: <1323946810-4868-1-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1323946810-4868-1-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tiejun Chen wrote:
> Changes from V1:
> 
> * use memcpy simply to withdraw copy_exc_stack
> * add !(regs->msr & MSR_PR)) and
> 	WARN_ON(test_thread_flag(TIF_EMULATE_STACK_STORE));
>   to make sure we're in goot path.
> * move this migration process inside 'restore'
> * clear TIF flag atomically 

Ben,

Is this series OK?

Thanks
Tiejun

> 
> Tiejun Chen (3):
>       powerpc/kprobe: introduce a new thread flag
>       ppc32/kprobe: complete kprobe and migrate exception frame
>       ppc32/kprobe: don't emulate store when kprobe stwu r1
> 
>  arch/powerpc/include/asm/thread_info.h |    3 ++
>  arch/powerpc/kernel/entry_32.S         |   35 ++++++++++++++++++++++++++++++++
>  arch/powerpc/lib/sstep.c               |   25 +++++++++++++++++++++-
>  3 files changed, 61 insertions(+), 2 deletions(-)
> 
> Tiejun
