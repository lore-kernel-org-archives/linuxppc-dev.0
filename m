Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BF60A1A042E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 20:44:25 +1100 (AEDT)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Fri, 27 Feb 2015 15:14:23 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 08C9CE0044
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 15:16:10 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1R9iKOD50266316
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 15:14:20 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1R9iJPp027450
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2015 15:14:19 +0530
Subject: [PATCH v1 2/2] perf/kvm: perf-kvm-stat to report syscalls
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 27 Feb 2015 15:14:19 +0530
Message-ID: <20150227094403.6367.66612.stgit@localhost.localdomain>
In-Reply-To: <20150227093649.6367.15679.stgit@localhost.localdomain>
References: <20150227093649.6367.15679.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com, anton@au1.ibm.com,
 linux-kernel@vger.kernel.org, agraf@suse.de, paulus@samba.org,
 warrier@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some of the kvm_hv exits are due to hcalls. So, this patch adds necessary
support to display the number of hcalls grouped according to their type
(H_IPI, H_CONFER, etc) with "perf kvm stat report --event=syscall".

The patch defines the reasons in "kvm_trace_symbol_hcall". It adds
kvm_hv:kvm_hcall_enter tracepoint to be recorded when
"perf kvm stat record" is invoked. It defines the handler functions to
handle a kvm_hcall_enter event sample from the samples recorded in
perf.data.guest.

To reuse the pSeries hypervisor opcodes, they codes are removed from
arch/powerpc/include/asm/hvcall.h and added to a new .h file in
arch/powerpc/include/uapi/asm/hcall_codes.h.
Also the hcall_code to hcall_reason string mapping is removed from
arch/powerpc/kvm/trace_hv.h to a new file
arch/powerpc/include/uapi/asm/trace_hcall.h
so that perf in the userspace can use them.

A sample output :
# pgrep qemu
19378
60515

# ./perf kvm stat record -a
^C[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 4.153 MB perf.data.guest (39624 samples) ]

# ./perf kvm stat report -p 60515 --event=syscall


Analyze events for pid(s) 60515, all VCPUs:

       SYSCALL-EVENT    Samples  Samples%     Time%    Min Time    Max Time         Avg time

        H_VIO_SIGNAL       1034    38.44%    15.77%      0.36us      1.59us      0.44us ( +-   0.66% )
          H_SEND_CRQ        652    24.24%    10.97%      0.39us      1.84us      0.49us ( +-   1.20% )
               H_IPI        523    19.44%    62.05%      1.35us     19.70us      3.44us ( +-   2.88% )
     H_PUT_TERM_CHAR        411    15.28%     8.03%      0.38us      3.77us      0.57us ( +-   1.61% )
     H_GET_TERM_CHAR         50     1.86%     0.99%      0.40us      0.98us      0.57us ( +-   3.37% )
               H_EOI         20     0.74%     2.19%      2.22us      4.72us      3.17us ( +-   5.96% )

Total Samples:2690, Total events handled time:2896.94us.

Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hvcall.h           |  120 --------------------------
 arch/powerpc/include/uapi/asm/hcall_codes.h |  123 +++++++++++++++++++++++++++
 arch/powerpc/include/uapi/asm/kvm_perf.h    |    4 +
 arch/powerpc/include/uapi/asm/trace_hcall.h |  122 +++++++++++++++++++++++++++
 arch/powerpc/kvm/trace_hv.h                 |  117 --------------------------
 tools/perf/arch/powerpc/util/kvm-stat.c     |   61 +++++++++++++
 6 files changed, 313 insertions(+), 234 deletions(-)
 create mode 100644 arch/powerpc/include/uapi/asm/hcall_codes.h
 create mode 100644 arch/powerpc/include/uapi/asm/trace_hcall.h

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 85bc8c0..f810466 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -155,124 +155,8 @@
 /* Each control block has to be on a 4K boundary */
 #define H_CB_ALIGNMENT          4096
 
