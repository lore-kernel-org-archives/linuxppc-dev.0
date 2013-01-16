Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 527CF2C0087
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2013 05:58:20 +1100 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 16 Jan 2013 11:58:16 -0700
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 591F319D803F
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2013 11:58:11 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0GIw5tQ054080
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2013 11:58:06 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0GIvvAa012955
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2013 11:57:58 -0700
Date: Wed, 16 Jan 2013 10:58:16 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 6/6][v3] perf: Document the ABI of perf sysfs entries
Message-ID: <20130116185815.GA3351@us.ibm.com>
References: <20130110010347.GA32590@us.ibm.com>
 <20130110010703.GF32590@us.ibm.com>
 <20130115185759.GG5826@ghostprotocols.net>
 <20130116113013.GA1042@krava.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130116113013.GA1042@krava.brq.redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 robert.richter@amd.com, Greg KH <greg@kroah.com>,
 Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jiri Olsa [jolsa@redhat.com] wrote:
| On Tue, Jan 15, 2013 at 03:57:59PM -0300, Arnaldo Carvalho de Melo wrote:
| > Em Wed, Jan 09, 2013 at 05:07:03PM -0800, Sukadev Bhattiprolu escreveu:
| > > [PATCH 6/6][v3] perf: Document the ABI of perf sysfs entries
| > > 
| > > This patchset addes two new sets of files to sysfs:
| > > 
| > > 	- generic and POWER-specific perf events in /sys/devices/cpu/events/
| > > 	- perf event config format in /sys/devices/cpu/format/event
| > > 
| > > Document the format of these files which would become part of the ABI.
| > > 
| > > Changelog[v3]:
| > > 	[Greg KH] Include ABI documentation.
| > 
| > Jiri, can I have your ack on this one too?
| 
| hm, we already already 'format' definition but in testing section
| (and we are missing 'events' definition there.. my bad)

I see that file now ! I have removed that documentation from my patch.
| 
| anyway, after reading Documentation/ABI/README looks like we
| should go for 'testing' section with this as well.. stable
| seems scary at this point ;-)

Agree.

Here is the updated patch.
---

This patchset addes two new sets of files to sysfs for POWER architecture.

	- perf event config format in /sys/devices/cpu/format/event
	- generic and POWER-specific perf events in /sys/devices/cpu/events/

The format of the first file is already documented in:

	Documentation/ABI/testing/sysfs-bus-event_source-devices-format

Document the format of the second set of files '/sys/devices/cpu/events/*'
which would also become part of the ABI.

Changelog[v3.1]:
	(small changes to this one patch).
	[Jiri Olsa]: Remove the documentation for the 'config format' file
	as it is already documented.
	[Jiri Olsa]: Move the documentation of 'events' also to 'testing/'

Changelog[v3]:
	[Greg KH] Include ABI documentation.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 .../testing/sysfs-bus-event_source-devices-events  |   58 ++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)
 delete mode 100644 Documentation/ABI/stable/sysfs-devices-cpu-events
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-events

diff --git a/Documentation/ABI/stable/sysfs-devices-cpu-events b/Documentation/ABI/stable/sysfs-devices-cpu-events
deleted file mode 100644
index e69de29..0000000
diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
new file mode 100644
index 0000000..2c4081e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
@@ -0,0 +1,58 @@
+What:		/sys/devices/cpu/events/
+		/sys/devices/cpu/events/branch-misses
+		/sys/devices/cpu/events/cache-references
+		/sys/devices/cpu/events/cache-misses
+		/sys/devices/cpu/events/stalled-cycles-frontend
+		/sys/devices/cpu/events/branch-instructions
+		/sys/devices/cpu/events/stalled-cycles-backend
+		/sys/devices/cpu/events/instructions
+		/sys/devices/cpu/events/cpu-cycles
+
+Date:		2012/01/NN
+
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+
+Description:	Generic performance monitoring events
+
+		A collection of performance monitoring events that may be
+		supported by many/most CPUs. These events can be monitored
+		using the 'perf(1)' tool.
+
+		The contents of each file would look like:
+
+			event=0xNNNN
+
+		where 'N' is a hex digit and the number '0xNNNN' shows the
+		"raw code" for the perf event identified by the file's
+		"basename".
+
+
+What: 		/sys/devices/cpu/events/PM_LD_MISS_L1
+		/sys/devices/cpu/events/PM_LD_REF_L1
+		/sys/devices/cpu/events/PM_CYC
+		/sys/devices/cpu/events/PM_BRU_FIN
+		/sys/devices/cpu/events/PM_GCT_NOSLOT_CYC
+		/sys/devices/cpu/events/PM_BRU_MPRED
+		/sys/devices/cpu/events/PM_INST_CMPL
+		/sys/devices/cpu/events/PM_CMPLU_STALL
+
+Date:		2013/01/08
+
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+		Linux Powerpc mailing list <linuxppc-dev@ozlabs.org>
+
+Description:	POWER-systems specific performance monitoring events
+
+		A collection of performance monitoring events that may be
+		supported by the POWER CPU. These events can be monitored
+		using the 'perf(1)' tool.
+
+		These events may not be supported by other CPUs.
+
+		The contents of each file would look like:
+
+			event=0xNNNN
+
+		where 'N' is a hex digit and the number '0xNNNN' shows the
+		"raw code" for the perf event identified by the file's
+		"basename".
-- 
1.7.1
