Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x22f.google.com (mail-pf0-x22f.google.com
 [IPv6:2607:f8b0:400e:c00::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvFWc575gzDq68
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 17:45:48 +1000 (AEST)
Received: by mail-pf0-x22f.google.com with SMTP id 206so3693161pfu.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 00:45:48 -0700 (PDT)
Subject: Re: [PATCH] powerpc: Add support for userspace P9 copy paste
To: Chris Smart <chris@distroguy.com>, linuxppc-dev@lists.ozlabs.org
References: <20160426002844.GA9198@x1.distroguy.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <571F1CA5.9020208@gmail.com>
Date: Tue, 26 Apr 2016 17:45:41 +1000
MIME-Version: 1.0
In-Reply-To: <20160426002844.GA9198@x1.distroguy.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> /*
>  * System calls.
> @@ -508,6 +509,14 @@ BEGIN_FTR_SECTION
>     ldarx    r6,0,r1
> END_FTR_SECTION_IFSET(CPU_FTR_STCX_CHECKS_ADDRESS)
> 
> +BEGIN_FTR_SECTION
> +/*
> + * A cp_abort (copy paste abort) here ensures that when context switching, a
> + * copy from one process can't leak into the paste of another.
> + */
> +        PPC_CP_ABORT

I think the alignment issue has been called out, but it is not clear from the changelog that
we do this during syscall_exit/syscalls.

And also, do we need to care about preemptions, etc by the scheduler?

> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
> +
> #ifdef CONFIG_PPC_BOOK3S
> /* Cancel all explict user streams as they will have no use after context
>  * switch and will stop the HW from creating streams itself