-/* pSeries hypervisor opcodes */
-#define H_REMOVE		0x04
-#define H_ENTER			0x08
-#define H_READ			0x0c
-#define H_CLEAR_MOD		0x10
-#define H_CLEAR_REF		0x14
-#define H_PROTECT		0x18
-#define H_GET_TCE		0x1c
-#define H_PUT_TCE		0x20
-#define H_SET_SPRG0		0x24
-#define H_SET_DABR		0x28
-#define H_PAGE_INIT		0x2c
-#define H_SET_ASR		0x30
-#define H_ASR_ON		0x34
-#define H_ASR_OFF		0x38
-#define H_LOGICAL_CI_LOAD	0x3c
-#define H_LOGICAL_CI_STORE	0x40
-#define H_LOGICAL_CACHE_LOAD	0x44
-#define H_LOGICAL_CACHE_STORE	0x48
-#define H_LOGICAL_ICBI		0x4c
-#define H_LOGICAL_DCBF		0x50
-#define H_GET_TERM_CHAR		0x54
-#define H_PUT_TERM_CHAR		0x58
-#define H_REAL_TO_LOGICAL	0x5c
-#define H_HYPERVISOR_DATA	0x60
-#define H_EOI			0x64
-#define H_CPPR			0x68
-#define H_IPI			0x6c
-#define H_IPOLL			0x70
-#define H_XIRR			0x74
-#define H_PERFMON		0x7c
-#define H_MIGRATE_DMA		0x78
-#define H_REGISTER_VPA		0xDC
-#define H_CEDE			0xE0
-#define H_CONFER		0xE4
-#define H_PROD			0xE8
-#define H_GET_PPP		0xEC
-#define H_SET_PPP		0xF0
-#define H_PURR			0xF4
-#define H_PIC			0xF8
-#define H_REG_CRQ		0xFC
-#define H_FREE_CRQ		0x100
-#define H_VIO_SIGNAL		0x104
-#define H_SEND_CRQ		0x108
-#define H_COPY_RDMA		0x110
-#define H_REGISTER_LOGICAL_LAN	0x114
-#define H_FREE_LOGICAL_LAN	0x118
-#define H_ADD_LOGICAL_LAN_BUFFER 0x11C
-#define H_SEND_LOGICAL_LAN	0x120
-#define H_BULK_REMOVE		0x124
-#define H_MULTICAST_CTRL	0x130
-#define H_SET_XDABR		0x134
-#define H_STUFF_TCE		0x138
-#define H_PUT_TCE_INDIRECT	0x13C
-#define H_CHANGE_LOGICAL_LAN_MAC 0x14C
-#define H_VTERM_PARTNER_INFO	0x150
-#define H_REGISTER_VTERM	0x154
-#define H_FREE_VTERM		0x158
-#define H_RESET_EVENTS          0x15C
-#define H_ALLOC_RESOURCE        0x160
-#define H_FREE_RESOURCE         0x164
-#define H_MODIFY_QP             0x168
-#define H_QUERY_QP              0x16C
-#define H_REREGISTER_PMR        0x170
-#define H_REGISTER_SMR          0x174
-#define H_QUERY_MR              0x178
-#define H_QUERY_MW              0x17C
-#define H_QUERY_HCA             0x180
-#define H_QUERY_PORT            0x184
-#define H_MODIFY_PORT           0x188
-#define H_DEFINE_AQP1           0x18C
-#define H_GET_TRACE_BUFFER      0x190
-#define H_DEFINE_AQP0           0x194
-#define H_RESIZE_MR             0x198
-#define H_ATTACH_MCQP           0x19C
-#define H_DETACH_MCQP           0x1A0
-#define H_CREATE_RPT            0x1A4
-#define H_REMOVE_RPT            0x1A8
-#define H_REGISTER_RPAGES       0x1AC
-#define H_DISABLE_AND_GETC      0x1B0
-#define H_ERROR_DATA            0x1B4
-#define H_GET_HCA_INFO          0x1B8
-#define H_GET_PERF_COUNT        0x1BC
-#define H_MANAGE_TRACE          0x1C0
-#define H_FREE_LOGICAL_LAN_BUFFER 0x1D4
-#define H_QUERY_INT_STATE       0x1E4
-#define H_POLL_PENDING		0x1D8
-#define H_ILLAN_ATTRIBUTES	0x244
-#define H_MODIFY_HEA_QP		0x250
-#define H_QUERY_HEA_QP		0x254
-#define H_QUERY_HEA		0x258
-#define H_QUERY_HEA_PORT	0x25C
-#define H_MODIFY_HEA_PORT	0x260
-#define H_REG_BCMC		0x264
-#define H_DEREG_BCMC		0x268
-#define H_REGISTER_HEA_RPAGES	0x26C
-#define H_DISABLE_AND_GET_HEA	0x270
-#define H_GET_HEA_INFO		0x274
-#define H_ALLOC_HEA_RESOURCE	0x278
-#define H_ADD_CONN		0x284
-#define H_DEL_CONN		0x288
-#define H_JOIN			0x298
-#define H_VASI_STATE            0x2A4
-#define H_ENABLE_CRQ		0x2B0
-#define H_GET_EM_PARMS		0x2B8
-#define H_SET_MPP		0x2D0
-#define H_GET_MPP		0x2D4
-#define H_HOME_NODE_ASSOCIATIVITY 0x2EC
-#define H_BEST_ENERGY		0x2F4
-#define H_XIRR_X		0x2FC
-#define H_RANDOM		0x300
-#define H_COP			0x304
-#define H_GET_MPP_X		0x314
-#define H_SET_MODE		0x31C
-#define MAX_HCALL_OPCODE	H_SET_MODE
-
-/* Platform specific hcalls, used by KVM */
-#define H_RTAS			0xf000
+/* include pSeries hypervisor opcodes */
+#include <uapi/asm/hcall_codes.h>
 
 /* "Platform specific hcalls", provided by PHYP */
 #define H_GET_24X7_CATALOG_PAGE	0xF078
