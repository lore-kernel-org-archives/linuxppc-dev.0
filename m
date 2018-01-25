Return-Path: <frowand.list@gmail.com>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zRt8Q3ZlszDqF9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 17:55:18 +1100 (AEDT)
Received: by mail-it0-x243.google.com with SMTP id e1so8184986ita.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 22:55:17 -0800 (PST)
Subject: Re: [RFC PATCH v2 0/1] of: easier debugging for node life cycle issues
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 devicetree@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-renesas-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
References: <20180121143117.19805-1-wsa+renesas@sang-engineering.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <00fc90ee-de26-f819-9c81-27d06918564d@gmail.com>
Date: Wed, 24 Jan 2018 22:55:13 -0800
MIME-Version: 1.0
In-Reply-To: <20180121143117.19805-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Steve,

On 01/21/18 06:31, Wolfram Sang wrote:
> I got a bug report for a DT node refcounting problem in the I2C subsystem. This
> patch was a huge help in validating the bug report and the proposed solution.
> So, I thought I bring it to attention again. Thanks Tyrel, for the initial
> work!
> 
> Note that I did not test the dynamic updates, only of_node_{get|put} so far. I
> read that Tyrel checked dynamic updates extensively with this patch. And since
> DT overlays are also used within our Renesas dev team, this will help there, as
> well.
> 
> Tested on a Renesas Salvator-XS board (R-Car H3).
> 
> Changes since RFC v1:
> 	* rebased to v4.15-rc8
> 	* fixed commit abbrev and one of the sysfs paths in commit desc
> 	* removed trailing space and fixed pointer declaration in code
> 
> I consider all the remaining checkpatch issues irrelevant for this patch.
> 
> So what about applying it?
> 
> Kind regards,
> 
>    Wolfram
> 
> 
> Tyrel Datwyler (1):
>   of: introduce event tracepoints for dynamic device_node lifecyle
> 
>  drivers/of/dynamic.c      | 32 ++++++----------
>  include/trace/events/of.h | 93 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 105 insertions(+), 20 deletions(-)
>  create mode 100644 include/trace/events/of.h
> 

Off the top of your head, can you tell me know early in the boot
process a trace_event can be called and successfully provide the
data to someone trying to debug early boot issues?

Also, way back when version 1 of this patch was being discussed,
a question about stacktrace triggers:

     >>> # echo stacktrace > /sys/kernel/debug/tracing/trace_options
     >>> # cat trace | grep -A6 "/pci@800000020000018"  
     >>
     >> Just to let you know that there is now stacktrace event triggers, where
     >> you don't need to stacktrace all events, you can pick and choose. And
     >> even filter the stack trace on specific fields of the event.  
     >
     > This is great, and I did figure that out this afternoon. One thing I was
     > still trying to determine though was whether its possible to set these
     > triggers at boot? As far as I could tell I'm still limited to
     > "trace_options=stacktrace" as a kernel boot parameter to get the stack
     > for event tracepoints.

     No not yet. But I'll add that to the todo list.

     Thanks,

     -- Steve

Is this still on your todo list, or is it now available?

Thanks,

Frank
