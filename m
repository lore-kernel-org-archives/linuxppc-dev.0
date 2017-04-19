Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w74GT547VzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 11:31:29 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frank Rowand <frowand.list@gmail.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, robh+dt@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, nfont@linux.vnet.ibm.com, rostedt@goodmis.org,
 mingo@redhat.com
Subject: Re: [PATCH] of: introduce event tracepoints for dynamic device_node
 lifecyle
In-Reply-To: <58F6AA35.2040902@gmail.com>
References: <1492475525-10827-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <58F6AA35.2040902@gmail.com>
Date: Wed, 19 Apr 2017 11:31:29 +1000
Message-ID: <87efwp6v4e.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frank Rowand <frowand.list@gmail.com> writes:

> On 04/17/17 17:32, Tyrel Datwyler wrote:
>> This patch introduces event tracepoints for tracking a device_nodes
>> reference cycle as well as reconfig notifications generated in response
>> to node/property manipulations.
>> 
>> With the recent upstreaming of the refcount API several device_node
>> underflows and leaks have come to my attention in the pseries (DLPAR) dynamic
>> logical partitioning code (ie. POWER speak for hotplugging virtual and physcial
>> resources at runtime such as cpus or IOAs). These tracepoints provide a
>> easy and quick mechanism for validating the reference counting of
>> device_nodes during their lifetime.
>> 
>> Further, when pseries lpars are migrated to a different machine we
>> perform a live update of our device tree to bring it into alignment with the
>> configuration of the new machine. The of_reconfig_notify trace point
>> provides a mechanism that can be turned for debuging the device tree
>> modifications with out having to build a custom kernel to get at the
>> DEBUG code introduced by commit 00aa3720.
>
> I do not like changing individual (or small groups of) printk() style
> debugging information to tracepoint style.

I'm not quite sure which printks() you're referring to.

The only printks that are removed in this series are under #ifdef DEBUG,
and so are essentially not there unless you build a custom kernel.

They also only cover the reconfig case, which is actually less
interesting than the much more common and bug-prone get/put logic.

> As far as I know, there is no easy way to combine trace data and printk()
> style data to create a single chronology of events.  If some of the
> information needed to debug an issue is trace data and some is printk()
> style data then it becomes more difficult to understand the overall
> situation.

If you enable CONFIG_PRINTK_TIME then you should be able to just sort
the trace and the printk output by the timestamp. If you're really
trying to correlate the two then you should probably just be using
trace_printk().

But IMO this level of detail, tracing every get/put, does not belong in
printk. Trace points are absolutely the right solution for this type of
debugging.

cheers
