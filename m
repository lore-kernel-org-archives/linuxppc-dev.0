Date: Tue, 26 Feb 2002 01:16:27 -0800 (PST)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: nvidiatest@yellowdoglinux.com, <linuxppc-dev@lists.linuxppc.org>,
	<debian-powerpc@lists.debian.org>,
	<yellowdog-general@lists.yellowdoglinux.com>,
	<yellowdog-devel@lists.yellowdoglinux.com>
Subject: nVidia ppc X and kernel support test binaries
Message-ID: <Pine.BSF.4.44.0202260107430.34176-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Below you will find test binaries for nVidia PowerPC Linux support.  If
the files are not present in the directory, please try again later as it
may take some time for them to propogate throughout the mirrors.

Test kernel:
	ftp://ftp.yellowdoglinux.com/pub/yellowdog/users/ajoshi/vmlinux-nv.gz

This kernel uses the rivafb framebuffer driver and should auto-detect flat
panel displays and default to the proper panel resolution.  On CRT
monitors it will default to 640x480 8bp 60 Hz.  To set different startup
resolution for CRT monitors use the following example kernel argument:
"video=riva:1024x768-8@60"  which will bring up a console in 1024x768 8bpp
at 60 Hz.

Test XFree86 4.2.0 driver:
	ftp://ftp.yellowdoglinux.com/pub/yellowdog/users/ajoshi/nv_drv.o.gz

Place the unzipped file in your /usr/X11R6/lib/modules/drivers directory
and in your /etc/X11/XF86Config-4 file you should have a similar
device section:

Section "Device"
        Identifier      "Card0"
#       Driver  "fbdev"
        Driver  "nv"
        Option  "FlatPanel"
        BusID   "PCI:0:16:0"
EndSection

For flat panel users, you *must* use the Option "FlatPanel".  If you wish
to use unaccelerated X, you can use the Driver "fbdev" instead of "nv",
and you can also remove the "FlatPanel" option.

Note, you must boot with the flat panel display if you wish to use the
display in X.  In other words, do not boot with a CRT monitor and then
plug in a flat panel and start X, it will not work.

If you are using the "nv" driver, you must use offb kernel driver and NOT
rivafb.  At the moment these two do not interact well with eachother, so
don't attempt it.

The hardware scaler does not work, so for flat panel displays I suggest
you do the following to figure out your "native" mode.  Boot the vmliux-nv
kernel and do "fbset -x", for example:

bash-2.04# /usr/sbin/fbset -x

Mode "1024x768"
    # D: 65.003 MHz, H: 48.365 kHz, V: 60.006 Hz
    DotClock 65.004
    HTimings 1024 1048 1184 1344
    VTimings 768 771 777 806
    Flags    "-HSync" "-VSync"
EndMode

Add this mode to your /etc/X11/XF86Config-4 file in your "Monitor" section
and use only this mode.  This is an *example* only, do not expect this
mode to work with every flat panel.


What works:
* Accelerated (driver "nv") and unaccelerated (driver "fbdev") X in
  all depths on CRT monitors and flat panel displays
* Text console in all depths

What doesnt:
* Text console acceleration, will be added soon
* If you use the "nv" driver and quit X, restarting X will cause a machine
  hardlock, this is a known issue
* "nv" driver with rivafb as the console driver
* Mozilla apparently causes random X server lockups with the "nv" driver
* video overlay in "nv" driver
* hw scaler, flat panels must use their "native" resolutions only,
  nothing smaller

Please send feedback to me and/or nvidiatest@yellowdoglinux.com, as I do
not subscribe to many of the other mailing lists.


ani

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
