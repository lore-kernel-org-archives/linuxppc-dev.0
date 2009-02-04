Return-Path: <mike_timmons@trimble.com>
Received: from snvl-smtp1.trimble.com (snvl-smtp1.trimble.com [155.63.64.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "snvl-smtp1.trimble.com", Issuer "Trimble CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 03D04DDDF0
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 03:45:47 +1100 (EST)
Message-ID: <4989C635.1050605@trimble.com>
Date: Wed, 04 Feb 2009 10:45:41 -0600
From: Mike Timmons <mike_timmons@trimble.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: kernel 2.6.24 USB wi fi device firmware loading issue(s): rt73.bin...
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Reply-To: mike_timmons@trimble.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I received great help last week in getting a USB wi fi device working. 
Thanks again, but can someone read below and advise me on kernel 2.6.24? 
The best out-of-the box solution for me was 2.6.27.8, for which I needed 
a Denx eldx toolchain in place of the toolchain I was using to compile 
2.6.24. The significance of all this is that I did get  USB wi fi 
working, but...

I'm not in a position to upgrade from 2.6.24 at this time. I need to get 
the USB wi wi (Linksys WUSB54GC) working under 2.6.24.

After success with linking firmware with the 2.6.27.8 kernel, 2.6.24 I 
keep hitting this error when loading from user space (I don't appear to 
have the, "link with kernel" option with 2.6.24)...

sh-2.05b# ifconfig wlan0 up
[  764.744354] phy0 -> rt2x00lib_request_firmware: Info - Loading 
firmware file 'rt73.bin'.

After a considerable delay I get an error that indicates the file can't 
be found.

I have spent many, many hours following leads (and links) this group has 
directed me to. Thanks again. I'm either missing a very simple step or 
indeed support under 6.2.24 is not good. Please advise. I've done the 
following...

1)placed rt73.bin in various locations (/lib/firmware, 
lib/firmware/'uname -a', and the location specified by my 
/etc/hotplug/firmware.agent), according to tips on some threads I've read.

None of this appears to make a difference.

2) I'm a bit confused by the hotplug dependancy, although I do have 
hotplug enabled. "hotplug" makes me think I should be configuring some 
script to load the firmware upon device insertion, but, "ifconfig wlan0 
up" appears to want to load the firmware anyway so I'm guessing if I 
just get rt73.bin installed correctly it should work.

Comparing my working 2.6.27.8 to 2.6.24 in the areas of, "firmware" and 
the ralink rt2x00 drivers reveals MANY changes, no doubt for the better.

QUESTIONS:
1) Am I missing something VERY simple on this firmware loading topic 
that should make this work under 2.6.24, or am I bumping into the reason 
so much of this code has changed between 2.6.24 and 2.6.27.8?
-linking firmware with the lernel at compile time is a nice, obvious 
method offered by the later kernel. I'm confused by the userspace method 
and I think this is where my problem lay.

2) am I correctly, "installing" the firmware just by placing rt73.bin in 
the correct location in my filesystem, or is there some other magic 
required before, "request_firmware()" will work?

Just when I thought I understood some of the kernel I hit a new topic: 
firmware loading! Any help much appreciated...

-Mike
