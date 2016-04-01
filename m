Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbjlz0BR7zDq7n
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 12:02:39 +1100 (AEDT)
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com
 [IPv6:2607:f8b0:400e:c03::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qbjly18BXz9s5g
 for <linuxppc-dev@ozlabs.org>; Fri,  1 Apr 2016 12:02:38 +1100 (AEDT)
Received: by mail-pa0-x22c.google.com with SMTP id td3so77584545pab.2
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Mar 2016 18:02:38 -0700 (PDT)
Subject: Re: [PATCH 5/6] powerpc/livepatch: Add livepatch stack to struct
 thread_info
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1458817445-5855-1-git-send-email-mpe@ellerman.id.au>
 <1458817445-5855-5-git-send-email-mpe@ellerman.id.au>
Cc: duwe@lst.de, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56FDC8A5.8010303@gmail.com>
Date: Fri, 1 Apr 2016 12:02:29 +1100
MIME-Version: 1.0
In-Reply-To: <1458817445-5855-5-git-send-email-mpe@ellerman.id.au>
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
> In order to support live patching we need to maintain an alternate
> stack of TOC & LR values. We use the base of the stack for this, and
> store the "live patch stack pointer" in struct thread_info.
>
> Unlike the other fields of thread_info, we can not statically initialise
> that value, so it must be done at run time.
>
> This patch just adds the code to support that, it is not enabled until
> the next patch which actually adds live patch support.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/livepatch.h   |  8 ++++++++
>  arch/powerpc/include/asm/thread_info.h |  4 +++-
>  arch/powerpc/kernel/irq.c              |  3 +++
>  arch/powerpc/kernel/process.c          |  6 +++++-
>  arch/powerpc/kernel/setup_64.c         | 17 ++++++++++-------
>  5 files changed, 29 insertions(+), 9 deletions(-)
>
>

Acked-by: Balbir Singh <bsingharora@gmail.com>
