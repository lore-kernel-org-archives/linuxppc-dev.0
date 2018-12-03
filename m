Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C16C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 16:57:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B74920834
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 16:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B74920834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 437rlM0JQ9zDqMk
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 03:57:35 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 437rhr4LJhzDqRK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 03:55:24 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB3GkCNQ106101
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Dec 2018 11:55:21 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p583f9akj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Dec 2018 11:55:21 -0500
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.ibm.com>;
 Mon, 3 Dec 2018 16:55:18 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 3 Dec 2018 16:55:10 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB3Gt9iC55312584
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 3 Dec 2018 16:55:09 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C32FA4054;
 Mon,  3 Dec 2018 16:55:09 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 39F55A405C;
 Mon,  3 Dec 2018 16:55:07 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.196])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Mon,  3 Dec 2018 16:55:07 +0000 (GMT)
Date: Mon, 3 Dec 2018 18:55:04 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 6/6] arm, unicore32: remove early_alloc*() wrappers
References: <1543852035-26634-1-git-send-email-rppt@linux.ibm.com>
 <1543852035-26634-7-git-send-email-rppt@linux.ibm.com>
 <CABGGisySdgSma1bSF2Bk586Vf461o-U2f3w9UMgHJcVucQ0oFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABGGisySdgSma1bSF2Bk586Vf461o-U2f3w9UMgHJcVucQ0oFA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18120316-0028-0000-0000-000003256811
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120316-0029-0000-0000-000023E16D02
Message-Id: <20181203165504.GC26700@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-03_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812030157
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
Cc: mhocko@suse.com, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 dalias@libc.org, Paul Mackerras <paulus@samba.org>, sparclinux@vger.kernel.org,
 deanbo422@gmail.com, jonas@southpole.se, linux-c6x-dev@linux-c6x.org,
 ysato@users.sourceforge.jp, linux@armlinux.org.uk, msalter@redhat.com,
 Arnd Bergmann <arnd@arndb.de>, stefan.kristiansson@saunalahti.fi,
 openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
 shorne@gmail.com, gxt@pku.edu.cn,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Michal Simek <monstr@monstr.eu>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Dec 03, 2018 at 10:27:02AM -0600, Rob Herring wrote:
> On Mon, Dec 3, 2018 at 9:48 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
> >
> > On arm and unicore32i the early_alloc_aligned() and and early_alloc() are
> > oneliner wrappers for memblock_alloc.
> >
> > Replace their usage with direct call to memblock_alloc.
> >
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/arm/mm/mmu.c       | 11 +++--------
> >  arch/unicore32/mm/mmu.c | 12 ++++--------
> >  2 files changed, 7 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > index 0a04c9a5..57de0dd 100644
> > --- a/arch/arm/mm/mmu.c
> > +++ b/arch/arm/mm/mmu.c
> > @@ -719,14 +719,9 @@ EXPORT_SYMBOL(phys_mem_access_prot);
> >
> >  #define vectors_base() (vectors_high() ? 0xffff0000 : 0)
> >
> > -static void __init *early_alloc_aligned(unsigned long sz, unsigned long align)
> > -{
> > -       return memblock_alloc(sz, align);
> > -}
> > -
> >  static void __init *early_alloc(unsigned long sz)
> 
> Why not get rid of this wrapper like you do on unicore?

ARM has early_alloc() and late_alloc() callbacks which in the end are
passed as a parameter to alloc_init_pXd() functions. 

Removing early_alloc() would require refactoring all the page table
allocation code.
 
> >  {
> > -       return early_alloc_aligned(sz, sz);
> > +       return memblock_alloc(sz, sz);
> >  }
> 

-- 
Sincerely yours,
Mike.

