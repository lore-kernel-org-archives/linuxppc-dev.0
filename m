Return-Path: <SRS0=4kvs=MX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DAEC32788
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 06:10:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3F4320841
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 06:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F4320841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42W0vc2KhczF3HX
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Oct 2018 17:10:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=rppt@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42W0sc4BwNzF360
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 17:09:08 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w9B694sd065089
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 02:09:06 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2n1ygpb8pd-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2018 02:09:06 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.vnet.ibm.com>;
 Thu, 11 Oct 2018 07:09:03 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 11 Oct 2018 07:08:56 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w9B68sIf1376738
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 11 Oct 2018 06:08:55 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EA939AE053;
 Thu, 11 Oct 2018 09:07:37 +0100 (BST)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5101AE057;
 Thu, 11 Oct 2018 09:07:35 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.69])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Thu, 11 Oct 2018 09:07:35 +0100 (BST)
Date: Thu, 11 Oct 2018 09:08:50 +0300
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] memblock: stop using implicit alignement to
 SMP_CACHE_BYTES
References: <1538687224-17535-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20181005151934.87226fa92825c3002a475413@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005151934.87226fa92825c3002a475413@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18101106-0020-0000-0000-000002D27E1F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101106-0021-0000-0000-00002120F47F
Message-Id: <20181011060850.GA19822@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-11_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810110060
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
Cc: linux-mips@linux-mips.org, linux-m68k@vger.kernel.org,
 Michal Hocko <mhocko@suse.com>, linux-ia64@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
 Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Matt Turner <mattst88@gmail.com>, linux-um@lists.infradead.org,
 Thomas Gleixner <tglx@linutronix.de>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Oct 05, 2018 at 03:19:34PM -0700, Andrew Morton wrote:
> On Fri,  5 Oct 2018 00:07:04 +0300 Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> 
> > When a memblock allocation APIs are called with align = 0, the alignment is
> > implicitly set to SMP_CACHE_BYTES.
> > 
> > Replace all such uses of memblock APIs with the 'align' parameter explicitly
> > set to SMP_CACHE_BYTES and stop implicit alignment assignment in the
> > memblock internal allocation functions.
> > 
> > For the case when memblock APIs are used via helper functions, e.g. like
> > iommu_arena_new_node() in Alpha, the helper functions were detected with
> > Coccinelle's help and then manually examined and updated where appropriate.
> > 
> > ...
> >
> > --- a/mm/memblock.c
> > +++ b/mm/memblock.c
> > @@ -1298,9 +1298,6 @@ static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
> >  {
> >  	phys_addr_t found;
> >  
> > -	if (!align)
> > -		align = SMP_CACHE_BYTES;
> > -
> 
> Can we add a WARN_ON_ONCE(!align) here?  To catch unconverted code
> which sneaks in later on.

Here it goes:

From baec825c58e8bc11371433d3a4b20b2216877a50 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Date: Mon, 8 Oct 2018 11:22:10 +0300
Subject: [PATCH] memblock: warn if zero alignment was requested

After update of all memblock users to explicitly specify SMP_CACHE_BYTES
alignment rather than use 0, it is still possible that uncovered users
may sneak in. Add a WARN_ON_ONCE for such cases.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 mm/memblock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index 0bbae56..5fefc70 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1298,6 +1298,9 @@ static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 {
 	phys_addr_t found;
 
+	if (WARN_ON_ONCE(!align))
+		align = SMP_CACHE_BYTES;
+
 	found = memblock_find_in_range_node(size, align, start, end, nid,
 					    flags);
 	if (found && !memblock_reserve(found, size)) {
@@ -1420,6 +1423,9 @@ static void * __init memblock_alloc_internal(
 	if (WARN_ON_ONCE(slab_is_available()))
 		return kzalloc_node(size, GFP_NOWAIT, nid);
 
+	if (WARN_ON_ONCE(!align))
+		align = SMP_CACHE_BYTES;
+
 	if (max_addr > memblock.current_limit)
 		max_addr = memblock.current_limit;
 again:
-- 
2.7.4


-- 
Sincerely yours,
Mike.

