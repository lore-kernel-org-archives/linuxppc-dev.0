Date: Fri, 5 Feb 1999 10:59:32 +1100
Message-Id: <199902042359.KAA10627@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: brad@pht.com
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.LNX.3.95.990204145554.26689A-100000@pacific.pht.com>
	(message from Brad Midgley on Thu, 4 Feb 1999 15:14:30 -0700 (MST))
Subject: Re: rsync kernel is incomplete
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.3.95.990204145554.26689A-100000@pacific.pht.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brad Midgley <brad@pht.com> wrote:

> is there a special keymap or something that i should be using? the 2.2.1
> kernel boots great but now i can't type at the console (the result is
> garbage). it used to be that i could type at the console but typing inside
> X was the only place a problem showed up. now it's both. 

I assume you're talking about the iMac. :-)

The kernel should have the correct keymap in it when it boots (well,
correct for US and Australia anyway :-).  You just need to make sure
the init scripts don't load up a keytable for an ADB keyboard.  One
way to do this is to change the definition of KEYTABLE in
/etc/sysconfig/keyboard to something that doesn't exist, for example,
/usr/lib/kbd/keytables/usb.map.

Assuming you're using the XF68_FBDev from Geert's web page, it should
read the keytable from the kernel on startup, provided you have
XkbDisable in your /etc/XF86Config.

> ps. does everybody use X with 8-bit ofonly? that's the only way i could
> get x on imac to display correctly. 

These days I use video=atyfb:vmode:17 and the XF86Config below and it
works great.  You can even use control command KP+ and control command
KP- to change the screen resolution.

Paul.

# $XFree86: xc/programs/Xserver/hw/xfree86/XF86Conf.cpp,v 3.21 1996/01/31 11:46:37 dawes Exp $
#
# Copyright (c) 1994 by The XFree86 Project, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
# THE XFREE86 PROJECT BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
# OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# 
# Except as contained in this notice, the name of the XFree86 Project shall
# not be used in advertising or otherwise to promote the sale, use or other
# dealings in this Software without prior written authorization from the
# XFree86 Project.
#
# $XConsortium: XF86Conf.cpp /main/16 1996/01/31 10:03:57 kaleb $

# **********************************************************************
# Refer to the XF86Config(4/5) man page for details about the format of 
# this file. This man page is installed as /usr/X11R6/man/man5/XF86Config.5x 
# **********************************************************************

# **********************************************************************
# Files section.  This allows default font and rgb paths to be set
# **********************************************************************

Section "Files"

# The location of the RGB database.  Note, this is the name of the
# file minus the extension (like ".txt" or ".db").  There is normally
# no need to change the default.

    RgbPath	"/usr/X11R6/lib/X11/rgb"

# Multiple FontPath entries are allowed (which are concatenated together),
# as well as specifying multiple comma-separated entries in one FontPath
# command (or a combination of both methods)

    FontPath	"/usr/X11R6/lib/X11/fonts/misc/"
#    FontPath	"/usr/X11R6/lib/X11/fonts/75dpi/:unscaled"
#    FontPath	"/usr/X11R6/lib/X11/fonts/100dpi/:unscaled"
    FontPath	"/usr/X11R6/lib/X11/fonts/Type1/"
    FontPath	"/usr/X11R6/lib/X11/fonts/Speedo/"
    FontPath	"/usr/X11R6/lib/X11/fonts/75dpi/"
    FontPath	"/usr/X11R6/lib/X11/fonts/100dpi/"

EndSection

# **********************************************************************
# Server flags section.
# **********************************************************************

Section "ServerFlags"

# Uncomment this to cause a core dump at the spot where a signal is 
# received.  This may leave the console in an unusable state, but may
# provide a better stack trace in the core dump to aid in debugging

#    NoTrapSignals

# Uncomment this to disable the <Crtl><Alt><BS> server abort sequence
# This allows clients to receive this key event.

#    DontZap

# Uncomment this to disable the <Crtl><Alt><KP_+>/<KP_-> mode switching
# sequences.  This allows clients to receive these key events.

#    DontZoom

