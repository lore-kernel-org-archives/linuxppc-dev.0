Return-Path: <paulus@ozlabs.org>
Date: Mon, 18 Mar 2013 08:26:48 +1100
From: Paul Mackerras <paulus@samba.org>
To: Lai Jiangshan <laijs@cn.fujitsu.com>
Subject: Re: [PATCH 1/9] powerpc,kvm: fix imbalance srcu_read_[un]lock()
Message-ID: <20130317212648.GA4259@iris.ozlabs.ibm.com>
References: <1363366257-4886-1-git-send-email-laijs@cn.fujitsu.com>
 <1363366257-4886-2-git-send-email-laijs@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1363366257-4886-2-git-send-email-laijs@cn.fujitsu.com>
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 16, 2013 at 12:50:49AM +0800, Lai Jiangshan wrote:
> At the point of up_out label in kvmppc_hv_setup_htab_rma(),
> srcu read lock is still held.
> 
> We have to release it before return.
> 
> Signed-off-by: Lai Jiangshan <laijs@cn.fujitsu.com>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Gleb Natapov <gleb@redhat.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: kvm@vger.kernel.org
> Cc: kvm-ppc@vger.kernel.org
> ---
>  arch/powerpc/kvm/book3s_hv.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 80dcc53..c26740e 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -1799,7 +1799,7 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu)
>  
>   up_out:
>  	up_read(&current->mm->mmap_sem);
> -	goto out;
> +	goto out_srcu;

Acked-by: Paul Mackerras <paulus@samba.org>
