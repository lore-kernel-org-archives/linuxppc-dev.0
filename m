Mime-Version: 1.0
Message-Id: <p04330101b629db91dabb@[192.168.0.1]>
In-Reply-To: <19340929061924.29978@192.168.1.10>
References: <p04330100b629527c3036@[192.168.0.1]>
 <19340929061924.29978@192.168.1.10>
Date: Sat, 4 Nov 2000 10:55:17 -0500
To: Benjamin Herrenschmidt <bh40@calva.net>
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: whacked out 2.2.18pre17?
Cc: <linuxppc-dev@lists.linuxppc.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  >The two things that are constant on my hardware (PowerTowerPro +
>>PowerLogix G3, 6 PCI cards, most of which are not seen anyway,
>>2940UW):
>>
>>1. Full boot is impossible, always with one of the following circumstances:
>>	a) freeze at "booting..."
>>	b) can't find MAC address for MACE device -> kernel panic
>>	c) "machine check in kernel mode" -> "unknown values in srr1" ->
>>		kernel panic
>
>That's weird. The symptoms you describe are typicall of a kernel beeing
>damaged by bus-mastering devices (your 6 PCI cards frighten me ...).


Me too :-) FWIW, here they are in order from top to bottom:

Adaptec 2940UW
Farallon ethernet 10/100
OrangeLink firewire/usb combo
Matrox Mystique card
ixMicro TV card
ixMicro Twin Turbo card

lspci gives (only):

00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
00:0d.0 SCSI storage controller: Adaptec AIC-7881U
00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip
21142/43 (rev 41)
00:0f.0 PCI bridge: Action Tec Electronics Inc: Unknown device 0100 (rev 11)
00:10.0 Class ff00: Apple Computer Inc. Grand Central I/O (rev 02)
01:0c.0 FireWire (IEEE 1394): NEC Corporation: Unknown device 00cd (rev 01)
01:0d.0 USB Controller: OPTi Inc. 82C861 (rev 10)


I had a long go-round with Tom Rini looking at this, because I was
wanting to try XF4 and run dual monitors, just like I do on the Mac
side. My understanding from discussing it with him is that it's
pretty much hopeless because of the current kernel's inability to
detangle (my unofficial word for it) all the pci issues. I believe he
said maybe in late 2.4 or 2.5 I'd get some help. I really really hope
by that time that machines like mine haven't been orphaned because of
a lack of resources and the prevalence of newworld machines.


>But in this case, 2.2.17 should have the same problems.

I finally located a pristine 2.2.17-linux-pmac-stable on a 6500 I
have. I'm going to retry that, although the 2.2.17 I've been using on
the PowerTower so far was rsynced to the same source. I haven't tried
the bk 2_2 in a while... Someone please verify, the 2 sources of
Paul's linux-pmac-stable are penguinppc.org and ppc.linuxcare.com,
correct? AFAICT, these are -not- generally the same code (although
close), which means I need to always try both?


>No explanation come to my mind. Did you try removing some PCI cards to
>see if one could be the cause of the problem ? I don't see any of the
>2.2.18 change that could explain your problem.

Not yet. I am really loathe to do that, but will if I must.

Speculation:

lspci does see the USB side of my OrangeLink card. My real goal in
starting all this to begin with is to try to get a Logitech USB mouse
working, for which I have to turn on a lot of USB stuff in the
kernel. So far I have tried building the 2.2.18 kernel -without- USB,
just to make sure it works (which is where I am right now). Is it
possible that with 2.2.18 and the USB card, I -must- turn on USB in
the kernel config?

This still wouldn't explain the symptom of the BootX video switch
being ignored. That's sure a weird one, but I've tried so many
different things I'm convinced it's real.

Here's hoping this can be solved. I'll try whatever is necessary,
although the PTP is my workhorse and Linux still has to take a back
seat (I'm trying to change that). From time to time things like this
have cropped up, and I always fear it's the end of the line for Linux
on my hardware. I guess that comes from being beaten up by Apple so
many times :-)


Stefan Jeglinski


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