diff --git a/arch/powerpc/include/uapi/asm/hcall_codes.h b/arch/powerpc/include/uapi/asm/hcall_codes.h
new file mode 100644
index 0000000..16b2f8c
--- /dev/null
+++ b/arch/powerpc/include/uapi/asm/hcall_codes.h
@@ -0,0 +1,123 @@
+#ifndef _ASM_POWERPC_HVCALL_CODES_H
+#define _ASM_POWERPC_HVCALL_CODES_H
+
+/* pSeries hypervisor opcodes */
+#define H_REMOVE               0x04
+#define H_ENTER                        0x08
+#define H_READ                 0x0c
+#define H_CLEAR_MOD            0x10
+#define H_CLEAR_REF            0x14
+#define H_PROTECT              0x18
+#define H_GET_TCE              0x1c
+#define H_PUT_TCE              0x20
+#define H_SET_SPRG0            0x24
+#define H_SET_DABR             0x28
+#define H_PAGE_INIT            0x2c
+#define H_SET_ASR              0x30
+#define H_ASR_ON               0x34
+#define H_ASR_OFF              0x38
+#define H_LOGICAL_CI_LOAD      0x3c
+#define H_LOGICAL_CI_STORE     0x40
+#define H_LOGICAL_CACHE_LOAD   0x44
+#define H_LOGICAL_CACHE_STORE  0x48
+#define H_LOGICAL_ICBI         0x4c
+#define H_LOGICAL_DCBF         0x50
+#define H_GET_TERM_CHAR                0x54
+#define H_PUT_TERM_CHAR                0x58
+#define H_REAL_TO_LOGICAL      0x5c
+#define H_HYPERVISOR_DATA      0x60
+#define H_EOI                  0x64
+#define H_CPPR                 0x68
+#define H_IPI                  0x6c
+#define H_IPOLL                        0x70
+#define H_XIRR                 0x74
+#define H_PERFMON              0x7c
+#define H_MIGRATE_DMA          0x78
+#define H_REGISTER_VPA         0xDC
+#define H_CEDE                 0xE0
+#define H_CONFER               0xE4
+#define H_PROD                 0xE8
+#define H_GET_PPP              0xEC
+#define H_SET_PPP              0xF0
+#define H_PURR                 0xF4
+#define H_PIC                  0xF8
+#define H_REG_CRQ              0xFC
+#define H_FREE_CRQ             0x100
+#define H_VIO_SIGNAL           0x104
+#define H_SEND_CRQ             0x108
+#define H_COPY_RDMA            0x110
+#define H_REGISTER_LOGICAL_LAN 0x114
+#define H_FREE_LOGICAL_LAN     0x118
+#define H_ADD_LOGICAL_LAN_BUFFER 0x11C
+#define H_SEND_LOGICAL_LAN     0x120
+#define H_BULK_REMOVE          0x124
+#define H_MULTICAST_CTRL       0x130
+#define H_SET_XDABR            0x134
+#define H_STUFF_TCE            0x138
+#define H_PUT_TCE_INDIRECT     0x13C
+#define H_CHANGE_LOGICAL_LAN_MAC 0x14C
+#define H_VTERM_PARTNER_INFO   0x150
+#define H_REGISTER_VTERM       0x154
+#define H_FREE_VTERM           0x158
+#define H_RESET_EVENTS          0x15C
+#define H_ALLOC_RESOURCE        0x160
+#define H_FREE_RESOURCE         0x164
+#define H_MODIFY_QP             0x168
+#define H_QUERY_QP              0x16C
+#define H_REREGISTER_PMR        0x170
+#define H_REGISTER_SMR          0x174
+#define H_QUERY_MR              0x178
+#define H_QUERY_MW              0x17C
+#define H_QUERY_HCA             0x180
+#define H_QUERY_PORT            0x184
+#define H_MODIFY_PORT           0x188
+#define H_DEFINE_AQP1           0x18C
+#define H_GET_TRACE_BUFFER      0x190
+#define H_DEFINE_AQP0           0x194
+#define H_RESIZE_MR             0x198
+#define H_ATTACH_MCQP           0x19C
+#define H_DETACH_MCQP           0x1A0
+#define H_CREATE_RPT            0x1A4
+#define H_REMOVE_RPT            0x1A8
+#define H_REGISTER_RPAGES       0x1AC
+#define H_DISABLE_AND_GETC      0x1B0
+#define H_ERROR_DATA            0x1B4
+#define H_GET_HCA_INFO          0x1B8
+#define H_GET_PERF_COUNT        0x1BC
+#define H_MANAGE_TRACE          0x1C0
+#define H_FREE_LOGICAL_LAN_BUFFER 0x1D4
+#define H_QUERY_INT_STATE       0x1E4
+#define H_POLL_PENDING         0x1D8
+#define H_ILLAN_ATTRIBUTES     0x244
+#define H_MODIFY_HEA_QP                0x250
+#define H_QUERY_HEA_QP         0x254
+#define H_QUERY_HEA            0x258
+#define H_QUERY_HEA_PORT       0x25C
+#define H_MODIFY_HEA_PORT      0x260
+#define H_REG_BCMC             0x264
+#define H_DEREG_BCMC           0x268
+#define H_REGISTER_HEA_RPAGES  0x26C
+#define H_DISABLE_AND_GET_HEA  0x270
+#define H_GET_HEA_INFO         0x274
+#define H_ALLOC_HEA_RESOURCE   0x278
+#define H_ADD_CONN             0x284
+#define H_DEL_CONN             0x288
+#define H_JOIN                 0x298
+#define H_VASI_STATE            0x2A4
+#define H_ENABLE_CRQ           0x2B0
+#define H_GET_EM_PARMS         0x2B8
+#define H_SET_MPP              0x2D0
+#define H_GET_MPP              0x2D4
+#define H_HOME_NODE_ASSOCIATIVITY 0x2EC
+#define H_BEST_ENERGY          0x2F4
+#define H_XIRR_X               0x2FC
+#define H_RANDOM               0x300
+#define H_COP                  0x304
+#define H_GET_MPP_X            0x314
+#define H_SET_MODE             0x31C
+#define MAX_HCALL_OPCODE       H_SET_MODE
+
+/* Platform specific hcalls, used by KVM */
+#define H_RTAS                 0xf000
+
+#endif
diff --git a/arch/powerpc/include/uapi/asm/kvm_perf.h b/arch/powerpc/include/uapi/asm/kvm_perf.h
index 30fa670..440902e 100644
--- a/arch/powerpc/include/uapi/asm/kvm_perf.h
+++ b/arch/powerpc/include/uapi/asm/kvm_perf.h
@@ -3,6 +3,7 @@
 
 #include <asm/trace_book3s.h>
 #include <asm/kvm.h>
