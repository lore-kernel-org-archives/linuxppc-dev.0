Return-Path: <michael@ellerman.id.au>
Date: Wed, 27 Feb 2013 12:27:37 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/6][v4]: perf: Create a sysfs entry for Power event format
Message-ID: <20130227012736.GD5819@concordia>
References: <20130123062201.GA13720@us.ibm.com>
 <20130123062613.GF13720@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130123062613.GF13720@us.ibm.com>
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

On Tue, Jan 22, 2013 at 10:26:13PM -0800, Sukadev Bhattiprolu wrote:
> 
> [PATCH 5/6][v4]: perf: Create a sysfs entry for Power event format
> 
> Create a sysfs entry, '/sys/bus/event_source/devices/cpu/format/event'
> which describes the format of a POWER cpu.

> diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
> index fa476d5..4ae044b 100644
> --- a/arch/powerpc/perf/core-book3s.c
> +++ b/arch/powerpc/perf/core-book3s.c
> @@ -1315,6 +1315,18 @@ ssize_t power_events_sysfs_show(struct device *dev,
>  	return sprintf(page, "event=0x%02llx\n", pmu_attr->id);
>  }
>  
> +PMU_FORMAT_ATTR(event, "config:0-20");

Just noticed, it's 20 bits, which is 0-19.

cheers
