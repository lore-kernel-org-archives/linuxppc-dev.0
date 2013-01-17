Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 88E052C007C
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2013 01:12:09 +1100 (EST)
Date: Thu, 17 Jan 2013 15:11:45 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/6][v3] perf: Document the ABI of perf sysfs entries
Message-ID: <20130117141145.GA3817@krava.brq.redhat.com>
References: <20130110010347.GA32590@us.ibm.com>
 <20130110010703.GF32590@us.ibm.com>
 <20130115185759.GG5826@ghostprotocols.net>
 <20130116113013.GA1042@krava.brq.redhat.com>
 <20130116185815.GA3351@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130116185815.GA3351@us.ibm.com>
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

On Wed, Jan 16, 2013 at 10:58:16AM -0800, Sukadev Bhattiprolu wrote:
> Jiri Olsa [jolsa@redhat.com] wrote:
> | On Tue, Jan 15, 2013 at 03:57:59PM -0300, Arnaldo Carvalho de Melo wrote:
> | > Em Wed, Jan 09, 2013 at 05:07:03PM -0800, Sukadev Bhattiprolu escreveu:
> | > > [PATCH 6/6][v3] perf: Document the ABI of perf sysfs entries
> | > > 
> | > > This patchset addes two new sets of files to sysfs:
> | > > 
> | > > 	- generic and POWER-specific perf events in /sys/devices/cpu/events/
> | > > 	- perf event config format in /sys/devices/cpu/format/event
> | > > 
> | > > Document the format of these files which would become part of the ABI.
> | > > 
> | > > Changelog[v3]:
> | > > 	[Greg KH] Include ABI documentation.
> | > 
> | > Jiri, can I have your ack on this one too?
> | 
> | hm, we already already 'format' definition but in testing section
> | (and we are missing 'events' definition there.. my bad)
> 
> I see that file now ! I have removed that documentation from my patch.
> | 
> | anyway, after reading Documentation/ABI/README looks like we
> | should go for 'testing' section with this as well.. stable
> | seems scary at this point ;-)
> 
> Agree.
> 
> Here is the updated patch.
> ---
> 
> This patchset addes two new sets of files to sysfs for POWER architecture.
> 
> 	- perf event config format in /sys/devices/cpu/format/event
> 	- generic and POWER-specific perf events in /sys/devices/cpu/events/
> 
> The format of the first file is already documented in:
> 
> 	Documentation/ABI/testing/sysfs-bus-event_source-devices-format
> 
> Document the format of the second set of files '/sys/devices/cpu/events/*'
> which would also become part of the ABI.
> 
> Changelog[v3.1]:
> 	(small changes to this one patch).
> 	[Jiri Olsa]: Remove the documentation for the 'config format' file
> 	as it is already documented.
> 	[Jiri Olsa]: Move the documentation of 'events' also to 'testing/'
> 
> Changelog[v3]:
> 	[Greg KH] Include ABI documentation.
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
>  .../testing/sysfs-bus-event_source-devices-events  |   58 ++++++++++++++++++++
>  1 files changed, 58 insertions(+), 0 deletions(-)
>  delete mode 100644 Documentation/ABI/stable/sysfs-devices-cpu-events
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> 
> diff --git a/Documentation/ABI/stable/sysfs-devices-cpu-events b/Documentation/ABI/stable/sysfs-devices-cpu-events
> deleted file mode 100644
> index e69de29..0000000
> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> new file mode 100644
> index 0000000..2c4081e
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> @@ -0,0 +1,58 @@
> +What:		/sys/devices/cpu/events/
> +		/sys/devices/cpu/events/branch-misses
> +		/sys/devices/cpu/events/cache-references
> +		/sys/devices/cpu/events/cache-misses
> +		/sys/devices/cpu/events/stalled-cycles-frontend
> +		/sys/devices/cpu/events/branch-instructions
> +		/sys/devices/cpu/events/stalled-cycles-backend
> +		/sys/devices/cpu/events/instructions
> +		/sys/devices/cpu/events/cpu-cycles
> +
> +Date:		2012/01/NN
> +
> +Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> +
> +Description:	Generic performance monitoring events
> +
> +		A collection of performance monitoring events that may be
> +		supported by many/most CPUs. These events can be monitored
> +		using the 'perf(1)' tool.
> +
> +		The contents of each file would look like:
> +
> +			event=0xNNNN
> +
> +		where 'N' is a hex digit and the number '0xNNNN' shows the
> +		"raw code" for the perf event identified by the file's
> +		"basename".

Maybe it'd worth to mention, that it does not need to be just 'event',
but anything from /sys/bus/event_source/devices/<dev>/format directory,
like

		The can be multiple terms like 'event=0xNNNN' specified
		and separated with comma. All available terms are located
		in /sys/bus/event_source/devices/<dev>/format file.

Please feel free to rephrase or use proper English ;-)

otherwise it's ok,
jirka
