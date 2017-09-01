Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xk6jm1spZzDqZ7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 15:09:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] uprobe: Warn if unable to install breakpoint
In-Reply-To: <20170831183215.4306-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20170831183215.4306-1-naveen.n.rao@linux.vnet.ibm.com>
Date: Fri, 01 Sep 2017 15:09:29 +1000
Message-ID: <87r2vr57jq.fsf@concordia.ellerman.id.au>
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

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:

> When we try to install a uprobe breakpoint in uprobe_mmap(), we ignore
> all errors encountered in the process per this comment at the top of
> the function:
>     /*
>      * Called from mmap_region/vma_adjust with mm->mmap_sem acquired.
>      *
>      * Currently we ignore all errors and always return 0, the callers
>      * can't handle the failure anyway.
>      */
>
> However, this is very confusing for users since no probe hits are
> recorded nor is an error logged in dmesg.
>
> Fix this by logging an error in dmesg so that users can discover that
> there was an issue with the uprobe. To facilitate use of uprobe_warn(),
> we move that function to the top of the file.
>
> With this patch, we see a message similar to this in dmesg:
>     [  201.449213] uprobe: uprobe_t:9740 failed to setup probe at 0x95c (-524)
>
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  kernel/events/uprobes.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 0e137f98a50c..587c591a535c 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -112,6 +112,12 @@ struct xol_area {
>  	unsigned long 			vaddr;		/* Page(s) of instruction slots */
>  };
>  
> +static void uprobe_warn(struct task_struct *t, const char *msg)
> +{
> +	pr_warn("uprobe: %s:%d failed to %s\n",
> +			current->comm, current->pid, msg);

That should probably be ratelimited no?

cheers
