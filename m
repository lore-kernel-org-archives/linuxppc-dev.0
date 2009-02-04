Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A813DDDED6
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 11:34:16 +1100 (EST)
Subject: Re: [PATCH v2] ftrace: On PowerPC we don't need frame pointers for
	CALLER_ADDRs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090203185933.GA9878@oksana.dev.rtsoft.ru>
References: <20090131190650.GA4284@oksana.dev.rtsoft.ru>
	<1233534919.18767.69.camel@pasglop>
	<1233583455.16878.3.camel@localhost.localdomain>
	<20090203145649.GA19955@oksana.dev.rtsoft.ru>
	<20090203160645.GA9020@elte.hu>
	<20090203161955.GA776@oksana.dev.rtsoft.ru>
	<1233678738.16878.5.camel@localhost.localdomain>
	<20090203185933.GA9878@oksana.dev.rtsoft.ru>
Content-Type: text/plain
Date: Wed, 04 Feb 2009 11:34:03 +1100
Message-Id: <1233707643.16867.115.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2009-02-03 at 21:59 +0300, Anton Vorontsov wrote:
> On Tue, Feb 03, 2009 at 11:32:18AM -0500, Steven Rostedt wrote:
> > 
> > On Tue, 2009-02-03 at 19:19 +0300, Anton Vorontsov wrote:
> > > On Tue, Feb 03, 2009 at 05:06:45PM +0100, Ingo Molnar wrote:
> > 
> > > [1] Btw, why exactly do we need the -fno-omit-frame-pointer for
> > > "FUNCTION_TRCER" tracer? Why just -pg isn't sufficient?..
> > > 
> > 
> > The problem is this that is in the toplevel Makefile:
> > 
> > 
> > ifdef CONFIG_FRAME_POINTER
> > KBUILD_CFLAGS	+= -fno-omit-frame-pointer -fno-optimize-sibling-calls
> > else
> > KBUILD_CFLAGS	+= -fomit-frame-pointer
> > endif
> > 

And don't forget the gcc bug that miscompiles function epilogues on ppc
with -fno-omit-frame-pointer (iirc), which we need to work around using
-mno-sched-epilog.

Currently, we set that only if CONFIG_FUNCTION_TRACER is set, ie, we
assume that we only set -fno-omit-frame-pointer when
CONFIG_FUNCTION_TRACER is set.

Ben.
