Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao08.cox.net (fed1rmmtao08.cox.net [68.230.241.31])
	by ozlabs.org (Postfix) with ESMTP id 0232967A45
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2005 05:33:40 +1100 (EST)
Date: Tue, 18 Jan 2005 11:33:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Tolunay Orkun <listmember@orkun.us>
Message-ID: <20050118183337.GK28724@smtp.west.cox.net>
References: <41EC29A8.1040703@mvista.com>
	<20050118161515.GI28724@smtp.west.cox.net>
	<93780AB0-696D-11D9-81BE-003065F9B7DC@embeddededge.com>
	<41ED49E2.5050401@orkun.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41ED49E2.5050401@orkun.us>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] Option to disable mapping genrtc calls to ppc_md calls
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 18, 2005 at 11:39:46AM -0600, Tolunay Orkun wrote:
> Dan Malek wrote:
> >
> >On Jan 18, 2005, at 11:15 AM, Tom Rini wrote:
> >
> >>On Mon, Jan 17, 2005 at 02:10:00PM -0700, Mark A. Greer wrote:
> >
> >
> >>>There are 2 reasons to not use the ppc_md.get_rtc_time() et. al. 
> >>>interfaces:
> >>>1) They are called before the i2c driver is initialized and even loaded
> >>>if its a module.
> >
> >
> >There are three reasons.  You don't want to use an I2c rtc clock at
> >all in these functions because they get can get called from the
> >clock interrupt to update the time in the rtc.  If it does happen to work,
> >it creates long latencies in the timer interrupt.  If the i2c requires an
> >interrupt, they system will crash or hang.
> >
> >A system using an I2C RTC should find some way to access the
> >clock from application space as a standard I2C device and manage
> >time/clock from the application, not from the kernel.
> 
> This is exactly what I've done for our PPC405GP based Linux port 
> (2.4.25). I've written a clone of hwclock utility using /dev/i2c0 to 
> access Dallas RTC chip with I2C interface. I setthe system clock from 
> RTC within /etc/rcS (Busybox). It is less than perfect as early logs 
> have the date wrong but it was the direction of least resistance.
> 
> Still, I think there should be a better standardized RTC interface to 
> help deal with I2C/SMBus based RTC chips.

There kind of is now, arch/arm/common/rtctime.c (thought of for I2C RTCs
and has alarm support).

-- 
Tom Rini
http://gate.crashing.org/~trini/
