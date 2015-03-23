Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B5E51A2B56
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 14:12:09 +1100 (AEDT)
Date: Mon, 23 Mar 2015 14:12:05 +1100
From: Paul Mackerras <paulus@samba.org>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc/book3s: Fix the MCE code to use
 CONFIG_KVM_BOOK3S_64_HANDLER
Message-ID: <20150323031205.GB8257@drongo>
References: <20150317103356.27872.65515.stgit@mars>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150317103356.27872.65515.stgit@mars>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, David Gibson <dgibson@redhat.com>,
 Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 17, 2015 at 04:14:41PM +0530, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> commit id 2ba9f0d has changed CONFIG_KVM_BOOK3S_64_HV to tristate to allow
> HV/PR bits to be built as modules. But the MCE code still depends on
> CONFIG_KVM_BOOK3S_64_HV which is wrong. When user selects
> CONFIG_KVM_BOOK3S_64_HV=m to build HV/PR bits as a separate module the
> relevant MCE code gets excluded.
> 
> This patch fixes the MCE code to use CONFIG_KVM_BOOK3S_64_HANDLER. This
> makes sure that the relevant MCE code is included when HV/PR bits
> are built as a separate modules.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
> Hi Michael,
> 	This patch should also goto stable.
> 
>  arch/powerpc/kernel/exceptions-64s.S |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index c2df815..9519e6b 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1408,7 +1408,7 @@ machine_check_handle_early:
>  	bne	9f			/* continue in V mode if we are. */
>  
>  5:
> -#ifdef CONFIG_KVM_BOOK3S_64_HV
> +#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
>  	/*
>  	 * We are coming from kernel context. Check if we are coming from
>  	 * guest. if yes, then we can continue. We will fall through

Acked-by: Paul Mackerras <paulus@samba.org>
Cc: stable@vger.kernel.org  # v3.14+
