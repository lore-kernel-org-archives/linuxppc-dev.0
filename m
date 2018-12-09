Return-Path: <SRS0=n4RZ=OS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F1AC07E85
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Dec 2018 15:03:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8DC520661
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Dec 2018 15:03:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8DC520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43CTwX4ZWwzDqZT
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 02:03:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43CTsl2dRbzDqXs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 02:00:43 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wB9ExIBM055509
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Dec 2018 10:00:41 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p8vg6e5jt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Dec 2018 10:00:40 -0500
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.ibm.com>;
 Sun, 9 Dec 2018 15:00:37 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Sun, 9 Dec 2018 15:00:30 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
 [9.149.105.58])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wB9F0TY951052574
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 9 Dec 2018 15:00:29 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 728B84C058;
 Sun,  9 Dec 2018 15:00:29 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B06C44C044;
 Sun,  9 Dec 2018 15:00:26 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.213])
 by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
 Sun,  9 Dec 2018 15:00:26 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation);
 Sun, 09 Dec 2018 17:00:26 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 0/6] memblock: simplify several early memory allocation
Date: Sun,  9 Dec 2018 17:00:18 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18120915-0012-0000-0000-000002D6AF46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18120915-0013-0000-0000-0000210C1ECE
Message-Id: <1544367624-15376-1-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-09_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=988 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812090139
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
 Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>,
 Mark Salter <msalter@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 openrisc@lists.librecores.org, Greentime Hu <green.hu@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>,
 linux-arm-kernel@lists.infradead.org, Michal Simek <monstr@monstr.eu>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

These patches simplify some of the early memory allocations by replacing
usage of older memblock APIs with newer and shinier ones.

Quite a few places in the arch/ code allocated memory using a memblock API
that returns a physical address of the allocated area, then converted this
physical address to a virtual one and then used memset(0) to clear the
allocated range.

More recent memblock APIs do all the three steps in one call and their
usage simplifies the code.

It's important to note that regardless of API used, the core allocation is
nearly identical for any set of memblock allocators: first it tries to find
a free memory with all the constraints specified by the caller and then
falls back to the allocation with some or all constraints disabled.

The first three patches perform the conversion of call sites that have
exact requirements for the node and the possible memory range.

The fourth patch is a bit one-off as it simplifies openrisc's
implementation of pte_alloc_one_kernel(), and not only the memblock usage.

The fifth patch takes care of simpler cases when the allocation can be
satisfied with a simple call to memblock_alloc().

The sixth patch removes one-liner wrappers for memblock_alloc on arm and
unicore32, as suggested by Christoph.

v3:
* added Tested-by from Michal Simek for microblaze changes
* updated powerpc changes as per Michael Ellerman comments:
  - use allocations that clear memory in alloc_paca_data() and alloc_stack()
  - ensure the replacement is equivalent to old API

v2:
* added Ack from Stafford Horne for openrisc changes
* entirely drop early_alloc wrappers on arm and unicore32, as per Christoph
Hellwig



Mike Rapoport (6):
  powerpc: prefer memblock APIs returning virtual address
  microblaze: prefer memblock API returning virtual address
  sh: prefer memblock APIs returning virtual address
  openrisc: simplify pte_alloc_one_kernel()
  arch: simplify several early memory allocations
  arm, unicore32: remove early_alloc*() wrappers

 arch/arm/mm/mmu.c                      | 13 +++----------
 arch/c6x/mm/dma-coherent.c             |  9 ++-------
 arch/microblaze/mm/init.c              |  5 +++--
 arch/nds32/mm/init.c                   | 12 ++++--------
 arch/openrisc/mm/ioremap.c             | 11 ++++-------
 arch/powerpc/kernel/paca.c             | 16 ++++++----------
 arch/powerpc/kernel/setup-common.c     |  4 ++--
 arch/powerpc/kernel/setup_64.c         | 24 ++++++++++--------------
 arch/powerpc/mm/hash_utils_64.c        |  6 +++---
 arch/powerpc/mm/pgtable-book3e.c       |  8 ++------
 arch/powerpc/mm/pgtable-book3s64.c     |  5 +----
 arch/powerpc/mm/pgtable-radix.c        | 25 +++++++------------------
 arch/powerpc/mm/pgtable_32.c           |  4 +---
 arch/powerpc/mm/ppc_mmu_32.c           |  3 +--
 arch/powerpc/platforms/pasemi/iommu.c  |  5 +++--
 arch/powerpc/platforms/powernv/opal.c  |  3 +--
 arch/powerpc/platforms/pseries/setup.c | 18 ++++++++++++++----
 arch/powerpc/sysdev/dart_iommu.c       |  7 +++++--
 arch/sh/mm/init.c                      | 18 +++++-------------
 arch/sh/mm/numa.c                      |  5 ++---
 arch/sparc/kernel/prom_64.c            |  7 ++-----
 arch/sparc/mm/init_64.c                |  9 +++------
 arch/unicore32/mm/mmu.c                | 14 ++++----------
 23 files changed, 88 insertions(+), 143 deletions(-)

-- 
2.7.4

