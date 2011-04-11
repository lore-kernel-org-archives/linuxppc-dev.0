Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1BE72B6F0C
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Apr 2011 09:50:47 +1000 (EST)
Date: Mon, 11 Apr 2011 16:50:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] mm: Check we have the right vma in __access_remote_vm()
Message-Id: <20110411165035.5a303647.akpm@linux-foundation.org>
In-Reply-To: <10e5cbf67c850b6ae511979bdbad1761236ad9b0.1302247435.git.michael@ellerman.id.au>
References: <10e5cbf67c850b6ae511979bdbad1761236ad9b0.1302247435.git.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: aarcange@redhat.com, riel@redhat.com, linuxppc-dev@ozlabs.org,
	hughd@google.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, walken@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri,  8 Apr 2011 17:24:01 +1000 (EST)
Michael Ellerman <michael@ellerman.id.au> wrote:

> In __access_remote_vm() we need to check that we have found the right
> vma, not the following vma, before we try to access it. Otherwise we
> might call the vma's access routine with an address which does not
> fall inside the vma.
> 

hm, mysteries.  Does this patch fix any known problem in any known
kernel, or was the problem discovered by inspection, or what?

> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 9da8cab..ce999ca 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3678,7 +3678,7 @@ static int __access_remote_vm(struct task_struct *tsk, struct mm_struct *mm,
>  			 */
>  #ifdef CONFIG_HAVE_IOREMAP_PROT
>  			vma = find_vma(mm, addr);
> -			if (!vma)
> +			if (!vma || vma->vm_start > addr)
>  				break;
>  			if (vma->vm_ops && vma->vm_ops->access)
>  				ret = vma->vm_ops->access(vma, addr, buf,
