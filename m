Return-Path: <paulus@ozlabs.org>
Date: Thu, 26 Sep 2013 08:31:18 +1000
From: Paul Mackerras <paulus@samba.org>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/kvmbook3s_hv: propagate H_SET_MODE to the host
Message-ID: <20130925223118.GA2844@iris.ozlabs.ibm.com>
References: <1379901913-5945-37-git-send-email-anton@samba.org>
 <20130925121027.29504.19269.stgit@nimbus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130925121027.29504.19269.stgit@nimbus>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 25, 2013 at 02:10:27PM +0200, Laurent Dufour wrote:
> Follow-up to Anton's H_SET_MODE patch, the host should be taken aware of
> guest endianess change.
> 
> The hcall H_SET_MODE is processed in kvm then in the host.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 998cad3..4a47c74 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -599,6 +599,14 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
>  					kvmppc_get_gpr(vcpu, 5),
>  					kvmppc_get_gpr(vcpu, 6),
>  					kvmppc_get_gpr(vcpu, 7));
> +		/*
> +		 * If the hcall succeeded, we propagate it to the host.
> +		 * This way, it will be aware of the endianess's change too.
> +		 * The assumption is made that the hcall will succeed in the
> +		 * host.
> +		 */
> +		if (ret == H_SUCCESS)
> +			return RESUME_HOST;
>  		break;

The problem with this is that H_SET_MODE isn't just used for setting
endianness; it also does breakpoint setting (DAWR/X and CIABR), which
might happen very frequently, so we don't want them being punted up to
userspace.

Paul.
