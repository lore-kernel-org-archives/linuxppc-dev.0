Return-Path: <cyrilbur@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xG3r972tDzDrCm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 11:36:41 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id y129so10309314pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jul 2017 18:36:41 -0700 (PDT)
Message-ID: <1500860194.10541.1.camel@gmail.com>
Subject: Re: [PATCH] powerpc/tm: fix TM SPRs in code dump file
From: Cyril Bur <cyrilbur@gmail.com>
To: Gustavo Romero <gromero@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 24 Jul 2017 11:36:34 +1000
In-Reply-To: <1500443053-1264-1-git-send-email-gromero@linux.vnet.ibm.com>
References: <1500443053-1264-1-git-send-email-gromero@linux.vnet.ibm.com>
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

On Wed, 2017-07-19 at 01:44 -0400, Gustavo Romero wrote:
> Currently flush_tmregs_to_thread() does not update accordingly the thread
> structures from live state before a core dump rendering wrong values of
> THFAR, TFIAR, and TEXASR in core dump files.
> 
> That commit fixes it by copying from live state to the appropriate thread
> structures when it's necessary.
> 
> Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>

Gustavo was nice enough to provide me with a simple test case:

int main(void)
{
	__builtin_set_texasr(0x4841434b);
	__builtin_set_tfhar(0xbfee00);
	__builtin_set_tfiar(0x4841434b);

	asm volatile (".long 0x0");

	return 0;
}

Running this binary in a loop and inspecting the resulting core file
with a modified elfutils also provided by Gustavo (https://sourceware.o
rg/ml/elfutils-devel/2017-q3/msg00030.html) should always observe the
values that those __builtin functions set.
__builtin_set_{texasr,tfhar,tfiar} are just wrappers around the
corresponding mtspr instruction.

On an unmodified 4.13-rc1 it takes in the order of 10 executions of the
test to observe an incorrect TM SPR values in the core file (typically
zero).

The above test was run on the same 4.13-rc1 with this patch applied for
a over 48 hours. The test was executed at a rate of about one run per
second. An incorrect value was never observed.

This gives me confidence that this patch is correct.

Running the kernel selftests does not detect any regressions.

Reviewed-by: Cyril Bur <cyrilbur@gmail.com>


> ---
>  arch/powerpc/kernel/ptrace.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index 925a4ef..660ed39 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -127,12 +127,19 @@ static void flush_tmregs_to_thread(struct task_struct *tsk)
>  	 * If task is not current, it will have been flushed already to
>  	 * it's thread_struct during __switch_to().
>  	 *
> -	 * A reclaim flushes ALL the state.
> +	 * A reclaim flushes ALL the state or if not in TM save TM SPRs
> +	 * in the appropriate thread structures from live.
>  	 */
>  
> -	if (tsk == current && MSR_TM_SUSPENDED(mfmsr()))
> -		tm_reclaim_current(TM_CAUSE_SIGNAL);
> +	if (tsk != current)
> +		return;
>  
> +	if (MSR_TM_SUSPENDED(mfmsr())) {
> +		tm_reclaim_current(TM_CAUSE_SIGNAL);
> +	} else {
> +		tm_enable();
> +		tm_save_sprs(&(tsk->thread));
> +	}
>  }
>  #else
>  static inline void flush_tmregs_to_thread(struct task_struct *tsk) { }
