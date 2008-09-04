Return-Path: <gunnar@genesi-usa.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 71CB6DE19A
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 00:45:18 +1000 (EST)
Received: by gxk14 with SMTP id 14so6307881gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 04 Sep 2008 07:45:16 -0700 (PDT)
Message-ID: <b989d750809040745x76231c19l2635c91311fe3b1c@mail.gmail.com>
Date: Thu, 4 Sep 2008 16:45:16 +0200
From: "Gunnar Von Boehn" <gunnar@genesi-usa.com>
To: munroesj@us.ibm.com
Subject: Re: Efficient memcpy()/memmove() for G2/G3 cores...
In-Reply-To: <1220538673.28869.261.camel@spokane1.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200808251131.02071.david.jander@protonic.nl>
	<200809041405.16489.david.jander@protonic.nl>
	<20080904121926.GA12867@yoda.jdub.homelinux.org>
	<200809041459.27606.david.jander@protonic.nl>
	<1220538673.28869.261.camel@spokane1.rchland.ibm.com>
Cc: David Jander <david.jander@protonic.nl>, John Rigby <jrigby@freescale.com>,
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

Steve,

I think we should be grateful for people being interested in improving
performance for PPC,
and we should not bash them.

The proposal to optimize the memcopy for the 5200 is good.


Steve, you said that you've heard about the 5200..
Maybe I can refresh your memory:
I did send you an optimized 32bit memcopy version for the 5200 about
halve a year ago,
I did send you the routine with the kind request for inclusion.
As you might recall the optimized 5200 memcopy version that I had send
you, was improving the performance by 50%.


Kind regards
Gunnar


On Thu, Sep 4, 2008 at 4:31 PM, Steven Munroe
<munroesj@linux.vnet.ibm.com> wrote:
> On Thu, 2008-09-04 at 14:59 +0200, David Jander wrote:
>> On Thursday 04 September 2008 14:19:26 Josh Boyer wrote:
>> >[...]
>> > >(I have edited the output of this tool to fit into an e-mail without
>> > > wrapping lines for readability).
>> > >Please tell me how on earth there can be such a big difference???
>> > >Note that on a MPC5200B this is TOTALLY different, and both processors
>> > > have an e300 core (different versions of it though).
>> >
>> > How can there be such a big difference in throughput?  Well, your algorithm
>> > seems better optimized than the glibc one for your testcase :).
>>
>> Yes, I admit my testcase is focussing on optimizing memcpy() of uncached data,
>> and that interest stems from the fact that I was testing X11 performance
>> (using xorg kdrive and xorg-server), and wondering why this processor wasn't
>> able to get more FPS when moving frames on screen or scrolling, when in
>> theory the on-board RAM should have bandwidth enough to get a smooth image.
>> What I mean is that I have a hard time believing that this processor core is
>> so dependent of tweaks in order to get some decent memory throughput. The
>> MPC5200B does get higher througput with much less effort, and the two cores
>> should be fairly identical (besides the MPC5200B having less cache memory and
>> some other details).
>>
>
> I have personally optimized memcpy for power4/5/6 and they are all
> different. There are dozens of different PPC implementations from
> different manufacturers and design, every one is different! With painful
> negotiation I was able to get the --with-cpu= framework added to glibc
> but not all distro use it. You can thank me later ...
>
> MPC5200B? never heard of it, don't care. I am busy with power7.
>
> So don't assume we are stupid because we have not dropped everything to
> optimize memcpy for YOUR processor and YOUR specific case.
>
> You care, your are a programmer? write code! If you care about the
> community then fit your optimization into the framework provided for CPU
> specific optimization and submit it so others can benefit.
>
>> >[...]
>> > I don't think you're doing anything wrong exactly.  But it seems that
>> > your testcase sits there and just copies data with memcpy in varying
>> > sizes and amounts.  That's not exactly a real-world usecase is it?
>>
>> No, of course it's not. I made this program to test the performance difference
>> of different tweaks quickly. Once I found something that worked, I started
>> LD_PRELOADing it to different other programs (among others the kdrive
>> Xserver, mplayer, and x11perf) to see its impact on performance of some
>> real-life apps. There the difference in performance is not so impressive of
>> course, but it is still there (almost always either noticeably in favor of
>> the tweaked version of memcpy(), or with a negligible or no difference).
>>
> The trick is that the code built into glibc has to be optimal for the
> average case (4-256, average 12 bytes). Actually most memcpy
> implementations are a series of special cases for length and alignment.
>
> You can always do better if you know exactly what processor you are on
> and what specific sizes and alignment your application uses.
>
>> I have not studied the different application's uses of memcpy(), and only done
>> empirical tests so far.
>>
>> > I think what Paul was saying is that during the course of runtime for a
>> > normal program (the kernel or userspace), most memcpy operations will be of
>> > a small order of magnitude.  They will also be scattered among code that
>> > does _other_ stuff than just memcpy.  So he's concerned about the overhead
>> > of an implementation that sets up the cache to do a single 32 byte memcpy.
>>
>> I understand. I also have this concern, especially for other processors, as
>> the MPC5200B, where there doesn't seem to be so much to gain anyway.
>>
>> > Of course, I could be totally wrong.  I haven't had my coffee yet this
>> > morning after all.
>>
>> You're doing quite good regardless of your lack of caffeine ;-)
>>
>> Greetings,
>>
>
>
