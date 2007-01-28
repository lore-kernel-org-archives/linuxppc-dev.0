Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6CC36DE1F2
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 08:39:35 +1100 (EST)
Subject: Re: [PATCH 1/9] ps3: AV Settings Driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0701261535180.30062@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701251846460.24610@pademelon.sonytel.be>
	<200701260513.24010.arnd@arndb.de>
	<Pine.LNX.4.62.0701261535180.30062@pademelon.sonytel.be>
Content-Type: text/plain
Date: Mon, 29 Jan 2007 08:37:00 +1100
Message-Id: <1170020220.26655.35.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	James Simmons <jsimmons@infradead.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Analog YUV (Component and composite/S-video) video timings are dictated by
> broadcast standards.
> 
> The last 3 resolutions are supported through the HDMI output only. Hence if
> your TV has HDMI or DVI-D (_with_ HDCP, else you get a black screen) inputs,
> you can use 1280x768.
> 
> If your TV doesn't have HDMI or DVI-D with HDCP, but it has component inputs,
> you can use analog 720p.

Please, still try to get the HV folks to add more VESA modes for use by
linux :-) 1600x1200 would be nice for example, as would 1440x900 (lots
of cheap flat panels do that nowadays.... they can demote to 720p which
is good enough for games, but for linux, we want native resolution).

> Reducing these values may cause video noise to be seen when changing video
> modes.

So the whole thing should be turned into a state machine on a timer or a
kthread no ? So at least, whatever issues the mode change can start
drawing while the kernel waits to actually enable the outputs...

Ben.
