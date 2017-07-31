Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLdcW5NFNzDsT0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 22:12:27 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id t83so1281741pfj.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 05:12:27 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/3] Have CONFIG_STRICT_KERNEL_RWX work with
 CONFIG_RELOCATABLE
Date: Mon, 31 Jul 2017 22:11:00 +1000
Message-Id: <20170731121103.6984-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches make CONFIG_STRICT_KERNEL_RWX work with CONFIG_RELOCATABLE
The first patch splits up the radix linear mapping nicely on relocation
to support granular read-only and execution bits. The second patch warns
if relocation is actually done (PHYSICAL_START > MEMORY_START), we do
best effort support of expected permissions. We could do more granular
linear mapping, but we decided to leave it as a TODO (to check for
performance/MPSS/etc).

The last patch changes the config so that we are no longer dependent on
!RELOCATABLE for CONFIG_STRICT_KERNEL_RWX feature.

Changelog v2
	- Rebase on top of the changes made in v4.13
	- Move hash tables to IS_ALIGNED logic

Balbir Singh (3):
  powerpc/mm/radix: Fix relocatable radix mappings for STRICT_RWX
  powerpc/mm/hash: WARN if relocation is enabled and
    CONFIG_STRICT_KERNEL_RWX
  powerpc/strict_kernel_rwx: Don't depend on !RELOCATABLE

 arch/powerpc/Kconfig             |   2 +-
 arch/powerpc/mm/pgtable-hash64.c |  28 +++++-
 arch/powerpc/mm/pgtable-radix.c  | 183 ++++++++++++++++++++++++++++++++-------
 3 files changed, 178 insertions(+), 35 deletions(-)

-- 
2.9.4
