Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp1.wanadoo.fr (smtp1.wanadoo.fr [193.252.22.30])
	by ozlabs.org (Postfix) with ESMTP id 0846E2BF12
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Jan 2005 03:51:39 +1100 (EST)
Date: Wed, 5 Jan 2005 18:00:13 +0100
To: Leigh Brown <leigh@solinno.co.uk>
Message-ID: <20050105170013.GB29287@pegasos>
References: <33721.82.10.231.190.1104781370.squirrel@82.10.231.190>
	<33151.82.10.231.190.1104878355.squirrel@82.10.231.190>
	<20050105090318.GA12317@pegasos> <200501051049.19225.pguyot@cvf.fr>
	<20050105114719.GB14332@pegasos>
	<C9ACD772-5F30-11D9-A2C3-000A95A0560C@penguinppc.org>
	<20050105160816.GA28046@pegasos>
	<25607.195.212.29.91.1104942605.squirrel@195.212.29.91>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <25607.195.212.29.91.1104942605.squirrel@195.212.29.91>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>,
	Philippe Guyot <pguyot@cvf.fr>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org, mikemartin@linux.ca
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 05, 2005 at 04:30:05PM -0000, Leigh Brown wrote:
> Sven Luther said:
> > On Wed, Jan 05, 2005 at 09:45:13AM -0600, Hollis Blanchard wrote:
> >> On Jan 5, 2005, at 5:47 AM, Sven Luther wrote:
> >> >On Wed, Jan 05, 2005 at 10:49:19AM +0100, Philippe Guyot wrote:
> >> >>>BTW, i have another question. I am trying to fix debian-installer
> >> >>>to create the prep partition, but i would like to have some info
> >> >>>on the expected constraints of said partition. Some tell it has
> >> >>>to be entirely in the first 8MB, others the first 5MB, and my
> >> >>>powerstack has a 17MB boot partition right now.
> >> >>
> >> >>All I can say, it's that my boot PReP partition is the 1st and about
> >> >>4 MB in size (cannot size it less than 1% of the disk.....)
> >> >>second partition is /
> >> >>third is swap.
> >> >
> >> >BTW, for debian, it makes more sense to have the second partition
> >> >as swap, and the third as /, i think, since it was decided some
> >> >time back to default to root=/dev/sda3, and not sda2.
> >> >
> >> >>That works for me.
> >> >
> >> >Until the kernel grows beyond 4MB.
> >>
> >> The size of that partition depends on firmware limitations. I have
> >> definitely seen reports of systems not booting when the PReP boot
> >> partition was too large. I think on some systems that has even happened
> >> at 8MB.
> >
> > Is the problem really the size of the partition, or the space used by
> > the kernel. I mean we could make a 100MB partition at start, and since
> > we just dd the kernel to it, the kernel would be found at the start of
> > the partition, and the firmware probably doesn't care about the real
> > size of the partition, as long as it can access all the kernel data we
> > added to it, no ?
> >
> > Do we have some documentation of the firmware limitations ?
> >
> >> In other words, should you need more space than 4-5MB at some point in
> >> the future, you cannot simply make a bigger boot partition.
> >
> > 8MB would be good, 4-5MB only would probably be a bit just.
> 
> Surely if you make the default mkinitrd behaviour a bit more sensible
> there won't be a problem.  A compressed 2.6 kernel is about 1.5MB, and

The compressed kernel should be arounf 1.0MB only.

> an initrd using MODULES=dep is about 1.5MB, which makes about 3MB,
> giving a comfortable amount of space for future growth...

well, when i use MODULES=dep, i still get all the filesystem and a bunch of
extra ide drivers, so it is no less than 4MB. Mmm, you are right about this
one, it is only 1499136 now, which makes a total of 2856844, quite reasonable.
Mmm, i wonder it may even boot on the pegasos 1 with the broken OF now.

Still, partman-prep is currently written to make sure the prep partition is in
the first 8MB.

Friendly,

Sven Luther
