Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <46FBE6FD.3030605@am.sony.com>
Date: Thu, 27 Sep 2007 10:23:09 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [Cbe-oss-dev] [patch 0/8] PS3 AV Settings Driver patches for
	2.6.24
References: <20070926163308.772580000@pademelon.sonytel.be>
	<1190860285.6502.6.camel@concordia>
In-Reply-To: <1190860285.6502.6.camel@concordia>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net,
	cbe-oss-dev@ozlabs.org, "Antonino A. Daplas" <adaplas@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> On Wed, 2007-09-26 at 18:33 +0200, Geert Uytterhoeven wrote:
>> 	Hi,
>> 
>> Here are some new patches for the PS3 AV Settings Driver (ps3av), which is
>> used in close collaboration with the PS3 Virtual Frame Buffer Device Driver
>> (ps3fb):
>>   [1] ps3av: eliminate unneeded temporary variables
>>   [2] ps3av: eliminate PS3AV_DEBUG
>>   [3] ps3av: use PS3 video mode ids in autodetect code
>>   [4] ps3av: treat DVI-D like HDMI in autodetect
>>   [5] ps3av: add autodetection for VESA modes
>>   [6] ps3av: add quirk database for broken monitors
>>   [7] ps3av: remove unused ps3av_set_mode()
>>   [8] ps3av: don't distinguish between `boot' and `non-boot' autodetection
>> 
>> Please review, and queue for 2.6.24 if they're ok. Thanks!
>> 
>> Question: As several DVI-D displays advertise they support 1080i modes while
>> they actually don't (cfr. the quirk database), perhaps I should drop 1080i
>> modes completely from the ps3av_preferred_modes[] table? Usually 720p looks
>> better than 1080i anyway.  What do you think?
> 
> Definitely. If the autodetection fails Linux is basically unusable on
> PS3 unless you hack the kernel sources and build your own kboot and
> otheros.bld - not entirely trivial for novice users. So it's pretty
> important that it works 100%.

It is not that bad.  If a bootloader is configued to use autodetection
so that it is shown at best video mode, then it should have advertised
key sequences to default to known video modes, with at least a 480p 'safe'
mode.

Second stage kerenls can be booted with a videomode appended on the
command line, and all kboot.conf's should have a 480p 'safe' mode
entry.

-Geoff
