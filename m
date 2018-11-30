Return-Path: <SRS0=EPkL=OK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B55C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Dec 2018 11:18:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A23EC2082F
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Dec 2018 11:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23EC2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 436TJf0JhjzDqdf
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Dec 2018 22:18:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=redhat.com
 (client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=david@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4362GW3ytfzDrTg
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Dec 2018 04:59:47 +1100 (AEDT)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EFA77308624C;
 Fri, 30 Nov 2018 17:59:43 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-126-156.rdu2.redhat.com [10.10.126.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1A695DDFE;
 Fri, 30 Nov 2018 17:59:23 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Subject: [PATCH RFCv2 0/4] mm/memory_hotplug: Introduce memory block types
Date: Fri, 30 Nov 2018 18:59:18 +0100
Message-Id: <20181130175922.10425-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 30 Nov 2018 17:59:45 +0000 (UTC)
X-Mailman-Approved-At: Sat, 01 Dec 2018 22:14:53 +1100
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
Cc: Oscar Salvador <osalvador@suse.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Michal Hocko <mhocko@suse.com>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@kernel.org>,
 Vitaly Kuznetsov <vkuznets@redhat.com>,
 Pavel Tatashin <pavel.tatashin@microsoft.com>, Rich Felker <dalias@libc.org>,
 Arun KS <arunks@codeaurora.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Rashmica Gupta <rashmica.g@gmail.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Dan Williams <dan.j.williams@intel.com>, Paul Mackerras <paulus@samba.org>,
 Pavel Tatashin <pasha.tatashin@soleen.com>, linux-s390@vger.kernel.org,
 Michael Neuling <mikey@neuling.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Dave Jiang <dave.jiang@intel.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Logan Gunthorpe <logang@deltatee.com>, x86@kernel.org,
 YueHaibing <yuehaibing@huawei.com>, Pavel Tatashin <pasha.tatashin@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 xen-devel@lists.xenproject.org,
 =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Len Brown <lenb@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
 =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>,
 Juergen Gross <jgross@suse.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Rob Herring <robh@kernel.org>, "mike.travis@hpe.com" <mike.travis@hpe.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Wei Yang <richard.weiyang@gmail.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Oscar Salvador <osalvador@suse.de>, Tony Luck <tony.luck@intel.com>,
 Andrew Banman <andrew.banman@hpe.com>, Mathieu Malaterre <malat@debian.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, devel@linuxdriverproject.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This is the second approach, introducing more meaningful memory block
types and not changing online behavior in the kernel. It is based on
latest linux-next.

As we found out during dicussion, user space should always handle onlining
of memory, in any case. However in order to make smart decisions in user
space about if and how to online memory, we have to export more information
about memory blocks. This way, we can formulate rules in user space.

One such information is the type of memory block we are talking about.
This helps to answer some questions like:
- Does this memory block belong to a DIMM?
- Can this DIMM theoretically ever be unplugged again?
- Was this memory added by a balloon driver that will rely on balloon
  inflation to remove chunks of that memory again? Which zone is advised?
- Is this special standby memory on s390x that is usually not automatically
  onlined?

And in short it helps to answer to some extend (excluding zone imbalances)
- Should I online this memory block?
- To which zone should I online this memory block?
... of course special use cases will result in different anwers. But that's
why user space has control of onlining memory.

More details can be found in Patch 1 and Patch 3.
Tested on x86 with hotplugged DIMMs. Cross-compiled for PPC and s390x.


Example:
$ udevadm info -q all -a /sys/devices/system/memory/memory0
	KERNEL=="memory0"
	SUBSYSTEM=="memory"
	DRIVER==""
	ATTR{online}=="1"
	ATTR{phys_device}=="0"
	ATTR{phys_index}=="00000000"
	ATTR{removable}=="0"
	ATTR{state}=="online"
	ATTR{type}=="boot"
	ATTR{valid_zones}=="none"
$ udevadm info -q all -a /sys/devices/system/memory/memory90
	KERNEL=="memory90"
	SUBSYSTEM=="memory"
	DRIVER==""
	ATTR{online}=="1"
	ATTR{phys_device}=="0"
	ATTR{phys_index}=="0000005a"
	ATTR{removable}=="1"
	ATTR{state}=="online"
	ATTR{type}=="dimm"
	ATTR{valid_zones}=="Normal"


RFC -> RFCv2:
- Now also taking care of PPC (somehow missed it :/ )
- Split the series up to some degree (some ideas on how to split up patch 3
  would be very welcome)
- Introduce more memory block types. Turns out abstracting too much was
  rather confusing and not helpful. Properly document them.

Notes:
- I wanted to convert the enum of types into a named enum but this
  provoked all kinds of different errors. For now, I am doing it just like
  the other types (e.g. online_type) we are using in that context.
- The "removable" property should never have been named like that. It
  should have been "offlinable". Can we still rename that? E.g. boot memory
  is sometimes marked as removable ...

David Hildenbrand (4):
  mm/memory_hotplug: Introduce memory block types
  mm/memory_hotplug: Replace "bool want_memblock" by "int type"
  mm/memory_hotplug: Introduce and use more memory types
  mm/memory_hotplug: Drop MEMORY_TYPE_UNSPECIFIED

 arch/ia64/mm/init.c                           |  4 +-
 arch/powerpc/mm/mem.c                         |  4 +-
 arch/powerpc/platforms/powernv/memtrace.c     |  9 +--
 .../platforms/pseries/hotplug-memory.c        |  7 +-
 arch/s390/mm/init.c                           |  4 +-
 arch/sh/mm/init.c                             |  4 +-
 arch/x86/mm/init_32.c                         |  4 +-
 arch/x86/mm/init_64.c                         |  8 +--
 drivers/acpi/acpi_memhotplug.c                | 16 ++++-
 drivers/base/memory.c                         | 60 ++++++++++++++--
 drivers/hv/hv_balloon.c                       |  3 +-
 drivers/s390/char/sclp_cmd.c                  |  3 +-
 drivers/xen/balloon.c                         |  2 +-
 include/linux/memory.h                        | 69 ++++++++++++++++++-
 include/linux/memory_hotplug.h                | 18 ++---
 kernel/memremap.c                             |  6 +-
 mm/memory_hotplug.c                           | 29 ++++----
 17 files changed, 194 insertions(+), 56 deletions(-)

-- 
2.17.2

