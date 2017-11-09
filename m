Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yXgG16wSfzDrKJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Nov 2017 22:01:29 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, nicholas.piggin@gmail.com, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/18] powerpc: Define set_thread_used_vas()
In-Reply-To: <1507343298-27496-15-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1507343298-27496-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1507343298-27496-15-git-send-email-sukadev@linux.vnet.ibm.com>
Date: Thu, 09 Nov 2017 22:01:28 +1100
Message-ID: <87efp7pvg7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:

> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index d861fcd..cb5f108 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1234,17 +1234,17 @@ struct task_struct *__switch_to(struct task_struct *prev,
>  		 * The copy-paste buffer can only store into foreign real
>  		 * addresses, so unprivileged processes can not see the
>  		 * data or use it in any way unless they have foreign real
> -		 * mappings. We don't have a VAS driver that allocates those
> -		 * yet, so no cpabort is required.
> +		 * mappings. If the new process has the foreign real address
> +		 * mappings, we must issue a cp_abort to clear any state and
> +		 * prevent a covert channel being setup.
> +		 *
> +		 * DD1 allows paste into normal system memory so we do an
> +		 * unpaired copy, rather than cp_abort, to clear the buffer,
> +		 * since cp_abort is quite expensive.
>  		 */
> -		if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
> -			/*
> -			 * DD1 allows paste into normal system memory, so we
> -			 * do an unpaired copy here to clear the buffer and
> -			 * prevent a covert channel being set up.
> -			 *
> -			 * cpabort is not used because it is quite expensive.
> -			 */
> +		if (new_thread->used_vas) {

So this has a bug in that it's not safe to use new_thread here.

Because this is on the way out of __switch_to(), this code can run both
when switching to a new task and also when switching back to an older
task. In the latter case the task pointed to by new_thread may have
already been freed.

I've fixed it up here to use current_thread_info()->task->thread.used_vas,
so that it's always checking current.

cheers
