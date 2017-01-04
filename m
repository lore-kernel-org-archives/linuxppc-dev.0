Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttWdH3LnxzDqGL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 11:18:59 +1100 (AEDT)
Message-ID: <1483489137.6577.11.camel@neuling.org>
Subject: Re: [PATCH] powerpc/mm/hugetlb: Don't panic if we don't find the
 default huge page size
From: Michael Neuling <mikey@neuling.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, Chris Smart
 <csmart@ozlabs.au.ibm.com>, Christophe Leroy <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 04 Jan 2017 11:18:57 +1100
In-Reply-To: <20161213140411.20633-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20161213140411.20633-1-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-12-13 at 19:34 +0530, Aneesh Kumar K.V wrote:
> generic hugetlbfs can handle that condition correctly. With HPAGE_SHIFT =
=3D 0
> we get
> [0.241333] hugetlbfs: disabling because there are no supported hugepage s=
izes
>=20
> bash-4.2# echo 30 > /proc/sys/vm/nr_hugepages
> bash: echo: write error: Operation not supported
>=20
> Fixes: "powerpc: get hugetlbpage handling more generic"
> Reported-by: Chris Smart <csmart@ozlabs.au.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Acked-By: Michael Neuling <mikey@neuling.org>

> ---
> =C2=A0arch/powerpc/mm/hugetlbpage.c | 3 ---
> =C2=A01 file changed, 3 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.=
c
> index 289df38fb7e0..e46bbd716832 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -852,9 +852,6 @@ static int __init hugetlbpage_init(void)
> =C2=A0	else if (mmu_psize_defs[MMU_PAGE_2M].shift)
> =C2=A0		HPAGE_SHIFT =3D mmu_psize_defs[MMU_PAGE_2M].shift;
> =C2=A0#endif
> -	else
> -		panic("%s: Unable to set default huge page size\n",
> __func__);
> -
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
