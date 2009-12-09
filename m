Return-Path: <mjw@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id A718AB6F1C
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Dec 2009 02:56:37 +1100 (EST)
Subject: Re: [PATCH 6/8] Use proper types for do_div
From: Mark Wielaard <mjw@redhat.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20091127223347.GF21805@oksana.dev.rtsoft.ru>
References: <20091127223251.GA17065@oksana.dev.rtsoft.ru>
	<20091127223347.GF21805@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Dec 2009 16:56:34 +0100
Message-Id: <1260374194.31018.11.camel@springer.wildebeest.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, systemtap@sourceware.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anton,

On Sat, 2009-11-28 at 01:33 +0300, Anton Vorontsov wrote: 
> do_div accepts unsigned 64-bit integer type for dividend, signed types
> would cause do_div's typecheck fail:
> 
> stat-common.c: In function 'needed_space':
> stat-common.c:50: error: comparison of distinct pointer types lacks a cast
> ...same errors in time.c and tapset-timers.cxx's generated code...
> 
> A fix for time.c is special, on ppc32 cycles_t is 32-bit, so technically
> we don't need do_div, but since the whole _stp_gettimeofday_ns() operates
> on 64-bit types we'd better be safe and use uint64_t for the math.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  runtime/stat-common.c |    8 ++++----
>  runtime/time.c        |    3 ++-
>  tapset-timers.cxx     |    2 +-
>  3 files changed, 7 insertions(+), 6 deletions(-)

I don't immediately see anything wrong with the code. But on x86_64 this
does cause some regression test failures in testsuite/systemtap.maps. In
particular the following tests now fail (they all pass with this one
patch reverted):

Running /home/mark/src/systemtap/testsuite/systemtap.maps/elision.exp ...
FAIL: elision-1
FAIL: elision0
FAIL: elision1
FAIL: elision2
FAIL: elision3
Running /home/mark/src/systemtap/testsuite/systemtap.maps/ix.exp ...
FAIL: systemtap.maps/ix.stp
Running /home/mark/src/systemtap/testsuite/systemtap.maps/linear_large_neg.exp ...
FAIL: systemtap.maps/linear_large_neg.stp
Running /home/mark/src/systemtap/testsuite/systemtap.maps/linear_overunder.exp ...
FAIL: systemtap.maps/linear_overunder.stp
Running /home/mark/src/systemtap/testsuite/systemtap.maps/linear_under.exp ...
FAIL: systemtap.maps/linear_under.stp
Running /home/mark/src/systemtap/testsuite/systemtap.maps/log.exp ...
FAIL: systemtap.maps/log.stp
Running /home/mark/src/systemtap/testsuite/systemtap.maps/log_edge.exp ...
FAIL: systemtap.maps/log_edge.stp

Could you have a look?

Thanks,

Mark