# Uncomment this to disable tuning with the xvidtune client. With
# it the client can still run and fetch card and monitor attributes,
# but it will not be allowed to change them. If it tries it will
# receive a protocol error.

#	DisableVidModeExtension

# Uncomment this to enable the use of a non-local xvidtune client.

#	AllowNonLocalXvidtune

EndSection

# **********************************************************************
# Input devices
# **********************************************************************

# **********************************************************************
# Keyboard section
# **********************************************************************

Section "Keyboard"

    Protocol	"Standard"

# when using XQUEUE, comment out the above line, and uncomment the
# following line

#    Protocol	"Xqueue"

    AutoRepeat	500 5

# Let the server do the NumLock processing.  This should only be required
# when using pre-R6 clients
#    ServerNumLock

# Specifiy which keyboard LEDs can be user-controlled (eg, with xset(1))
#    Xleds      1 2 3

# To set the LeftAlt to Meta, RightAlt key to ModeShift, 
# RightCtl key to Compose, and ScrollLock key to ModeLock:

#    LeftAlt     Meta
#    RightAlt    ModeShift
#    RightCtl    Compose
#    ScrollLock  ModeLock

# To disable the XKEYBOARD extension, uncomment XkbDisable.

XkbDisable

# To use the default map in ProjectRoot keymap/xfree86, uncomment 
# XkbKeymap. To use one of the alternate maps in keymap/xfree86 
# uncomment and modify the XkbKeymap line, e.g.: 
#    XkbKeymap   "keymap/xfree86(us_microsoft)"
# To tailor a combination not already in keymap/xfree86 modify
# keymap/xfree86 or uncomment and modify the other lines as 
# desired. One way to get a german layout on a 101 key keyboard 
# is to modify the XkbSymbols line, e.g.:
#    XkbSymbols  "symbols/us(pc101)+de"

#    XkbKeymap   "keymap/xfree86"
#    Xkbkeycodes "keycodes/xfree86"
#    XkbTypes    "types/default"
#    XkbCompat   "compat/default"
#    XkbSymbols  "symbols/us(pc101)"
#    XkbGeometry "geometry/pc"

EndSection


# **********************************************************************
# Pointer section
# **********************************************************************

Section "Pointer"

    Protocol	"busmouse"
    Device	"/dev/usbmouse"

# When using XQUEUE, comment out the above two lines, and uncomment
# the following line.

#    Protocol	"Xqueue"

# Baudrate and SampleRate are only for some Logitech mice

#    BaudRate	9600
#    SampleRate	150

# Emulate3Buttons is an option for 2-button Microsoft mice
# Emulate3Timeout is the timeout in milliseconds (default is 50ms)

#    Emulate3Buttons
#    Emulate3Timeout	50

# ChordMiddle is an option for some 3-button Logitech mice

#    ChordMiddle

EndSection


# **********************************************************************
# Xinput section -- this is optional and is required only if you
# are using extended input devices.  This is for example only.  Refer
# to the XF86Config man page for a description of the options.
# **********************************************************************
#
# Section "Xinput"
#    SubSection "WacomStylus"
#        Port "/dev/ttyS1"
#        DeviceName "Wacom"
#    EndSubSection
#    SubSection "WacomCursor"
#    EndSubSection
#    SubSection "WacomEraser"
#    EndSubSection
#
#    SubSection "Elographics"
#        Port "/dev/ttyS1"
#        DeviceName "Elo"
#        MinimumXPosition 300
#        MaximumXPosition 3500
#        MinimumYPosition 300
#        MaximumYPosition 3500
#        Screen 0
#        UntouchDelay 10
#        ReportDelay 10
#    EndSubSection
#   
#    SubSection "Joystick"
#        Port "/dev/joy0"
#        DeviceName "Joystick"
#        TimeOut 10
#        MinimumXPosition 100
#        MaximumXPosition 1300
#        MinimumYPosition 100
#        MaximumYPosition 1100
#        # CenterX 700
#        # CenterY 600
#        Delta 20
#    EndSubSection
# EndSection


# **********************************************************************
# Monitor section
# **********************************************************************

# Any number of monitor sections may be present

Section "Monitor"

    Identifier	"Nokia447Xi"
    VendorName	"Nokia"
    ModelName	"Multigraph 447Xi"

