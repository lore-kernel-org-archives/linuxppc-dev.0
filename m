Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id ADE602BDDA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Oct 2004 11:51:24 +1000 (EST)
Date: Mon, 18 Oct 2004 18:51:20 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Zajac Adam-AAZ004 <Adam.Zajac@motorola.com>
Message-ID: <20041019015120.GA6252@gate.ebshome.net>
References: <EFB813091B18D511BD3600508B644F820A6181E9@tx14exm06.ftw.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <EFB813091B18D511BD3600508B644F820A6181E9@tx14exm06.ftw.mot.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Help on tuning the Linux kernel for soft real-time requiremen ts
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Oct 18, 2004 at 05:44:52PM -0500, Zajac Adam-AAZ004 wrote:
> It sounds like you're doing exactly what we've been trying to achieve.
> We're trying to meet soft real-time deadlines that are in order of seconds
> (2sec).

Hmm, 2s is a lot. You shouldn't have any problems with getting 2 
second accuracy.

> The only differences between our systems are:
> - kernel 2.4.20
> - HZ = 100
> - Compact Flash

And O(1) scheduler + SCHED_FIFO instead of round-robin (I don't like 
this scheduling policy :), SCHED_FIFO is true priority based 
scheduling.

BTW, we have systems with CF card, writing to it doesn't seem to 
affect real-time threads either.

> We tried to do a similar thing to the scenario you described where we were
> running all other threads with SCHED_OTHER, and the thread with real-time
> priority with RoundRobin scheduler policy. We keep experiencing the greatest
> slips for such file system intensive operations like gzip and tar.
> Also, for an experiment, we tried to turn disk caching off, which helped
> meeting the deadlines a little but slowed down all file transfers
> unacceptably.
> To eliminate the question on the compact flash performance we tried using
> NFS. Using NFS  yielded similar results (missed deadlines) to performing the
> transfers with the cflash card.
> 
> Did you have to set anything special at your kernel config file (.config)?

Nothing special I can think of.

> Did you need to apply low-latency patch separately or the MV kernel you have
> came pre-patched?

I applied _all_ patches myself, although I used MV kernel as a 
reference in some cases, e.g. where rml PPC preempt patches were 
buggy.

--
Eugene
