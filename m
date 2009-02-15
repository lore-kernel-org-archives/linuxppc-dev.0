Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4F52FDDDA0
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Feb 2009 19:10:03 +1100 (EST)
Date: Sun, 15 Feb 2009 09:09:46 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] Makefile: Include arch Makefiles as late as possible
Message-ID: <20090215080946.GB24508@elte.hu>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
	<20090204150835.GA30027@oksana.dev.rtsoft.ru>
	<20090204212612.GN22608@elte.hu>
	<20090214195702.GB1241@uranus.ravnborg.org>
	<20090214220326.GA5200@elte.hu> <1234657196.26036.86.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1234657196.26036.86.camel@pasglop>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Sat, 2009-02-14 at 23:03 +0100, Ingo Molnar wrote:
> > 
> > So the question is: even with FRAME_POINTERS disabled on PPC, is 
> > __builtin_return_address(1)/(2) reliable, and is save_stack_trace() fast? (i.e.
> > can it walk down the stack frame efficiently, or does it have to scan the full
> > kernel stack) I.e. does PPC have all the material advantages of frame pointers?
> 
> Yes, we do. We effectively have frame pointers in fact, they may only be
> omitted in leaf functions but then gcc __builtin_return_address() knows
> how to handle that afaik.

So basically we want to define FRAME_POINTERS on PPC, but do not want
the -fno-omit-frame-pointers flag.

Originally (many moons ago) FRAME_POINTER _was_ just the toplevel Makefile
detail, but these days we've got a handful of secondary uses as well,
expressing the reliability of backtraces in essence.

We could split the whole option (affecting lots of files), or we could zap
that compiler flag in the PPC case - it is only PPC that worries about this
anyway.

	Ingo
