Return-Path: <rientjes@google.com>
Received: from smtp-out.google.com (smtp-out.google.com [74.125.121.35])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 82CBDB7BEE
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Apr 2010 07:55:06 +1000 (EST)
Received: from wpaz24.hot.corp.google.com (wpaz24.hot.corp.google.com
	[172.24.198.88]) by smtp-out.google.com with ESMTP id o3MLiRhB020747
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Apr 2010 23:44:28 +0200
Received: from pvg4 (pvg4.prod.google.com [10.241.210.132])
	by wpaz24.hot.corp.google.com with ESMTP id o3MLhxNV022854
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Apr 2010 14:44:25 -0700
Received: by pvg4 with SMTP id 4so110151pvg.1
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Apr 2010 14:44:25 -0700 (PDT)
Date: Thu, 22 Apr 2010 14:44:22 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: npiggin@suse.de
Subject: Re: [patch 11/14] powerpc: invoke oom-killer from page fault
In-Reply-To: <20100422161224.465958039@suse.de>
Message-ID: <alpine.DEB.2.00.1004221442590.25350@chino.kir.corp.google.com>
References: <20100422160613.723698029@suse.de>
	<20100422161224.465958039@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 23 Apr 2010, npiggin@suse.de wrote:

> As explained in commit 1c0fe6e3bd, we want to call the architecture independent
> oom killer when getting an unexplained OOM from handle_mm_fault, rather than
> simply killing current.
> 
> Cc: linuxppc-dev@ozlabs.org
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Nick Piggin <npiggin@suse.de>
> ---
> Index: linux-2.6/arch/powerpc/mm/fault.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/mm/fault.c
> +++ linux-2.6/arch/powerpc/mm/fault.c
> @@ -359,15 +359,10 @@ bad_area_nosemaphore:
>   */
>  out_of_memory:
>  	up_read(&mm->mmap_sem);
> -	if (is_global_init(current)) {
> -		yield();
> -		down_read(&mm->mmap_sem);
> -		goto survive;
> -	}
> -	printk("VM: killing process %s\n", current->comm);
> -	if (user_mode(regs))
> -		do_group_exit(SIGKILL);
> -	return SIGKILL;
> +	if (!user_mode(regs))
> +		return SIGKILL;
> +	pagefault_out_of_memory();
> +	return 0;

Do we really want to return 0 and indicate that the fault was handled?  It 
seems more consistent to do

	if (user_mode(regs))
		pagefault_out_of_memory();
	return SIGKILL;
