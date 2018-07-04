Return-Path: <bhe@redhat.com>
Received: from mx1.redhat.com (mx3-rdu2.redhat.com [66.187.233.73])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41L6yc1KlkzF1LK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 14:12:24 +1000 (AEST)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 robh+dt@kernel.org, dan.j.williams@intel.com, nicolas.pitre@linaro.org,
 josh@joshtriplett.org, fengguang.wu@intel.com, bp@suse.de,
 andy.shevchenko@gmail.com
Cc: patrik.r.jakobsson@gmail.com, airlied@linux.ie, kys@microsoft.com,
 haiyangz@microsoft.com, sthemmin@microsoft.com, dmitry.torokhov@gmail.com,
 frowand.list@gmail.com, keith.busch@intel.com, jonathan.derrick@intel.com,
 lorenzo.pieralisi@arm.com, bhelgaas@google.com, tglx@linutronix.de,
 brijesh.singh@amd.com, jglisse@redhat.com, thomas.lendacky@amd.com,
 gregkh@linuxfoundation.org, baiyaowei@cmss.chinamobile.com,
 richard.weiyang@gmail.com, devel@linuxdriverproject.org,
 linux-input@vger.kernel.org, linux-nvdimm@lists.01.org,
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
 ebiederm@xmission.com, vgoyal@redhat.com, dyoung@redhat.com,
 yinghai@kernel.org, kexec@lists.infradead.org, monstr@monstr.eu,
 davem@davemloft.net, chris@zankel.net, jcmvbkbc@gmail.com,
 gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
 seanpaul@chromium.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH v6 4/4] kexec_file: Load kernel at top of system RAM if
 required
Date: Wed,  4 Jul 2018 12:10:38 +0800
Message-Id: <20180704041038.8190-5-bhe@redhat.com>
In-Reply-To: <20180704041038.8190-1-bhe@redhat.com>
References: <20180704041038.8190-1-bhe@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For kexec_file loading, if kexec_buf.top_down is 'true', the memory which
is used to load kernel/initrd/purgatory is supposed to be allocated from
top to down. This is what we have been doing all along in the old kexec
loading interface and the kexec loading is still default setting in some
distributions. However, the current kexec_file loading interface doesn't
do likt this. The function arch_kexec_walk_mem() it calls ignores checking
kexec_buf.top_down, but calls walk_system_ram_res() directly to go through
all resources of System RAM from bottom to up, to try to find memory region
which can contain the specific kexec buffer, then call locate_mem_hole_callback()
to allocate memory in that found memory region from top to down. This brings
confusion especially when KASLR is widely supported , users have to make clear
why kexec/kdump kernel loading position is different between these two
interfaces in order to exclude unnecessary noises. Hence these two interfaces
need be unified on behaviour.

Here add checking if kexec_buf.top_down is 'true' in arch_kexec_walk_mem(),
if yes, call the newly added walk_system_ram_res_rev() to find memory region
from top to down to load kernel.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: kexec@lists.infradead.org
---
 kernel/kexec_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index c6a3b6851372..75226c1d08ce 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -518,6 +518,8 @@ int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
 					   IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
 					   crashk_res.start, crashk_res.end,
 					   kbuf, func);
+	else if (kbuf->top_down)
+		return walk_system_ram_res_rev(0, ULONG_MAX, kbuf, func);
 	else
 		return walk_system_ram_res(0, ULONG_MAX, kbuf, func);
 }
-- 
2.13.6
