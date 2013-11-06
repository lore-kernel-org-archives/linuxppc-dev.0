Return-Path: <paulus@ozlabs.org>
Date: Wed, 6 Nov 2013 16:04:18 +1100
From: Paul Mackerras <paulus@samba.org>
To: Liu Ping Fan <kernelfans@gmail.com>
Subject: Re: [PATCH 2/3] powerpc/kvm: fix rare but potential deadlock scene
Message-ID: <20131106050418.GD14842@drongo>
References: <1383637364-14691-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <1383637364-14691-2-git-send-email-pingfank@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383637364-14691-2-git-send-email-pingfank@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 05, 2013 at 03:42:43PM +0800, Liu Ping Fan wrote:
> Since kvmppc_hv_find_lock_hpte() is called from both virtmode and
> realmode, so it can trigger the deadlock.

Good catch, we should have preemption disabled while ever we have a
HPTE locked.

> @@ -474,8 +474,10 @@ static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
>  	}
>  
>  	/* Find the HPTE in the hash table */
> +	preempt_disable();
>  	index = kvmppc_hv_find_lock_hpte(kvm, eaddr, slb_v,
>  					 HPTE_V_VALID | HPTE_V_ABSENT);
> +	preempt_enable();

Which means we need to add the preempt_enable after unlocking the
HPTE, not here.

Regards,
Paul.
