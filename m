Return-Path: <pbonzini@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v6YDw3fp3zDqQD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 01:13:04 +1100 (AEDT)
Subject: Re: [PATCH 01/11] KVM: PPC: Book3S HV: Move assignments for the
 variable "err" in kvm_htab_write()
To: SF Markus Elfring <elfring@users.sourceforge.net>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <rkrcmar@redhat.com>
References: <fc2c36e6-a453-ae09-89bf-98b3d74113a4@users.sourceforge.net>
 <51bcdd72-467c-8afb-94cb-fd756b3d63a7@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7e09721f-2785-4c34-cfe8-593acafc455e@redhat.com>
Date: Mon, 23 Jan 2017 15:12:55 +0100
MIME-Version: 1.0
In-Reply-To: <51bcdd72-467c-8afb-94cb-fd756b3d63a7@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 20/01/2017 19:19, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 19 Jan 2017 22:45:56 +0100
> 
> * A local variable was set to an error code in five cases
>   before a concrete error situation was detected.
>   Thus move the corresponding assignments into
>   if branches to indicate a software failure there.
> 
>   This issue was detected by using the Coccinelle software.
> 
> * Delete two zero assignments which became unnecessary with
>   this refactoring.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

NACK, current code uses consistent style.

> ---
>  arch/powerpc/kvm/book3s_64_mmu_hv.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index b795dd1ac2ef..dc34729e4ad0 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -1399,22 +1399,23 @@ static ssize_t kvm_htab_write(struct file *file, const char __user *buf,
>  
>  	err = 0;
>  	for (nb = 0; nb + sizeof(hdr) <= count; ) {
> -		err = -EFAULT;
> -		if (__copy_from_user(&hdr, buf, sizeof(hdr)))
> +		if (__copy_from_user(&hdr, buf, sizeof(hdr))) {
> +			err = -EFAULT;
>  			break;
> +		}
>  
> -		err = 0;
>  		if (nb + hdr.n_valid * HPTE_SIZE > count)
>  			break;
>  
>  		nb += sizeof(hdr);
>  		buf += sizeof(hdr);
>  
> -		err = -EINVAL;
>  		i = hdr.index;
>  		if (i >= kvm->arch.hpt_npte ||
> -		    i + hdr.n_valid + hdr.n_invalid > kvm->arch.hpt_npte)
> +		    i + hdr.n_valid + hdr.n_invalid > kvm->arch.hpt_npte) {
> +			err = -EINVAL;
>  			break;
> +		}
>  
>  		hptp = (__be64 *)(kvm->arch.hpt_virt + (i * HPTE_SIZE));
>  		lbuf = (unsigned long __user *)buf;
> @@ -1422,26 +1423,28 @@ static ssize_t kvm_htab_write(struct file *file, const char __user *buf,
>  			__be64 hpte_v;
>  			__be64 hpte_r;
>  
> -			err = -EFAULT;
>  			if (__get_user(hpte_v, lbuf) ||
> -			    __get_user(hpte_r, lbuf + 1))
> +			    __get_user(hpte_r, lbuf + 1)) {
> +				err = -EFAULT;
>  				goto out;
> +			}
>  			v = be64_to_cpu(hpte_v);
>  			r = be64_to_cpu(hpte_r);
> -			err = -EINVAL;
> -			if (!(v & HPTE_V_VALID))
> +			if (!(v & HPTE_V_VALID)) {
> +				err = -EINVAL;
>  				goto out;
> +			}
>  			lbuf += 2;
>  			nb += HPTE_SIZE;
>  
>  			if (be64_to_cpu(hptp[0]) & (HPTE_V_VALID | HPTE_V_ABSENT))
>  				kvmppc_do_h_remove(kvm, 0, i, 0, tmp);
> -			err = -EIO;
>  			ret = kvmppc_virtmode_do_h_enter(kvm, H_EXACT, i, v, r,
>  							 tmp);
>  			if (ret != H_SUCCESS) {
>  				pr_err("kvm_htab_write ret %ld i=%ld v=%lx "
>  				       "r=%lx\n", ret, i, v, r);
> +				err = -EIO;
>  				goto out;
>  			}
>  			if (!hpte_setup && is_vrma_hpte(v)) {
> @@ -1465,7 +1468,6 @@ static ssize_t kvm_htab_write(struct file *file, const char __user *buf,
>  			++i;
>  			hptp += 2;
>  		}
> -		err = 0;
>  	}
>  
>   out:
> 
