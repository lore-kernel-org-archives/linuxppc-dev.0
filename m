Return-Path: <muriloo@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42H73n36QNzF3Qc
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Sep 2018 08:06:45 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8LKOCxM130907
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 16:24:23 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2mn60r3k6r-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 16:24:23 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <muriloo@linux.ibm.com>;
 Fri, 21 Sep 2018 14:24:22 -0600
Date: Fri, 21 Sep 2018 17:24:15 -0300
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/3] powerpc/process: fix casting and missing header
References: <113d4a559f6eec448b253bf5f0b4f2a8ffb187af.1536327756.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <113d4a559f6eec448b253bf5f0b4f2a8ffb187af.1536327756.git.christophe.leroy@c-s.fr>
Message-Id: <20180921202415.GA19940@kermit-br-ibm-com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 07, 2018 at 01:47:29PM +0000, Christophe Leroy wrote:
> This patch fixes the following warnings. The first ones are leftovers
> from when __get_user() was replaced by probe_kernel_address().
> 
> The last one is from when show_user_instructions() was added.
> 
> arch/powerpc/kernel/process.c:1287:22: warning: incorrect type in argument 2 (different address spaces)
> arch/powerpc/kernel/process.c:1287:22:    expected void const *src
> arch/powerpc/kernel/process.c:1287:22:    got unsigned int [noderef] <asn:1>*<noident>
> arch/powerpc/kernel/process.c:1319:21: warning: incorrect type in argument 2 (different address spaces)
> arch/powerpc/kernel/process.c:1319:21:    expected void const *src
> arch/powerpc/kernel/process.c:1319:21:    got unsigned int [noderef] <asn:1>*<noident>
> arch/powerpc/kernel/process.c:1302:6: warning: symbol 'show_user_instructions' was not declared. Should it be static?
> 
> Fixes: 7b051f665c32d ("powerpc: Use probe_kernel_address in show_instructions")
> Fixes: 88b0fe1757359 ("powerpc: Add show_user_instructions()")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Smoke test passed.  Thank you.

Reviewed-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

> ---
>  v3: new in v3 to fix sparse warnings reported by snowpatch on the serie
> 
>  arch/powerpc/kernel/process.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 913c5725cdb2..e108e1ef2b85 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -65,6 +65,7 @@
>  #include <asm/livepatch.h>
>  #include <asm/cpu_has_feature.h>
>  #include <asm/asm-prototypes.h>
> +#include <asm/stacktrace.h>
>  
>  #include <linux/kprobes.h>
>  #include <linux/kdebug.h>
> @@ -1284,7 +1285,7 @@ static void show_instructions(struct pt_regs *regs)
>  #endif
>  
>  		if (!__kernel_text_address(pc) ||
> -		     probe_kernel_address((unsigned int __user *)pc, instr)) {
> +		    probe_kernel_address((const void *)pc, instr)) {
>  			pr_cont("XXXXXXXX ");
>  		} else {
>  			if (regs->nip == pc)
> @@ -1316,7 +1317,7 @@ void show_user_instructions(struct pt_regs *regs)
>  			pr_info("%s[%d]: code: ", current->comm, current->pid);
>  		}
>  
> -		if (probe_kernel_address((unsigned int __user *)pc, instr)) {
> +		if (probe_kernel_address((const void *)pc, instr)) {
>  			pr_cont("XXXXXXXX ");
>  		} else {
>  			if (regs->nip == pc)
> -- 
> 2.13.3
> 

-- 
Murilo
