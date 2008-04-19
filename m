Return-Path: <neko@genesi-usa.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by ozlabs.org (Postfix) with ESMTP id 733FADE20D
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Apr 2008 04:50:05 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id 16so927393fgg.39
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 11:50:03 -0700 (PDT)
Message-ID: <480A3ED5.5060709@genesi-usa.com>
Date: Sat, 19 Apr 2008 19:49:57 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH] [POWERPC] mpc5200: Switch mpc5200 dts files to dts-v1
	format
References: <20080418160812.11897.5654.stgit@trillian.secretlab.ca>
	<20080419133658.GJ13814@pengutronix.de>
In-Reply-To: <20080419133658.GJ13814@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, m8@semihalf.com, Sascha Hauer <sha@pengutronix.de>,
	Wolfram Sang <wsa@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I wholeheartedly agree, although the difference between gpt and timer
and pic vs interrupt-controller (actually interrupt-controller is meant
to be a property of the interrupt controller, not a device type.. weird)
was chosen because they did not conflict with what might be considered
"standard device_types" with real OF (Forth, CIS) interfaces like read,
write, ping, world-peace etc.

However since Linux doesn't care about the interface provided by the
firmware and only reads the tree, and real OF interfaces MIGHT need
to be provided by these items on real OF firmwares, I don't see why
they should not be used.

A problem arises; how do you decide when you name something after what
it is rather than the documentation acronym? What does the 5200B CDM
turn into? The XLB arbiter module? What about the rest of the SIU?

There really needs to be a standards committee for this, that has good
experience with device trees and BSPs, and can work with the device
vendors and board manufacturers (Freescale for example) directly, with
them on the committee, who can give the docs a run though before any
board ever hits the streets...

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Robert Schwebel wrote:
> On Fri, Apr 18, 2008 at 09:10:04AM -0700, Grant Likely wrote:
>> Update dts files to current format
> 
> Is it somehow possible that this device tree stuff is *not* changed over
> and over again and break everything out there? When people have not even
> agreed on basic things like decimal vs. hex numbers, the whole idea
> should be developed out-of-tree, then stabilize and *then* be submitted
> to the Linux mainline.
> 
> Is it also really necessary to change like "gpt" vs. "timer" and "pic"
> vs. "interrupt-controller" all the time? If you compare the last
> mainline kernels, each one got a fundamental change in the naming, each
> time breaking anyone who doesn't have his stuff in the mainline yet.
> 
> Sorry, but this is simply annoying, and the whole "the only thing we
> have to do is to define it once and be done then" is crap.
> 
> Robert
