Return-Path: <cyrilbur@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtcx40Rb0zDqZ4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 11:18:47 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id j16so508707pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 18:18:47 -0700 (PDT)
Message-ID: <1505438319.2732.1.camel@gmail.com>
Subject: Re: [PATCH v2] powerpc/tm: Flush TM only if CPU has TM feature
From: Cyril Bur <cyrilbur@gmail.com>
To: Gustavo Romero <gromero@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, sam.bobroff@au1.ibm.com, stable@vger.kernel.org
Date: Fri, 15 Sep 2017 11:18:39 +1000
In-Reply-To: <1505355228-15039-1-git-send-email-gromero@linux.vnet.ibm.com>
References: <1505315421-13266-1-git-send-email-gromero@linux.vnet.ibm.com>
 <1505355228-15039-1-git-send-email-gromero@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-09-13 at 22:13 -0400, Gustavo Romero wrote:
> Commit cd63f3c ("powerpc/tm: Fix saving of TM SPRs in core dump")
> added code to access TM SPRs in flush_tmregs_to_thread(). However
> flush_tmregs_to_thread() does not check if TM feature is available on
> CPU before trying to access TM SPRs in order to copy live state to
> thread structures. flush_tmregs_to_thread() is indeed guarded by
> CONFIG_PPC_TRANSACTIONAL_MEM but it might be the case that kernel
> was compiled with CONFIG_PPC_TRANSACTIONAL_MEM enabled and ran on
> a CPU without TM feature available, thus rendering the execution
> of TM instructions that are treated by the CPU as illegal instructions.
> 
> The fix is just to add proper checking in flush_tmregs_to_thread()
> if CPU has the TM feature before accessing any TM-specific resource,
> returning immediately if TM is no available on the CPU. Adding
> that checking in flush_tmregs_to_thread() instead of in places
> where it is called, like in vsr_get() and vsr_set(), is better because
> avoids the same problem cropping up elsewhere.
> 
> Cc: stable@vger.kernel.org # v4.13+
> Fixes: cd63f3c ("powerpc/tm: Fix saving of TM SPRs in core dump")
> Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>

Keeping in mind I reviewed cd63f3c and feeling a bit sheepish having
missed this.

Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

> ---
>  arch/powerpc/kernel/ptrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index 07cd22e..f52ad5b 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -131,7 +131,7 @@ static void flush_tmregs_to_thread(struct task_struct *tsk)
>  	 * in the appropriate thread structures from live.
>  	 */
>  
> -	if (tsk != current)
> +	if ((!cpu_has_feature(CPU_FTR_TM)) || (tsk != current))
>  		return;
>  
>  	if (MSR_TM_SUSPENDED(mfmsr())) {
