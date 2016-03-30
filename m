Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZSg44fxhzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 11:09:04 +1100 (AEDT)
Message-ID: <1459296544.25307.2.camel@ellerman.id.au>
Subject: Re: [PATCH] Remove kretprobe_trampoline_holder.
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Date: Wed, 30 Mar 2016 11:09:04 +1100
In-Reply-To: <1625864.aO4Q1DYN9d@hactar>
References: <3qWbvb0yVwz9sdm@ozlabs.org> <2042788.6sAC9lOLzB@hactar>
 <1459208757.8173.3.camel@ellerman.id.au> <1625864.aO4Q1DYN9d@hactar>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-03-29 at 15:34 -0300, Thiago Jung Bauermann wrote:
> Am Dienstag, 29 März 2016, 10:45:57 schrieb Michael Ellerman:
> > On Mon, 2016-03-28 at 17:29 -0300, Thiago Jung Bauermann wrote:
> > > If I do s/_do_fork/._do_fork/ in kprobe_ftrace.tc then all ftrace kprobe
> > > tests pass:
> > 
> > OK. We fixed that in 'perf probe', but not if you're using the sysfs file
> > directly.
> > 
> > Do you want to write a patch for ftracetest to try and handle it? I guess
> > you'd try "_do_fork" and if that fails then try "._do_fork", and maybe
> > only if uname -m says you're running on ppc64?
> 
> I did write a patch yesterday (included below for reference), but then I
> noticed that the other ftrace tests use _do_fork and they work fine (I guess
> because of the fix you mentioned). I think that ideally the ftrace filter
> mechanism should work with dot symbols as well as regular symbols.
> 
> I think this could work by creating a mechanism analogous to the
> ARCH_HAS_SYSCALL_MATCH_SYM_NAME one in trace_syscalls.c. Ftrace_match_record
> could call it to adjust the symbol name (like kprobe_lookup_name) before
> calling ftrace_match.
> 
> But I’m wondering if it’s really worth the effort and maybe patching the
> testcase is enough? Also, I don’t know whether my idea would have any
> side effects.

It'd be nice if it worked properly. Reusing kprobe_lookup_name() looks like it
would be the right fix, given this is "kprobe events".

cheers
