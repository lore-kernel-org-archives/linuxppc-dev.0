Return-Path: <cody@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1B8072C02FC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Mar 2014 11:45:24 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Wed, 5 Mar 2014 19:45:22 -0500
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 523A238C8045
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 19:45:20 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s260jKxB57475290
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Mar 2014 00:45:20 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s260jJKK015539
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Mar 2014 19:45:20 -0500
From: Cody P Schafer <cody@linux.vnet.ibm.com>
To: linux-doc@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Cody P Schafer <cody@linux.vnet.ibm.com>,
 Michael Ellerman <michael@ellerman.id.au>,
 Runzhen Wang <runzhen@linux.vnet.ibm.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [PATCH 1/2] perf Documentation: sysfs events/ interfaces
Date: Wed,  5 Mar 2014 16:44:14 -0800
Message-Id: <1394066658-16766-2-git-send-email-cody@linux.vnet.ibm.com>
In-Reply-To: <1394066658-16766-1-git-send-email-cody@linux.vnet.ibm.com>
References: <1394066658-16766-1-git-send-email-cody@linux.vnet.ibm.com>
Cc: rob@landley.net, Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add documentation for the <event>, <event>.scale, and <event>.unit
files in sysfs.

<event>.scale and <event>.unit were undocumented.
<event> was previously documented only for specific powerpc pmu events.

I've added a restriction that event names cannot contain '.' characters
so we can avoid breaking the API when we (inevitably) add more
'event.????' files.

Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
---
 .../testing/sysfs-bus-event_source-devices-events  | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
index 3c1cc24..5393e1ed6 100644
--- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
@@ -82,3 +82,62 @@ Description:	POWER-systems specific performance monitoring events
 		Further, multiple terms like 'event=0xNNNN' can be specified
 		and separated with comma. All available terms are defined in
 		the /sys/bus/event_source/devices/<dev>/format file.
+
+What: /sys/bus/event_source/devices/<pmu>/events/<event>
+Date: 2014/02/24
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Per-pmu performance monitoring events specific to the running system
+
+		Each file (with a name not containing a '.') in the 'events'
+		directory describes a single performance monitoring event
+		supported by the <pmu>. The name of the file is the name of the event.
+
+		File contents:
+
+			<term>[=<value>][,<term>[=<value>]]...
+
+		Where <term> is one of the terms listed under
+		/sys/bus/event_source/devices/<pmu>/format/ and <value> is
+		a number is base-16 format with a '0x' prefix (lowercase only).
+		If a <term> is specified alone (without an assigned value), it
+		is implied that 0x1 is assigned to that <term>.
+
+		Examples (each of these lines would be in a seperate file):
+
+			event=0x2abc
+			event=0x423,inv,cmask=0x3
+			domain=0x1,offset=0x8,starting_index=0xffff
+
+		Each of the assignments indicates a value to be assigned to a
+		particular set of bits (as defined by the format file
+		corresponding to the <term>) in the perf_event structure passed
+		to the perf_open syscall.
+
+What: /sys/bus/event_source/devices/<pmu>/events/<event>.unit
+Date: 2014/02/24
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Perf event units
+
+		A string specifying the English plural numerical unit that <event>
+		(once multiplied by <event>.scale) represents.
+
+		Example:
+
+			Joules
+
+What: /sys/bus/event_source/devices/<pmu>/events/<event>.scale
+Date: 2014/02/24
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Perf event scaling factors
+
+		A string representing a floating point value expressed in
+		scientific notation to be multiplied by the event count
+		recieved from the kernel to match the unit specified in the
+		<event>.unit file.
+
+		Example:
+
+			2.3283064365386962890625e-10
+
+		This is provided to avoid performing floating point arithmetic
+		in the kernel.
-- 
1.9.0
