Date: Sun, 22 Feb 2004 12:18:47 +0100
From: Costantino Pistagna <cpistagna@vrlteam.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: ibook G4 Status Report
Message-ID: <20040222111847.GX2289@adapter.n0skillz.org>
Reply-To: cpistagna@vrlteam.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thu 12 Feb 2004, Benjamin Herrenschmidt wrote:

> Ok, you need to use XFree without UseFBDev. This cause some flicker on
> your LCD, and then run the enclosed hack which should fix the flicker. Let
> me know if that helps. XFree without UseFBDev will also screw up switching
> back to console unfortunately, I have a hack for that (remove all the vgaXXX
>calls in XFree) locally.

First of all sorry for my lag, i was out for work last two weeks.

I've tried your lcd_hack patch with no FBDev option in XFree,
now the lcd is not flickering anymore;  i've used the OUTPLL(3,0xc)
workaround, because without it the hack is useless.

Now the second screen switch in clone-mode without any problem. The only
trouble is that the output resolution is the same of the embedded lcd,
so the max res that i can use is 1024x768; no matter about the paramters
specified in XF86Config. If it's usefull, i've patched my OF to unlock
the video resolutions as described in some howtos on the net.

Another issue is about the on-the-fly resolution switch: if during the X session
i switch to another resolution the LCD screen start to flickering again; i've to
rerun the lcd_hack to stop the problem.

follow some scratch of my XF86Config:

Section "Device"
    Identifier  "Radeon-1"
    Driver      "radeon"
    ChipID      0x514d
    BusID       "PCI:0:16:0"
    Option      "SWcursor"      "true"
    Option      "AGPMode"       "4"
    Option      "EnablePageFlip"        "On"
    Screen      0
EndSection

Section "Device"
    Identifier  "Radeon-2"
    Driver      "radeon"
    ChipID      0x514d
    BusID       "PCI:0:16:0"
    Option      "SWcursor"      "true"
    Option      "AGPMode"       "4"
    Option      "EnablePageFlip"        "On"
    Screen      1
EndSection


Section "Screen"
    Identifier  "Screen 1"
    Device      "Radeon-1"
    Monitor     "aoc"
    DefaultDepth 16
    Subsection "Display"
	Depth       16
	Modes       "1024x768"
	ViewPort    0 0
    EndSubsection
EndSection

Section "Screen"
    Identifier  "Screen 2"
    Device      "Radeon-2"
    Monitor     "aoc"
    DefaultDepth 16
    Subsection "Display"
	Depth       16
	Modes       "1280x1024"
	ViewPort    0 0
    EndSubsection
EndSection

Section "ServerLayout"
    Screen "Screen 1"

    # Screen "Screen 2"
End Section


if you've readed carefully above, i've to disable the second screen in
ServerLayout; if i turn it on the system start with an 8bits ColorDepth.
I've no idea about this...maybe i've done some mistake.

finally, i'm using a 2.6.1-ben1 with no additional patch or workaround.

i've not tried your suggested hack for the turn back to console problem.
next week i'll find a couple of minutes to patch X and i'll write a
report onto this list.

cheers,
--
(v^v) ? spj:fnml:vrl;
keyID = 0x1D67B4DD;

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
