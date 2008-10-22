Return-Path: <neko@genesi-usa.com>
Received: from mail-gx0-f14.google.com (mail-gx0-f14.google.com
	[209.85.217.14]) by ozlabs.org (Postfix) with ESMTP id 93245474C1
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 06:09:10 +1100 (EST)
Received: by gxk7 with SMTP id 7so4422gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 12:09:06 -0700 (PDT)
Message-ID: <48FF7A4D.4000506@genesi-usa.com>
Date: Wed, 22 Oct 2008 14:09:01 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] powerpc: Remove device_type = "rtc" properties in .dts
	files
References: <20081021185844.GA31070@oksana.dev.rtsoft.ru>
	<48FF2CBB.7060605@genesi-usa.com>
	<20081022135046.GA30347@oksana.dev.rtsoft.ru>
	<48FF73B2.8040600@genesi-usa.com>
	<20081022185913.GA1828@oksana.dev.rtsoft.ru>
In-Reply-To: <20081022185913.GA1828@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=windows-1251; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Anton Vorontsov wrote:
> On Wed, Oct 22, 2008 at 01:40:50PM -0500, Matt Sealey wrote:
> 
> I think I got it. ;-) You think that I'm not aware of that we _can_
> use the device_type for matching the nodes. Well, I'm aware of it,
> sure we can. ;-)

I'm sure you are aware, I am just a little jumpy regarding 
this as the whole ePAPR-is-official thing and the direction 
Linux is taking with regards to redefining part of the device 
tree specs, that this could have been something a little more 
serious :)

> But we don't use it for the rtc nodes, and we don't want to encourage
> the usage for the flat trees. And that's the point of this patch.

Would it not be prudent to, while not actively encouraging it, 
at least mention device_type in any specifications as a legacy 
item (for real Open Firmware only) and for if a device should 
be in the tree as a generic, IEEE 1275-style device (i.e. 
there would be a set of well-defined client interface methods 
for it in a real OF)?

My basic concerns are for input/output as reported by /chosen 
- in case it is important exactly what is being used, there is 
at least one out-of-driver code snippet which checks if stdin 
and stdout are of type "serial" (or "failsafe") and 
auto-directs console to that - it would be nice to keep this 
clean and not dump a million serial-device-compatibles in 
another list here if someone wants to automatically choose 
between console output on the DIU or PSC for MPC5121e/MPC8610 
for example, or wants to restrict the amount of fancy stuff it 
does on a terminal if it's a slow serial device, or perhaps 
even automatically invoke netconsole if it's set to "network"?

I know U-Boot doesn't have the intelligence to output to 
anything but a serial port these days on those devices, but as 
they say, there is no fate but what we make .. we should make 
sure it doesn't turn up that code is never suggested or 
attempted because supporting it in Linux would be too big a 
jump or too messy a patch :)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
