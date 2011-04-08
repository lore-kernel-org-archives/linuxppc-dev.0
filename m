Return-Path: <kosaki.motohiro@jp.fujitsu.com>
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C28F3B6F72
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2011 19:07:49 +1000 (EST)
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by fgwmail7.fujitsu.co.jp (Postfix) with ESMTP id E1E87179292D
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2011 17:42:44 +0900 (JST)
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 078263EE0C3
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2011 17:42:39 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
	by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id D70EF45DF4C
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2011 17:42:38 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
	by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id BC93145DED5
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2011 17:42:38 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id A7BE3E18007
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2011 17:42:38 +0900 (JST)
Received: from ml14.s.css.fujitsu.com (ml14.s.css.fujitsu.com [10.240.81.134])
	by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 65C6AE18003
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2011 17:42:38 +0900 (JST)
From: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] mm: Check we have the right vma in __access_remote_vm()
In-Reply-To: <10e5cbf67c850b6ae511979bdbad1761236ad9b0.1302247435.git.michael@ellerman.id.au>
References: <10e5cbf67c850b6ae511979bdbad1761236ad9b0.1302247435.git.michael@ellerman.id.au>
Message-Id: <20110408174244.9B6F.A69D9226@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Date: Fri,  8 Apr 2011 17:42:36 +0900 (JST)
Cc: aarcange@redhat.com, Andrew Morton <akpm@osdl.org>, riel@redhat.com,
	linuxppc-dev@ozlabs.org, hughd@google.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	kosaki.motohiro@jp.fujitsu.com, walken@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> In __access_remote_vm() we need to check that we have found the right
> vma, not the following vma, before we try to access it. Otherwise we
> might call the vma's access routine with an address which does not
> fall inside the vma.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  mm/memory.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
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

Looks good to me.
	Reviewed-by: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
