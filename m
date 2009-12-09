Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 6F3A1B6EEA
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Dec 2009 03:09:43 +1100 (EST)
Date: Wed, 9 Dec 2009 19:09:41 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Mark Wielaard <mjw@redhat.com>
Subject: Re: [PATCH 6/8] Use proper types for do_div
Message-ID: <20091209160941.GA8539@oksana.dev.rtsoft.ru>
References: <20091127223251.GA17065@oksana.dev.rtsoft.ru>
	<20091127223347.GF21805@oksana.dev.rtsoft.ru>
	<1260374194.31018.11.camel@springer.wildebeest.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1260374194.31018.11.camel@springer.wildebeest.org>
Cc: linuxppc-dev@ozlabs.org, systemtap@sourceware.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 09, 2009 at 04:56:34PM +0100, Mark Wielaard wrote:
> On Sat, 2009-11-28 at 01:33 +0300, Anton Vorontsov wrote: 
> > do_div accepts unsigned 64-bit integer type for dividend, signed types
> > would cause do_div's typecheck fail:
> > 
> > stat-common.c: In function 'needed_space':
> > stat-common.c:50: error: comparison of distinct pointer types lacks a cast
> > ...same errors in time.c and tapset-timers.cxx's generated code...
> > 
> I don't immediately see anything wrong with the code. But on x86_64 this
> does cause some regression test failures in testsuite/systemtap.maps. In
> particular the following tests now fail (they all pass with this one
> patch reverted):
> 
> Running /home/mark/src/systemtap/testsuite/systemtap.maps/elision.exp ...
> FAIL: elision-1
[...]
> Running /home/mark/src/systemtap/testsuite/systemtap.maps/log_edge.exp ...
> FAIL: systemtap.maps/log_edge.stp
> 
> Could you have a look?

I think this should be fixed by this patch:

http://sourceware.org/ml/systemtap/2009-q4/msg00800.html

Can you try it? With this patch I see no new regressions on x86_64.

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
