Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17673.56806.552948.748504@cargo.ozlabs.ibm.com>
Date: Fri, 15 Sep 2006 08:55:34 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Please pull powerpc.git 'merge' branch
In-Reply-To: <Pine.LNX.4.64.0609141208510.4388@g5.osdl.org>
References: <17671.64971.450232.870486@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0609141208510.4388@g5.osdl.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus Torvalds writes:

> Hmm. I'm not at all sure this pull caused the problem, and it may have 
> started long before, but right now I have problems printing on my G5 
> machine. 
> 
> I'll get around to trying to bisect it at some point, but before I even 
> start, I should probably check if anybody recognizes this immediately.

Curious.  It doesn't look familiar.  I have had problems printing from
my G5 in the past few weeks, but I attributed it to something being
broken in debian unstable, and right now, running current git,
printing is working again for me.

> which actually looks like something is broken (it says timeout in 5 
> microseconds, even though the timeout structure is shown as being one 
> second).
> 
> Now, it's entirely possible that the _broken_ thing is actually strrace 
> itself (that return value from "time()" looks a bit strange too), and that 
> it's some tracing problem with rinning 32-bit programs on a 64-bit kernel.

I just tried stracing the X server (I don't have a cupsd running) and
the selects look reasonable, e.g.:

select(256, [1 3 4 5 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
26 27 28 29 30 32 33], NULL, NULL, {0, 484000}) = 1 (in [33], left {0,
460000}) <0.026111>

Is your cupsd a 32-bit or a 64-bit binary?

Paul.
