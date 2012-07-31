Return-Path: <gerald.schaefer@de.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp12.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 61C542C0081
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2012 22:23:03 +1000 (EST)
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gerald.schaefer@de.ibm.com>;
 Tue, 31 Jul 2012 13:22:57 +0100
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by d06nrmr1507.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q6VCMss52957510
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2012 13:22:55 +0100
Received: from d06av11.portsmouth.uk.ibm.com (loopback [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q6VCMrUo011780
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2012 06:22:54 -0600
Date: Tue, 31 Jul 2012 14:22:51 +0200
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
To: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [RFC PATCH v5 16/19] memory-hotplug: free memmap of sparse-vmemmap
Message-ID: <20120731142251.5b2cae37@thinkpad>
In-Reply-To: <50126EBE.1020006@cn.fujitsu.com>
References: <50126B83.3050201@cn.fujitsu.com> <50126EBE.1020006@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-acpi@vger.kernel.org, len.brown@intel.com, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
 Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 cl@linux.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 liuj97@gmail.com
Reply-To: gerald.schaefer@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 27 Jul 2012 18:34:38 +0800
Wen Congyang <wency@cn.fujitsu.com> wrote:

> From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> 
> All pages of virtual mapping in removed memory cannot be freed, since
> some pages used as PGD/PUD includes not only removed memory but also
> other memory. So the patch checks whether page can be freed or not.
> 
> How to check whether page can be freed or not?
>  1. When removing memory, the page structs of the revmoved memory are
> filled with 0FD.
>  2. All page structs are filled with 0xFD on PT/PMD, PT/PMD can be
> cleared. In this case, the page used as PT/PMD can be freed.
> 
> Applying patch, __remove_section() of CONFIG_SPARSEMEM_VMEMMAP is
> integrated into one. So __remove_section() of
> CONFIG_SPARSEMEM_VMEMMAP is deleted.

There should also be generic or dummy versions of the functions
vmemmap_free_bootmem(), vmemmap_kfree() and
register_page_bootmem_memmap(). It doesn't compile on other
archtitectures than x86 as it is now:

mm/built-in.o: In function `sparse_remove_one_section':
(.text+0x49fa6): undefined reference to `vmemmap_free_bootmem'
mm/built-in.o: In function `sparse_remove_one_section':
(.text+0x49fcc): undefined reference to `vmemmap_kfree'
mm/built-in.o: In function `register_page_bootmem_info_node':
(.text+0x57c06): undefined reference to `register_page_bootmem_memmap'
mm/built-in.o: In function `sparse_add_one_section':
(.meminit.text+0x2506): undefined reference to `vmemmap_kfree'
mm/built-in.o: In function `sparse_add_one_section':
(.meminit.text+0x2528): undefined reference to `vmemmap_kfree'
make: *** [vmlinux] Error 1