# HorizSync is in kHz unless units are specified.
# HorizSync may be a comma separated list of discrete values, or a
# comma separated list of ranges of values.
# NOTE: THE VALUES HERE ARE EXAMPLES ONLY.  REFER TO YOUR MONITOR'S
# USER MANUAL FOR THE CORRECT NUMBERS.

#    HorizSync   31.5  # typical for a single frequency fixed-sync monitor

#    HorizSync	15-40         # multisync
#    HorizSync	30-64         # multisync
#    HorizSync	31.5, 35.2    # multiple fixed sync frequencies
#    HorizSync	15-25, 30-50  # multiple ranges of sync frequencies

    HorizSync	31-92

# VertRefresh is in Hz unless units are specified.
# VertRefresh may be a comma separated list of discrete values, or a
# comma separated list of ranges of values.
# NOTE: THE VALUES HERE ARE EXAMPLES ONLY.  REFER TO YOUR MONITOR'S
# USER MANUAL FOR THE CORRECT NUMBERS.

#    VertRefresh 60  # typical for a single frequency fixed-sync monitor

#    VertRefresh	50-100        # multisync
#    VertRefresh	60, 65        # multiple fixed sync frequencies
#    VertRefresh	40-50, 80-100 # multiple ranges of sync frequencies

    VertRefresh	50-100

# Modes can be specified in two formats.  A compact one-line format, or
# a multi-line format.

# A generic VGA 640x480 mode (hsync = 31.5kHz, refresh = 60Hz)
# These two are equivalent

#    ModeLine "640x480" 25.175 640 664 760 800 480 491 493 525

    Mode "640x480"
        DotClock	25.175
        HTimings	640 664 760 800
        VTimings	480 491 493 525
    EndMode

# These two are equivalent

#    ModeLine "1024x768i" 45 1024 1048 1208 1264 768 776 784 817 Interlace

    Mode "1024x768i"
        DotClock	45
        HTimings	1024 1048 1208 1264
        VTimings	768 776 784 817
        Flags		"Interlace"
    EndMode

ModeLine "640x480" 30.438 640 704 768 832 480 512 514 546 -HSync -VSync -CSync
ModeLine "800x600" 49.553 800 864 928 992 600 632 634 666 -HSync -VSync -CSync
ModeLine "832x624" 52.995 832 896 960 1024 624 656 658 690 -HSync -VSync -CSync
ModeLine "1024x768" 76.064 1024 1088 1152 1216 768 800 802 834 -HSync -VSync -CSync
ModeLine "1152x870" 94.358 1152 1216 1280 1344 870 902 904 936 -HSync -VSync -CSync

EndSection

Section "Monitor"

    Identifier	"iMac monitor"
    VendorName	"Apple Computer"
    ModelName	"iMac"

# HorizSync is in kHz unless units are specified.
# HorizSync may be a comma separated list of discrete values, or a
# comma separated list of ranges of values.

    HorizSync	58-62

# VertRefresh is in Hz unless units are specified.
# VertRefresh may be a comma separated list of discrete values, or a
# comma separated list of ranges of values.

    VertRefresh	50-130

# Modes can be specified in two formats.  A compact one-line format, or
# a multi-line format.

Mode "1024x768"
    # D: 78.524 MHz, H: 59.850 kHz, V: 74.813 Hz
    DotClock 78.525
    HTimings 1024 1049 1145 1312
    VTimings 768 769 772 800
    Flags    "+HSync" "+VSync"
EndMode

Mode "800x600"
    # D: 62.356 MHz, H: 59.958 kHz, V: 94.869 Hz
    DotClock 62.357
    HTimings 800 821 901 1040
    VTimings 600 601 604 632
    Flags    "+HSync" "+VSync"
EndMode

Mode "640x480"
    # D: 49.885 MHz, H: 59.958 kHz, V: 116.650 Hz
    DotClock 49.886
    HTimings 640 661 725 832
    VTimings 480 481 484 514
    Flags    "+HSync" "+VSync"
EndMode

EndSection

# **********************************************************************
# Graphics device section
# **********************************************************************

# Any number of graphics device sections may be present

