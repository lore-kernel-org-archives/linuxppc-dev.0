Return-Path: <turtle.in.the.kernel@gmail.com>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com
 [IPv6:2607:f8b0:400d:c0d::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7nPX07FjzDqHv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 15:25:04 +1000 (AEST)
Received: by mail-qt0-x244.google.com with SMTP id y33so6137181qta.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 22:25:03 -0700 (PDT)
Subject: Re: [PATCH] of: introduce event tracepoints for dynamic device_node
 lifecyle
To: Steven Rostedt <rostedt@goodmis.org>
References: <1492475525-10827-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <58F6AA35.2040902@gmail.com> <87efwp6v4e.fsf@concordia.ellerman.id.au>
 <1d51a229-612b-bf09-93d5-6e43b476e2cf@gmail.com>
 <20170419223342.0bbe2593@grimm.local.home>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Frank Rowand <frowand.list@gmail.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, robh+dt@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, nfont@linux.vnet.ibm.com, mingo@redhat.com
From: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
Message-ID: <90e008a7-0660-99b9-edbe-6bf146268ba8@gmail.com>
Date: Wed, 19 Apr 2017 22:24:58 -0700
MIME-Version: 1.0
In-Reply-To: <20170419223342.0bbe2593@grimm.local.home>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/19/2017 07:33 PM, Steven Rostedt wrote:
> On Wed, 19 Apr 2017 16:27:10 -0700
> Tyrel Datwyler <turtle.in.the.kernel@gmail.com> wrote:
> 
>> # echo stacktrace > /sys/kernel/debug/tracing/trace_options
>> # cat trace | grep -A6 "/pci@800000020000018"
> 
> Just to let you know that there is now stacktrace event triggers, where
> you don't need to stacktrace all events, you can pick and choose. And
> even filter the stack trace on specific fields of the event.

This is great, and I did figure that out this afternoon. One thing I was
still trying to determine though was whether its possible to set these
triggers at boot? As far as I could tell I'm still limited to
"trace_options=stacktrace" as a kernel boot parameter to get the stack
for event tracepoints.

-Tyrel

> 
>  # cd /sys/kernel/debug/tracing
>  # echo "stacktrace if common_pid == $$ && reason == 3" \
>    > events/tlb/tlb_flush/trigger
> 
>  # cat trace
>             bash-1103  [003] ...1  1290.100133: tlb_flush: pages:-1 reason:local mm shootdown (3)
>             bash-1103  [003] ...2  1290.100140: <stack trace>
>  => copy_process.part.39
>  => _do_fork
>  => SyS_clone
>  => do_syscall_64
>  => return_from_SYSCALL_64
> 
> -- Steve
> 
