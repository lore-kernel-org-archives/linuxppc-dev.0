Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id A77942C011C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 21:41:04 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1812\))
Subject: Re: [PATCH v3] powerpc: kvm: optimize "sc 1" as fast return
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1384841568-20986-2-git-send-email-pingfank@linux.vnet.ibm.com>
Date: Tue, 19 Nov 2013 11:40:56 +0100
Message-Id: <EF086F2D-EC59-4014-921C-18CA0EA0679F@suse.de>
References: <1384841568-20986-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <1384841568-20986-2-git-send-email-pingfank@linux.vnet.ibm.com>
To: Liu Ping Fan <kernelfans@gmail.com>
Cc: Gleb Natapov <gleb@redhat.com>,
 "kvm@vger.kernel.org mailing list" <kvm@vger.kernel.org>,
 kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 19.11.2013, at 07:12, Liu Ping Fan <kernelfans@gmail.com> wrote:

> In some scene, e.g openstack CI, PR guest can trigger "sc 1" =
frequently,
> this patch optimizes the path by directly delivering =
BOOK3S_INTERRUPT_SYSCALL
> to HV guest, so powernv can return to HV guest without heavy exit, =
i.e,
> no need to swap TLB, HTAB,.. etc
>=20
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> ---
> v3: add some document

This is v4 I think

> ---
> arch/powerpc/kvm/book3s_hv.c            | 10 ++++------
> arch/powerpc/kvm/book3s_hv_rmhandlers.S | 19 ++++++++++++++++++-
> 2 files changed, 22 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_hv.c =
b/arch/powerpc/kvm/book3s_hv.c
> index 62a2b5a..1addb1a 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -628,12 +628,10 @@ static int kvmppc_handle_exit(struct kvm_run =
*run, struct kvm_vcpu *vcpu,
> 		/* hcall - punt to userspace */
> 		int i;
>=20
> -		if (vcpu->arch.shregs.msr & MSR_PR) {
> -			/* sc 1 from userspace - reflect to guest =
syscall */
> -			kvmppc_book3s_queue_irqprio(vcpu, =
BOOK3S_INTERRUPT_SYSCALL);
> -			r =3D RESUME_GUEST;
> -			break;
> -		}
> +		/* hypercall with MSR_PR has already been handled in =
rmode,
> +		 * and never reaches here.
> +		 */

It would've been nice to also mention the real mode hypercall handling, =
but I can just post a follow-up patch for that one.


Thanks, applied to kvm-ppc-queue.

Alex
