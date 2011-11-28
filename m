Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 61073B6F81
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2011 03:01:23 +1100 (EST)
Subject: Re: [PATCH 03/13] powerpc: Fix booke hugetlb preload code for
 PPC_MM_SLICES and 64-bit
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1322181832.32635.14.camel@pasglop>
Date: Mon, 28 Nov 2011 10:01:06 -0600
Message-Id: <8EB69A3C-B196-4178-BDAD-D5533DA9A0E5@kernel.crashing.org>
References: <1318279848494-git-send-email-beckyb@kernel.crashing.org>
 <13182798624083-git-send-email-beckyb@kernel.crashing.org>
 <13182798643553-git-send-email-beckyb@kernel.crashing.org>
 <13182798681100-git-send-email-beckyb@kernel.crashing.org>
 <1322181832.32635.14.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 24, 2011, at 6:43 PM, Benjamin Herrenschmidt wrote:

> On Mon, 2011-10-10 at 15:50 -0500, Becky Bruce wrote:
>=20
> .../...
>=20
>> #ifdef CONFIG_PPC_MM_SLICES
>> -	psize =3D mmu_get_tsize(get_slice_psize(mm, ea));
>> -	tsize =3D mmu_get_psize(psize);
>> +	psize =3D get_slice_psize(mm, ea);
>> +	tsize =3D mmu_get_tsize(psize);
>> 	shift =3D mmu_psize_defs[psize].shift;
>> #else
>> -	vma =3D find_vma(mm, ea);
>> -	psize =3D vma_mmu_pagesize(vma);	/* returns actual size =
in bytes */
>> -	asm (PPC_CNTLZL "%0,%1" : "=3Dr" (lz) : "r" (psize));
>> -	shift =3D 31 - lz;
>> -	tsize =3D 21 - lz;
>> +	psize =3D vma_mmu_pagesize(find_vma(mm, ea));
>> +	shift =3D __ilog2(psize);
>> +	tsize =3D shift - 10;
>> #endif
>=20
> Now, I know it was already there and you are just moving it around in
> this patch but come on ... find_vma() here ? Really ? And with no =
result
> checking nor boundary checking (remember it can return a vma that
> doesn't enclose the address etc....). Now I know in this specific case
> it -should- be safe but still...
>=20
> Now, the caller is just doing:
>=20
> 	book3e_hugetlb_preload(vma->vm_mm, address, *ptep);
>=20
> So why not just change the prototype and pass the vma down instead ?

Can we do this on top of the patchset instead of changing the existing =
patchset?

- k=