+#include <asm/trace_hcall.h>
 
 #define DECODE_STR_LEN 20
 
@@ -11,5 +12,8 @@
 #define KVM_ENTRY_TRACE "kvm_hv:kvm_guest_enter"
 #define KVM_EXIT_TRACE "kvm_hv:kvm_guest_exit"
 #define KVM_EXIT_REASON "trap"
+#define KVM_HCALL_ENTRY_TRACE "kvm_hv:kvm_hcall_enter"
+#define KVM_HCALL_EXIT_TRACE "kvm_hv:kvm_hcall_exit"
+#define KVM_HCALL_REASON "req"
 
 #endif /* _ASM_POWERPC_KVM_PERF_H */
diff --git a/arch/powerpc/include/uapi/asm/trace_hcall.h b/arch/powerpc/include/uapi/asm/trace_hcall.h
new file mode 100644
index 0000000..fccef3a
--- /dev/null
+++ b/arch/powerpc/include/uapi/asm/trace_hcall.h
@@ -0,0 +1,122 @@
+#ifndef _KVM_TRACE_HCALL_MAP_H
+#define _KVM_TRACE_HCALL_MAP_H
+
+#include "hcall_codes.h"
+
+#define kvm_trace_symbol_hcall						\
+	{H_REMOVE,			"H_REMOVE"},			\
+	{H_ENTER,			"H_ENTER"},			\
+	{H_READ,			"H_READ"},			\
+	{H_CLEAR_MOD,			"H_CLEAR_MOD"},			\
+	{H_CLEAR_REF,			"H_CLEAR_REF"},			\
+	{H_PROTECT,			"H_PROTECT"},			\
+	{H_GET_TCE,			"H_GET_TCE"},			\
+	{H_PUT_TCE,			"H_PUT_TCE"},			\
+	{H_SET_SPRG0,			"H_SET_SPRG0"},			\
+	{H_SET_DABR,			"H_SET_DABR"},			\
+	{H_PAGE_INIT,			"H_PAGE_INIT"},			\
+	{H_SET_ASR,			"H_SET_ASR"},			\
+	{H_ASR_ON,			"H_ASR_ON"},			\
+	{H_ASR_OFF,			"H_ASR_OFF"},			\
+	{H_LOGICAL_CI_LOAD,		"H_LOGICAL_CI_LOAD"},		\
+	{H_LOGICAL_CI_STORE,		"H_LOGICAL_CI_STORE"},		\
+	{H_LOGICAL_CACHE_LOAD,		"H_LOGICAL_CACHE_LOAD"},	\
+	{H_LOGICAL_CACHE_STORE,		"H_LOGICAL_CACHE_STORE"},	\
+	{H_LOGICAL_ICBI,		"H_LOGICAL_ICBI"},		\
+	{H_LOGICAL_DCBF,		"H_LOGICAL_DCBF"},		\
+	{H_GET_TERM_CHAR,		"H_GET_TERM_CHAR"},		\
+	{H_PUT_TERM_CHAR,		"H_PUT_TERM_CHAR"},		\
+	{H_REAL_TO_LOGICAL,		"H_REAL_TO_LOGICAL"},		\
+	{H_HYPERVISOR_DATA,		"H_HYPERVISOR_DATA"},		\
+	{H_EOI,				"H_EOI"},			\
+	{H_CPPR,			"H_CPPR"},			\
+	{H_IPI,				"H_IPI"},			\
+	{H_IPOLL,			"H_IPOLL"},			\
+	{H_XIRR,			"H_XIRR"},			\
+	{H_PERFMON,			"H_PERFMON"},			\
+	{H_MIGRATE_DMA,			"H_MIGRATE_DMA"},		\
+	{H_REGISTER_VPA,		"H_REGISTER_VPA"},		\
+	{H_CEDE,			"H_CEDE"},			\
+	{H_CONFER,			"H_CONFER"},			\
+	{H_PROD,			"H_PROD"},			\
+	{H_GET_PPP,			"H_GET_PPP"},			\
+	{H_SET_PPP,			"H_SET_PPP"},			\
+	{H_PURR,			"H_PURR"},			\
+	{H_PIC,				"H_PIC"},			\
+	{H_REG_CRQ,			"H_REG_CRQ"},			\
+	{H_FREE_CRQ,			"H_FREE_CRQ"},			\
+	{H_VIO_SIGNAL,			"H_VIO_SIGNAL"},		\
+	{H_SEND_CRQ,			"H_SEND_CRQ"},			\
+	{H_COPY_RDMA,			"H_COPY_RDMA"},			\
+	{H_REGISTER_LOGICAL_LAN,	"H_REGISTER_LOGICAL_LAN"},	\
+	{H_FREE_LOGICAL_LAN,		"H_FREE_LOGICAL_LAN"},		\
+	{H_ADD_LOGICAL_LAN_BUFFER,	"H_ADD_LOGICAL_LAN_BUFFER"},	\
+	{H_SEND_LOGICAL_LAN,		"H_SEND_LOGICAL_LAN"},		\
+	{H_BULK_REMOVE,			"H_BULK_REMOVE"},		\
+	{H_MULTICAST_CTRL,		"H_MULTICAST_CTRL"},		\
+	{H_SET_XDABR,			"H_SET_XDABR"},			\
+	{H_STUFF_TCE,			"H_STUFF_TCE"},			\
+	{H_PUT_TCE_INDIRECT,		"H_PUT_TCE_INDIRECT"},		\
+	{H_CHANGE_LOGICAL_LAN_MAC,	"H_CHANGE_LOGICAL_LAN_MAC"},	\
+	{H_VTERM_PARTNER_INFO,		"H_VTERM_PARTNER_INFO"},	\
+	{H_REGISTER_VTERM,		"H_REGISTER_VTERM"},		\
+	{H_FREE_VTERM,			"H_FREE_VTERM"},		\
+	{H_RESET_EVENTS,		"H_RESET_EVENTS"},		\
+	{H_ALLOC_RESOURCE,		"H_ALLOC_RESOURCE"},		\
+	{H_FREE_RESOURCE,		"H_FREE_RESOURCE"},		\
+	{H_MODIFY_QP,			"H_MODIFY_QP"},			\
+	{H_QUERY_QP,			"H_QUERY_QP"},			\
+	{H_REREGISTER_PMR,		"H_REREGISTER_PMR"},		\
+	{H_REGISTER_SMR,		"H_REGISTER_SMR"},		\
+	{H_QUERY_MR,			"H_QUERY_MR"},			\
+	{H_QUERY_MW,			"H_QUERY_MW"},			\
+	{H_QUERY_HCA,			"H_QUERY_HCA"},			\
+	{H_QUERY_PORT,			"H_QUERY_PORT"},		\
+	{H_MODIFY_PORT,			"H_MODIFY_PORT"},		\
+	{H_DEFINE_AQP1,			"H_DEFINE_AQP1"},		\
+	{H_GET_TRACE_BUFFER,		"H_GET_TRACE_BUFFER"},		\
+	{H_DEFINE_AQP0,			"H_DEFINE_AQP0"},		\
+	{H_RESIZE_MR,			"H_RESIZE_MR"},			\
+	{H_ATTACH_MCQP,			"H_ATTACH_MCQP"},		\
+	{H_DETACH_MCQP,			"H_DETACH_MCQP"},		\
+	{H_CREATE_RPT,			"H_CREATE_RPT"},		\
+	{H_REMOVE_RPT,			"H_REMOVE_RPT"},		\
+	{H_REGISTER_RPAGES,		"H_REGISTER_RPAGES"},		\
+	{H_DISABLE_AND_GETC,		"H_DISABLE_AND_GETC"},		\
+	{H_ERROR_DATA,			"H_ERROR_DATA"},		\
+	{H_GET_HCA_INFO,		"H_GET_HCA_INFO"},		\
+	{H_GET_PERF_COUNT,		"H_GET_PERF_COUNT"},		\
+	{H_MANAGE_TRACE,		"H_MANAGE_TRACE"},		\
+	{H_FREE_LOGICAL_LAN_BUFFER,	"H_FREE_LOGICAL_LAN_BUFFER"},	\
+	{H_QUERY_INT_STATE,		"H_QUERY_INT_STATE"},		\
+	{H_POLL_PENDING,		"H_POLL_PENDING"},		\
+	{H_ILLAN_ATTRIBUTES,		"H_ILLAN_ATTRIBUTES"},		\
+	{H_MODIFY_HEA_QP,		"H_MODIFY_HEA_QP"},		\
+	{H_QUERY_HEA_QP,		"H_QUERY_HEA_QP"},		\
+	{H_QUERY_HEA,			"H_QUERY_HEA"},			\
+	{H_QUERY_HEA_PORT,		"H_QUERY_HEA_PORT"},		\
+	{H_MODIFY_HEA_PORT,		"H_MODIFY_HEA_PORT"},		\
+	{H_REG_BCMC,			"H_REG_BCMC"},			\
+	{H_DEREG_BCMC,			"H_DEREG_BCMC"},		\
+	{H_REGISTER_HEA_RPAGES,		"H_REGISTER_HEA_RPAGES"},	\
+	{H_DISABLE_AND_GET_HEA,		"H_DISABLE_AND_GET_HEA"},	\
+	{H_GET_HEA_INFO,		"H_GET_HEA_INFO"},		\
+	{H_ALLOC_HEA_RESOURCE,		"H_ALLOC_HEA_RESOURCE"},	\
+	{H_ADD_CONN,			"H_ADD_CONN"},			\
+	{H_DEL_CONN,			"H_DEL_CONN"},			\
+	{H_JOIN,			"H_JOIN"},			\
+	{H_VASI_STATE,			"H_VASI_STATE"},		\
+	{H_ENABLE_CRQ,			"H_ENABLE_CRQ"},		\
+	{H_GET_EM_PARMS,		"H_GET_EM_PARMS"},		\
+	{H_SET_MPP,			"H_SET_MPP"},			\
+	{H_GET_MPP,			"H_GET_MPP"},			\
+	{H_HOME_NODE_ASSOCIATIVITY,	"H_HOME_NODE_ASSOCIATIVITY"},	\
+	{H_BEST_ENERGY,			"H_BEST_ENERGY"},		\
+	{H_XIRR_X,			"H_XIRR_X"},			\
+	{H_RANDOM,			"H_RANDOM"},			\
+	{H_COP,				"H_COP"},			\
+	{H_GET_MPP_X,			"H_GET_MPP_X"},			\
+	{H_SET_MODE,			"H_SET_MODE"},			\
+	{H_RTAS,			"H_RTAS"}
+
+#endif
diff --git a/arch/powerpc/kvm/trace_hv.h b/arch/powerpc/kvm/trace_hv.h
index 02d0a07..6063aa9 100644
--- a/arch/powerpc/kvm/trace_hv.h
+++ b/arch/powerpc/kvm/trace_hv.h
@@ -3,6 +3,7 @@
 
 #include <linux/tracepoint.h>
 #include <uapi/asm/trace_book3s.h>
