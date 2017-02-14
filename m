Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vN0kp2s73zDqpl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 22:37:06 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
 xinhui.pan@linux.vnet.ibm.com, gpiccoli@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/xmon: add debugfs entry for xmon
In-Reply-To: <1487019642-11411-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1487019642-11411-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Date: Tue, 14 Feb 2017 22:37:04 +1100
Message-ID: <87vasdknq7.fsf@concordia.ellerman.id.au>
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

"Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:

> Currently the xmon debugger is set only via kernel boot command-line.
> It's disabled by default, and can be enabled with "xmon=on" on the
> command-line. Also, xmon may be accessed via sysrq mechanism, but once
> we enter xmon via sysrq,  it's  kept enabled until system is rebooted,
> even if we exit the debugger. A kernel crash will then lead to xmon
> instance, instead of triggering a kdump procedure (if configured), for
> example.
>
> This patch introduces a debugfs entry for xmon, allowing user to query
> its current state and change it if desired. Basically, the "xmon" file
> to read from/write to is under the debugfs mount point, on powerpc
> directory. Reading this file will provide the current state of the
> debugger, one of the following: "on", "off", "early" or "nobt". Writing
> one of these states to the file will take immediate effect on the debugger.

I like this in general.

But I think we can simplify it a bit.

I don't think we need the nobt state anymore. As far as I can see it was
added as a way to reinstate the old behaviour when the auto backtrace
mode was added, but I've never heard of anyone using it.

If anyone hits a crash where they really need that feature they can
always just hack the code to disable the backtrace.

So I think step 1 is a patch to drop the xmon_no_auto_backtrace stuff.

Also I'm not sure EARLY needs to be a separate state. It's just a
one-off invocation at boot, all we really need is just a single bit of
state communicated from early_parse_xmon() to xmon_setup(), ie. a static
bool would do.

If we agree with that, then there's only two states left, on and off, in
which case it can probably just be an int - and we can use a simple
attribute file rather than custom parsing.

> * I had this patch partially done for some time, and after a discussion
> at the kernel slack channel latest week, I decided to rebase and fix
> some remaining bugs. I'd change 'x' option to always disable the debugger,

Not quite.

'x' should exit and leave xmon in whatever state it was previously in.

cheers
