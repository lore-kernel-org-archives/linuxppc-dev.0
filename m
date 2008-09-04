Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id AB4C1DDF1D
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 02:26:28 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: munroesj@us.ibm.com
Subject: Re: Efficient memcpy()/memmove() for G2/G3 cores...
Date: Thu, 4 Sep 2008 18:25:20 +0200
References: <200808251131.02071.david.jander@protonic.nl>
	<200809041459.27606.david.jander@protonic.nl>
	<1220538673.28869.261.camel@spokane1.rchland.ibm.com>
In-Reply-To: <1220538673.28869.261.camel@spokane1.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200809041825.21031.david.jander@protonic.nl>
Cc: linuxppc-dev@ozlabs.org, Gunnar Von Boehn <gunnar@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Steven,

On Thursday 04 September 2008 16:31:13 Steven Munroe wrote:
>[...]
> > Yes, I admit my testcase is focussing on optimizing memcpy() of uncached
> > data, and that interest stems from the fact that I was testing X11
> > performance (using xorg kdrive and xorg-server), and wondering why this
> > processor wasn't able to get more FPS when moving frames on screen or
> > scrolling, when in theory the on-board RAM should have bandwidth enough
> > to get a smooth image. What I mean is that I have a hard time believing
> > that this processor core is so dependent of tweaks in order to get some
> > decent memory throughput. The MPC5200B does get higher througput with
> > much less effort, and the two cores should be fairly identical (besides
> > the MPC5200B having less cache memory and some other details).
>
> I have personally optimized memcpy for power4/5/6 and they are all
> different. There are dozens of different PPC implementations from
> different manufacturers and design, every one is different! With painful
> negotiation I was able to get the --with-cpu= framework added to glibc
> but not all distro use it. You can thank me later ...

Well, thank you ;-)

> MPC5200B? never heard of it, don't care. I am busy with power7.

Ok, keep up your work with power7, it's great you care about that one ;-)

> So don't assume we are stupid because we have not dropped everything to
> optimize memcpy for YOUR processor and YOUR specific case.

Ho! I never, ever assumed that anyone (on this list) is stupid. I think you 
got me totally wrong (and _that_ may be my fault). I was asking for other 
users experience. You make it apear as if I was complaining about your 
optimizations for Power4/5/6/970/Cell, but in fact, if you read correctly I 
havn't even touched them... they are useless to me, since this is an e300 
core. My comparisons are all against vanilla glibc _without_ any optimized 
code... that is (most probably) simple loops with char copy, or at most 
32-bit word copies. What I want to know is why this processor (MPC5121e, not 
the MPC5200B) is so terribly inefficient at this without optimizations and if 
someone has done something about it before me (I am doing it right now). I 
have never stated that specifically _you_ did a bad job or something, so why 
are you reacting like that??
In fact, your framework for specific optimizations in glibc will most probably 
come in VERY handy, once I have sorted out the root of the problem with my 
specific case.... so thanks a lot for your valuable work... yes, I mean it.

> You care, your are a programmer? write code! If you care about the
> community then fit your optimization into the framework provided for CPU
> specific optimization and submit it so others can benefit.

I _am_ writing code, and Gunnar is helping me find an explaination to the 
bizarre behaviour of this particular chip. If the result is useable to 
others, i _will_ fit it on your framework for optimizations.

> > >[...]
> > > I don't think you're doing anything wrong exactly.  But it seems that
> > > your testcase sits there and just copies data with memcpy in varying
> > > sizes and amounts.  That's not exactly a real-world usecase is it?
> >
> > No, of course it's not. I made this program to test the performance
> > difference of different tweaks quickly. Once I found something that
> > worked, I started LD_PRELOADing it to different other programs (among
> > others the kdrive Xserver, mplayer, and x11perf) to see its impact on
> > performance of some real-life apps. There the difference in performance
> > is not so impressive of course, but it is still there (almost always
> > either noticeably in favor of the tweaked version of memcpy(), or with a
> > negligible or no difference).
>
> The trick is that the code built into glibc has to be optimal for the
> average case (4-256, average 12 bytes). Actually most memcpy
> implementations are a series of special cases for length and alignment.
> 
> You can always do better if you know exactly what processor you are on
> and what specific sizes and alignment your application uses.

Yes, I know that's a problem. Thanks for the information for "average size", I 
don't know where it comes from, but I'll take your word.

I am trying to be as polite and friendly as I can, so if you think I am not, 
please tell me where and when... I'll try to improve my social skills for the 
next time ;-)

Greetings,

-- 
David Jander
