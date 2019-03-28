Return-Path: <SRS0=U6gC=R7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C7BC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 05:59:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DD9E20700
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 05:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DD9E20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44VDhY5r1xzDqPj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 16:59:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=rppt@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44VDfq4vZmzDqLj
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 16:57:39 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x2S5nVRn008190
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 01:57:37 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2rgqtq1nty-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 01:57:36 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.ibm.com>;
 Thu, 28 Mar 2019 05:57:34 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 28 Mar 2019 05:57:26 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x2S5vPYa44761316
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Mar 2019 05:57:25 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 28854A4051;
 Thu, 28 Mar 2019 05:57:25 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9B51A405D;
 Thu, 28 Mar 2019 05:57:22 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.112])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 28 Mar 2019 05:57:22 +0000 (GMT)
Date: Thu, 28 Mar 2019 07:57:21 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH AUTOSEL 5.0 015/262] memblock:
 memblock_phys_alloc_try_nid(): don't panic
References: <20190327180158.10245-1-sashal@kernel.org>
 <20190327180158.10245-15-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327180158.10245-15-sashal@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19032805-0020-0000-0000-00000328A172
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032805-0021-0000-0000-0000217AE66F
Message-Id: <20190328055720.GB14864@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-03-28_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=21 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1031 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903280044
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
Cc: Rich Felker <dalias@libc.org>, Petr Mladek <pmladek@suse.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Guo Ren <guoren@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Rob Herring <robh@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <ren_guo@c-sky.com>,
 Mark Salter <msalter@redhat.com>, Dennis Zhou <dennis@kernel.org>,
 Matt Turner <mattst88@gmail.com>, Juergen Gross <jgross@suse.com>,
 linuxppc-dev@lists.ozlabs.org, Rob Herring <robh+dt@kernel.org>,
 Greentime Hu <green.hu@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Guan Xuetao <gxt@pku.edu.cn>, Michal Simek <monstr@monstr.eu>,
 Tony Luck <tony.luck@intel.com>, linux-mm@kvack.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
 Vineet Gupta <vgupta@synopsys.com>, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

On Wed, Mar 27, 2019 at 01:57:50PM -0400, Sasha Levin wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> [ Upstream commit 337555744e6e39dd1d87698c6084dd88a606d60a ]
> 
> The memblock_phys_alloc_try_nid() function tries to allocate memory from
> the requested node and then falls back to allocation from any node in
> the system.  The memblock_alloc_base() fallback used by this function
> panics if the allocation fails.
> 
> Replace the memblock_alloc_base() fallback with the direct call to
> memblock_alloc_range_nid() and update the memblock_phys_alloc_try_nid()
> callers to check the returned value and panic in case of error.

This is a part of memblock refactoring, I don't think it should be applied
to -stable.
 
> Link: http://lkml.kernel.org/r/1548057848-15136-7-git-send-email-rppt@linux.ibm.com
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>		[powerpc]
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Guan Xuetao <gxt@pku.edu.cn>
> Cc: Guo Ren <guoren@kernel.org>
> Cc: Guo Ren <ren_guo@c-sky.com>				[c-sky]
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Juergen Gross <jgross@suse.com>			[Xen]
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/arm64/mm/numa.c   | 4 ++++
>  arch/powerpc/mm/numa.c | 4 ++++
>  mm/memblock.c          | 4 +++-
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> index ae34e3a1cef1..2c61ea4e290b 100644
> --- a/arch/arm64/mm/numa.c
> +++ b/arch/arm64/mm/numa.c
> @@ -237,6 +237,10 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
>  		pr_info("Initmem setup node %d [<memory-less node>]\n", nid);
>  
>  	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
> +	if (!nd_pa)
> +		panic("Cannot allocate %zu bytes for node %d data\n",
> +		      nd_size, nid);
> +
>  	nd = __va(nd_pa);
>  
>  	/* report and initialize */
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 87f0dd004295..8ec2ed30d44c 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -788,6 +788,10 @@ static void __init setup_node_data(int nid, u64 start_pfn, u64 end_pfn)
>  	int tnid;
>  
>  	nd_pa = memblock_phys_alloc_try_nid(nd_size, SMP_CACHE_BYTES, nid);
> +	if (!nd_pa)
> +		panic("Cannot allocate %zu bytes for node %d data\n",
> +		      nd_size, nid);
> +
>  	nd = __va(nd_pa);
>  
>  	/* report and initialize */
> diff --git a/mm/memblock.c b/mm/memblock.c
> index ea31045ba704..d5923df56acc 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1342,7 +1342,9 @@ phys_addr_t __init memblock_phys_alloc_try_nid(phys_addr_t size, phys_addr_t ali
>  
>  	if (res)
>  		return res;
> -	return memblock_alloc_base(size, align, MEMBLOCK_ALLOC_ACCESSIBLE);
> +	return memblock_alloc_range_nid(size, align, 0,
> +					MEMBLOCK_ALLOC_ACCESSIBLE,
> +					NUMA_NO_NODE, MEMBLOCK_NONE);
>  }
>  
>  /**
> -- 
> 2.19.1
> 

-- 
Sincerely yours,
Mike.

