Date: Wed, 27 Sep 2000 19:42:34 +0200
From: Olaf Hering <olh@suse.de>
To: "Jon Erick Ween" <jween@som.llu.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Xfree86-4.0.1, Lombard, Mach64 driver, X-server Crash
Message-ID: <20000927194234.A2778@suse.de>
References: <B5F77AFE.62A%jween@som.llu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B5F77AFE.62A%jween@som.llu.edu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Sep 27, Jon Erick Ween wrote:

> OK, I've switched from BootX to Yboot using a stable 2.2.17 kernel and the
> most recent XF86-4.0.1 and ati driver sources I can find. I seem to get
> different PCI assignments to the ATI chip on boot-up (looking at dmesg
> compared with using BootX) but the X-server still doesn't detect the chip
> with "startx" or "XFree86" and exits with a "device not found" and "no
> screens" error. Any further suggestions?

There is a Modes line in the screen section, use a generic mode.
Don't specify a Modes section.

It could look like that:

Section "Screen"
  DefaultDepth  24
  SubSection "Display"
    Depth       24
    Modes       "1024x768"
  EndSubSection
  Device        "Device[0]"
  Identifier    "Screen[0]"
  Monitor       "Monitor[0]"
EndSection
Section "Device"
  BoardName     "mycard"
  BusID         "0:16:0"
  Driver        "ati"
  Identifier    "Device[0]"
  Option        "sw_cursor"
  VendorName    "ATI"
EndSection


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
