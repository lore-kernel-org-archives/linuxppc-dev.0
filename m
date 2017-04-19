Return-Path: <frowand.list@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w72Ps1bzCzDq8V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 10:07:45 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id 34so1337708pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 17:07:44 -0700 (PDT)
Subject: Re: [PATCH] of: introduce event tracepoints for dynamic device_node
 lifecyle
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, robh+dt@kernel.org
References: <1492475525-10827-1-git-send-email-tyreld@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, nfont@linux.vnet.ibm.com, mpe@ellerman.id.au,
 rostedt@goodmis.org, mingo@redhat.com
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <58F6AA35.2040902@gmail.com>
Date: Tue, 18 Apr 2017 17:07:17 -0700
MIME-Version: 1.0
In-Reply-To: <1492475525-10827-1-git-send-email-tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/17/17 17:32, Tyrel Datwyler wrote:
> This patch introduces event tracepoints for tracking a device_nodes
> reference cycle as well as reconfig notifications generated in response
> to node/property manipulations.
> 
> With the recent upstreaming of the refcount API several device_node
> underflows and leaks have come to my attention in the pseries (DLPAR) dynamic
> logical partitioning code (ie. POWER speak for hotplugging virtual and physcial
> resources at runtime such as cpus or IOAs). These tracepoints provide a
> easy and quick mechanism for validating the reference counting of
> device_nodes during their lifetime.
> 
> Further, when pseries lpars are migrated to a different machine we
> perform a live update of our device tree to bring it into alignment with the
> configuration of the new machine. The of_reconfig_notify trace point
> provides a mechanism that can be turned for debuging the device tree
> modifications with out having to build a custom kernel to get at the
> DEBUG code introduced by commit 00aa3720.

I do not like changing individual (or small groups of) printk() style
debugging information to tracepoint style.

As far as I know, there is no easy way to combine trace data and printk()
style data to create a single chronology of events.  If some of the
information needed to debug an issue is trace data and some is printk()
style data then it becomes more difficult to understand the overall
situation.

If Rob wants to convert printk() style data to trace data (and I can't
convince him otherwise) then I will have further comments on this specific
patch.

-Frank

> 
> The following trace events are provided: of_node_get, of_node_put,
> of_node_release, and of_reconfig_notify. These trace points require a kernel
> built with ftrace support to be enabled. In a typical environment where
> debugfs is mounted at /sys/kernel/debug the entire set of tracepoints
> can be set with the following:
> 
>   echo "of:*" > /sys/kernel/debug/tracing/set_event
> 
> or
> 
>   echo 1 > /sys/kernel/debug/tracing/of/enable
> 
> The following shows the trace point data from a DLPAR remove of a cpu
> from a pseries lpar:
> 
> cat /sys/kernel/debug/tracing/trace | grep "POWER8@10"
> 
> cpuhp/23-147   [023] ....   128.324827:
> 	of_node_put: refcount=5, dn->full_name=/cpus/PowerPC,POWER8@10
> cpuhp/23-147   [023] ....   128.324829:
> 	of_node_put: refcount=4, dn->full_name=/cpus/PowerPC,POWER8@10
> cpuhp/23-147   [023] ....   128.324829:
> 	of_node_put: refcount=3, dn->full_name=/cpus/PowerPC,POWER8@10
> cpuhp/23-147   [023] ....   128.324831:
> 	of_node_put: refcount=2, dn->full_name=/cpus/PowerPC,POWER8@10
>    drmgr-7284  [009] ....   128.439000:
> 	of_node_put: refcount=1, dn->full_name=/cpus/PowerPC,POWER8@10
>    drmgr-7284  [009] ....   128.439002:
> 	of_reconfig_notify: action=DETACH_NODE, dn->full_name=/cpus/PowerPC,POWER8@10,
> 			    prop->name=null, old_prop->name=null
>    drmgr-7284  [009] ....   128.439015:
> 	of_node_put: refcount=0, dn->full_name=/cpus/PowerPC,POWER8@10
>    drmgr-7284  [009] ....   128.439016:
> 	of_node_release: dn->full_name=/cpus/PowerPC,POWER8@10, dn->_flags=4
> 
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
> ---
>  drivers/of/dynamic.c      | 30 ++++++---------
>  include/trace/events/of.h | 93 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 105 insertions(+), 18 deletions(-)
>  create mode 100644 include/trace/events/of.h
> 

< snip >
