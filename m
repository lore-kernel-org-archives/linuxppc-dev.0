Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id CE14CDDEF5
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 12:30:25 +1100 (EST)
Date: Thu, 5 Feb 2009 04:30:23 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powerpc: Make it possible to safely select
	CONFIG_FRAME_POINTER
Message-ID: <20090205013023.GA31417@oksana.dev.rtsoft.ru>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
	<20090204150838.GB30027@oksana.dev.rtsoft.ru>
	<1233793889.4612.33.camel@pasglop>
	<1233794154.16878.20.camel@localhost.localdomain>
	<1233796531.4612.35.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <1233796531.4612.35.camel@pasglop>
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 05, 2009 at 12:15:31PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2009-02-04 at 19:35 -0500, Steven Rostedt wrote:
> > On Thu, 2009-02-05 at 11:31 +1100, Benjamin Herrenschmidt wrote:
> > > On Wed, 2009-02-04 at 18:08 +0300, Anton Vorontsov wrote:
> > > > Remove -fno-omit-frame-pointer flag from CFLAGS.
> > > > Remove -fno-omit-frame-pointer workarounds.
> > > 
> > > But what about -pg -requires -fno-omit-frame-pointer ?
> > 
> > I don't think it requires -fno-omit-frame-pointer. It is just
> > incompatible with -fomit-frame-pointer.
> 
> From a quick test, you seem to be right.
> 
> Now the question of course is whether -pg will internally trigger
> the bug for which we need the workaround tho...

According to http://marc.info/?l=linux-kernel&m=121958694215835&w=4
just removing -fno-omit-frame-pointer solved the problem.

But I'll double check that on the actual hardware.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
