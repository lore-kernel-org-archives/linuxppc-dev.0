Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Daniel Berlin <dan@cgsoftware.com>
Subject: Re: DFP support for kernel radeonfb.c added
Date: Fri, 16 Nov 2001 08:00:27 -0500
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	<linuxppc-dev@lists.linuxppc.org>
References: <Pine.LNX.4.33.0111151649150.27274-100000@www.cgsoftware.com>
In-Reply-To: <Pine.LNX.4.33.0111151649150.27274-100000@www.cgsoftware.com>
MIME-Version: 1.0
Message-Id: <20011116125743.SSEO9849.tomts10-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Daniel,

I looked at the EDID info for my normal Apple 17" multisync monitor and
when I look at the detailed timing section the timings provided are not
"good" to day the least.

        Mode    "832x624"       # vfreq 74.546Hz, hfreq 49.722kHz
        Mode    "1600x1200"     # vfreq 59.944Hz, hfreq 74.931kHz

The 75hz 832x624 size seems strange to me and the 60 hz 1600x1200 would
just be a terrible refresh rate.

The list of standard VESA timings seems okay and we could parse and check
which of these are available in macmodes.

What does the EDID from your LCD look like?

If its detailed timing sections is as strange as this one, that may
explain its poor performance.

Interestingly, on the DFP's there are NO standard or VESA timings at all
in the EDID and there is only 1 detailed timing section that pretty much
explains everything.

Perhaps we should only recommend using of_edid with DFP and not LCD?

Anyway here is what my EDID from the Apple 17" multisync monitor says:

[kbhend@localhost ddc]$ ./edid r128edid.dat
Manufacturer: APP  Model: 9d02  Serial#: 16843009
Year: 1999  Week: 14
EDID Version: 1.1
Analog Display Input,  Input Voltage Level: 0.700/0.700 V
Sync:  Separate
Max H-Image Size [cm]: horiz.: 32  vert.: 24
Gamma: 1.40
DPMS capabilities: StandBy Suspend Off; RGB/Color Display
redX: 0.625 redY: 0.340   greenX: 0.290 greenY: 0.605
blueX: 0.150 blueY: 0.070   whiteX: 0.283 whiteY: 0.298
Supported VESA Video Modes:
640x480@60Hz
640x480@67Hz
800x600@60Hz
832x624@75Hz
1024x768@60Hz
1024x768@75Hz
1280x1024@75Hz
1152x870@75Hz
Manufacturer's mask: 0
Supported Future Video Modes:
#0: hsize: 640  vsize 480  refresh: 85  vid: 22833
#1: hsize: 800  vsize 600  refresh: 85  vid: 22853
#2: hsize: 1024  vsize 768  refresh: 85  vid: 22881
#3: hsize: 1600  vsize 1200  refresh: 60  vid: 16553
Supported additional Video Mode:
clock: 57.3 MHz   Image Size:  312 x 234 mm
h_active: 832  h_sync: 864  h_sync_end 928 h_blank_end 1152 h_border: 0
v_active: 624  v_sync: 626  v_sync_end 629 v_blanking: 667 v_border: 0
NON-INTERLACED
sync type: 3  misc: 0
-HSync  -VSync
Supported additional Video Mode:
clock: 162.0 MHz   Image Size:  312 x 234 mm
h_active: 1600  h_sync: 1664  h_sync_end 1858 h_blank_end 2162 h_border: 0
v_active: 1200  v_sync: 1201  v_sync_end 1204 v_blanking: 1250 v_border: 0
NON-INTERLACED
sync type: 3  misc: 0
-HSync  -VSync
Ranges: V min: 48  V max: 160 Hz, H min: 30  H max: 85 kHz, PixClock max
160 MHzMonitor name: StudioDsply17
[kbhend@localhost ddc]$


For comparison, here is what my Apple 17" DFP says in its EDID:

[kbhend@localhost ddc]$ ./edid edid1.dat
Manufacturer: APP  Model: 9217  Serial#: 50201135
Year: 2001  Week: 33
EDID Version: 1.2
Digital Display Input
Max H-Image Size [cm]: horiz.: 33  vert.: 27
Gamma: 2.35
DPMS capabilities: Off; RGB/Color Display
redX: 0.631 redY: 0.351   greenX: 0.301 greenY: 0.570
blueX: 0.141 blueY: 0.096   whiteX: 0.311 whiteY: 0.330
Manufacturer's mask: 0
Supported Future Video Modes:
#0: hsize: 1280  vsize 1024  refresh: 60  vid: 32897
Supported additional Video Mode:
clock: 108.0 MHz   Image Size:  337 x 270 mm
h_active: 1280  h_sync: 1408  h_sync_end 1520 h_blank_end 1688 h_border: 0
v_active: 1024  v_sync: 1028  v_sync_end 1031 v_blanking: 1066 v_border: 0
NON-INTERLACED
sync type: 3  misc: 0
-HSync  -VSync
Monitor name: Apple Studio
Monitor name: Display
[kbhend@localhost ddc]$


What do people think?  Should we only be using EDID info for DFP and not
LCD?

At least with LCD's we can identify the machine type (as Daniel has done)
and hard code a dsiplay mode for each machine type).

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
