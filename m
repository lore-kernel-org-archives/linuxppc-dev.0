Return-Path: <SRS0=to3W=WL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA773C31E40
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Aug 2019 06:57:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75DF72084D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Aug 2019 06:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75DF72084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 468HLj3m8CzDqcw
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Aug 2019 16:57:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=rppt@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 468HJW3H0qzDqcM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2019 16:55:06 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7F6pk7E105022
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2019 02:55:03 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ucx4y7ggy-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2019 02:55:02 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.ibm.com>;
 Thu, 15 Aug 2019 07:55:00 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 15 Aug 2019 07:54:56 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7F6stfi50921518
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Aug 2019 06:54:55 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 68AA9A4060;
 Thu, 15 Aug 2019 06:54:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 31DEEA4054;
 Thu, 15 Aug 2019 06:54:54 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.59])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 15 Aug 2019 06:54:54 +0000 (GMT)
Date: Thu, 15 Aug 2019 09:54:52 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
To: "Alastair D'Silva" <alastair@au1.ibm.com>
Subject: Re: [PATCH 4/6] powerpc: Chunk calls to flush_dcache_range in
 arch_*_memory
References: <20190815041057.13627-1-alastair@au1.ibm.com>
 <20190815041057.13627-5-alastair@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815041057.13627-5-alastair@au1.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19081506-0028-0000-0000-0000038FF606
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081506-0029-0000-0000-000024520BD9
Message-Id: <20190815065452.GB19609@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-15_03:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908150071
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alastair@d-silva.org,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>, Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Qian Cai <cai@lca.pw>, Paul Mackerras <paulus@samba.org>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Allison Randal <allison@lohutok.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Aug 15, 2019 at 02:10:49PM +1000, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> When presented with large amounts of memory being hotplugged
> (in my test case, ~890GB), the call to flush_dcache_range takes
> a while (~50 seconds), triggering RCU stalls.
> 
> This patch breaks up the call into 16GB chunks, calling
> cond_resched() inbetween to allow the scheduler to run.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  arch/powerpc/mm/mem.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 5400da87a804..fb0d5e9aa11b 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -104,11 +104,14 @@ int __weak remove_section_mapping(unsigned long start, unsigned long end)
>  	return -ENODEV;
>  }
> 
> +#define FLUSH_CHUNK_SIZE (16ull * 1024ull * 1024ull * 1024ull)

IMHO this begs for adding SZ_16G to include/linux/sizes.h and using it here

> +
>  int __ref arch_add_memory(int nid, u64 start, u64 size,
>  			struct mhp_restrictions *restrictions)
>  {
>  	unsigned long start_pfn = start >> PAGE_SHIFT;
>  	unsigned long nr_pages = size >> PAGE_SHIFT;
> +	unsigned long i;
>  	int rc;
> 
>  	resize_hpt_for_hotplug(memblock_phys_mem_size());
> @@ -120,7 +123,11 @@ int __ref arch_add_memory(int nid, u64 start, u64 size,
>  			start, start + size, rc);
>  		return -EFAULT;
>  	}
> -	flush_dcache_range(start, start + size);
> +
> +	for (i = 0; i < size; i += FLUSH_CHUNK_SIZE) {
> +		flush_dcache_range(start + i, min(start + size, start + i + FLUSH_CHUNK_SIZE));
> +		cond_resched();
> +	}
> 
>  	return __add_pages(nid, start_pfn, nr_pages, restrictions);
>  }
> @@ -131,13 +138,18 @@ void __ref arch_remove_memory(int nid, u64 start, u64 size,
>  	unsigned long start_pfn = start >> PAGE_SHIFT;
>  	unsigned long nr_pages = size >> PAGE_SHIFT;
>  	struct page *page = pfn_to_page(start_pfn) + vmem_altmap_offset(altmap);
> +	unsigned long i;
>  	int ret;
> 
>  	__remove_pages(page_zone(page), start_pfn, nr_pages, altmap);
> 
>  	/* Remove htab bolted mappings for this section of memory */
>  	start = (unsigned long)__va(start);
> -	flush_dcache_range(start, start + size);
> +	for (i = 0; i < size; i += FLUSH_CHUNK_SIZE) {
> +		flush_dcache_range(start + i, min(start + size, start + i + FLUSH_CHUNK_SIZE));
> +		cond_resched();
> +	}
> +
>  	ret = remove_section_mapping(start, start + size);
>  	WARN_ON_ONCE(ret);
> 
> -- 
> 2.21.0
> 

-- 
Sincerely yours,
Mike.

