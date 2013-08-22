Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 5E5CB2C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 02:48:43 +1000 (EST)
Subject: Re: [PATCH] powerpc/kvm: Handle the boundary condition correctly
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1377171479-25738-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 22 Aug 2013 17:48:41 +0100
Message-Id: <1683D101-052D-4BEB-8ED1-6F32C6904850@suse.de>
References: <1377171479-25738-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 22.08.2013, at 12:37, Aneesh Kumar K.V wrote:

> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Isn't this you?

>=20
> We should be able to copy upto count bytes

Why?


Alex

>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
> arch/powerpc/kvm/book3s_64_mmu_hv.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c =
b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> index 710d313..0ae6bb6 100644
> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
> @@ -1362,7 +1362,7 @@ static ssize_t kvm_htab_read(struct file *file, =
char __user *buf,
> 	lbuf =3D (unsigned long __user *)buf;
>=20
> 	nb =3D 0;
> -	while (nb + sizeof(hdr) + HPTE_SIZE < count) {
> +	while (nb + sizeof(hdr) + HPTE_SIZE <=3D count) {
> 		/* Initialize header */
> 		hptr =3D (struct kvm_get_htab_header __user *)buf;
> 		hdr.n_valid =3D 0;
> @@ -1385,7 +1385,7 @@ static ssize_t kvm_htab_read(struct file *file, =
char __user *buf,
> 		/* Grab a series of valid entries */
> 		while (i < kvm->arch.hpt_npte &&
> 		       hdr.n_valid < 0xffff &&
> -		       nb + HPTE_SIZE < count &&
> +		       nb + HPTE_SIZE <=3D count &&
> 		       record_hpte(flags, hptp, hpte, revp, 1, =
first_pass)) {
> 			/* valid entry, write it out */
> 			++hdr.n_valid;
> --=20
> 1.8.1.2
>=20
