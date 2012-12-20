Return-Path: <greg@kroah.com>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 60EA72C008E
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2012 16:40:16 +1100 (EST)
Date: Wed, 19 Dec 2012 21:36:00 -0800
From: Greg KH <greg@kroah.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/5] perf/POWER7: Make generic event translations
 available in sysfs
Message-ID: <20121220053600.GC28007@kroah.com>
References: <20121219072646.GA30580@us.ibm.com>
 <20121219072848.GB30790@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121219072848.GB30790@us.ibm.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, robert.richter@amd.com,
 Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
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

On Tue, Dec 18, 2012 at 11:28:49PM -0800, Sukadev Bhattiprolu wrote:
> 
> [PATCH 3/5] perf/POWER7: Make generic event translations available in sysfs
> 
> Make the generic perf events in POWER7 available via sysfs.
> 
> 	$ ls /sys/bus/event_source/devices/cpu/events
> 	branch-instructions
> 	branch-misses
> 	cache-misses
> 	cache-references
> 	cpu-cycles
> 	instructions
> 	stalled-cycles-backend
> 	stalled-cycles-frontend
> 
> 	$ cat /sys/bus/event_source/devices/cpu/events/cache-misses
> 	event=0x400f0
> 
> This patch is based on commits that implement this functionality on x86.
> Eg:
> 	commit a47473939db20e3961b200eb00acf5fcf084d755
> 	Author: Jiri Olsa <jolsa@redhat.com>
> 	Date:   Wed Oct 10 14:53:11 2012 +0200
> 
> 	    perf/x86: Make hardware event translations available in sysfs
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/perf_event_server.h |   25 +++++++++++++++++++
>  arch/powerpc/perf/core-book3s.c              |   12 +++++++++
>  arch/powerpc/perf/power7-pmu.c               |   34 ++++++++++++++++++++++++++
>  3 files changed, 71 insertions(+), 0 deletions(-)

As you are adding new sysfs files, you must also add new
Documentation/ABI entries at the same time.  Please also do this for the
other patches in this series that add new sysfs files.

thanks,

greg k-h
