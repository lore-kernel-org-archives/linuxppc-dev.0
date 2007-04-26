Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id C4B7FDE085
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 06:36:51 +1000 (EST)
Date: Thu, 26 Apr 2007 15:37:10 -0500
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v2] [2.6.22] pasemi: cpufreq driver
Message-ID: <20070426203710.GB17302@lixom.net>
References: <20070425204633.GC19781@lixom.net>
	<20070426053700.GA23922@lixom.net>
	<1177583160.6814.37.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1177583160.6814.37.camel@johannes.berg>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, egor@pasemi.com, paulus@samba.org, arnd@arndb.de,
	cpufreq@lists.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 26, 2007 at 12:26:00PM +0200, Johannes Berg wrote:
> On Thu, 2007-04-26 at 00:37 -0500, Olof Johansson wrote:
> > 
> > +       policy->cur = pas_freqs[cur_astate].frequency;
> > +       policy->cpus = cpu_possible_map; 
> 
> That doesn't seem right.
> 
> Either, all your processors scale along each other in which case you
> should use cpu_online_map here, or they scale each on their own in which
> case you just set a single bit here.

You can set the requested speed per-processor, but the actual speed
will be the max of them. Because of this, it's less surprising to set
it on both at the same time since then you'll at least know what you're
running at.

So yes, I'll change it to online_map instead of possible_map.

> The generic code works like this:
> CPU 0 is brought online and cpufreq initialised for it
> CPU 1 is brought online and cpufreq initialised for it. if cpus includes
> more than a single bit, cpufreq is linked to the first other CPU in
> policy->cpus and then cpufreq for CPU1 is deinitialised again.
>
> We have the same bug on powermac but for some reason the patch to fix it
> that I posted a long time ago (look for "powermac: fix G5-cpufreq for
> cpu on/offline") wasn't applied yet. Look at it though, it includes a
> comment on what needs to be done.

Hmm, I just tried adding debugging to the cpu_init code, and I'm not
seeing it called more than once (i.e. only for cpu 0). Mind you, I don't
have cpu hotplug support at this time.






-Olof