+#include <uapi/asm/trace_hcall.h>
 #include <asm/hvcall.h>
 #include <asm/kvm_asm.h>
 
@@ -11,122 +12,6 @@
 #define TRACE_INCLUDE_PATH .
 #define TRACE_INCLUDE_FILE trace_hv
 
-#define kvm_trace_symbol_hcall \
-	{H_REMOVE,			"H_REMOVE"}, \
-	{H_ENTER,			"H_ENTER"}, \
-	{H_READ,			"H_READ"}, \
-	{H_CLEAR_MOD,			"H_CLEAR_MOD"}, \
-	{H_CLEAR_REF,			"H_CLEAR_REF"}, \
-	{H_PROTECT,			"H_PROTECT"}, \
-	{H_GET_TCE,			"H_GET_TCE"}, \
-	{H_PUT_TCE,			"H_PUT_TCE"}, \
-	{H_SET_SPRG0,			"H_SET_SPRG0"}, \
-	{H_SET_DABR,			"H_SET_DABR"}, \
-	{H_PAGE_INIT,			"H_PAGE_INIT"}, \
-	{H_SET_ASR,			"H_SET_ASR"}, \
-	{H_ASR_ON,			"H_ASR_ON"}, \
-	{H_ASR_OFF,			"H_ASR_OFF"}, \
-	{H_LOGICAL_CI_LOAD,		"H_LOGICAL_CI_LOAD"}, \
-	{H_LOGICAL_CI_STORE,		"H_LOGICAL_CI_STORE"}, \
-	{H_LOGICAL_CACHE_LOAD,		"H_LOGICAL_CACHE_LOAD"}, \
-	{H_LOGICAL_CACHE_STORE,		"H_LOGICAL_CACHE_STORE"}, \
-	{H_LOGICAL_ICBI,		"H_LOGICAL_ICBI"}, \
-	{H_LOGICAL_DCBF,		"H_LOGICAL_DCBF"}, \
-	{H_GET_TERM_CHAR,		"H_GET_TERM_CHAR"}, \
-	{H_PUT_TERM_CHAR,		"H_PUT_TERM_CHAR"}, \
-	{H_REAL_TO_LOGICAL,		"H_REAL_TO_LOGICAL"}, \
-	{H_HYPERVISOR_DATA,		"H_HYPERVISOR_DATA"}, \
-	{H_EOI,				"H_EOI"}, \
-	{H_CPPR,			"H_CPPR"}, \
-	{H_IPI,				"H_IPI"}, \
-	{H_IPOLL,			"H_IPOLL"}, \
-	{H_XIRR,			"H_XIRR"}, \
-	{H_PERFMON,			"H_PERFMON"}, \
-	{H_MIGRATE_DMA,			"H_MIGRATE_DMA"}, \
-	{H_REGISTER_VPA,		"H_REGISTER_VPA"}, \
-	{H_CEDE,			"H_CEDE"}, \
-	{H_CONFER,			"H_CONFER"}, \
-	{H_PROD,			"H_PROD"}, \
-	{H_GET_PPP,			"H_GET_PPP"}, \
-	{H_SET_PPP,			"H_SET_PPP"}, \
-	{H_PURR,			"H_PURR"}, \
-	{H_PIC,				"H_PIC"}, \
-	{H_REG_CRQ,			"H_REG_CRQ"}, \
-	{H_FREE_CRQ,			"H_FREE_CRQ"}, \
-	{H_VIO_SIGNAL,			"H_VIO_SIGNAL"}, \
-	{H_SEND_CRQ,			"H_SEND_CRQ"}, \
-	{H_COPY_RDMA,			"H_COPY_RDMA"}, \
-	{H_REGISTER_LOGICAL_LAN,	"H_REGISTER_LOGICAL_LAN"}, \
-	{H_FREE_LOGICAL_LAN,		"H_FREE_LOGICAL_LAN"}, \
-	{H_ADD_LOGICAL_LAN_BUFFER,	"H_ADD_LOGICAL_LAN_BUFFER"}, \
-	{H_SEND_LOGICAL_LAN,		"H_SEND_LOGICAL_LAN"}, \
-	{H_BULK_REMOVE,			"H_BULK_REMOVE"}, \
-	{H_MULTICAST_CTRL,		"H_MULTICAST_CTRL"}, \
-	{H_SET_XDABR,			"H_SET_XDABR"}, \
-	{H_STUFF_TCE,			"H_STUFF_TCE"}, \
-	{H_PUT_TCE_INDIRECT,		"H_PUT_TCE_INDIRECT"}, \
-	{H_CHANGE_LOGICAL_LAN_MAC,	"H_CHANGE_LOGICAL_LAN_MAC"}, \
-	{H_VTERM_PARTNER_INFO,		"H_VTERM_PARTNER_INFO"}, \
-	{H_REGISTER_VTERM,		"H_REGISTER_VTERM"}, \
-	{H_FREE_VTERM,			"H_FREE_VTERM"}, \
-	{H_RESET_EVENTS,		"H_RESET_EVENTS"}, \
-	{H_ALLOC_RESOURCE,		"H_ALLOC_RESOURCE"}, \
-	{H_FREE_RESOURCE,		"H_FREE_RESOURCE"}, \
-	{H_MODIFY_QP,			"H_MODIFY_QP"}, \
-	{H_QUERY_QP,			"H_QUERY_QP"}, \
-	{H_REREGISTER_PMR,		"H_REREGISTER_PMR"}, \
-	{H_REGISTER_SMR,		"H_REGISTER_SMR"}, \
-	{H_QUERY_MR,			"H_QUERY_MR"}, \
-	{H_QUERY_MW,			"H_QUERY_MW"}, \
-	{H_QUERY_HCA,			"H_QUERY_HCA"}, \
-	{H_QUERY_PORT,			"H_QUERY_PORT"}, \
-	{H_MODIFY_PORT,			"H_MODIFY_PORT"}, \
-	{H_DEFINE_AQP1,			"H_DEFINE_AQP1"}, \
-	{H_GET_TRACE_BUFFER,		"H_GET_TRACE_BUFFER"}, \
-	{H_DEFINE_AQP0,			"H_DEFINE_AQP0"}, \
-	{H_RESIZE_MR,			"H_RESIZE_MR"}, \
-	{H_ATTACH_MCQP,			"H_ATTACH_MCQP"}, \
-	{H_DETACH_MCQP,			"H_DETACH_MCQP"}, \
-	{H_CREATE_RPT,			"H_CREATE_RPT"}, \
-	{H_REMOVE_RPT,			"H_REMOVE_RPT"}, \
-	{H_REGISTER_RPAGES,		"H_REGISTER_RPAGES"}, \
-	{H_DISABLE_AND_GETC,		"H_DISABLE_AND_GETC"}, \
-	{H_ERROR_DATA,			"H_ERROR_DATA"}, \
-	{H_GET_HCA_INFO,		"H_GET_HCA_INFO"}, \
-	{H_GET_PERF_COUNT,		"H_GET_PERF_COUNT"}, \
-	{H_MANAGE_TRACE,		"H_MANAGE_TRACE"}, \
-	{H_FREE_LOGICAL_LAN_BUFFER,	"H_FREE_LOGICAL_LAN_BUFFER"}, \
-	{H_QUERY_INT_STATE,		"H_QUERY_INT_STATE"}, \
-	{H_POLL_PENDING,		"H_POLL_PENDING"}, \
-	{H_ILLAN_ATTRIBUTES,		"H_ILLAN_ATTRIBUTES"}, \
-	{H_MODIFY_HEA_QP,		"H_MODIFY_HEA_QP"}, \
-	{H_QUERY_HEA_QP,		"H_QUERY_HEA_QP"}, \
-	{H_QUERY_HEA,			"H_QUERY_HEA"}, \
-	{H_QUERY_HEA_PORT,		"H_QUERY_HEA_PORT"}, \
-	{H_MODIFY_HEA_PORT,		"H_MODIFY_HEA_PORT"}, \
-	{H_REG_BCMC,			"H_REG_BCMC"}, \
-	{H_DEREG_BCMC,			"H_DEREG_BCMC"}, \
-	{H_REGISTER_HEA_RPAGES,		"H_REGISTER_HEA_RPAGES"}, \
-	{H_DISABLE_AND_GET_HEA,		"H_DISABLE_AND_GET_HEA"}, \
-	{H_GET_HEA_INFO,		"H_GET_HEA_INFO"}, \
-	{H_ALLOC_HEA_RESOURCE,		"H_ALLOC_HEA_RESOURCE"}, \
-	{H_ADD_CONN,			"H_ADD_CONN"}, \
-	{H_DEL_CONN,			"H_DEL_CONN"}, \
-	{H_JOIN,			"H_JOIN"}, \
-	{H_VASI_STATE,			"H_VASI_STATE"}, \
-	{H_ENABLE_CRQ,			"H_ENABLE_CRQ"}, \
-	{H_GET_EM_PARMS,		"H_GET_EM_PARMS"}, \
-	{H_SET_MPP,			"H_SET_MPP"}, \
-	{H_GET_MPP,			"H_GET_MPP"}, \
-	{H_HOME_NODE_ASSOCIATIVITY,	"H_HOME_NODE_ASSOCIATIVITY"}, \
-	{H_BEST_ENERGY,			"H_BEST_ENERGY"}, \
-	{H_XIRR_X,			"H_XIRR_X"}, \
-	{H_RANDOM,			"H_RANDOM"}, \
-	{H_COP,				"H_COP"}, \
-	{H_GET_MPP_X,			"H_GET_MPP_X"}, \
-	{H_SET_MODE,			"H_SET_MODE"}, \
-	{H_RTAS,			"H_RTAS"}
-
 #define kvm_trace_symbol_kvmret \
 	{RESUME_GUEST,			"RESUME_GUEST"}, \
 	{RESUME_GUEST_NV,		"RESUME_GUEST_NV"}, \
diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index 62cdcc1..914cca3 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -1,7 +1,9 @@
 #include "../../util/kvm-stat.h"
 #include <asm/kvm_perf.h>
+#include "../../util/debug.h"
 
 define_exit_reasons_table(hv_exit_reasons, kvm_trace_symbol_exit);
+define_exit_reasons_table(hcall_reasons, kvm_trace_symbol_hcall);
 
 static struct kvm_events_ops exit_events = {
 	.is_begin_event = exit_event_begin,
@@ -10,14 +12,73 @@ static struct kvm_events_ops exit_events = {
 	.name = "VM-EXIT"
 };
 
+static void hcall_event_get_key(struct perf_evsel *evsel,
+				struct perf_sample *sample,
+				struct event_key *key)
+{
+	key->info = 0;
+	key->key = perf_evsel__intval(evsel, sample, KVM_HCALL_REASON);
+}
+
+static const char *get_exit_reason(u64 exit_code)
+{
+	struct exit_reasons_table *tbl = hcall_reasons;
+
+	while (tbl->reason != NULL) {
+		if (tbl->exit_code == exit_code)
+			return tbl->reason;
+		tbl++;
+	}
+
+	pr_err("Unknown kvm hcall exit code: %lld\n",
+	       (unsigned long long)exit_code);
+	return "UNKNOWN";
+}
+
+static bool hcall_event_end(struct perf_evsel *evsel,
+			    struct perf_sample *sample __maybe_unused,
+			    struct event_key *key __maybe_unused)
+{
+	return (!strcmp(evsel->name, KVM_HCALL_EXIT_TRACE));
+}
+
+static bool hcall_event_begin(struct perf_evsel *evsel,
+			      struct perf_sample *sample, struct event_key *key)
+{
+	if (!strcmp(evsel->name, KVM_HCALL_ENTRY_TRACE)) {
+		hcall_event_get_key(evsel, sample, key);
+		return true;
+	}
+
+	return false;
+}
+static void hcall_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
+				   struct event_key *key,
+				   char *decode)
+{
+	const char *hcall_reason = get_exit_reason(key->key);
+
+	scnprintf(decode, DECODE_STR_LEN, "%s", hcall_reason);
+}
+
+static struct kvm_events_ops hcall_events = {
+	.is_begin_event = hcall_event_begin,
+	.is_end_event = hcall_event_end,
+	.decode_key = hcall_event_decode_key,
+	.name = "SYSCALL-EVENT",
+};
+
 const char *const kvm_events_tp[] = {
 	"kvm_hv:kvm_guest_exit",
 	"kvm_hv:kvm_guest_enter",
+	"kvm_hv:kvm_hcall_enter",
+	"kvm_hv:kvm_hcall_exit",
 	NULL,
 };
 
 struct kvm_reg_events_ops kvm_reg_events_ops[] = {
 	{ .name = "vmexit", .ops = &exit_events },
+	{ .name = "syscall", .ops = &hcall_events },
 	{ NULL, NULL },
 };
 
