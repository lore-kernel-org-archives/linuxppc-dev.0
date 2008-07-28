Return-Path: <dave@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 394E3DE69B
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 06:37:43 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6SKbeVV016773
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 16:37:40 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6SKbeA4159946
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 16:37:40 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6SKbdqW008889
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 16:37:40 -0400
Subject: Re: [PATCH 4/5 V2] Build hugetlb backed process stacks
From: Dave Hansen <dave@linux.vnet.ibm.com>
To: Eric Munson <ebmunson@us.ibm.com>
In-Reply-To: <34bf5c7a2116bc6bd16b4235bc1cf84395ee561e.1216928613.git.ebmunson@us.ibm.com>
References: <cover.1216928613.git.ebmunson@us.ibm.com>
	<34bf5c7a2116bc6bd16b4235bc1cf84395ee561e.1216928613.git.ebmunson@us.ibm.com>
Content-Type: text/plain
Date: Mon, 28 Jul 2008 13:37:38 -0700
Message-Id: <1217277458.23502.39.camel@nimitz>
Mime-Version: 1.0
Cc: linux-mm@kvack.org, libhugetlbfs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-07-28 at 12:17 -0700, Eric Munson wrote:
> 
> +static int move_to_huge_pages(struct linux_binprm *bprm,
> +                               struct vm_area_struct *vma, unsigned
> long shift)
> +{
> +       struct mm_struct *mm = vma->vm_mm;
> +       struct vm_area_struct *new_vma;
> +       unsigned long old_end = vma->vm_end;
> +       unsigned long old_start = vma->vm_start;
> +       unsigned long new_end = old_end - shift;
> +       unsigned long new_start, length;
> +       unsigned long arg_size = new_end - bprm->p;
> +       unsigned long flags = vma->vm_flags;
> +       struct file *hugefile = NULL;
> +       unsigned int stack_hpages = 0;
> +       struct page **from_pages = NULL;
> +       struct page **to_pages = NULL;
> +       unsigned long num_pages = (arg_size / PAGE_SIZE) + 1;
> +       int ret;
> +       int i;
> +
> +#ifdef CONFIG_STACK_GROWSUP

Why do you have the #ifdef for the CONFIG_STACK_GROWSUP=y case in that
first patch if you don't support CONFIG_STACK_GROWSUP=y?

I think it might be worth some time to break this up a wee little bit.
16 local variables is a big on the beefy side. :)

-- Dave
