Return-Path: <SRS0=4FME=QK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8E2C169C4
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Feb 2019 10:06:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3471121773
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Feb 2019 10:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3471121773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43smhg22M0zDqJ3
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Feb 2019 21:06:43 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43smfZ06wQzDqBt
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Feb 2019 21:04:53 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x13A4lrY003344
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 3 Feb 2019 05:04:50 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2qds0rh756-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 03 Feb 2019 05:04:49 -0500
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.ibm.com>;
 Sun, 3 Feb 2019 10:04:45 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 3 Feb 2019 10:04:34 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x13A4XSJ44368088
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 3 Feb 2019 10:04:33 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7B628A4040;
 Sun,  3 Feb 2019 10:04:33 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5359FA4053;
 Sun,  3 Feb 2019 10:04:30 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.84])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Sun,  3 Feb 2019 10:04:30 +0000 (GMT)
Date: Sun, 3 Feb 2019 12:04:28 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 10/21] memblock: refactor internal allocation functions
References: <1548057848-15136-1-git-send-email-rppt@linux.ibm.com>
 <1548057848-15136-11-git-send-email-rppt@linux.ibm.com>
 <87ftt5nrcn.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftt5nrcn.fsf@concordia.ellerman.id.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19020310-4275-0000-0000-000003097DF6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19020310-4276-0000-0000-000038178E51
Message-Id: <20190203100428.GB8620@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-02-03_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=993 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902030085
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
 linux-mips@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>,
 Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
 linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Weinberger <richard@nod.at>, linux-sh@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>, kasan-dev@googlegroups.com,
 Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>,
 Dennis Zhou <dennis@kernel.org>, Matt Turner <mattst88@gmail.com>,
 linux-snps-arc@lists.infradead.org, uclinux-h8-devel@lists.sourceforge.jp,
 Petr Mladek <pmladek@suse.com>, linux-xtensa@linux-xtensa.org,
 linux-alpha@vger.kernel.org, linux-um@lists.infradead.org,
 linux-m68k@lists.linux-m68k.org, Rob Herring <robh+dt@kernel.org>,
 Greentime Hu <green.hu@gmail.com>, xen-devel@lists.xenproject.org,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 Tony Luck <tony.luck@intel.com>, linux-mm@kvack.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
 openrisc@lists.librecores.org, Vineet Gupta <vgupta@synopsys.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Feb 03, 2019 at 08:39:20PM +1100, Michael Ellerman wrote:
> Mike Rapoport <rppt@linux.ibm.com> writes:
> 
> > Currently, memblock has several internal functions with overlapping
> > functionality. They all call memblock_find_in_range_node() to find free
> > memory and then reserve the allocated range and mark it with kmemleak.
> > However, there is difference in the allocation constraints and in fallback
> > strategies.
> >
> > The allocations returning physical address first attempt to find free
> > memory on the specified node within mirrored memory regions, then retry on
> > the same node without the requirement for memory mirroring and finally fall
> > back to all available memory.
> >
> > The allocations returning virtual address start with clamping the allowed
> > range to memblock.current_limit, attempt to allocate from the specified
> > node from regions with mirroring and with user defined minimal address. If
> > such allocation fails, next attempt is done with node restriction lifted.
> > Next, the allocation is retried with minimal address reset to zero and at
> > last without the requirement for mirrored regions.
> >
> > Let's consolidate various fallbacks handling and make them more consistent
> > for physical and virtual variants. Most of the fallback handling is moved
> > to memblock_alloc_range_nid() and it now handles node and mirror fallbacks.
> >
> > The memblock_alloc_internal() uses memblock_alloc_range_nid() to get a
> > physical address of the allocated range and converts it to virtual address.
> >
> > The fallback for allocation below the specified minimal address remains in
> > memblock_alloc_internal() because memblock_alloc_range_nid() is used by CMA
> > with exact requirement for lower bounds.
> 
> This is causing problems on some of my machines.
> 
> I see NODE_DATA allocations falling back to node 0 when they shouldn't,
> or didn't previously.
> 
> eg, before:
> 
> 57990190: (116011251): numa:   NODE_DATA [mem 0xfffe4980-0xfffebfff]
> 58152042: (116373087): numa:   NODE_DATA [mem 0x8fff90980-0x8fff97fff]
> 
> after:
> 
> 16356872061562: (6296877055): numa:   NODE_DATA [mem 0xfffe4980-0xfffebfff]
> 16356872079279: (6296894772): numa:   NODE_DATA [mem 0xfffcd300-0xfffd497f]
> 16356872096376: (6296911869): numa:     NODE_DATA(1) on node 0
> 
> 
> On some of my other systems it does that, and then panics because it
> can't allocate anything at all:
> 
> [    0.000000] numa:   NODE_DATA [mem 0x7ffcaee80-0x7ffcb3fff]
> [    0.000000] numa:   NODE_DATA [mem 0x7ffc99d00-0x7ffc9ee7f]
> [    0.000000] numa:     NODE_DATA(1) on node 0
> [    0.000000] Kernel panic - not syncing: Cannot allocate 20864 bytes for node 16 data
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.0.0-rc4-gccN-next-20190201-gdc4c899 #1
> [    0.000000] Call Trace:
> [    0.000000] [c0000000011cfca0] [c000000000c11044] dump_stack+0xe8/0x164 (unreliable)
> [    0.000000] [c0000000011cfcf0] [c0000000000fdd6c] panic+0x17c/0x3e0
> [    0.000000] [c0000000011cfd90] [c000000000f61bc8] initmem_init+0x128/0x260
> [    0.000000] [c0000000011cfe60] [c000000000f57940] setup_arch+0x398/0x418
> [    0.000000] [c0000000011cfee0] [c000000000f50a94] start_kernel+0xa0/0x684
> [    0.000000] [c0000000011cff90] [c00000000000af70] start_here_common+0x1c/0x52c
> [    0.000000] Rebooting in 180 seconds..
> 
> 
> So there's something going wrong there, I haven't had time to dig into
> it though (Sunday night here).

I'll try to see if I can reproduce it with qemu.
 
> cheers
> 

-- 
Sincerely yours,
Mike.

