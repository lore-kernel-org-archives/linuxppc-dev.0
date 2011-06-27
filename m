Return-Path: <ananth@in.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3F9C1B6F6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jun 2011 20:01:22 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp02.au.ibm.com (8.14.4/8.13.1) with ESMTP id p5R9tDLQ003833
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2011 19:55:13 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5RA06uw778314
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2011 20:00:06 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p5RA1B1A013600
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2011 20:01:12 +1000
Date: Mon, 27 Jun 2011 15:31:05 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: [BUG?]3.0-rc4+ftrace+kprobe: set kprobe at instruction 'stwu'
	lead to system crash/freeze
Message-ID: <20110627100104.GA24705@in.ibm.com>
References: <BANLkTi=gx73d6-s-jqeke05SQYorpnzLVw@mail.gmail.com>
	<1308911347.531.56.camel@gandalf.stny.rr.com>
	<4E074671.7060100@hitachi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4E074671.7060100@hitachi.com>
Cc: Jim Keniston <jkenisto@linux.vnet.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Yong Zhang <yong.zhang0@gmail.com>, paulus@samba.org,
	yrl.pp-manager.tt@hitachi.com, linuxppc-dev@lists.ozlabs.org
Reply-To: ananth@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 26, 2011 at 11:47:13PM +0900, Masami Hiramatsu wrote:
> (2011/06/24 19:29), Steven Rostedt wrote:
> > On Fri, 2011-06-24 at 17:21 +0800, Yong Zhang wrote:
> >> Hi,
> >>
> >> When I use kprobe to do something, I found some wired thing.
> >>
> >> When CONFIG_FUNCTION_TRACER is disabled:
> >> (gdb) disassemble do_fork
> >> Dump of assembler code for function do_fork:
> >>    0xc0037390 <+0>:	mflr    r0
> >>    0xc0037394 <+4>:	stwu    r1,-64(r1)
> >>    0xc0037398 <+8>:	mfcr    r12
> >>    0xc003739c <+12>:	stmw    r27,44(r1)
> >>
> >> Then I:
> >> modprobe kprobe_example func=do_fork offset=4
> >> ls
> >> Things works well.
> >>
> >> But when CONFIG_FUNCTION_TRACER is enabled:
> >> (gdb) disassemble do_fork
> >> Dump of assembler code for function do_fork:
> >>    0xc0040334 <+0>:	mflr    r0
> >>    0xc0040338 <+4>:	stw     r0,4(r1)
> >>    0xc004033c <+8>:	bl      0xc00109d4 <mcount>
> >>    0xc0040340 <+12>:	stwu    r1,-80(r1)
> >>    0xc0040344 <+16>:	mflr    r0
> >>    0xc0040348 <+20>:	stw     r0,84(r1)
> >>    0xc004034c <+24>:	mfcr    r12
> >> Then I:
> >> modprobe kprobe_example func=do_fork offset=12
> >> ls
> >> 'ls' will never retrun. system freeze.
> > 
> > I'm not sure if x86 had a similar issue.
> > 
> > Masami, have any ideas to why this happened?
> 
> No, I don't familiar with ppc implementation. I guess
> that single-step resume code failed to emulate the
> instruction, but it strongly depends on ppc arch.
> Maybe IBM people may know what happened.
> 
> Ananth, Jim, would you have any ideas?

On powerpc, we emulate sstep whenever possible. Only recently support to
emulate loads and stores got added. I don't have access to a powerpc box
today... but will try to recreate the problem ASAP and see what could be
happening in the presence of mcount.

Ananth
