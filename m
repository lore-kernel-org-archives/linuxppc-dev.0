Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 06E101A0F5A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jan 2015 12:14:40 +1100 (AEDT)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 7 Jan 2015 18:14:39 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 9A42E3E4003D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jan 2015 18:14:35 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t081F7TQ44957902
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Jan 2015 18:15:07 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t081EYYd006473
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 7 Jan 2015 18:14:35 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH v7 3/4] perf Documentation: add event parameters
Date: Wed,  7 Jan 2015 17:13:52 -0800
Message-Id: <1420679633-28856-4-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1420679633-28856-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1420679633-28856-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: peterz@infradead.org, linuxppc-dev@lists.ozlabs.org, dev@codyps.com,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Cody P Schafer <cody@linux.vnet.ibm.com>

Event parameters are a basic way for partial events to be specified in
sysfs with per-event names given to the fields that need to be filled in
when using a particular event.

It is intended for supporting cases where the single 'cpu' parameter is
insufficient. For example, POWER 8 has events for physical
sockets/cores/cpus that are accessible from with virtual machines. To
keep using the single 'cpu' parameter we'd need to perform a mapping
between Linux's cpus and the physical machine's cpus (in this case
Linux is running under a hypervisor). This isn't possible because
bindings between our cpus and physical cpus may not be fixed, and we
probably won't have a "cpu" on each physical cpu.

CC: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
CC: Haren Myneni <hbabu@us.ibm.com>
CC: Cody P Schafer <dev@codyps.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
Changelog[v6]
	Update event description to explain how required parameters
	are displayed.

 Documentation/ABI/testing/sysfs-bus-event_source-devices-events | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
index 20979f8..505f080 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
@@ -52,12 +52,18 @@ Description:	Per-pmu performance monitoring events specific to the running syste
 			event=0x2abc
 			event=0x423,inv,cmask=0x3
 			domain=0x1,offset=0x8,starting_index=0xffff
+			domain=0x1,offset=0x8,core=?
 
 		Each of the assignments indicates a value to be assigned to a
 		particular set of bits (as defined by the format file
 		corresponding to the <term>) in the perf_event structure passed
 		to the perf_open syscall.
 
+		In the case of the last example, a value replacing "?" would
+		need to be provided by the user selecting the particular event.
+		This is referred to as "event parameterization". Event
+		parameters have the format 'param=?'.
+
 What: /sys/bus/event_source/devices/<pmu>/events/<event>.unit
 Date: 2014/02/24
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
-- 
1.8.3.1
