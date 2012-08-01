Return-Path: <wency@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 1746C2C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2012 16:04:25 +1000 (EST)
Message-ID: <5018C817.80509@cn.fujitsu.com>
Date: Wed, 01 Aug 2012 14:09:27 +0800
From: Wen Congyang <wency@cn.fujitsu.com>
MIME-Version: 1.0
To: gerald.schaefer@de.ibm.com
Subject: Re: [RFC PATCH v5 16/19] memory-hotplug: free memmap of sparse-vmemmap
References: <50126B83.3050201@cn.fujitsu.com>	<50126EBE.1020006@cn.fujitsu.com>
 <20120731142251.5b2cae37@thinkpad>
In-Reply-To: <20120731142251.5b2cae37@thinkpad>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-acpi@vger.kernel.org, len.brown@intel.com, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
 Yasuaki ISIMATU <isimatu.yasuaki@jp.fujitsu.com>, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 cl@linux.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At 07/31/2012 08:22 PM, Gerald Schaefer Wrote:
> On Fri, 27 Jul 2012 18:34:38 +0800
> Wen Congyang <wency@cn.fujitsu.com> wrote:
> 
>> From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
>>
>> All pages of virtual mapping in removed memory cannot be freed, since
>> some pages used as PGD/PUD includes not only removed memory but also
>> other memory. So the patch checks whether page can be freed or not.
>>
>> How to check whether page can be freed or not?
>>  1. When removing memory, the page structs of the revmoved memory are
>> filled with 0FD.
>>  2. All page structs are filled with 0xFD on PT/PMD, PT/PMD can be
>> cleared. In this case, the page used as PT/PMD can be freed.
>>
>> Applying patch, __remove_section() of CONFIG_SPARSEMEM_VMEMMAP is
>> integrated into one. So __remove_section() of
>> CONFIG_SPARSEMEM_VMEMMAP is deleted.
> 
> There should also be generic or dummy versions of the functions
> vmemmap_free_bootmem(), vmemmap_kfree() and
> register_page_bootmem_memmap(). It doesn't compile on other
> archtitectures than x86 as it is now:
> 
> mm/built-in.o: In function `sparse_remove_one_section':
> (.text+0x49fa6): undefined reference to `vmemmap_free_bootmem'
> mm/built-in.o: In function `sparse_remove_one_section':
> (.text+0x49fcc): undefined reference to `vmemmap_kfree'
> mm/built-in.o: In function `register_page_bootmem_info_node':
> (.text+0x57c06): undefined reference to `register_page_bootmem_memmap'
> mm/built-in.o: In function `sparse_add_one_section':
> (.meminit.text+0x2506): undefined reference to `vmemmap_kfree'
> mm/built-in.o: In function `sparse_add_one_section':
> (.meminit.text+0x2528): undefined reference to `vmemmap_kfree'
> make: *** [vmlinux] Error 1
> 
> 

Thanks for testing. I will fix it.

Wen Congyang
