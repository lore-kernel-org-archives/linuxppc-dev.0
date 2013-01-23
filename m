Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E83222C0089
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2013 17:22:12 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 22 Jan 2013 23:22:08 -0700
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id D265D1FF0043
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2013 23:21:52 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0N6M4dJ142936
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2013 23:22:04 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0N6M3Cs022930
 for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2013 23:22:04 -0700
Date: Tue, 22 Jan 2013 22:22:02 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>,
 Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 0/6][v4]: perf: Make POWER7 events available in sysfs
Message-ID: <20130123062201.GA13720@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andi Kleen <ak@linux.intel.com>, robert.richter@amd.com,
 Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Jiri Olsa <jolsa@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[PATCH 0/6][v4]: perf: Make POWER7 events available in sysfs

Make the generic and some POWER7-specific perf events available in sysfs.
These changes mainly extend similar functionality implemented in x86 to
work on POWER architecture as well.

Thanks to input from Stephane Eranian, Robert Richter, Peter Ziljstra
and Jiri Olsa.

Changelog[v4]:
	[Jiri Olsa]: Document that multiple event= like terms can be specified
	in the 'events' file.
	[Jiri Olsa]: Remove the documentation for the 'config format' file
	as it is already documented in 'Documentation/ABI/testing/'
	[Jiri Olsa]: Move the ABI documentaion from 'stable/' to 'testing/'.

Changelog[v3]:
	[Jiri Olsa]: No need to define EVENT_ID, PMU_EVENT_PTR() if used only
	once
	[Greg KH]: Document the new sysfs interfaces in Documenation/ABI

Changelog[v2]:
	[Jiri Olsa] Use PMU_FORMAT_ATTR() rather than duplicating code.

Sukadev Bhattiprolu (6):
  perf/Power7: Use macros to identify perf events
  perf: Make EVENT_ATTR global
  perf/POWER7: Make generic event translations available in sysfs
  perf/POWER7: Make some POWER7 events available in sysfs
  perf: Create a sysfs entry for Power event format
  perf: Document the ABI of perf sysfs entries

 .../testing/sysfs-bus-event_source-devices-events  |   62 +++++++++++++++
 arch/powerpc/include/asm/perf_event_server.h       |   32 ++++++++
 arch/powerpc/perf/core-book3s.c                    |   24 ++++++
 arch/powerpc/perf/power7-pmu.c                     |   81 ++++++++++++++++++--
 arch/x86/kernel/cpu/perf_event.c                   |   13 +---
 include/linux/perf_event.h                         |   11 +++
 6 files changed, 205 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-events
