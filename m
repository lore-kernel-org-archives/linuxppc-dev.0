Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 042B52C008E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2013 21:06:08 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1812\))
Subject: Re: [PATCH v2 2/2] powerpc/kvm: remove redundant assignment
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1383805375-14766-2-git-send-email-pingfank@linux.vnet.ibm.com>
Date: Thu, 7 Nov 2013 11:06:01 +0100
Message-Id: <CF6D863C-3E0A-4BEF-B985-77B336BA92F1@suse.de>
References: <1383805375-14766-1-git-send-email-pingfank@linux.vnet.ibm.com>
 <1383805375-14766-2-git-send-email-pingfank@linux.vnet.ibm.com>
To: Liu Ping Fan <kernelfans@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 07.11.2013, at 07:22, Liu Ping Fan <kernelfans@gmail.com> wrote:

> ret is assigned twice with the same value, so remove the later one.
>=20
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> Acked-by: Paul Mackerras <paulus@samba.org>

I suppose my last request for a patch description was slightly too =
abbreviated :). Sorry about that.

Imagine you are a Linux-stable maintainer. You have about 5000 patches =
in front of you and you want to figure out whether a patch should get =
backported into a stable tree or not.

It's very easy to read through the patch description.
It's reasonably easy to do a git show on the patch.
It's very hard to look at the actual surrounding code that was changed.

If I open a text editor on the file, I immediately see what you're =
saying:

>         ret =3D RESUME_GUEST;
>         preempt_disable();
>         while (!try_lock_hpte(hptep, HPTE_V_HVLOCK))
>                 cpu_relax();
>         if ((hptep[0] & ~HPTE_V_HVLOCK) !=3D hpte[0] || hptep[1] !=3D =
hpte[1] ||
>             rev->guest_rpte !=3D hpte[2])
>                 /* HPTE has been changed under us; let the guest retry =
*/
>                 goto out_unlock;
>         hpte[0] =3D (hpte[0] & ~HPTE_V_ABSENT) | HPTE_V_VALID;
>=20
>         rmap =3D &memslot->arch.rmap[gfn - memslot->base_gfn];
>         lock_rmap(rmap);
>=20
>         /* Check if we might have been invalidated; let the guest =
retry if so */
>         ret =3D RESUME_GUEST;

However, that scope is not given in the actual patch itself. If you look =
at the diff below, you have no idea whether the patch is fixing a bug or =
just removes duplication and doesn't actually have any effect. In fact, =
the compiled assembly should be the same with this patch and without. =
But you can't tell from the diff below.

So what I would like to see in the patch description is something that =
makes it easy to understand what's going on without the need to check =
out the source file. Something like

> We redundantly set ret to RESUME_GUEST twice without changing it in =
between. Only do it once:
>=20
>         ret =3D RESUME_GUEST;
>         preempt_disable();
>         while (!try_lock_hpte(hptep, HPTE_V_HVLOCK))
>                 cpu_relax();
>         if ((hptep[0] & ~HPTE_V_HVLOCK) !=3D hpte[0] || hptep[1] !=3D =
hpte[1] ||
>             rev->guest_rpte !=3D hpte[2])
>                 /* HPTE has been changed under us; let the guest retry =
*/
>                 goto out_unlock;
>         hpte[0] =3D (hpte[0] & ~HPTE_V_ABSENT) | HPTE_V_VALID;
>=20
>         rmap =3D &memslot->arch.rmap[gfn - memslot->base_gfn];
>         lock_rmap(rmap);
>=20
>         /* Check if we might have been invalidated; let the guest =
retry if so */
>         ret =3D RESUME_GUEST;


If I look at that patch description it immediately tells me "Ah, no need =
to worry, it's not a critical bug I need to backport". If you have a =
better idea how to express that I'm more than happy to take that too. =
Otherwise just let me know whether you like the description above and =
I'll modify it to the one that includes the code snippet when applying =
the patch.


Thanks a lot,

Alex

> ---
> arch/powerpc/kvm/book3s_64_mmu_hv.c | 1 -
> 1 file changed, 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c =
b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index dbc1478..9b97b42 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -733,7 +733,6 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run =
*run, struct kvm_vcpu *vcpu,
> 	lock_rmap(rmap);
>=20
> 	/* Check if we might have been invalidated; let the guest retry =
if so */
> -	ret =3D RESUME_GUEST;
> 	if (mmu_notifier_retry(vcpu->kvm, mmu_seq)) {
> 		unlock_rmap(rmap);
> 		goto out_unlock;
> --=20
> 1.8.1.4
>=20
