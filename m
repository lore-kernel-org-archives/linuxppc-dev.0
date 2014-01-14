Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 400A22C0091
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 15:17:15 +1100 (EST)
Message-ID: <1389673024.6933.1.camel@pasglop>
Subject: Re: [PATCH mmotm/next] powerpc: fix powernv boot breakage on G5???
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hughd@google.com>
Date: Tue, 14 Jan 2014 15:17:04 +1100
In-Reply-To: <alpine.LSU.2.11.1401120043210.1092@eggly.anvils>
References: <alpine.LSU.2.11.1401120043210.1092@eggly.anvils>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2014-01-12 at 00:46 -0800, Hugh Dickins wrote:
> My PowerMac G5 cannot boot mmotm these days: different symptoms
> (starting /sbin/init failed? or ATA errors and hang?), with unrelated
> bugs adding to the confusion; but a bisection led to b5ff4211a829
> "powerpc/book3s: Queue up and process delayed MCE events".  Since that
> series seems to be mostly about powernv, I tried changing BOOK3S_64
> to POWERNV in entry_64.S, which has got it back to working for me.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> just in case this happens to be right, but it's well beyond me!
> ---

Do that help instead ?

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 770d6d6..9820d36 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -187,6 +187,7 @@ syscall_exit:
 #ifdef CONFIG_PPC_BOOK3S_64
 BEGIN_FTR_SECTION
 	bl	.machine_check_process_queued_event
+	ld	r3,RESULT(r1)
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 #endif
 	CURRENT_THREAD_INFO(r12, r1)

Cheers,
Ben.

> 
>  arch/powerpc/kernel/entry_64.S |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- mmotm/arch/powerpc/kernel/entry_64.S	2014-01-10 18:24:56.940448828 -0800
> +++ linux/arch/powerpc/kernel/entry_64.S	2014-01-10 18:29:24.276455182 -0800
> @@ -184,7 +184,7 @@ syscall_exit:
>  	bl	.do_show_syscall_exit
>  	ld	r3,RESULT(r1)
>  #endif
> -#ifdef CONFIG_PPC_BOOK3S_64
> +#ifdef CONFIG_PPC_POWERNV
>  BEGIN_FTR_SECTION
>  	bl	.machine_check_process_queued_event
>  END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
