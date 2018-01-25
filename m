Return-Path: <tyreld@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zSJm60msxzF0Q6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jan 2018 10:54:13 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0PNsAsw037760
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 18:54:11 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2fqr5wa7un-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 18:54:10 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tyreld@linux.vnet.ibm.com>;
 Thu, 25 Jan 2018 16:54:05 -0700
Subject: Re: [RFC PATCH v2 0/1] of: easier debugging for node life cycle issues
To: Frank Rowand <frowand.list@gmail.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>,
 linux-renesas-soc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linuxppc-dev@lists.ozlabs.org
References: <20180121143117.19805-1-wsa+renesas@sang-engineering.com>
 <00fc90ee-de26-f819-9c81-27d06918564d@gmail.com>
 <20180125060330.781667e9@vmware.local.home>
 <a30d4cd3-0068-8cca-cc2f-ca207d0d278b@gmail.com>
From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date: Thu, 25 Jan 2018 15:53:58 -0800
MIME-Version: 1.0
In-Reply-To: <a30d4cd3-0068-8cca-cc2f-ca207d0d278b@gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <c20ffeb2-f17a-ddab-7327-b8854b301d18@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/25/2018 01:49 PM, Frank Rowand wrote:
> Hi Wolfram,
> 
> On 01/25/18 03:03, Steven Rostedt wrote:
>> On Wed, 24 Jan 2018 22:55:13 -0800
>> Frank Rowand <frowand.list@gmail.com> wrote:
>>
>>> Hi Steve,
>>
>>>
>>> Off the top of your head, can you tell me know early in the boot
>>> process a trace_event can be called and successfully provide the
>>> data to someone trying to debug early boot issues?
>>
>> The trace events are enabled by early_initcall().
> 
> < snip >
> 
> This means that ftrace can not be used for the of_node_get(),
> of_node_put(), and of_node_release() debug info, because
> these functions are called before early_initcall().  Please
> use pr_debug() for these functions.

I would argue that early boot debugging doesn't completely negate the usefulness of this tracing infrastructure. I get that no information is available in the trace up until ftrace is setup by its early_initcall, but I still found issues  after early boot using this patch and I would hope that it would be somewhat obvious if references are out of whack once the ftrace data becomes available. In the dynamic case on Power we often do reconfig well after boot on live systems which produces a lot of reference put/gets. This patch made it easy to identify several reference leaks and underflows in our attach and detach logic with the added aid of being able to turn on the stacktrace for each call in the ftrace data.

Another thought is it would be nice if we could have the best of both worlds such that the tracepoints were pr_debugs up until the ftrace early_initcall. Or, I suppose we could ifdef it and make the ftrace tracepoints a configuration option, such that if it wasn't configured we implement the tracepoint functions as pr_debugs. This makes early boot an option. Just spit balling ideas.

-Tyrel

> 
> As far as I know, the of_reconfig_notify() could remain an
> ftrace instrumented function.  But now that the only thing
> that would be ftrace instrumented is of_reconfig_notify(),
> I don't see a strong justification for changing the existing
> pr_debug() calls to an ftrace alternative.  Though I suspect
> the original author of the patch still might desire to have
> the "#ifdef DEBUG" surrounding the pr_debug() calls removed
> since one of his issues was having to recompile his kernel
> to do his debugging.
> 
> -Frank
> 
