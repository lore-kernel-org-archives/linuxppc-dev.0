Return-Path: <pj@sgi.com>
Received: from omx2.sgi.com (omx2-ext.sgi.com [192.48.171.19])
	by ozlabs.org (Postfix) with ESMTP id F1DBE67A77
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Apr 2006 10:25:42 +1000 (EST)
Date: Mon, 3 Apr 2006 17:25:33 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: Fw: 2.6.16 crashes when running numastat on p575
Message-Id: <20060403172533.f03f1ba2.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0604031104110.20903@schroedinger.engr.sgi.com>
References: <20060402213216.2e61b74e.akpm@osdl.org>
	<Pine.LNX.4.64.0604022149450.15895@schroedinger.engr.sgi.com>
	<20060402221513.96f05bdc.pj@sgi.com>
	<Pine.LNX.4.64.0604022224001.18401@schroedinger.engr.sgi.com>
	<20060403141027.GB25663@localdomain>
	<Pine.LNX.4.64.0604031039560.20648@schroedinger.engr.sgi.com>
	<20060403180131.GD25663@localdomain>
	<Pine.LNX.4.64.0604031104110.20903@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, ak@suse.com, ntl@pobox.com,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph wrote:
> There may be some complicated interactions with cpusets.

Hopefully not, but it's possible.  I did my best not to assume that
cpus or memory nodes stayed online, and to build in fallbacks if one
of them disappeared out from under me.

But the code has never been tested to these assumptions, nor even
carefully reviewed to them.

So something will likely break somewhere, though quite possibly not
in the cpuset code itself, but in the scheduler or allocator code
that depends on selecting an online cpu or memory for some purpose.

Someone from the hotplug side will have to look at this, with an
understanding of how the coming and going of cpus and memory nodes
can affect the scheduler and allocators.

Look at the callers of cpuset_cpus_allowed(), cpuset_mems_allowed(),
cpuset_update_task_memory_state(), and cpuset_zone_allowed() to see
the likely hot spots for interaction between cpusets and hotplug.

The callers of these routines are important hooks into the scheduler
and allocator, and the question needs to be asked what happens if
a cpu or memory node goes offline after one of these cpuset_*()
routines is called before the scheduler or allocator finishes doing
what it is doing with what it thought was a usable cpu or node.

Also, there is currently no hotplug aware code that I know of in
the kernel/cpuset.c code, so each of the references to the globals
cpu_online_map and node_online_map therein are suspect.  Presumably as
anywhere else in the kernel these appear, or the for_each_online_*()
macros appear, the code needs to be examined for perhaps needing some
sort of guard.

So, in sum, the kernel needs to be inspected at the location of at
least each of the following calls or references, for possible problems
if the cpus or nodes online change unexpectedly:

 any_online_node()
 cpu_online_map
 cpu_present()
 cpu_present_map
 cpuset_cpus_allowed()
 cpuset_mems_allowed()
 cpuset_update_task_memory_state()
 cpuset_zone_allowed()
 for_each_online_cpu()
 for_each_online_node()
 for_each_present_cpu()
 node_online_map
 num_online_cpus()
 num_online_nodes()
 num_present_cpus()

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
