Return-Path: <nab@linux-iscsi.org>
Received: from linux-iscsi.org (mail.linux-iscsi.org [67.23.28.174])
 by ozlabs.org (Postfix) with ESMTP id 735552C008E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2012 13:23:18 +1000 (EST)
Subject: Re: [v2][PATCH 3/3] powerpc/kgdb: restore current_thread_info properly
From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
To: Tiejun Chen <tiejun.chen@windriver.com>
In-Reply-To: <1345687820-5248-3-git-send-email-tiejun.chen@windriver.com>
References: <1345687820-5248-1-git-send-email-tiejun.chen@windriver.com>
 <1345687820-5248-3-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 22 Aug 2012 20:14:10 -0700
Message-ID: <1345691650.10190.31.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 jason.wessel@windriver.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-08-23 at 10:10 +0800, Tiejun Chen wrote:
> For powerpc BooKE and e200, singlestep is handled on the critical/dbg
> exception stack. This causes current_thread_info() to fail for kgdb
> internal, so previously We work around this issue by copying
> the thread_info from the kernel stack before calling kgdb_handle_exception,
> and copying it back afterwards.
> 
> But actually we don't do this properly. We should backup current_thread_info
> then restore that when exit.
> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
> v2: fix a typo in patch head description.
> 
>  arch/powerpc/kernel/kgdb.c |   11 +++++++++--
>  1 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> index 05adb69..c470a40 100644
> --- a/arch/powerpc/kernel/kgdb.c
> +++ b/arch/powerpc/kernel/kgdb.c
> @@ -25,6 +25,7 @@
>  #include <asm/processor.h>
>  #include <asm/machdep.h>
>  #include <asm/debug.h>
> +#include <linux/slab.h>
>  
>  /*
>   * This table contains the mapping between PowerPC hardware trap types, and
> @@ -153,6 +154,8 @@ static int kgdb_handle_breakpoint(struct pt_regs *regs)
>  static int kgdb_singlestep(struct pt_regs *regs)
>  {
>  	struct thread_info *thread_info, *exception_thread_info;
> +	struct thread_info *backup_current_thread_info = \
> +		(struct thread_info *)kmalloc(sizeof(struct thread_info), GFP_KERNEL);
>  

Looks like a rouge '\' in the above assignment..
