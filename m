Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DD9C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 07:28:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F35B2082F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 07:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F35B2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433JRK5K7QzDqNJ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 18:27:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 433JP561VtzDqJS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 18:26:01 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAQ7O1nW079342
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 02:25:59 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p0a02db1y-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 02:25:59 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.ibm.com>;
 Mon, 26 Nov 2018 07:25:57 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 26 Nov 2018 07:25:51 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAQ7Posj8716688
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Nov 2018 07:25:50 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EF6CC11C04C;
 Mon, 26 Nov 2018 07:25:49 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F12F11C04A;
 Mon, 26 Nov 2018 07:25:48 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.115])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon, 26 Nov 2018 07:25:48 +0000 (GMT)
Date: Mon, 26 Nov 2018 09:25:46 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 5/5] arch: simplify several early memory allocations
References: <1543182277-8819-1-git-send-email-rppt@linux.ibm.com>
 <1543182277-8819-6-git-send-email-rppt@linux.ibm.com>
 <7a92357c-6251-fe84-d724-16fdc49d03a3@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a92357c-6251-fe84-d724-16fdc49d03a3@c-s.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18112607-4275-0000-0000-000002E6AA64
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112607-4276-0000-0000-000037F3E223
Message-Id: <20181126072546.GB14863@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-26_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811260069
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
Cc: Michal Hocko <mhocko@suse.com>, linux-sh@vger.kernel.org,
 linux-mm@kvack.org, Rich Felker <dalias@libc.org>,
 Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 Vincent Chen <deanbo422@gmail.com>, Jonas Bonn <jonas@southpole.se>,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Russell King <linux@armlinux.org.uk>, Mark Salter <msalter@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 26, 2018 at 08:03:55AM +0100, Christophe LEROY wrote:
> 
> 
> Le 25/11/2018 à 22:44, Mike Rapoport a écrit :
> >There are several early memory allocations in arch/ code that use
> >memblock_phys_alloc() to allocate memory, convert the returned physical
> >address to the virtual address and then set the allocated memory to zero.
> >
> >Exactly the same behaviour can be achieved simply by calling
> >memblock_alloc(): it allocates the memory in the same way as
> >memblock_phys_alloc(), then it performs the phys_to_virt() conversion and
> >clears the allocated memory.
> >
> >Replace the longer sequence with a simpler call to memblock_alloc().
> >
> >Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> >---
> >  arch/arm/mm/mmu.c                     |  4 +---
> >  arch/c6x/mm/dma-coherent.c            |  9 ++-------
> >  arch/nds32/mm/init.c                  | 12 ++++--------
> >  arch/powerpc/kernel/setup-common.c    |  4 ++--
> >  arch/powerpc/mm/pgtable_32.c          |  4 +---
> >  arch/powerpc/mm/ppc_mmu_32.c          |  3 +--
> >  arch/powerpc/platforms/powernv/opal.c |  3 +--
> >  arch/sparc/kernel/prom_64.c           |  7 ++-----
> >  arch/sparc/mm/init_64.c               |  9 +++------
> >  arch/unicore32/mm/mmu.c               |  4 +---
> >  10 files changed, 18 insertions(+), 41 deletions(-)
> >
> [...]
> 
> >diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> >index bda3c6f..9931e68 100644
> >--- a/arch/powerpc/mm/pgtable_32.c
> >+++ b/arch/powerpc/mm/pgtable_32.c
> >@@ -50,9 +50,7 @@ __ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
> >  	if (slab_is_available()) {
> >  		pte = (pte_t *)__get_free_page(GFP_KERNEL|__GFP_ZERO);
> >  	} else {
> >-		pte = __va(memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE));
> >-		if (pte)
> >-			clear_page(pte);
> >+		pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
> 
> memblock_alloc() uses memset to zeroize the block.
> 
> clear_page() is more performant than memset().

As far as I can tell, the majority of the page table pages will be anyway
allocated with __get_free_page() so I think the performance loss here will
negligible.
 
> Christophe
> 
> [...]
> 

-- 
Sincerely yours,
Mike.

