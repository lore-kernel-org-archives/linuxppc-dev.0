Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27436C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 10:29:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9498E21773
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 10:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9498E21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pxPk4RMGzDqMF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 20:29:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=david@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pxKf4WKrzDqDJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 20:25:41 +1000 (AEST)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9E2923199364;
 Wed, 24 Apr 2019 10:25:33 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-45.ams2.redhat.com [10.36.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CDA8600C4;
 Wed, 24 Apr 2019 10:25:12 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Subject: [PATCH v1 0/7] mm/memory_hotplug: Factor out memory block device
 handling
Date: Wed, 24 Apr 2019 12:25:04 +0200
Message-Id: <20190424102511.29318-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 24 Apr 2019 10:25:38 +0000 (UTC)
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
Cc: Oscar Salvador <osalvador@suse.com>, Michal Hocko <mhocko@suse.com>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Pavel Tatashin <pavel.tatashin@microsoft.com>, Rich Felker <dalias@libc.org>,
 Arun KS <arunks@codeaurora.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Qian Cai <cai@lca.pw>, linux-s390@vger.kernel.org, Baoquan He <bhe@redhat.com>,
 Logan Gunthorpe <logang@deltatee.com>, David Hildenbrand <david@redhat.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Pavel Tatashin <pasha.tatashin@soleen.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Rob Herring <robh@kernel.org>,
 "mike.travis@hpe.com" <mike.travis@hpe.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, Mark Brown <broonie@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>, Wei Yang <richard.weiyang@gmail.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Oscar Salvador <osalvador@suse.de>,
 Tony Luck <tony.luck@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Andrew Banman <andrew.banman@hpe.com>, Mathieu Malaterre <malat@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Wei Yang <richardw.yang@linux.intel.com>,
 Alex Deucher <alexander.deucher@amd.com>, Paul Mackerras <paulus@samba.org>,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We only want memory block devices for memory to be onlined/offlined
(add/remove from the buddy). This is required so user space can
online/offline memory and kdump gets notified about newly onlined memory.

Only such memory has the requirement of having to span whole memory blocks.
Let's factor out creation/removal of memory block devices. This helps
to further cleanup arch_add_memory/arch_remove_memory() and to make
implementation of new features (e.g. sub-section hot-add) easier.

Patch 1 makes sure the memory block size granularity is always respected.
Patch 2 implements arch_remove_memory() on s390x. Patch 3 prepares
arch_remove_memory() to be also called without CONFIG_MEMORY_HOTREMOVE.
Patch 4,5 and 6 factor out creation/removal of memory block devices.
Patch 7 gets rid of some unlikely errors that could have happened, not
removinf links between memory block devices and nodes, previously brought
up by Oscar.

Did a quick sanity test with DIMM plug/unplug, making sure all devices
and sysfs links properly get added/removed. Compile tested on s390x and
x86-64.

Based on git://git.cmpxchg.org/linux-mmots.git

David Hildenbrand (7):
  mm/memory_hotplug: Simplify and fix check_hotplug_memory_range()
  s390x/mm: Implement arch_remove_memory()
  mm/memory_hotplug: arch_remove_memory() and __remove_pages() with
    CONFIG_MEMORY_HOTPLUG
  mm/memory_hotplug: Create memory block devices after arch_add_memory()
  mm/memory_hotplug: Drop MHP_MEMBLOCK_API
  mm/memory_hotplug: Remove memory block devices before
    arch_remove_memory()
  mm/memory_hotplug: Make unregister_memory_block_under_nodes() never
    fail

 arch/ia64/mm/init.c            |   2 -
 arch/powerpc/mm/mem.c          |   2 -
 arch/s390/mm/init.c            |  15 +++--
 arch/sh/mm/init.c              |   2 -
 arch/x86/mm/init_32.c          |   2 -
 arch/x86/mm/init_64.c          |   2 -
 drivers/base/memory.c          | 109 +++++++++++++++++++--------------
 drivers/base/node.c            |  27 +++-----
 include/linux/memory.h         |   6 +-
 include/linux/memory_hotplug.h |  10 ---
 include/linux/node.h           |   7 +--
 mm/memory_hotplug.c            |  42 +++++--------
 mm/sparse.c                    |   6 --
 13 files changed, 100 insertions(+), 132 deletions(-)

-- 
2.20.1

