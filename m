Date: Sun, 9 Feb 2003 23:26:33 +0000
From: Magnus Damm <damm@opensource.se>
To: linuxppc-dev@lists.linuxppc.org
Subject: aty128fb and EDID
Message-Id: <20030209232633.414c0fc0.damm@opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

I recently bought a Cube G4 and got a 17" Apple Studio Display (CRT, ADC) with
it. However, that combination seems hard to use out of the box if you want to
use something else than the open firmware framebuffer.

The thing is that the monitor only supports two modes:
1600x1200 64Hz
1280x1024 75Hz

This gives me no picture at all when I try to use the aty128 driver.

However, when I hardcode this video mode as default things work out ok:
/* default modedb mode */
/* 1600x1200, 64Hz, Non-Interlaced */
static struct fb_videomode defaultmode __initdata = {
        refresh:        64,
        xres:           1600,
        yres:           1200,
        pixclock:       5952,
        left_margin:    304,
        right_margin:   24,
        upper_margin:   38,
        lower_margin:   1,
        hsync_len:      184,
        vsync_len:      3,
        sync:           3,
        vmode:          FB_VMODE_NONINTERLACED
};

The information above was built from my EDID file.

To create some kind of generic solution I need to add EDID support to
the aty128 driver, or even better - a generic framebuffer layer.

My question to you is:
All probing that is done by checking if "machine_is_compatible()", could
that all be replaced by EDID code?

If you could send me your EDID files with together with information about your
machine and monitor I would be really happy. Then I could parse them and
see if they contain enough information. If you don't find any EDID file then
I would be glad to know that too.

These machines are extra interesting:
* PowerMac2,1 first r128 iMacs
* PowerMac2,2 summer 2000 iMacs
* PowerMac4,1 january 2001 iMacs "flower power"
* iBook SE
* PowerBook Firewire (Pismo), iBook Dual USB
* PowerBook Titanium

I find my EDID file in /proc/device-tree/pci/ATY,Rage128Pd@10/EDID

Thanks.

/ magnus

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
