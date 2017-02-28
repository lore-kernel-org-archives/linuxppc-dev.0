Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXPvR1cmNzDqGG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 14:58:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Steven Rostedt <rostedt@goodmis.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 2/2] powerpc: ftrace_64: split further based on
 -mprofile-kernel
In-Reply-To: <20170227104014.7b7dee0e@gandalf.local.home>
References: <cover.1487702678.git.naveen.n.rao@linux.vnet.ibm.com>
 <378311b965ca33fe69b159f7609ff2eedfe3bc2f.1487702678.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170227104014.7b7dee0e@gandalf.local.home>
Date: Tue, 28 Feb 2017 14:58:42 +1100
Message-ID: <87zih7otjh.fsf@concordia.ellerman.id.au>
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

> On Wed, 22 Feb 2017 00:31:02 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>
>> Split ftrace_64.S further retaining the core ftrace 64-bit aspects
>> in ftrace_64.S and moving ftrace_caller() and ftrace_graph_caller() into
>> separate files based on -mprofile-kernel. The livepatch routines are all
>> now contained within the mprofile file.
>
> Why?

Because we have two ABIs that are basically entirely different.

Splitting them into separate files makes it easier to work on one or the
other without getting muddled.

It also makes it clearer that the livepatch code only relates to the
mprofile ABI for example.

> I would think that it may be possible to share code if they stay
> in the same file.

We can share code even if they're in separate files. But I don't think
there's much that can be shared TBH.

> I haven't had the chance to look deeply into the
> current code, but there may be ways to make macros and consolidate
> duplicate code like we did in x86.

I'd obviously be happy to remove duplicate code, but as I said above
there's not much that is obviously shared.

There's a few shared lines such as:

  .globl ftrace_graph_call
  ftrace_graph_call:
  	b	ftrace_graph_stub


Which could go in a macro I guess, but it's almost not worth the
trouble.

cheers
