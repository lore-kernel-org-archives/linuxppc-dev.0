Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 30BDCDDFF9
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 22:59:54 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: Efficient memcpy()/memmove() for G2/G3 cores...
Date: Thu, 4 Sep 2008 14:59:27 +0200
References: <200808251131.02071.david.jander@protonic.nl>
	<200809041405.16489.david.jander@protonic.nl>
	<20080904121926.GA12867@yoda.jdub.homelinux.org>
In-Reply-To: <20080904121926.GA12867@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809041459.27606.david.jander@protonic.nl>
Cc: munroesj@us.ibm.com, John Rigby <jrigby@freescale.com>,
	Gunnar Von Boehn <gunnar@genesi-usa.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	prodyut hazarika <prodyuth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 04 September 2008 14:19:26 Josh Boyer wrote:
>[...]
> >$ ./memcpyspeed
> >Fully aligned:
> >100000 chunks of 5 bytes   :  3.48 Mbyte/s ( throughput:  6.96 Mbytes/s)
> >50000 chunks of 16 bytes   :  14.3 Mbyte/s ( throughput:  28.6 Mbytes/s)
> >10000 chunks of 100 bytes  :  14.4 Mbyte/s ( throughput:  28.8 Mbytes/s)
> >5000 chunks of 256 bytes   :  14.4 Mbyte/s ( throughput:  28.7 Mbytes/s)
> >1000 chunks of 1000 bytes  :  14.4 Mbyte/s ( throughput:  28.7 Mbytes/s)
> >50 chunks of 16384 bytes   :  14.2 Mbyte/s ( throughput:  28.4 Mbytes/s)
> >1 chunks of 1048576 bytes  :  14.4 Mbyte/s ( throughput:  28.8 Mbytes/s)
> >
> >$ LD_PRELOAD=./libmemcpye300dj.so ./memcpyspeed
> >Fully aligned:
> >100000 chunks of 5 bytes   :  7.44 Mbyte/s ( throughput:  14.9 Mbytes/s)
> >50000 chunks of 16 bytes   :  13.1 Mbyte/s ( throughput:  26.2 Mbytes/s)
> >10000 chunks of 100 bytes  :  29.4 Mbyte/s ( throughput:  58.8 Mbytes/s)
> >5000 chunks of 256 bytes   :  90.2 Mbyte/s ( throughput:   180 Mbytes/s)
> >1000 chunks of 1000 bytes  :    77 Mbyte/s ( throughput:   154 Mbytes/s)
> >50 chunks of 16384 bytes   :  96.8 Mbyte/s ( throughput:   194 Mbytes/s)
> >1 chunks of 1048576 bytes  :  97.6 Mbyte/s ( throughput:   195 Mbytes/s)
> >
> >(I have edited the output of this tool to fit into an e-mail without
> > wrapping lines for readability).
> >Please tell me how on earth there can be such a big difference???
> >Note that on a MPC5200B this is TOTALLY different, and both processors
> > have an e300 core (different versions of it though).
>
> How can there be such a big difference in throughput?  Well, your algorithm
> seems better optimized than the glibc one for your testcase :).

Yes, I admit my testcase is focussing on optimizing memcpy() of uncached data, 
and that interest stems from the fact that I was testing X11 performance 
(using xorg kdrive and xorg-server), and wondering why this processor wasn't 
able to get more FPS when moving frames on screen or scrolling, when in 
theory the on-board RAM should have bandwidth enough to get a smooth image.
What I mean is that I have a hard time believing that this processor core is 
so dependent of tweaks in order to get some decent memory throughput. The 
MPC5200B does get higher througput with much less effort, and the two cores 
should be fairly identical (besides the MPC5200B having less cache memory and 
some other details).

>[...]
> I don't think you're doing anything wrong exactly.  But it seems that
> your testcase sits there and just copies data with memcpy in varying
> sizes and amounts.  That's not exactly a real-world usecase is it?

No, of course it's not. I made this program to test the performance difference 
of different tweaks quickly. Once I found something that worked, I started 
LD_PRELOADing it to different other programs (among others the kdrive 
Xserver, mplayer, and x11perf) to see its impact on performance of some 
real-life apps. There the difference in performance is not so impressive of 
course, but it is still there (almost always either noticeably in favor of 
the tweaked version of memcpy(), or with a negligible or no difference).

I have not studied the different application's uses of memcpy(), and only done 
empirical tests so far.

> I think what Paul was saying is that during the course of runtime for a
> normal program (the kernel or userspace), most memcpy operations will be of
> a small order of magnitude.  They will also be scattered among code that
> does _other_ stuff than just memcpy.  So he's concerned about the overhead
> of an implementation that sets up the cache to do a single 32 byte memcpy.

I understand. I also have this concern, especially for other processors, as 
the MPC5200B, where there doesn't seem to be so much to gain anyway.

> Of course, I could be totally wrong.  I haven't had my coffee yet this
> morning after all.

You're doing quite good regardless of your lack of caffeine ;-)

Greetings,

-- 
David Jander
