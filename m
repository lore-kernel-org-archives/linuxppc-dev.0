Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id A062EDDD07
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2007 00:08:46 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ehca: map 4k firmware context of cq, qp to user space
Date: Thu, 2 Aug 2007 16:08:15 +0200
References: <200708021139.31695.hnguyen@linux.vnet.ibm.com>
In-Reply-To: <200708021139.31695.hnguyen@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708021608.16436.arnd@arndb.de>
Cc: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
	raisch@de.ibm.com, paulus@samba.org, general@lists.openfabrics.org,
	Hoang-Nam Nguyen <hnguyen@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 02 August 2007, Hoang-Nam Nguyen wrote:
> +#ifdef CONFIG_PPC_64K_PAGES
> +=A0=A0=A0=A0=A0=A0=A0/* make sure we map only 4k for fw context */
> +=A0=A0=A0=A0=A0=A0=A0ret =3D remap_4k_pfn(vma, vma->vm_start, physical >=
> EHCA_PAGESHIFT,
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=A0 vma->vm_page_prot);
> +#else
> =A0=A0=A0=A0=A0=A0=A0=A0ret =3D remap_pfn_range(vma, vma->vm_start, physi=
cal >> PAGE_SHIFT,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
=A0 =A0 =A0vsize, vma->vm_page_prot);
> +#endif

remap_4k_pfn is defined in terms of remap_pfn_range if the base page
size if 4k, so you don't need this #ifdef afaics.

otherwise, the patch looks good.

	Arnd <><
