Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 573AA1A09FB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Nov 2014 00:13:15 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2F16514018C
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2014 00:13:15 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 21 Nov 2014 23:13:14 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0F7ED2BB0062
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2014 00:13:12 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sALDDBgh41353240
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2014 00:13:12 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sALDDAaN010930
 for <linuxppc-dev@ozlabs.org>; Sat, 22 Nov 2014 00:13:11 +1100
Message-ID: <546F3A5C.3010604@linux.vnet.ibm.com>
Date: Fri, 21 Nov 2014 18:43:00 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH V4 2/8] powerpc, process: Add functions flush_tm_state,
 flush_tmregs_to_thread
References: <1415683597-22819-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1415683597-22819-3-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1415683597-22819-3-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, peterz@infradead.org, palves@redhat.com,
 oleg@redhat.com, dhowells@redhat.com, tglx@linutronix.de, davej@redhat.com,
 akpm@linux-foundation.org, sukadev@linux.vnet.ibm.com, davem@davemloft.net,
 sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/11/2014 10:56 AM, Anshuman Khandual wrote:
> This patch creates a new function called flush_tm_state to flush
> the existing transactional memory state from the thread. It also
> creates a function called flush_tmregs_to_thread which will then
> be used on subsequent patches in this series.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/switch_to.h |  8 ++++++
>  arch/powerpc/kernel/process.c        | 49 +++++++++++++++++++++++++++++-------
>  2 files changed, 48 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
> index 58abeda..23752a9 100644
> --- a/arch/powerpc/include/asm/switch_to.h
> +++ b/arch/powerpc/include/asm/switch_to.h
> @@ -82,6 +82,14 @@ static inline void flush_spe_to_thread(struct task_struct *t)
>  }
>  #endif
>  
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +extern void flush_tmregs_to_thread(struct task_struct *);
> +#else
> +static inline void flush_tmregs_to_thread(struct task_struct *t)
> +{
> +}
> +#endif
> +
>  static inline void clear_task_ebb(struct task_struct *t)
>  {
>  #ifdef CONFIG_PPC_BOOK3S_64
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index aa1df89..c36477b 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -745,6 +745,45 @@ void restore_tm_state(struct pt_regs *regs)
>  #define __switch_to_tm(prev)
>  #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
>  
> +/*
> + * flush_tm_state
> + *
> + * Flush TM state out so we can copy it.  __switch_to_tm() does this
> + * flush but it removes the checkpointed state from the current CPU and
> + * transitions the CPU out of TM mode.  Hence we need to call
> + * tm_recheckpoint_new_task() (on the same task) to restore the
> + * checkpointed state back and the TM mode.
> + */
> +static void flush_tm_state(struct task_struct *src)
> +{
> +	__switch_to_tm(src);
> +	tm_recheckpoint_new_task(src);
> +}
> +
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +void flush_tmregs_to_thread(struct task_struct *tsk)
> +{
> +	/*
> +	 * If task is not current, it should have been flushed
> +	 * already to it's thread_struct during __switch_to().
> +	 */
> +	if (tsk != current)
> +		return;

As of now, ptrace does not support process self tracing. So here in this
function we really dont have to do anything if current and tsk does not
match each other. In case they match, we will just post one warning (as
ptrace generic code should have prevented this from happening) and move
on. Will make this function very simple like the following and remove
the next patch as well which was created because of this patch.

#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
void flush_tmregs_to_thread(struct task_struct *tsk)
{
	/*
	 * Self tracing is not yet supported through ptrace
	 * interface. Warn here if attempted.
	 */

	WARN_ON(tsk == current);
	return;
}
#endif
