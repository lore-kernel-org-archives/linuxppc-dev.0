Return-Path: <tangchen@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 036212C047F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 14:22:00 +1100 (EST)
Message-ID: <50DA6D1E.1010209@cn.fujitsu.com>
Date: Wed, 26 Dec 2012 11:21:02 +0800
From: Tang Chen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
To: Jianguo Wu <wujianguo@huawei.com>
Subject: Re: [PATCH v5 06/14] memory-hotplug: implement
 register_page_bootmem_info_section of sparse-vmemmap
References: <1356350964-13437-1-git-send-email-tangchen@cn.fujitsu.com>
 <1356350964-13437-7-git-send-email-tangchen@cn.fujitsu.com>
 <50D95F51.9090007@huawei.com>
In-Reply-To: <50D95F51.9090007@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, cl@linux.com,
 linux-s390@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, linfeng@cn.fujitsu.com, mgorman@suse.de,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, liuj97@gmail.com,
 len.brown@intel.com, wency@cn.fujitsu.com, cmetcalf@tilera.com,
 yinghai@kernel.org, laijs@cn.fujitsu.com, linux-kernel@vger.kernel.org,
 minchan.kim@gmail.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/25/2012 04:09 PM, Jianguo Wu wrote:
>> +
>> +		if (!cpu=5Fhas=5Fpse) {
>> +			next =3D (addr + PAGE=5FSIZE)&  PAGE=5FMASK;
>> +			pmd =3D pmd=5Foffset(pud, addr);
>> +			if (pmd=5Fnone(*pmd))
>> +				continue;
>> +			get=5Fpage=5Fbootmem(section=5Fnr, pmd=5Fpage(*pmd),
>> +					 MIX=5FSECTION=5FINFO);
>> +
>> +			pte =3D pte=5Foffset=5Fkernel(pmd, addr);
>> +			if (pte=5Fnone(*pte))
>> +				continue;
>> +			get=5Fpage=5Fbootmem(section=5Fnr, pte=5Fpage(*pte),
>> +					 SECTION=5FINFO);
>> +		} else {
>> +			next =3D pmd=5Faddr=5Fend(addr, end);
>> +
>> +			pmd =3D pmd=5Foffset(pud, addr);
>> +			if (pmd=5Fnone(*pmd))
>> +				continue;
>> +			get=5Fpage=5Fbootmem(section=5Fnr, pmd=5Fpage(*pmd),
>> +					 SECTION=5FINFO);
>
> Hi Tang=EF=BC=8C
> 	In this case, pmd maps 512 pages, but you only get=5Fpage=5Fbootmem() on=
 the first page.
> I think the whole 512 pages should be get=5Fpage=5Fbootmem(), what do you=
 think?
>
Hi Wu,

Yes, thanks. I will fix it. :)

Thanks. :)

=
