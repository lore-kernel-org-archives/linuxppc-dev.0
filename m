Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vBjTY0ZTRzDqCW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 19:38:25 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [PATCH v5 1/4] powerpc/mm: refactor radix physical page mapping
In-Reply-To: <1484593666-8001-2-git-send-email-arbab@linux.vnet.ibm.com>
References: <1484593666-8001-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1484593666-8001-2-git-send-email-arbab@linux.vnet.ibm.com>
Date: Mon, 30 Jan 2017 19:38:18 +1100
Message-ID: <87o9ypvt6t.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reza Arbab <arbab@linux.vnet.ibm.com> writes:

> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-ra=
dix.c
> index 623a0dc..2ce1354 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -107,54 +107,66 @@ int radix__map_kernel_page(unsigned long ea, unsign=
ed long pa,
>  	return 0;
>  }
>=20=20
> +static inline void __meminit print_mapping(unsigned long start,
> +					   unsigned long end,
> +					   unsigned long size)
> +{
> +	if (end <=3D start)
> +		return;
> +
> +	pr_info("Mapped range 0x%lx - 0x%lx with 0x%lx\n", start, end, size);
> +}
> +
> +static int __meminit create_physical_mapping(unsigned long start,
> +					     unsigned long end)
> +{
> +	unsigned long addr, mapping_size;
> +
> +	start =3D _ALIGN_UP(start, PAGE_SIZE);
> +	for (addr =3D start; addr < end; addr +=3D mapping_size) {
> +		unsigned long gap, previous_size;
> +		int rc;
> +
> +		gap =3D end - addr;
> +		previous_size =3D mapping_size;
> +
> +		if (IS_ALIGNED(addr, PUD_SIZE) && gap >=3D PUD_SIZE &&
> +		    mmu_psize_defs[MMU_PAGE_1G].shift)
> +			mapping_size =3D PUD_SIZE;
> +		else if (IS_ALIGNED(addr, PMD_SIZE) && gap >=3D PMD_SIZE &&
> +			 mmu_psize_defs[MMU_PAGE_2M].shift)
> +			mapping_size =3D PMD_SIZE;
> +		else
> +			mapping_size =3D PAGE_SIZE;
> +
> +		if (mapping_size !=3D previous_size) {
> +			print_mapping(start, addr, previous_size);
> +			start =3D addr;
> +		}
> +
> +		rc =3D radix__map_kernel_page((unsigned long)__va(addr), addr,
> +					    PAGE_KERNEL_X, mapping_size);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	print_mapping(start, addr, mapping_size);

Doesn't build.


In file included from ../include/linux/kernel.h:13:0,
                 from ../include/linux/sched.h:17,
                 from ../arch/powerpc/mm/pgtable-radix.c:11:
../arch/powerpc/mm/pgtable-radix.c: In function =E2=80=98create_physical_ma=
pping=E2=80=99:
../include/linux/printk.h:299:2: error: =E2=80=98mapping_size=E2=80=99 may =
be used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
  printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~
../arch/powerpc/mm/pgtable-radix.c:123:22: note: =E2=80=98mapping_size=E2=
=80=99 was declared here
  unsigned long addr, mapping_size;
                      ^~~~~~~~~~~~


cheers
