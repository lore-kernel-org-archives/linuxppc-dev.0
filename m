Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Brad Sawatzky <brad+linuxppc@lamorak.phys.virginia.edu>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Mach64-GX using fbdev problem
Date: Mon, 3 Feb 2003 14:14:21 -0500
References: <20030203190143.GB20673@lamorak.phys.virginia.edu>
In-Reply-To: <20030203190143.GB20673@lamorak.phys.virginia.edu>
MIME-Version: 1.0
Message-Id: <200302031414.21974.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

One trick,  under MacOSX you can sometimes dump the device tree using the
ioreg command (try  man "ioreg" under MacOSX).

Sometimes in that device tree you can find timing info from an EDID block.
I have code somplace (and so does X11R6 project) that can parse the EDID
info block and get back preferred timing info.

Another place to look for the EDID block is under Linux  in the OF
device-tree

/proc/device-tree/pci@f0000000/ATY,BlueStoneParent/ATY,BlueStone_A/EDID

is an example in mine.

The use hexdump to dump the EDID info and then pass it through an EDID
converter program to interpret it.

Not all EDID blocks are called EDID (some have extra cahrs in the file
name).

Hope something here helps,

Kevin


On February 3, 2003 02:01, Brad Sawatzky wrote:
> Hi all,
>
> If anyone has managed to get this card to work I would appreciate an
> email with the relevant ModeLine and/or kernel arguments.  I would like
> to get this thing to run in at least 800x600x24.  A configuration for
> 1024x768x16 would also be nice.
>
> I have gotten to the stage where I can see a mangled X screen (ie. the
> kind of thing you see when you are using a bogus mode for the monitor).
> I have tried quite few different (stock) resolution/depth combos as well
> as explicitly defining some reasonable looking ModeLines taken from
> successful 'fbset -x' commands.  The monitor (NEC XV17" CRT) works fine
> at all of the refresh rates, geometries and depths under OSX.  (Is there
> a tool comparable to 'fbset -i' in OSX?)  I've also tested with my 21"
> Apple CRT without success so I don't think the problem is monitor
> related.
>
> Some relevant info:
>   Blue&White G3, kernel 2.4.20-ben1
>
>   XFree86 Version 4.2.1.1 (Debian 4.2.1-5 20030121181741
> branden@debian.org)/ X Window System (protocol Version 11, revision 0,
> vendor release 6600)
>   Release Date: 18 October 2002
>
> From lspci:
>   01:03.0 VGA compatible controller: ATI Technologies Inc 210888GX
> [Mach64 GX] (rev 03)
>
> From /proc/fb:
>   0 ATY Rage128
>   1 ATY Mach64
>
> From 'fbset -fb /dev/fb1 -i' (right after a reboot, X hasn't fired up)
> Frame buffer device information:
>     Name        : ATY Mach64
>     Address     : 0x81800000
>     Size        : 1048576
>     Type        : PACKED PIXELS
>     Visual      : PSEUDOCOLOR
>     XPanStep    : 8
>     YPanStep    : 1
>     YWrapStep   : 0
>     LineLength  : 640
>     MMIO Address: 0x817ffc00
>     MMIO Size   : 1024
>     Accelerator : ATI Mach64GX
>
> From XF86Config
> Section "Device"
>         Identifier      "Mach64-GX"
>         Driver          "fbdev"
>         BusID           "PCI:1:3:0"
>         Option          "UseFBDev"              "true"
>         Option          "fbdev"                 "/dev/fb1"
> EndSection


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
