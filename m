Return-Path: <david@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vnPH5lrYzF1qF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 20:44:51 +1000 (AEST)
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
 xen-devel@lists.xenproject.org, devel@linuxdriverproject.org,
 David Hildenbrand <david@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Rashmica Gupta <rashmica.g@gmail.com>,
 Balbir Singh <bsingharora@gmail.com>, Michael Neuling <mikey@neuling.org>
Subject: [PATCH RFCv2 4/6] powerpc/powernv: hold device_hotplug_lock when
 calling device_online()
Date: Tue, 21 Aug 2018 12:44:16 +0200
Message-Id: <20180821104418.12710-5-david@redhat.com>
In-Reply-To: <20180821104418.12710-1-david@redhat.com>
References: <20180821104418.12710-1-david@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

device_online() should be called with device_hotplug_lock() held.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Rashmica Gupta <rashmica.g@gmail.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Michael Neuling <mikey@neuling.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/platforms/powernv/memtrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
index 8f1cd4f3bfd5..ef7181d4fe68 100644
--- a/arch/powerpc/platforms/powernv/memtrace.c
+++ b/arch/powerpc/platforms/powernv/memtrace.c
@@ -229,9 +229,11 @@ static int memtrace_online(void)
 		 * we need to online the memory ourselves.
 		 */
 		if (!memhp_auto_online) {
+			lock_device_hotplug();
 			walk_memory_range(PFN_DOWN(ent->start),
 					  PFN_UP(ent->start + ent->size - 1),
 					  NULL, online_mem_block);
+			unlock_device_hotplug();
 		}
 
 		/*
-- 
2.17.1
