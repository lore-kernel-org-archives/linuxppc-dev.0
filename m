Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3symRs3ZgQzDrPG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 18:10:17 +1100 (AEDT)
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3symRr5lKjz9sBr
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Oct 2016 18:10:16 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id r16so14360112pfg.3
 for <linuxppc-dev@ozlabs.org>; Tue, 18 Oct 2016 00:10:16 -0700 (PDT)
To: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] Setup per-cpu cpu<->node binding early
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <1c7ad577-da11-e4a5-b5b0-16ce2da6f67c@gmail.com>
Date: Tue, 18 Oct 2016 18:10:10 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman debugged an issue w.r.t workqueue changes
(see https://lkml.org/lkml/2016/10/17/352) down to the fact
that we don't setup our per cpu (cpu to node) binding early
enough (in setup_per_cpu_areas like x86 does).

This lead to a problem with workqueue changes where the
cpus seen by for_each_node() in workqueue_init_early() was
different from their binding seen later in

for_each_possible_cpu(cpu) {
	node = cpu_to_node(cpu)
	...

}

In setup_arch()->initmem_init() we have access to the binding
in numa_cpu_lookup_table()

This patch implements Michael's suggestion of setting up
the per cpu node binding inside of setup_per_cpu_areas()

I did not remove the original setting of these values
from smp_prepare_cpus(). I've also not setup per cpu
mem's via set_cpu_numa_mem() since zonelists are not
yet built by the time we do per cpu setup.

Reported-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/kernel/setup_64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index c3e1290..842415a 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -625,6 +625,8 @@ void __init setup_per_cpu_areas(void)
 	for_each_possible_cpu(cpu) {
                 __per_cpu_offset[cpu] = delta + pcpu_unit_offsets[cpu];
 		paca[cpu].data_offset = __per_cpu_offset[cpu];
+
+		set_cpu_numa_node(cpu, numa_cpu_lookup_table[cpu]);
 	}
 }
 #endif
-- 
2.5.5