Section "Device"
    Identifier	"Generic VGA"
    VendorName	"Unknown"
    BoardName	"Unknown"
    Chipset	"generic"
#    VideoRam	256
#    Clocks	25.2 28.3
EndSection

Section "Device"
    # SVGA server auto-detected chipset
    Identifier	"Generic SVGA"
    VendorName	"Unknown"
    BoardName	"Unknown"
EndSection

# Section "Device"
#    Identifier	"Any Trident TVGA 9000"
#    VendorName	"Trident"
#    BoardName	"TVGA 9000"
#    Chipset	"tvga9000"
#    VideoRam	512
#    Clocks	25 28 45 36 57 65 50 40 25 28 0 45 72 77 80 75
# EndSection

# Section "Device"
#    Identifier	"Actix GE32+ 2MB"
#    VendorName	"Actix"
#    BoardName	"GE32+"
#    Ramdac	"ATT20C490"
#    Dacspeed	110
#    Option	"dac_8_bit"
#    Clocks	 25.0  28.0  40.0   0.0  50.0  77.0  36.0  45.0
#    Clocks	130.0 120.0  80.0  31.0 110.0  65.0  75.0  94.0
# EndSection

# Section "Device"
#    Identifier	"Hercules mono"
# EndSection

# **********************************************************************
# Screen sections
# **********************************************************************

# The colour SVGA server

Section "Screen"
    Driver	"svga"
    Device	"Generic SVGA"
    Monitor	"Nokia447Xi"
    Subsection "Display"
        Depth	    8
        Modes	    "640x480"
        ViewPort    0 0
        Virtual     800 600
    EndSubsection
EndSection

# The 16-colour VGA server

Section "Screen"
    Driver	"vga16"
    Device	"Generic VGA"
    Monitor	"Nokia447Xi"
    Subsection "Display"
        Modes	    "640x480"
        ViewPort    0 0
        Virtual     800 600
    EndSubsection
EndSection

# The Mono server

Section "Screen"
    Driver	"vga2"
    Device	"Generic VGA"
    Monitor	"Nokia447Xi"
    Subsection "Display"
        Modes	    "640x480"
        ViewPort    0 0
        Virtual     800 600
    EndSubsection
EndSection

# The hercules driver in the Mono and VGA16 servers
#
# Section "Screen"
#     Driver	"mono"
#     Device	"Hercules Mono"
#     Monitor	"Generic Monitor"
#     Subsection "Display"
#     EndSubsection
# EndSection

# The accelerated servers (S3, Mach32, Mach8, 8514, P9000, AGX, W32)

# Section "Screen"
#     Driver	"accel"
#     Device	"Actix GE32+ 2MB"
#     Monitor	"Generic Monitor"
#     Subsection  "Display"
#         Depth	    8
#         Modes	    "640x480"
#         ViewPort    0 0
#         Virtual	    1280 1024
#     EndSubsection
#     SubSection "Display"
#         Depth	    16
#         Weight	    565
#         Modes	    "640x480"
#         ViewPort    0 0
#         Virtual	    1024 768
#     EndSubsection
# EndSection


# **********************************************************************
# Server for the Linux Frame Buffer Device
# **********************************************************************

Section "Device"
    Identifier "Linux Frame Buffer Device"
EndSection

Section "Screen"
    Driver	"fbdev"
    Device	"Linux Frame Buffer Device"
    Monitor	"iMac monitor"
    DefaultColorDepth	8
#    SubSection "Display"
#        Modes       "default"
#    EndSubsection
    SubSection "Display"
        Depth	    8
        Modes	    "1024x768" "800x600" "640x480"
        Virtual	    1024 768
    EndSubSection
    SubSection "Display"
        Depth	    16
        Modes	    "1024x768" "800x600" "640x480"
        Virtual	    1024 768
    EndSubSection
    SubSection "Display"
        Depth	    24
        Modes	    "1024x768" "800x600" "640x480"
        Virtual	    1024 768
    EndSubSection
    SubSection "Display"
        Depth	    32
        Modes	    "1024x768" "800x600" "640x480"
        Virtual	    1024 768
    EndSubSection
EndSection

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
