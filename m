Return-Path: <linuxuser330250@gmx.net>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by ozlabs.org (Postfix) with SMTP id 52268B7235
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 24 Feb 2011 04:56:39 +1100 (EST)
From: "Linux User #330250" <linuxuser330250@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Add support for PowerMac3,5 in snd-aoa ALSA sound module
Date: Wed, 23 Feb 2011 18:56:22 +0100
References: <201102202238.28517.linuxuser330250@gmx.net>
	<s5hd3mlbx6x.wl%tiwai@suse.de> <1298326851.8833.75.camel@pasglop>
In-Reply-To: <1298326851.8833.75.camel@pasglop>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201102231856.23117.linuxuser330250@gmx.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

----------  Original message  ----------
Subject: Re: [PATCH] Add support for PowerMac3,5 in snd-aoa ALSA sound module
Date:    Montag, 21. Februar 2011N
From:    Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:      Takashi Iwai <tiwai@suse.de>

> So somebody else can just pick the "documentation" that layout ID 21
> works just like 22 for us, and write an "acceptable" patch... 

Actually, the G4 "Quicksilver" PowerMac3,5 is propably more alike to the G4 
"Digital Audio" PowerMac3,4 in this regard. The device ID on the Digital Audio 
is decimal 14. The Quicksilver is decimal 21.

PowerMac3,4 Digital Audio: Device ID 14, ??? chip
PowerMac3,5 Quicksilver: Device ID 21, TAS 3001C CODEC chip
PowerMac3,6 Mirrored Drive Doors: Device ID 22, TAS3004 CODEC chip

$LINUX/sound/aoa/codecs/tas.c driver was originally made for the TAS3004, 
which I figure because only "tas 3004" is mentioned in the source, no other.

Since the Quicksilver, which is newer than the Digital Audio, doesn't have the 
TAS3004 chip (Mac OS X System Profiler states "Texas Intruments TAS3001C"), but 
the Digital Audio seemed to work fine with the aoa-tas codec too (it's already 
in the kernel) I tried it with the Quicksilver as well.

The modules loads without errors, the sound card is listed 
(/proc/asound/cards) and the volume controls are usable.

I played some sound and everything seemed to work fine. So I submitted the 
patch.


So now I have to appologize. And I'm glad the patch hasn't been accepted. Why?
Because I had booted with the wrong kernel when I tested if the sound played 
okay. I must have still used the powermac sound module, not aoa.


BIG APPOLOGIES.


I tested again yesterday and today and can't get it to play a sound. I also 
checked the logs and all the ALSA stuff (in /proc/asound). Everything seems 
okay. I then tried a different mixer: pavucontrol -- because I have trouble to 
unmute without this on my PC too.

Now the surprise: it won't let me unmute.
Maybe it's just my system. I use Gentoo Linux and just recently updated the 
whole system to use Pulse Audio.


If anyone else could try the patch or write a new one on their G4 Quicksilvers 
I'd be happy.

And: I do understand the sign-off limiting to real names. It's a good thing.


Cheers,
Andreas  aka  Mac User #330250
