Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BAD8BB6EF2
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Nov 2009 21:31:17 +1100 (EST)
In-Reply-To: <20091120202838.GA25843@compile2.chatsunix.int.mrv.com>
References: <1258712471-3104-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<20091120202838.GA25843@compile2.chatsunix.int.mrv.com>
Subject: Re: [PATCH 00/10 v6]  Fix 8xx MMU/TLB
To: Rex Feany <RFeany@mrv.com>
Message-ID: <OF074C7D1E.26CB4818-ONC1257675.0035EDC0-C1257675.003979F2@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sat, 21 Nov 2009 11:27:47 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Rex Feany <RFeany@mrv.com> wrote on 20/11/2009 21:28:38:
>
> Thus spake Joakim Tjernlund (Joakim.Tjernlund@transmode.se):
>
> > Yet again an iteration of the series.
> > Rex & Scott, please test and signoff.
> > Changes since last version:
> >  - Fix rlwimi insn(from Scott)
>
> Hi Joakim,
>
> Things look much better with this patch set, I see none
> of the random crashes that I had with the earlier patches.
> I'll leave it running on a few boards here over the weekend and
> see if anything bad happens.

Good to hear that.

>
> Since patch #1 fixes a regression in the current kernel
> is there any way you can get that into .32? I know it is late,
> but without that patch .32 doesn't work for 8xx boards.

You need to convince Ben of that. I guess the best you can do
is to reply(include Ben too) with your s-o-b and explain that this
fixes a regression for you.

>
> On another note, how does your patch set affect performance?
> Have you been able to do any testing?  What is the advantage
> of using dcbX in the kernel, besides keeping the code
> similar to other ppc platforms?

I consider this a big plus, not having to pay special attention
to 8xx anymore. There aren't many 8xx people around
to fix problems that are specific for 8xx.

> Maybe it is good to
> catch/fixup userspace uses of dcbX, but why change the
> kernel? How does it affect performance?

when I originally did the dcbX path many years ago I did
some perf testing and it was a win. Perhaps you could
run a some tests?

Consider that the dcbx workaround is only triggered by a DTLB errors
and the kernel never gets into DTLB errors for normal activity.

TLB errors are the slow path anyway with lots of mm code
so a few more insn won't matter.

There is also the case of dcbst setting the store bit wrongly
and this could generate a SEGV if it hits a RO page.

The kernel isn't free of dcbX insn anyway so if it ever hit
a DTLB error, it is possible that could bring down the kernel.

The only perf regression I can think of is the
  8xx: Remove DIRTY pte handling in DTLB Error.
which will make dirty handling much slower.
I am happy to leave that one out, but Ben requested
this.

 Jocke

PS.
    You should consider fixing glibc's mem* functions to make
    use of dcbX for 8xx once the kernel has this patchset.
