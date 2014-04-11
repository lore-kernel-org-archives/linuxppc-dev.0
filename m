Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 61EC51400A8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Apr 2014 00:03:17 +1000 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH v3] powerpc: kvm: make _PAGE_NUMA take effect
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1397216707-12795-1-git-send-email-pingfank@linux.vnet.ibm.com>
Date: Fri, 11 Apr 2014 16:03:09 +0200
Message-Id: <3DC9A8E1-547C-4660-AB61-BE371DEDA520@suse.de>
References: <1397216707-12795-1-git-send-email-pingfank@linux.vnet.ibm.com>
To: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 11.04.2014, at 13:45, Liu Ping Fan <pingfank@linux.vnet.ibm.com> =
wrote:

> When we mark pte with _PAGE_NUMA we already call =
mmu_notifier_invalidate_range_start
> and mmu_notifier_invalidate_range_end, which will mark existing guest =
hpte
> entry as HPTE_V_ABSENT. Now we need to do that when we are inserting =
new
> guest hpte entries.

What happens when we don't? Why do we need the check? Why isn't it done =
implicitly? What happens when we treat a NUMA marked page as =
non-present? Why does it work out for us?

Assume you have no idea what PAGE_NUMA is, but try to figure out what =
this patch does and whether you need to cherry-pick it into your =
downstream kernel. The description as is still is not very helpful for =
that. It doesn't even explain what really changes with this patch =
applied.

>=20
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
> v3:
>  rebased onto Alex's tree, branch kvm-ppc-next
>  substitue commit log with the more clear description in Aneesh's =
reply (thanks, Aneesh)
> ---
> arch/powerpc/kvm/book3s_hv_rm_mmu.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c =
b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> index 1d6c56a..1117525 100644
> --- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> +++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
> @@ -234,7 +234,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned =
long flags,
> 		pte_size =3D psize;
> 		pte =3D lookup_linux_pte_and_update(pgdir, hva, writing,
> 						  &pte_size);
> -		if (pte_present(pte)) {
> +		if (pte_present(pte)&&!pte_numa(pte)) {

Spaces missing


Alex
