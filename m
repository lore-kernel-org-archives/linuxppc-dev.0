Return-Path: <dja@axtens.net>
Received: from mail-pa0-x232.google.com (mail-pa0-x232.google.com
 [IPv6:2607:f8b0:400e:c03::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB0991A041D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 09:04:52 +1100 (AEDT)
Received: by padhk11 with SMTP id hk11so234628732pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 15:04:50 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 bhelgaas@google.com, mpe@ellerman.id.au, aik@ozlabs.ru
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V10 03/12] powerpc/pci: Cache VF index in pci_dn
In-Reply-To: <1445829362-2738-4-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1445829362-2738-4-git-send-email-weiyang@linux.vnet.ibm.com>
Date: Wed, 28 Oct 2015 09:04:34 +1100
Message-ID: <87pp00otn1.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-=-=
Content-Type: text/plain

Hi,

>
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index b3a226b..3d7e537 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -210,6 +210,7 @@ struct pci_dn {
>  #define IODA_INVALID_PE		(-1)
>  #ifdef CONFIG_PPC_POWERNV
>  	int	pe_number;
> +	int     vf_index;		/* VF index in the PF */

Here, vf_index is inside CONFIG_PPC_POWERNV...

>  #ifdef CONFIG_PCI_IOV
>  	u16     vfs_expanded;		/* number of VFs IOV BAR expanded */
>  	u16     num_vfs;		/* number of VFs enabled*/
> diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
> index b3b4df9..f771130 100644
> --- a/arch/powerpc/kernel/pci_dn.c
> +++ b/arch/powerpc/kernel/pci_dn.c
> @@ -139,6 +139,7 @@ struct pci_dn *pci_get_pdn(struct pci_dev *pdev)
>  #ifdef CONFIG_PCI_IOV
>  static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
>  					   struct pci_dev *pdev,
> +					   int vf_index,
>  					   int busno, int devfn)
>  {
>  	struct pci_dn *pdn;
> @@ -157,6 +158,7 @@ static struct pci_dn *add_one_dev_pci_data(struct pci_dn *parent,
>  	pdn->parent = parent;
>  	pdn->busno = busno;
>  	pdn->devfn = devfn;
> +	pdn->vf_index = vf_index;
>  #ifdef CONFIG_PPC_POWERNV
>  	pdn->pe_number = IODA_INVALID_PE;
... but here, vf_index is outside CONFIG_PPC_POWERNV.

Otherwise, the patch looks fine to me.

I'm still trying to get my head around SR-IOV generally - once I do I
will add any more comments I have or add a reviewed-by.

Regards,
Daniel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: GPGTools - https://gpgtools.org

iQIcBAEBCgAGBQJWL/TyAAoJEPC3R3P2I92FDOYQAK308mSVjJMwzWsRyQjYYhZl
Hrow29pj8Lu4gmTdntb4xWX0+hc8uIbJpFk0mvFzIhCv/QhY0PQgURK04FQQLiv9
lti0624zP1ah6C7JzLRkRQsCbZAuTpMlj/IvHroFg0YJQNdKkyCM2ijq+7SrKzkJ
OUD10QA9RGTTX8tt6BfW6hHoxMPA4EB+I074LLQtNMjQcZRQh8aE/ezSpIazrPV/
yhac7Jgf6evmRCl/xovRi5YPZs+qnyKm79o5YSaug0VLVEDwtMXySwgtKsPIZzF7
HFCDmS9ThWo+Td9R0+dnybOgwxFhXW59aTbXcs7VLFRUtO0U1gJvv3ytKtLL1aSa
GqxPcBhrpDeJJw1Yd94rxx7ZK8n0vJ4sAtdqCHwPsbG6wxax7YlvnNnSFzBvWerv
5LUrEd1SEm5CE9gQrp7GLQsGg+dSPT++0muBPyA4YUMQLfsngYOmIzST620L7bfX
jIZYIh/9JaB/GHJf4vQQ8FiZ5rHi2UEyfan3dWOgP5Tj+XXk/5bLWSQk5TV2Sc47
t9kFgTtq1nwhfSl3SMsOdwtByxWhNhDrTCFYJbnbCBhAn0waJ7Ig1sMfp9lF9yMi
m4IYattxpuJmVWlLC/0LAvFUuCdyiIkH68O8XjZcuaxtpEFNxcGtyoSXJ7bZ0AlW
9pSia8FdoYjscWeP5sSL
=i6vB
-----END PGP SIGNATURE-----
--=-=-=--
