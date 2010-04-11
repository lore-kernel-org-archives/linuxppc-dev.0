Return-Path: <r.goyet@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by ozlabs.org (Postfix) with ESMTP id 5B3BCB7D22
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 11 Apr 2010 19:51:20 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id 22so482677fge.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 11 Apr 2010 02:51:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1270162160.7101.136.camel@pasglop>
References: <alpine.DEB.2.01.1003310430570.5493@bogon.housecafe.de>
	<20100331132300.GA15951@oksana.dev.rtsoft.ru>
	<alpine.DEB.2.01.1003311131250.5493@bogon.housecafe.de>
	<20100401145642.70d5eab0.krautilein@gmx.de>
	<20100401151450.GA26399@oksana.dev.rtsoft.ru>
	<1270162160.7101.136.camel@pasglop>
Date: Sun, 11 Apr 2010 11:51:18 +0200
Message-ID: <r2h8028e5751004110251w18a81b5ar1b0617df158d5b94@mail.gmail.com>
Subject: Re: poweroff/suspend problems on PowerMac G5
From: Romain Goyet <r.goyet@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 2, 2010 at 12:49 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Thu, 2010-04-01 at 19:14 +0400, Anton Vorontsov wrote:
>
>> So CONFIG_HIBERNATION breaks suspend? Hm. How do you try
>> to suspend? echo mem > /sys/power/state?
>
> Nah, suspend isn't supported on these ( ... yet, I suppose I could
> implement it one of these days if nouveau can bring back the video
> card).
>
> I think his problem is that CONFIG_HIB* is breaking shutdown.
>
>> > as well as when just trying to shut
>> > down the machine.
>>
>> How do try to shut down the machine? halt/poweroff commands?
>>
>> >From a brief look, I don't see how CONFIG_HIBERNATION may change
>> halt/poweroff code flow in the kernel...
>>
>> Can you show us a boot log of working and not working kernels?
>> And .config files you use.
>>
>> ..maybe for some reason PMU/SMU modules didn't get loaded?
>
> Nah, I doubt it. Smells more like the old crap with broken cpu unplug on
> shutdown, no ?

I'm using a QuadG5 under Debian PPC right now, and indeed, it seems
like I have a similar issue (i.e. it takes *forever* for the machine
to halt). In my case it does end up powering itself off, but sometimes
it even goes in a state where all the fan are running at top-speed.
And indeed, I remember having some message in the console about CPUs
"unplugging" themselves.

>
> I have one of these guys at work, I can give it a try next week.
>

Great. While you're at it, is there any chance you could try to get
"server_mode" to work for this machine (or any SMU-based machine for
that matter). You know, so that the machine reboots after a power
failure :-)

Thanks a lot Ben !

  - Romain

> Cheers,
> Ben.
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
