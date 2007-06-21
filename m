Return-Path: <matt@genesi-usa.com>
Message-ID: <467AC93C.2020408@genesi-usa.com>
Date: Thu, 21 Jun 2007 19:53:48 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Marc Leeman <marc.leeman@gmail.com>
Subject: Re: network load 8245 vs. 8347E
References: <20070621141519.GQ5417@chiana.homelinux.org>
	<0090CCD0-EBB4-4475-BF03-36AF41E2DDA1@kernel.crashing.org>
	<20070621155616.GR5417@chiana.homelinux.org>
	<20070621171340.GS5417@chiana.homelinux.org>
	<467ABCDC.8060401@genesi-usa.com>
	<20070621183349.GT5417@chiana.homelinux.org>
In-Reply-To: <20070621183349.GT5417@chiana.homelinux.org>
Content-Type: text/plain; charset=UTF-8
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sure; the 2.4 ethernet driver for the e100 might be extremely efficient
on the CPU but not very good on bandwidth. They've (Intel) rewritten it
a short while back according to the documentation, so it may be that
the newer version on 2.4 may be just as CPU intensive as the gianfar
driver, and you're lucky to be using the old one. I haven't looked at
the 2.4.x version you're running to see what driver it's using, but Intel
do have their latest driver version backported to the 2.4 kernel series
on their site.

You might just be lucky that 2.4 is less bloated and has to handle less
features than 2.6 and it's lowering the CPU usage :)

So, I suppose, comparing at least 2.6 series kernels is a start, making
sure you compare the old 2.4 e100 driver to the new 2.6 e100 driver is
another idea. I think there are too many variables. That said, usually
inbuilt ethernets on SoC's.. at least in my experience.. tend to be
more efficient in some ways but not in others. In any case an Intel
network card has always kicked the pants off it.. :(

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Marc Leeman wrote:
>> Isn't it just because the Intel  chipset is a REALLY nice ethernet
>> controller and the integrated one in the 8347E isn't as good? :)
> 
> Well, that's something what I'm afraid off: that for any kind of decent
> network performance we'd need an external chipset. But there are some
> other hickups we need to investigate with the 8347.
> 
> I just hope it's either a configuration problem, a not so efficient
> driver implementation -> no re-design :)
> 
>> You could try turning the interrupt coaelescing off in the e100
>> driver and see how well it does, then. Or knock the bundling
>> threshold or timer down to something similar to the 8347E is using..
>> or turn the ones on the 8347E up to match the ones the e100 driver
>> is using :)
>>
>> All these options used to be modprobe options but the latest
>> e100 driver seems to hardcode a bunch of them probably for best
>> performance. Anyway, putting them on a level peg would mean at
>> least you are comparing onboard apples with pci apples.
> 
> I started doing this this evening, but at first glance, changing sysfs
> params (on the gianfar driver) didn't change much.
> 
> I'll start comparing 8245/e100/2.4.34, 8245/e100/2.6.17 and
> 8347E/gianfar/2.6.21.1 tomorrow.
> 
> Anyway a load of 30% for a single process where an older processor only
> takes around 5% seems too much of a difference to be solved with simple
> parameter settings.
> 
