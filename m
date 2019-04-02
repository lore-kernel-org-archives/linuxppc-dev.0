Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372CCC4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 22:06:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B17BA2075E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 22:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17BA2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Yjvp6FjSzDqRX
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 09:05:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux-foundation.org
 (client-ip=140.211.169.12; helo=mail.linuxfoundation.org;
 envelope-from=akpm@linux-foundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Yjt44VWjzDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 09:04:28 +1100 (AEDT)
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
 by mail.linuxfoundation.org (Postfix) with ESMTPSA id EB8B0C84;
 Tue,  2 Apr 2019 22:04:25 +0000 (UTC)
Date: Tue, 2 Apr 2019 15:04:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH 1/6] mm: change locked_vm's type from unsigned long to
 atomic64_t
Message-Id: <20190402150424.5cf64e19deeafa58fc6c1a9f@linux-foundation.org>
In-Reply-To: <20190402204158.27582-2-daniel.m.jordan@oracle.com>
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
 <20190402204158.27582-2-daniel.m.jordan@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Davidlohr Bueso <dave@stgolabs.net>, kvm@vger.kernel.org,
 Alan Tull <atull@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linux-mm@kvack.org,
 Alex Williamson <alex.williamson@redhat.com>, Moritz Fischer <mdf@kernel.org>,
 Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
 Wu Hao <hao.wu@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue,  2 Apr 2019 16:41:53 -0400 Daniel Jordan <daniel.m.jordan@oracle.com> wrote:

> Taking and dropping mmap_sem to modify a single counter, locked_vm, is
> overkill when the counter could be synchronized separately.
> 
> Make mmap_sem a little less coarse by changing locked_vm to an atomic,
> the 64-bit variety to avoid issues with overflow on 32-bit systems.
> 
> ...
>
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -59,32 +59,34 @@ static unsigned long kvmppc_stt_pages(unsigned long tce_pages)
>  static long kvmppc_account_memlimit(unsigned long stt_pages, bool inc)
>  {
>  	long ret = 0;
> +	s64 locked_vm;
>  
>  	if (!current || !current->mm)
>  		return ret; /* process exited */
>  
>  	down_write(&current->mm->mmap_sem);
>  
> +	locked_vm = atomic64_read(&current->mm->locked_vm);
>  	if (inc) {
>  		unsigned long locked, lock_limit;
>  
> -		locked = current->mm->locked_vm + stt_pages;
> +		locked = locked_vm + stt_pages;
>  		lock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
>  		if (locked > lock_limit && !capable(CAP_IPC_LOCK))
>  			ret = -ENOMEM;
>  		else
> -			current->mm->locked_vm += stt_pages;
> +			atomic64_add(stt_pages, &current->mm->locked_vm);
>  	} else {
> -		if (WARN_ON_ONCE(stt_pages > current->mm->locked_vm))
> -			stt_pages = current->mm->locked_vm;
> +		if (WARN_ON_ONCE(stt_pages > locked_vm))
> +			stt_pages = locked_vm;
>  
> -		current->mm->locked_vm -= stt_pages;
> +		atomic64_sub(stt_pages, &current->mm->locked_vm);
>  	}

With the current code, current->mm->locked_vm cannot go negative. 
After the patch, it can go negative.  If someone else decreased
current->mm->locked_vm between this function's atomic64_read() and
atomic64_sub().

I guess this is a can't-happen in this case because the racing code
which performed the modification would have taken it negative anyway.

But this all makes me rather queazy.


Also, we didn't remove any down_write(mmap_sem)s from core code so I'm
thinking that the benefit of removing a few mmap_sem-takings from a few
obscure drivers (sorry ;)) is pretty small.


Also, the argument for switching 32-bit arches to a 64-bit counter was
suspiciously vague.  What overflow issues?  Or are we just being lazy?

