Date: Sun, 8 Feb 2004 15:05:08 -0800
From: Brad Boyer <flar@allandria.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/m68k <linux-m68k@lists.linux-m68k.org>,
	Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: drivers/macintosh/Kconfig (was: Re: Linux 2.6.3-rc1)
Message-ID: <20040208230508.GA14393@pants.nu>
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org> <Pine.GSO.4.58.0402081436370.2443@waterleaf.sonytel.be> <20040208205734.GA13906@pants.nu> <1076275785.885.94.camel@gaston> <20040208215918.GB13906@pants.nu> <1076278954.27930.98.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1076278954.27930.98.camel@gaston>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Feb 09, 2004 at 09:22:35AM +1100, Benjamin Herrenschmidt wrote:
> I agree that the abuse of adb_request should go, though replacing
> it isn't easy at this stage. It's not worth bothering with a
> common interface for things like poweroff, reset and RTC imho,
> it would only solve a small part of the problem, there are too
> many places where we actually need to send directly a PMU command.

Based on my reading of the code, most of the places sending PMU
commands directly are actually calling pmu_request, so I was
planning on leaving that alone as a hook directly into the PMU
driver, and although it's related to ADB, it isn't going through
the current ADB framework, either.

> Part of the problem is that the PMU driver low level state machine
> it tied to the format of the adb_request structure. I don't think
> I will fix any of that for 2.6. For 2.7, I may define a low level
> pmu_request structure _without_ embedded buffers and have the ADB
> request handling allocate one of those atomically.

I don't see where that is an issue. The PMU driver internally can
continue to be based on the same structure, and interface with
the new ADB layer just for ADB messages. I suppose it will be clearer
once I get that part of the code finished. I've been concentrating
more on the 68k side of things for this, since I don't care if I
confuse one of my older boxes.

	Brad Boyer
	flar@allandria.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
