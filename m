Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0008.hostedemail.com
 [216.40.44.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yr7QF0rpkzDrRp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Dec 2017 02:02:12 +1100 (AEDT)
Message-ID: <1512399725.6321.44.camel@perches.com>
Subject: Re: [PATCH v2 1/2] KVM: PPC: Book3S HV: Drop prepare_done from
 struct kvm_resize_hpt and cleanups
From: Joe Perches <joe@perches.com>
To: Serhii Popovych <spopovyc@redhat.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, michael@ellerman.id.au,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org, david@gibson.dropbear.id.au
Date: Mon, 04 Dec 2017 07:02:05 -0800
In-Reply-To: <1512398202-8195-2-git-send-email-spopovyc@redhat.com>
References: <1512398202-8195-1-git-send-email-spopovyc@redhat.com>
 <1512398202-8195-2-git-send-email-spopovyc@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-12-04 at 09:36 -0500, Serhii Popovych wrote:
> Change comparison against zero to make checkpatch.pl happy.

Huh?  Either I'm confused or you are incorrect here.

checkpatch should or does not warn against comparisons
to zero.  There is a test for comparison to NULL.

> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
[]
> @@ -1547,16 +1561,12 @@ long kvm_vm_ioctl_resize_hpt_commit(struct kvm *kvm,
>  	if (!resize || (resize->order != shift))
>  		goto out;
>  
> -	ret = -EBUSY;
> -	if (!resize->prepare_done)
> -		goto out;
> -
>  	ret = resize->error;
> -	if (ret != 0)
> +	if (ret)
>  		goto out;
>  
>  	ret = resize_hpt_rehash(resize);
> -	if (ret != 0)
> +	if (ret)
>  		goto out;
>  
>  	resize_hpt_pivot(resize);
