Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 27A751A02BF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 02:58:49 +1000 (AEST)
Date: Thu, 20 Aug 2015 09:58:39 -0700
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Krause <xerofoify@gmail.com>
Cc: gleb@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, pbonzini@redhat.com,
 linuxppc-dev@lists.ozlabs.org, agraf@suse.com
Subject: Re: [PATCH] kvm:powerpc:Fix return statements for wrapper functions
 in the file book3s_64_mmu_hv.c
Message-ID: <20150820165839.GA12530@fergus.ozlabs.ibm.com>
References: <1439220451-26094-1-git-send-email-xerofoify@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1439220451-26094-1-git-send-email-xerofoify@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 10, 2015 at 11:27:31AM -0400, Nicholas Krause wrote:
> This fixes the wrapper functions kvm_umap_hva_hv and the function
> kvm_unmap_hav_range_hv to return the return value of the function
> kvm_handle_hva or kvm_handle_hva_range that they are wrapped to
> call internally rather then always making the caller of these
> wrapper functions think they always run successfully by returning
> the value of zero directly.

In fact these functions do always run successfully, and there is no
bug fixed here (see below).

I don't object to the change per se, since it reduces the code size
very slightly, but the commit message and headline needs to be
reworded to avoid giving the impression that this fixes something.

>  int kvm_unmap_hva_hv(struct kvm *kvm, unsigned long hva)
>  {
> -	kvm_handle_hva(kvm, hva, kvm_unmap_rmapp);
> -	return 0;
> +	return kvm_handle_hva(kvm, hva, kvm_unmap_rmapp);
>  }
>  
>  int kvm_unmap_hva_range_hv(struct kvm *kvm, unsigned long start, unsigned long end)
>  {
> -	kvm_handle_hva_range(kvm, start, end, kvm_unmap_rmapp);
> -	return 0;
> +	return kvm_handle_hva_range(kvm, start, end, kvm_unmap_rmapp);

kvm_handle_hva and kvm_handle_hva_range call the handler function
(kvm_unmap_rmapp in this case) one or more times, and return the
logical OR of the return values from the handler.  Since
kvm_unmap_rmapp always returns 0, the return value from
kvm_handle_hva{,_range} will always be 0 here.

Paul.
