Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbjxm5PXKzDq6T
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 12:11:08 +1100 (AEDT)
Received: from mail-pf0-x229.google.com (mail-pf0-x229.google.com
 [IPv6:2607:f8b0:400e:c00::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qbjxl6spZz9sC3
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Apr 2016 12:11:07 +1100 (AEDT)
Received: by mail-pf0-x229.google.com with SMTP id x3so81746076pfb.1
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Mar 2016 18:11:07 -0700 (PDT)
Subject: Re: [PATCH 6/6] powerpc/livepatch: Add live patching support on
 ppc64le
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1458817445-5855-1-git-send-email-mpe@ellerman.id.au>
 <1458817445-5855-6-git-send-email-mpe@ellerman.id.au>
Cc: duwe@lst.de, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56FDCAA3.8000503@gmail.com>
Date: Fri, 1 Apr 2016 12:10:59 +1100
MIME-Version: 1.0
In-Reply-To: <1458817445-5855-6-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 24/03/16 22:04, Michael Ellerman wrote:
> Add the kconfig logic & assembly support for handling live patched
> functions. This depends on DYNAMIC_FTRACE_WITH_REGS, which in turn
> depends on the new -mprofile-kernel ftrace ABI, which is only supported
> currently on ppc64le.
>
> Live patching is handled by a special ftrace handler. This means it runs
> from ftrace_caller(). The live patch handler modifies the NIP so as to
> redirect the return from ftrace_caller() to the new patched function.
>
> However there is one particularly tricky case we need to handle.
>
> If a function A calls another function B, and it is known at link time
> that they share the same TOC, then A will not save or restore its TOC,
> and will call the local entry point of B.
>
> When we live patch B, we replace it with a new function C, which may
> not have the same TOC as A. At live patch time it's too late to modify A
> to do the TOC save/restore, so the live patching code must interpose
> itself between A and C, and do the TOC save/restore that A omitted.
>
> An additionaly complication is that the livepatch code can not create a
> stack frame in order to save the TOC. That is because if C takes > 8
> arguments, or is varargs, A will have written the arguments for C in
> A's stack frame.
>
> To solve this, we introduce a "livepatch stack" which grows upward from
> the base of the regular stack, and is used to store the TOC & LR when
> calling a live patched function.
>
> When the patched function returns, we retrieve the real LR & TOC from
> the livepatch stack, restore them, and pop the livepatch "stack frame".
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
