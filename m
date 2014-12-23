Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 12E021A0DB6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Dec 2014 07:00:11 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 23 Dec 2014 13:00:09 -0700
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 3D00638C8046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 15:00:06 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBNK06KQ16777332
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 20:00:06 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBNK04bF017374
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 15:00:05 -0500
Date: Tue, 23 Dec 2014 11:59:34 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH v6 3/4] perf Documentation: add event parameters
Message-ID: <20141223195934.GB26952@us.ibm.com>
References: <1419234567-22784-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1419234567-22784-4-git-send-email-sukadev@linux.vnet.ibm.com>
 <20141222143943.GB29096@krava.brq.redhat.com>
 <20141222193436.GB19784@us.ibm.com>
 <20141223095121.GA22265@krava.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141223095121.GA22265@krava.brq.redhat.com>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, dev@codyps.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>From bfc20fd2161060cc51f3f24aa91663da39e97750 Mon Sep 17 00:00:00 2001
From: Cody P Schafer <cody@linux.vnet.ibm.com>
Date: Wed, 24 Sep 2014 12:27:22 -0700
Subject: [PATCH 3/4] perf Documentation: add event parameters

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

Changelog[v6]
	Update event description to explain how required parameters
	are displayed.

CC: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
CC: Haren Myneni <hbabu@us.ibm.com>
CC: Cody P Schafer <dev@codyps.com>
Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
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
