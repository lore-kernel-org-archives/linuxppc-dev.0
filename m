Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8B213DDDA1
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Feb 2009 11:20:17 +1100 (EST)
Subject: Re: [PATCH 1/3] Makefile: Include arch Makefiles as late as possible
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20090214220326.GA5200@elte.hu>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
	<20090204150835.GA30027@oksana.dev.rtsoft.ru>
	<20090204212612.GN22608@elte.hu>
	<20090214195702.GB1241@uranus.ravnborg.org>
	<20090214220326.GA5200@elte.hu>
Content-Type: text/plain
Date: Sun, 15 Feb 2009 11:19:56 +1100
Message-Id: <1234657196.26036.86.camel@pasglop>
Mime-Version: 1.0
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

On Sat, 2009-02-14 at 23:03 +0100, Ingo Molnar wrote:
> 
> So the question is: even with FRAME_POINTERS disabled on PPC, is 
> __builtin_return_address(1)/(2) reliable, and is save_stack_trace() fast? (i.e.
> can it walk down the stack frame efficiently, or does it have to scan the full
> kernel stack) I.e. does PPC have all the material advantages of frame pointers?

Yes, we do. We effectively have frame pointers in fact, they may only be
omitted in leaf functions but then gcc __builtin_return_address() knows
how to handle that afaik.

Cheers,
Ben.
