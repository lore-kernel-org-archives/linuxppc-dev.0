Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18723.37096.243151.673526@cargo.ozlabs.ibm.com>
Date: Wed, 19 Nov 2008 15:07:04 +1100
From: Paul Mackerras <paulus@samba.org>
To: Sonny Rao <sonnyrao@us.ibm.com>
Subject: Re: [PATCH] Fix BSR to allow mmap of small BSR on 64k kernel
In-Reply-To: <20081117072613.GO16240@us.ibm.com>
References: <20081107003841.GE7533@us.ibm.com>
	<18707.53757.132643.518167@cargo.ozlabs.ibm.com>
	<20081117072613.GO16240@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sonny Rao writes:

> -	if (io_remap_pfn_range(vma, vma->vm_start, dev->bsr_addr >> PAGE_SHIFT,
> -			       size, vma->vm_page_prot))
> +	/* check for the case of a small BSR device and map one 4k page for it*/
> +	if (dev->bsr_len < PAGE_SIZE && size == PAGE_SIZE)
> +		ret = remap_4k_pfn(vma, vma->vm_start, dev->bsr_addr >> 12,
> +				   vma->vm_page_prot);

I think we should be checking that dev->bsr_len == 4096 here.

Paul.
