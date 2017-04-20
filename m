Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0103.hostedemail.com
 [216.40.44.103])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7jbx27ckzDqC6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 12:33:49 +1000 (AEST)
Date: Wed, 19 Apr 2017 22:33:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Frank Rowand
 <frowand.list@gmail.com>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 robh+dt@kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 nfont@linux.vnet.ibm.com, mingo@redhat.com
Subject: Re: [PATCH] of: introduce event tracepoints for dynamic device_node
 lifecyle
Message-ID: <20170419223342.0bbe2593@grimm.local.home>
In-Reply-To: <1d51a229-612b-bf09-93d5-6e43b476e2cf@gmail.com>
References: <1492475525-10827-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <58F6AA35.2040902@gmail.com>
 <87efwp6v4e.fsf@concordia.ellerman.id.au>
 <1d51a229-612b-bf09-93d5-6e43b476e2cf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 19 Apr 2017 16:27:10 -0700
Tyrel Datwyler <turtle.in.the.kernel@gmail.com> wrote:

> # echo stacktrace > /sys/kernel/debug/tracing/trace_options
> # cat trace | grep -A6 "/pci@800000020000018"

Just to let you know that there is now stacktrace event triggers, where
you don't need to stacktrace all events, you can pick and choose. And
even filter the stack trace on specific fields of the event.

 # cd /sys/kernel/debug/tracing
 # echo "stacktrace if common_pid == $$ && reason == 3" \
   > events/tlb/tlb_flush/trigger

 # cat trace
            bash-1103  [003] ...1  1290.100133: tlb_flush: pages:-1 reason:local mm shootdown (3)
            bash-1103  [003] ...2  1290.100140: <stack trace>
 => copy_process.part.39
 => _do_fork
 => SyS_clone
 => do_syscall_64
 => return_from_SYSCALL_64

-- Steve
