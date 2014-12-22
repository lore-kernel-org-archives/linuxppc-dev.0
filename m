Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C82B41A0D60
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 01:40:20 +1100 (AEDT)
Date: Mon, 22 Dec 2014 15:39:43 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 3/4] perf Documentation: add event parameters
Message-ID: <20141222143943.GB29096@krava.brq.redhat.com>
References: <1419234567-22784-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1419234567-22784-4-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419234567-22784-4-git-send-email-sukadev@linux.vnet.ibm.com>
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

On Sun, Dec 21, 2014 at 11:49:26PM -0800, Sukadev Bhattiprolu wrote:
> From: Cody P Schafer <cody@linux.vnet.ibm.com>
> 
> Event parameters are a basic way for partial events to be specified in
> sysfs with per-event names given to the fields that need to be filled in
> when using a particular event.
> 
> It is intended for supporting cases where the single 'cpu' parameter is
> insufficient. For example, POWER 8 has events for physical
> sockets/cores/cpus that are accessible from with virtual machines. To
> keep using the single 'cpu' parameter we'd need to perform a mapping
> between Linux's cpus and the physical machine's cpus (in this case
> Linux is running under a hypervisor). This isn't possible because
> bindings between our cpus and physical cpus may not be fixed, and we
> probably won't have a "cpu" on each physical cpu.
> 
> Changelog[v6]
> 	Update event description to explain how required parameters
> 	are displayed.
> 
> CC: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> CC: Haren Myneni <hbabu@us.ibm.com>
> CC: Cody P Schafer <dev@codyps.com>
> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-event_source-devices-events | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> index 20979f8..47ad2a1 100644
> --- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> @@ -52,12 +52,18 @@ Description:	Per-pmu performance monitoring events specific to the running syste
>  			event=0x2abc
>  			event=0x423,inv,cmask=0x3
>  			domain=0x1,offset=0x8,starting_index=0xffff
> +			domain=0x1,offset=0x8,core=?
>  
>  		Each of the assignments indicates a value to be assigned to a
>  		particular set of bits (as defined by the format file
>  		corresponding to the <term>) in the perf_event structure passed
>  		to the perf_open syscall.
>  
> +		In the case of the last example, a value replacing "?" would
> +		need to be provided by the user selecting the particular event.
> +		This is referred to as "event parameterization". All
> +		non-numerical values indicate an event parameter.

I see.. here's the glitch ;-) I thought we agreed on forcing '?'
as the value for param events, not 'All non-numerical values'

thanks,
jirka
