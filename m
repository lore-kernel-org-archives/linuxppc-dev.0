Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id A7261DDF17
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 16:23:05 +1000 (EST)
Date: Fri, 22 Jun 2007 16:23:05 +1000
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: [RFC] clocksouce implementation for powerpc
Message-ID: <20070622062305.GX9768@bakeyournoodle.com>
References: <20070616101126.296384219@inhelltoy.tec.linutronix.de>
	<20070616101637.107940593@inhelltoy.tec.linutronix.de>
	<1182009083.11539.369.camel@imap.mvista.com>
	<20070620065710.GR9768@bakeyournoodle.com>
	<1182351439.18168.79.camel@imap.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1182351439.18168.79.camel@imap.mvista.com>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: Andrew Morton <akpm@osdl.org>, john stultz <johnstul@us.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	LinuxPPC-dev <linuxppc-dev@ozlabs.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 20, 2007 at 07:57:19AM -0700, Daniel Walker wrote:

Hi Daniel.

> As I said in our private thread, I do think you should be using
> update_vsyscall() .. update_vsyscall() is just called when the time is
> set, usually that happens in the timer interrupt and sometimes that
> happens in settimeofday() ..

Well I've taken another look at the code and I think I can probably
restructure my code to use update_vsyscall().  I thought I needed a
hook that was called /only/ from settimeofday() (which as you say
doesn't match update_vsyscall()'s usage).

I'll try again and see what problems I hit.
 
> At least some of your code is duplications over what is already being
> worked on inside the powerpc community.. For instance, I know there is
> already a timebase clocksource,
> 
> http://people.redhat.com/~mingo/realtime-preempt/patch-2.6.21.5-rt17

Thanks. The one in -rt doesn't seem to support the VDSO.  however I see
that there is duplication of effort there.
 
> Hmm .. This doesn't look like it's taking into account that the time has
> changed .. Your time has effectively incremented by one jiffie .. The
> vdso_data doesn't appear to be updated ..

Unless I miss your meaning, the vdso is updated in
timer_recalc_offset()/update_gtod() when needed.

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
