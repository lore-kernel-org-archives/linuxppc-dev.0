Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F05481A08AA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 13:06:24 +1100 (AEDT)
Date: Mon, 30 Nov 2015 13:06:00 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.com>,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel 5/9] KVM: PPC: Account TCE-containing pages in
 locked_vm
Message-ID: <20151130020600.GB8991@fergus.ozlabs.ibm.com>
References: <1442314179-9706-1-git-send-email-aik@ozlabs.ru>
 <1442314179-9706-6-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1442314179-9706-6-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 15, 2015 at 08:49:35PM +1000, Alexey Kardashevskiy wrote:
> At the moment pages used for TCE tables (in addition to pages addressed
> by TCEs) are not counted in locked_vm counter so a malicious userspace
> tool can call ioctl(KVM_CREATE_SPAPR_TCE) as many times as RLIMIT_NOFILE and
> lock a lot of memory.
> 
> This adds counting for pages used for TCE tables.
> 
> This counts the number of pages required for a table plus pages for
> the kvmppc_spapr_tce_table struct (TCE table descriptor) itself.
> 
> This does not change the amount of (de)allocated memory.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/kvm/book3s_64_vio.c | 51 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
> index 9526c34..b70787d 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -45,13 +45,56 @@ static long kvmppc_stt_npages(unsigned long window_size)
>  		     * sizeof(u64), PAGE_SIZE) / PAGE_SIZE;
>  }
>  
> +static long kvmppc_account_memlimit(long npages, bool inc)
> +{
> +	long ret = 0;
> +	const long bytes = sizeof(struct kvmppc_spapr_tce_table) +
> +			(abs(npages) * sizeof(struct page *));

Why abs(npages)?  Can npages be negative?  If so, what does that mean?

Paul.
