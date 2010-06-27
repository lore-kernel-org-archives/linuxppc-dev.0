Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id A67C7B6F05
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 27 Jun 2010 18:24:05 +1000 (EST)
Message-ID: <4C270AA1.5030801@redhat.com>
Date: Sun, 27 Jun 2010 11:24:01 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 12/26] KVM: PPC: First magic page steps
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-13-git-send-email-agraf@suse.de>
In-Reply-To: <1277508314-915-13-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/26/2010 02:25 AM, Alexander Graf wrote:
> We will be introducing a method to project the shared page in guest context.
> As soon as we're talking about this coupling, the shared page is colled magic
> page.
>
> This patch introduces simple defines, so the follow-up patches are easier to
> read.
>
>
>
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index e35c1ac..5f8c214 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -285,6 +285,8 @@ struct kvm_vcpu_arch {
>   	u64 dec_jiffies;
>   	unsigned long pending_exceptions;
>   	struct kvm_vcpu_arch_shared *shared;
> +	unsigned long magic_page_pa; /* phys addr to map the magic page to */
> +	unsigned long magic_page_ea; /* effect. addr to map the magic page to */
>    

Is ea like a va?  If so, can't the guest specify it by manipulating the 
hash table (or tlb)?

-- 
error compiling committee.c: too many arguments to function
