Date: Wed, 31 Jan 2001 16:26:41 -0600
From: T E Whalen <tew@debian.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: SMP G4, BK 2.4.1, aty128, and 22" Apple Cinema Display (ADC)
Message-ID: <20010131162641.A11495@troy.psych.nwu.edu>
Reply-To: tew@introvert.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm running Debian (testing) on the above configuration.  I'm trying to
get XFree 4.0.2 to work.  Right now, I can boot with the "novideo"
option, and XFree 3.3.6 will work in 1600x1200@8bpp.

With the BK kernel sources I rsync'd and compiled today (2.4.1), I
tried various "aty128fb" kernel options, and none of them displayed
properly.  Relevant lines from yaboot.conf (neither 'append' line
works):

> image=hd:11,/vmlinux
>  label=Linux-test
>  root=/dev/hda11
>  read-only
>  append="video=aty128fb:vmode:22"
>  #append="video=aty128fb:"

I'll see the BootX text flash by, then the screen will immediately turn
black.  No penguins.

/proc/fb says:
0 OFfb /pci@f0000000/ATY,Rage128Pd@10

/proc/pci says [in part]:
PCI devices found:
  Bus  0, device  11, function  0:
    Host bridge: PCI device 106b:0020 (Apple Computer Inc.) (rev 0).
      Master Capable.  Latency=16.
  Bus  0, device  16, function  0:
    VGA compatible controller: ATI Technologies Inc Rage 128 PF (rev 0).
      IRQ 48.
      Master Capable.  Latency=255.  Min Gnt=8.
      Prefetchable 32 bit memory at 0x94000000 [0x97ffffff].
      I/O at 0x12400 [0x124ff].
      Non-prefetchable 32 bit memory at 0x90000000 [0x90003fff].

fbset says:
mode "1600x1024-57"
    # D: 100.000 MHz, H: 60.976 kHz, V: 57.308 Hz
    geometry 1600 1024 1600 1024 8
    timings 10000 16 16 16 16 8 8
    rgba 8/0,8/0,8/0,0/0
endmode


--
               'Dry no plastic or rubberized articles'
                     Ted Whalen - tew@debian.org
                        <http://introvert.net>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
