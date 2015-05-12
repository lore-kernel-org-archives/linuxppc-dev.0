Return-Path: <aaro.koskinen@iki.fi>
Received: from filtteri5.pp.htv.fi (filtteri5.pp.htv.fi [213.243.153.188])
 by lists.ozlabs.org (Postfix) with ESMTP id 520361A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 03:56:05 +1000 (AEST)
Date: Tue, 12 May 2015 20:55:55 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: G5 Xserve rackmeter broken?
Message-ID: <20150512175555.GB609@fuloong-minipc.musicnaut.iki.fi>
References: <20150510183259.GA13777@aspire-one.musicnaut.iki.fi>
 <1431296015.13039.12.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431296015.13039.12.camel@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Mon, May 11, 2015 at 08:13:35AM +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2015-05-10 at 21:32 +0300, Aaro Koskinen wrote:
> > Hi,
> > 
> > With 4.1-rc2 the rackmeter driver for G5 Xserve is giving bogus
> > led patterns. So far I have seen at least the following:
> > 
> > a) With static load the leds seems to be sane and report CPU
> > usage properly, but after few minutes they go completely OFF,
> > even if the CPU load remains high.
> > 
> > b) On a completely idle system, leds alter between all OFF and all ON
> > roughly once a second.
> > 
> > Unfortunately I cannot say which was the last kernel where this worked
> > properly... These servers were away from normal use for a while due
> > to PSU issues.
> 
> And mine is dead due to ... PSU issue :-(

I had 4 dead servers, of which I have now managed get 2 again back
running by recapping the PSU.

> It could be that what we use to get the "idle time" isn't correct
> anymore...

It seems sometimes the idle ticks exceed total ticks and mess up
load calculation. This will explain the b) case behaviour at least.
I added the following debug patch:

@@ -234,6 +234,10 @@ static void rackmeter_do_timer(struct work_struct *work)
         */
        load = (9 * (total_ticks - idle_ticks)) / total_ticks;

+       if (load > 10)
+               pr_err("load: %d total: %u idle: %u\n", load,
+                       total_ticks, idle_ticks);
+
        offset = cpu << 3;
        cumm = 0;
        for (i = 0; i < 8; i++) {

Which shows:

[  795.832701] load: 515 total: 8333333 idle: 8333661
[  796.792767] load: 515 total: 8333333 idle: 8333551
[  796.832770] load: 515 total: 8333333 idle: 8333656
[  797.292799] load: 515 total: 8333334 idle: 8333532
[  798.082856] load: 515 total: 8333334 idle: 8333591
[  798.792903] load: 515 total: 8333333 idle: 8333424
[  798.832909] load: 515 total: 8333333 idle: 8333571
[  799.292937] load: 515 total: 8333334 idle: 8333459
[  799.832973] load: 515 total: 8333333 idle: 8333551
[  800.793038] load: 515 total: 8333333 idle: 8333414
[  800.833045] load: 515 total: 8333333 idle: 8333583
[  801.293071] load: 515 total: 8333334 idle: 8333455
[  801.833107] load: 515 total: 8333333 idle: 8333564

I'm running with HZ=100 so the values are still probably within
jiffy resolution, so perhaps the calculation should first do
idle = min(idle, total)?

A.
