Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXQ1q5sFSzDqGG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 15:04:15 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Steven Rostedt <rostedt@goodmis.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 1/2] powerpc: split ftrace bits into a separate file
In-Reply-To: <20170227103650.0955c5eb@gandalf.local.home>
References: <cover.1487702678.git.naveen.n.rao@linux.vnet.ibm.com>
 <d2058affbf317d0f72e2df970f97b7b53ade47cb.1487702678.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170227103650.0955c5eb@gandalf.local.home>
Date: Tue, 28 Feb 2017 15:04:15 +1100
Message-ID: <87wpcbota8.fsf@concordia.ellerman.id.au>
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

Steven Rostedt <rostedt@goodmis.org> writes:

> On Wed, 22 Feb 2017 00:31:01 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>
>> entry_*.S now includes a lot more than just kernel entry/exit code. As a
>> first step at cleaning this up, let's split out the ftrace bits into
>> separate files. Also move all related tracing code into a new trace/
>> subdirectory.
>> 
>> No functional changes.
>
> I wonder if we should stay consistent among archs, and call these files
> "mcount_*.S". Or perhaps we should change x86 from mcount_64.S to
> ftrace_64.S?

I prefer ftrace_64.S, there's a lot more in those files than just the
mcount() implementation, and it also makes the link to
kernel/trace/ftrace.c more obvious.

I don't know if it's really worth keeping the names the same across
arches, especially as we already have:

  arch/arm64/kernel/entry-ftrace.S
  arch/arm/kernel/entry-ftrace.S
  arch/blackfin/kernel/ftrace-entry.S
  arch/metag/kernel/ftrace_stub.S

But we can rename it if you feel strongly about it.

cheers
