Return-Path: <tom.huynh@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0147.outbound.protection.outlook.com [65.55.169.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 71B8F1A0A03
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Feb 2015 09:45:23 +1100 (AEDT)
From: Tom Huynh <tom.huynh@freescale.com>
To: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <a.p.zijlstra@chello.nl>, <mingo@redhat.com>, <acme@kernel.org>
Subject: [PATCH 3/3] perf/doc: Update perf_event_attr struct
Date: Fri, 6 Feb 2015 16:43:56 -0600
Message-ID: <1423262636-12053-4-git-send-email-tom.huynh@freescale.com>
In-Reply-To: <1423262636-12053-1-git-send-email-tom.huynh@freescale.com>
References: <1423262636-12053-1-git-send-email-tom.huynh@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tom Huynh <tom.huynh@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update the fields in perf_event_attr as currently seen in
include/uapi/linux/perf_event.h

Remove outdated comments on the config field
	The doc has not account for commit a21ca2cac582 ("perf_counter:
	Separate out attr->type from attr->config").

Signed-off-by: Tom Huynh <tom.huynh@freescale.com>
---
 tools/perf/design.txt | 159 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 113 insertions(+), 46 deletions(-)

diff --git a/tools/perf/design.txt b/tools/perf/design.txt
index a28dca2..96bd261 100644
--- a/tools/perf/design.txt
+++ b/tools/perf/design.txt
@@ -32,60 +32,127 @@ can be used to set the blocking mode, etc.
 Multiple counters can be kept open at a time, and the counters
 can be poll()ed.
 
-When creating a new counter fd, 'perf_event_attr' is:
+When creating a new counter fd, 'perf_event_attr' is defined in
+include/linux/uapi/perf_event.h as:
 
 struct perf_event_attr {
-        /*
-         * The MSB of the config word signifies if the rest contains cpu
-         * specific (raw) counter configuration data, if unset, the next
-         * 7 bits are an event type and the rest of the bits are the event
-         * identifier.
-         */
-        __u64                   config;
-
-        __u64                   irq_period;
-        __u32                   record_type;
-        __u32                   read_format;
-
-        __u64                   disabled       :  1, /* off by default        */
-                                inherit        :  1, /* children inherit it   */
-                                pinned         :  1, /* must always be on PMU */
-                                exclusive      :  1, /* only group on PMU     */
-                                exclude_user   :  1, /* don't count user      */
-                                exclude_kernel :  1, /* ditto kernel          */
-                                exclude_hv     :  1, /* ditto hypervisor      */
-                                exclude_idle   :  1, /* don't count when idle */
-                                mmap           :  1, /* include mmap data     */
-                                munmap         :  1, /* include munmap data   */
-                                comm           :  1, /* include comm data     */
-
-                                __reserved_1   : 52;
-
-        __u32                   extra_config_len;
-        __u32                   wakeup_events;  /* wakeup every n events */
-
-        __u64                   __reserved_2;
-        __u64                   __reserved_3;
-};
 
-The 'config' field specifies what the counter should count.  It
-is divided into 3 bit-fields:
+	/*
+	 * Major type: hardware/software/tracepoint/etc.
+	 */
+	__u32			type;
+
+	/*
+	 * Size of the attr structure, for fwd/bwd compat.
+	 */
+	__u32			size;
+
+	/*
+	 * Type specific configuration information.
+	 */
+	__u64			config;
+
+	union {
+		__u64		sample_period;
+		__u64		sample_freq;
+	};
+
+	__u64			sample_type;
+	__u64			read_format;
+
+	__u64			disabled       :  1, /* off by default        */
+				inherit	       :  1, /* children inherit it   */
+				pinned	       :  1, /* must always be on PMU */
+				exclusive      :  1, /* only group on PMU     */
+				exclude_user   :  1, /* don't count user      */
+				exclude_kernel :  1, /* ditto kernel          */
+				exclude_hv     :  1, /* ditto hypervisor      */
+				exclude_idle   :  1, /* don't count when idle */
+				mmap           :  1, /* include mmap data     */
+				comm	       :  1, /* include comm data     */
+				freq           :  1, /* use freq, not period  */
+				inherit_stat   :  1, /* per task counts       */
+				enable_on_exec :  1, /* next exec enables     */
+				task           :  1, /* trace fork/exit       */
+				watermark      :  1, /* wakeup_watermark      */
+				/*
+				 * precise_ip:
+				 *
+				 *  0 - SAMPLE_IP can have arbitrary skid
+				 *  1 - SAMPLE_IP must have constant skid
+				 *  2 - SAMPLE_IP requested to have 0 skid
+				 *  3 - SAMPLE_IP must have 0 skid
+				 *
+				 *  See also PERF_RECORD_MISC_EXACT_IP
+				 */
+				precise_ip     :  2, /* skid constraint       */
+				mmap_data      :  1, /* non-exec mmap data    */
+				sample_id_all  :  1, /* sample_type all events */
+
+				exclude_host   :  1, /* don't count in host   */
+				exclude_guest  :  1, /* don't count in guest  */
+
+				exclude_callchain_kernel : 1, /* exclude kernel callchains */
+				exclude_callchain_user   : 1, /* exclude user callchains */
+				mmap2          :  1, /* include mmap with inode data     */
+				comm_exec      :  1, /* flag comm events that are due to an exec */
+				__reserved_1   : 39;
+
+	union {
+		__u32		wakeup_events;	  /* wakeup every n events */
+		__u32		wakeup_watermark; /* bytes before wakeup   */
+	};
+
+	__u32			bp_type;
+	union {
+		__u64		bp_addr;
+		__u64		config1; /* extension of config */
+	};
+	union {
+		__u64		bp_len;
+		__u64		config2; /* extension of config1 */
+	};
+	__u64	branch_sample_type; /* enum perf_branch_sample_type */
+
+	/*
+	 * Defines set of user regs to dump on samples.
+	 * See asm/perf_regs.h for details.
+	 */
+	__u64	sample_regs_user;
+
+	/*
+	 * Defines size of the user stack to dump on samples.
+	 */
+	__u32	sample_stack_user;
 
-raw_type: 1 bit   (most significant bit)	0x8000_0000_0000_0000
-type:	  7 bits  (next most significant)	0x7f00_0000_0000_0000
-event_id: 56 bits (least significant)		0x00ff_ffff_ffff_ffff
+	/* Align to u64. */
+	__u32	__reserved_2;
+	/*
+	 * Defines set of regs to dump for each sample
+	 * state captured on:
+	 *  - precise = 0: PMU interrupt
+	 *  - precise > 0: sampled instruction
+	 *
+	 * See asm/perf_regs.h for details.
+	 */
+	__u64	sample_regs_intr;
+};
 
-If 'raw_type' is 1, then the counter will count a hardware event
-specified by the remaining 63 bits of event_config.  The encoding is
-machine-specific.
+The 'config' field specifies what the counter should count.  The counter will
+count a hardware event specified by the 64 bits of event_config.  The encoding
+is machine-specific.
 
-If 'raw_type' is 0, then the 'type' field says what kind of counter
-this is, with the following encoding:
+The 'type' field says what kind of counter this is, with the following encoding:
 
 enum perf_type_id {
-	PERF_TYPE_HARDWARE		= 0,
-	PERF_TYPE_SOFTWARE		= 1,
-	PERF_TYPE_TRACEPOINT		= 2,
+	PERF_TYPE_HARDWARE			= 0,
+	PERF_TYPE_SOFTWARE			= 1,
+	PERF_TYPE_TRACEPOINT			= 2,
+	PERF_TYPE_HW_CACHE			= 3,
+	PERF_TYPE_RAW				= 4,
+	PERF_TYPE_BREAKPOINT			= 5,
+
+	PERF_TYPE_MAX,				/* non-ABI */
 };
 
 A counter of PERF_TYPE_HARDWARE will count the hardware event
-- 
1.9.1
