Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id AD07DB7149
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Mar 2011 03:55:19 +1100 (EST)
Date: Tue, 1 Mar 2011 08:55:15 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: [PATCH 0/8] fsldma: lockup fixes
Message-ID: <20110301165515.GA23403@ovro.caltech.edu>
References: <4D6BEDCE.3020102@embedded-sol.com>
	<20110228195350.GA31428@ovro.caltech.edu>
	<4D6C0275.6000807@embedded-sol.com>
	<20110228211103.GB31428@ovro.caltech.edu>
	<4D6C134C.4070407@embedded-sol.com>
	<20110301002156.GC31428@ovro.caltech.edu>
	<4D6C89A7.8010803@embedded-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D6C89A7.8010803@embedded-sol.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 01, 2011 at 07:52:39AM +0200, Felix Radensky wrote:
> Hi Ira,
> 
> On 03/01/2011 02:21 AM, Ira W. Snyder wrote:
> > On Mon, Feb 28, 2011 at 11:27:40PM +0200, Felix Radensky wrote:
> >> Hi Ira,
> >>
> >> On 02/28/2011 11:11 PM, Ira W. Snyder wrote:
> >>> On Mon, Feb 28, 2011 at 10:15:49PM +0200, Felix Radensky wrote:
> >>>> Hi Ira,
> >>>>
> >>>>> Thank you very much Felix. The dmesg output shows that the controller
> >>>>> never got an interrupt for the second transaction. The patch below has
> >>>>> extra debugging information that may help determine why this happens.
> >>>>> Please apply it and re-run the test.
> >>>>>
> >>>>> The last section of dmesg (after "Freeing unused kernel memory") is all
> >>>>> I need.
> >>>>>
> >>>> Attached relevant dmesg portion.
> >>>>
> >>> Ok, try this patch on top of the last one.
> >>>
> >>> It looks like you used the dmatest module in multi-channel mode last
> >>> time. One channel makes it easier to debug:
> >>>
> >>> modprobe dmatest max_channels=1 threads_per_chan=2 iterations=1
> >>>
> >>> Thanks for your help in debugging this. Hopefully this is the last
> >>> patch to test. :)
> >>>
> >>> Ira
> >>>
> >> Looks like this was not the last one. The test still fails, see below
> >>
> >  From this log, it looks like the DMA controller is not generating an
> > interrupt after the second chain is started. The first chain is finished
> > before the second thread runs and starts its chain.
> >
> > The end-of-segments interrupt is completely missing. The part is not
> > behaving as the datasheet explains it should. Are you sure you applied
> > the patch and rebuilt the kernel? (Just checking to be sure. I'm very
> > appreciative of the amount of help you've given me debugging this!)
> >
> > Can you run this for me:
> >
> > modprobe dmatest max_channels=1 threads_per_chan=1 iterations=4
> >
> > Thanks again,
> > Ira
> 
> Without your patches applied the output of the test above looks
> like this:
> 

Thanks, this is exactly what I was going to ask for next. :)

I really don't understand why the P2020 DMA controller isn't behaving
nicely after my patches.

Can you run a git bisect to figure out which patch in the series causes
the problems. It should take three or four build + test cycles to narrow
down which patch breaks the driver. When it is finished, send me the
output of git bisect.

Like this (assuming you have two branches: master and
fsldma, where fsldma is master + my patches):

# setup the bisect
git bisect start
git bisect bad fsldma
git bisect good master

# build and test the kernel using the same test as before:
modprobe dmatest max_channels=1 threads_per_chan=1 iterations=4

# if the test passes:
git bisect good

# if the test fails:
git bisect bad

# now build + test again, then mark that good or bad. Repeat until
# finished.


I really appreciate your help in testing this. You've been great at
providing everything I've asked for.

Thanks,
Ira
