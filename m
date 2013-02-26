Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7A3D02C007E
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Feb 2013 07:06:34 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 26 Feb 2013 15:06:30 -0500
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id B9DC96E8061
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2013 15:06:24 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1QK6KhH65077264
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2013 15:06:20 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1QK6BFO007113
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2013 17:06:19 -0300
Date: Tue, 26 Feb 2013 12:03:43 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 5/6][v4]: perf: Create a sysfs entry for Power event format
Message-ID: <20130226200343.GA21543@us.ibm.com>
References: <20130123062201.GA13720@us.ibm.com>
 <20130123062613.GF13720@us.ibm.com>
 <20130226052646.GB21553@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130226052646.GB21553@concordia>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 robert.richter@amd.com, Anton Blanchard <anton@au1.ibm.com>,
 linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
 linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
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

Michael Ellerman [michael@ellerman.id.au] wrote:
| On Tue, Jan 22, 2013 at 10:26:13PM -0800, Sukadev Bhattiprolu wrote:
| > 
| > [PATCH 5/6][v4]: perf: Create a sysfs entry for Power event format
| > 
| > Create a sysfs entry, '/sys/bus/event_source/devices/cpu/format/event'
| > which describes the format of a POWER cpu.
| 
| Did this patch go upstream? I don't see it.

Hmm, patches 1..4,6 are in linux-tip and Arnaldo's trees but patch 5 is
in neither.

| 
| If not, please don't merge it.
| 
| > The format of the event is the same for all POWER cpus at least in
| > (Power6, Power7), so bulk of this change is common in the code common
| > to POWER cpus.
| 
| No. The event format is different on most POWER cpus, in particular it
| is different on Power6 and Power7, and will be different again on
| Power8.

Sigh.  The port of this patchset to Power6 has not started yet.

But this patchset does work on Power7 correct ?

If so, and we figure out what happened to patch 5, can we add a patch to
to move the format code to power7-pmu.c ?

Sukadev
