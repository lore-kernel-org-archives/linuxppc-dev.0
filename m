Date: Sat, 4 Nov 2000 07:35:40 -0500
From: Simon Piette <spiette@generation.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: whacked out 2.2.18pre17?
Message-ID: <20001104073540.A23753@xim.dyndns.org>
Reply-To: spiette@generation.net
References: <v04003a00b628feabbda6@[24.70.162.12]> <v04003a00b628feabbda6@[24.70.162.12]> <p04330100b629125ff911@[192.168.0.1]> <v04003a01b629191ff4ae@[24.70.162.12]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <v04003a01b629191ff4ae@[24.70.162.12]>; from nicoya@apia.dhs.org on Fri, Nov 03, 2000 at 08:01:55PM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

* Tony Mantler (nicoya@apia.dhs.org) [001103 21:14]:
>
> At 7:15 PM -0600 11/3/2000, Stefan Jeglinski wrote:
> [...]
> >Well, this is unlike most users of Twin Turbo cards, if the past list
> >traffic is any measure. Interestingly, I have seen comments before
> >that the issue is not the imsttfb driver, but X itself. This would
> >not be inconsistent with your setup, given the debian X. I would love
> >to get the twin turbo working, I have been waiting for X4 to get far
> >enough along, but it appears to still be lacking in even
> >straightforward atyfb support (debugged that is), as per the last I
> >read. Older ATI Rage Pro card(s) are what else I have, but it won't
> >do me any good to get one card working if another that I have breaks.
>
> >From a kterm 5 seconds ago:
>
> merida:~# cat /proc/fb
> 0 IMS TT (IBM)
> merida:~# uname -a
> Linux merida 2.2.17 #8 SMP Sun Oct 29 10:17:32 CST 2000 ppc unknown
> merida:~# dpkg -l xserver-fbdev
> [...]
> ii  xserver-fbdev  3.3.6-11       X server for framebuffer-based graphics driv
> merida:~# fbset -x
>
> Mode "1280x1024"
> 	# D: 135.007 MHz, H: 102.278 kHz, v: 96.126 Hz
> 	DotClock 135.008
> 	HTimings 1280 1296 1304 1320
> 	VTimings 1024 1040 1048 1064
> 	Flags     "+HSync" "+VSync"
> EndMode
>
>
> Of course, the actual dotclock is really only 105.336 MHz (1280x1024x75Hz),
> but the modeline works. 1280x1024x96Hz would be nice, mind you, but I don't
> quite think my monitor could take it. ;)
>

Could you elaborate on that? I have an IMSTT 128 (2Mb VRAM) and I'm
unable to accelerated video on a plain pmac kernel. I am currently stuck
at kernel 2.2.12 because this is the only kernel that will accept a
patch from Ryen Nielsen (http://krazynet.com/~ran/linux/imsttfb.c).
The last pmac I tried is 2.2.16

Here's some info about my system:

$ uname -a
Linux xim.dyndns.org 2.2.12-9a #2 Thu Jul 20 01:34:31 EDT 2000 ppc
unknown
$ cat /proc/cmdline
root=/dev/sdb6 video=imsttfb:vmode:17,cmode:16 idebus=66 hda=noautotune
$ lspci -vv
[snip]
00:0e.0 Display controller: Integrated Micro Solutions Inc. IMS9129 (rev 01)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 8 min, 8 max, 32 set
        Interrupt: pin A routed to IRQ 24
        Region 0: Memory at 82000000
        (32-bit, prefetchable)
[snip]

Simon Piette
--
PGP key ID: 1024D/99290743 	Simon Piette <spiette@generation.net>
PGP Key fingerprint: 9AF9 33F9 A900 E153 9DF3  0625 8928 CB52 9929 0743

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
