Subject: Re: drivers/macintosh/Kconfig (was: Re: Linux 2.6.3-rc1)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brad Boyer <flar@allandria.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040208215918.GB13906@pants.nu>
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org>
	 <Pine.GSO.4.58.0402081436370.2443@waterleaf.sonytel.be>
	 <20040208205734.GA13906@pants.nu> <1076275785.885.94.camel@gaston>
	 <20040208215918.GB13906@pants.nu>
Content-Type: text/plain
Message-Id: <1076278954.27930.98.camel@gaston>
Mime-Version: 1.0
Date: Mon, 09 Feb 2004 09:22:35 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I've been thinking about splitting up the ADB and other functions
> of the egret, cuda, and pmu. The abuse of adb_request for non-ADB
> functionality should go away. With the new driver model, the ADB
> bus will be represented as a generic bus and any request should
> go to a specific bus or device. I don't want to have to assume
> a single, global bus the way the current code does.
>
> I would prefer to have ADB be really just for ADB. The power
> management stuff should be a separate interface, and really
> should be more generic across the different Mac power management
> systems. Although the egret and cuda don't do as much as pmu,
> they still manage poweroff, reset, and the PRAM/RTC. These are
> totally unrelated to ADB, and that stuff I think should be left
> in drivers/macintosh/.

I agree that the abuse of adb_request should go, though replacing
it isn't easy at this stage. It's not worth bothering with a
common interface for things like poweroff, reset and RTC imho,
it would only solve a small part of the problem, there are too
many places where we actually need to send directly a PMU command.

Part of the problem is that the PMU driver low level state machine
it tied to the format of the adb_request structure. I don't think
I will fix any of that for 2.6. For 2.7, I may define a low level
pmu_request structure _without_ embedded buffers and have the ADB
request handling allocate one of those atomically.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
